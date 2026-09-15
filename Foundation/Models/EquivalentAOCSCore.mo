within NISSA_12UCubeSat.Foundation.Models;
model EquivalentAOCSCore "低阶双矢量姿态控制核心"
  parameter NISSA_12UCubeSat.Foundation.Types.MassProperties massProperties;
  NISSA_12UCubeSat.Foundation.Interfaces.EnvironmentPort environment
    annotation(Placement(transformation(extent={{-112,-10},{-92,10}})));
  NISSA_12UCubeSat.Foundation.Interfaces.InformationPort information
    annotation(Placement(transformation(extent={{92,-10},{112,10}})));
  parameter Real maxManeuverRate(unit="rad/s")=2*Modelica.Constants.pi/180
    "系统级 finite attitude-service slew limit";
  parameter Real maneuverTimeConstant(unit="s")=5
    "First-order large/small-angle maneuver scaling";
  parameter Real rateServoTimeConstant(unit="s")=5
    "Low-order body-rate service time constant";
  parameter Real wheelSpeedServoGain[4](each unit="N.m.s/rad")={1.60e-4,1.55e-4,1.70e-4,1.50e-4}
    "X/Y/Z/S physical wheel speed-servo gains";
  parameter Real wheelTorqueLimit[4](each unit="N.m")={0.010,0.010,0.010,0.0038}
    "X/Y/Z/S physical torque limits used by the feasible null-space intersection";
  parameter Real wheelInertia[4](each unit="kg.m2")={9.5e-5,9.8e-5,9.3e-5,1.02e-4}
    "X/Y/Z/S physical rotor inertias";
  parameter Real skewAllocationFraction(min=0,max=0.5)=0.30
    "Share of commanded body torque assigned to the diagonal S wheel";
  parameter Real wheelSpeedLimit(unit="rad/s")=628.3185307
    "任务级参数, 6000 rpm";
  parameter Real wheelBalanceSoftStart(min=0,max=1)=0.38
    "Below this wheel-speed utilization the null-space balancer is inactive";
  parameter Real wheelBalanceStrongStart(min=0,max=1)=0.58
    "Utilization at which the null-space wheel-speed penalty is strengthened";
  parameter Real wheelPreferredUtilization(min=0,max=1)=0.70
    "Soft design target only; the physical hard limit remains 6000 rpm";
  parameter Real wheelBalanceGain(unit="N.m")=0.004
    "Idle/SunPointing-only continuous null-space momentum balancing gain";
  parameter Real wheelBalancePriority[4]=fill(1,4)
    "Optional per-wheel balancing cost; unity was used in the accepted configuration";
  parameter Real sunChargingBoresightBody[3]={0.7071067811865476,0.7071067811865476,0}
    "45 degree bisector of body-mounted +X and +Y solar faces";
  parameter Real cameraBoresightBody[3]={1,0,0};
  parameter Real groundBoresightBody[3]={1,0,0};
  parameter Real targetPointingTolerance(unit="rad")=0.5*Modelica.Constants.pi/180
    "Earth-camera attitude qualification, independent of the 7 degree half-FOV";
  parameter Real sunPointingTolerance(unit="rad")=0.035
    "Two-face charging needs coarse, not payload-grade, primary alignment";
  parameter Real groundPointingTolerance(unit="rad")=0.12
    "Patch-antenna ground LOS qualification (6.9 degree)";
  parameter Real secondaryTolerance(unit="rad")=0.30
    "Roll-about-LOS qualification; camera FOV and target illumination remain independently enforced";
  parameter Real groundSecondaryTolerance(unit="rad")=0.50
    "Solar-aware roll qualification during wide-beam ground tracking";
  parameter Real bodyRateTolerance(unit="rad/s")=0.002;
  parameter Real trackingRateTolerance(unit="rad/s")=0.05*Modelica.Constants.pi/180
    "Maximum body-to-LOS relative tracking-rate error";
  parameter Real settleDwellTime(unit="s")=8;
protected
  Modelica.Blocks.Interfaces.RealOutput wheelCommandPublisher[4](each unit="rad/s") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput primaryPointingErrorPublisher(unit="rad") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput secondaryPointingErrorPublisher(unit="rad") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput attitudeErrorPublisher(unit="rad") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput bodyRateMagnitudePublisher(unit="rad/s") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput bodyRatePublisher[3](each unit="rad/s") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput attitudeSettledPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput attitudeReadyPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput imagingWindowReadyPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput imagingAttitudeReadyPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput groundLinkAttitudeReadyPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  NISSA_12UCubeSat.Foundation.Interfaces.ControlModeOutput actualControlModePublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  NISSA_12UCubeSat.Foundation.Interfaces.AttitudeControlStateOutput attitudeControlStatePublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  // ReferenceGenerator：依据任务模式构造太阳、目标或地面站双矢量参考
  Real quaternionSign;
  Real quaternionError[3];
  Real quaternionAngle(unit="rad");
  Boolean sunMode;
  Boolean targetMode;
  Boolean groundMode;
  Boolean vectorMode;
  Boolean referenceValid;
  Boolean taskVectorMode;
  Real rawPrimaryReference[3];
  Real primaryReferenceNorm;
  Real primaryReference[3];
  Real primaryBoresight[3];
  Real primaryCrossRaw[3];
  Real primaryCrossNorm;
  Real primaryCrossError[3];
  Real primaryAngle(unit="rad");
  Real sunProjectionRaw[3];
  Real sunProjectionNorm;
  Real fallbackProjectionRaw[3];
  Real fallbackProjectionNorm;
  Real secondaryReference[3];
  Real secondaryCrossError[3];
  Real secondaryAngle(unit="rad");
  // AttitudeService：形成有限速率姿态服务并计算本体控制力矩
  Real primarySlewAxis[3];
  Real primarySlewRate(unit="rad/s");
  Real secondarySlewRate(unit="rad/s");
  Real desiredBodyRate[3](each unit="rad/s");
  Real bodyTorqueCommand[3](each unit="N.m");
  // WheelMomentumManager：四轮分配、限幅和太阳指向阶段零空间均衡
  Real rotorTorqueBase[4](each unit="N.m");
  Real rotorTorqueCommand[4](each unit="N.m");
  Real wheelSpeedOffset[4](each unit="rad/s");
  final parameter Real skewAxis[3]={0.577350269,0.577350269,0.577350269};
  final parameter Real nullVector[4]={-skewAxis[1],-skewAxis[2],-skewAxis[3],1}
    "One-dimensional null space of the fixed X/Y/Z/S wheel-axis matrix";
  Real normalizedWheelSpeed[4];
  Real wheelMomentum[4](each unit="N.m.s");
  Real normalizedWheelMomentum[4];
  Real softBalanceActivation[4];
  Real strongBalanceActivation[4];
  Real wheelPenaltyActivation[4];
  Real softPenalty[4];
  Real weightedWheelMomentum[4];
  Boolean balanceEnabled;
  Real balanceActivation;
  Real balanceError;
  Real deltaBalanceRaw(unit="N.m");
  Real deltaLowerBound[4](each unit="N.m");
  Real deltaUpperBound[4](each unit="N.m");
  Real deltaMin(unit="N.m");
  Real deltaMax(unit="N.m");
  Real deltaBalance(unit="N.m");
  // AttitudeService：指向资格、回差、驻留和状态输出
  Real attitudeErrorMagnitude(unit="rad");
  Real bodyRateMagnitude(unit="rad/s");
  Real pointingRateMagnitude(unit="rad/s")
    "Rate that disturbs the active pointing objective";
  Real referenceTrackingRate[3](each unit="rad/s");
  Boolean anyWheelSaturated;
  Boolean pointingQuality;
  Real pointingQualityRatio
    "Active primary/rate/secondary qualification expressed as a worst normalized ratio";
  Modelica.Blocks.Logical.Hysteresis qualityViolation(
    uLow=1.0,uHigh=1.10,pre_y_start=true)
    "Enter qualification only below the strict limit; leave above 110 percent to suppress threshold chatter";
  Modelica.Blocks.Logical.Timer settlingTimer "Continuous-good-pointing dwell timer";
  Boolean dwellComplete;
  Boolean attitudeEstimateValidInternal;
  Boolean wheelActuationAvailableInternal;
  Boolean groundLinkQuality;
  Modelica.Blocks.Logical.Timer groundLinkSettlingTimer "通信主视轴连续合格驻留计时";
  Foundation.Interfaces.RealSignalBridge informationRealBridge[11] annotation(Placement(transformation(extent={{58,-92},{66,-84}})));
  Foundation.Interfaces.BooleanSignalBridge informationBooleanBridge[5] annotation(Placement(transformation(extent={{82,-92},{90,-84}})));
  Foundation.Interfaces.ControlModeSignalBridge informationControlModeBridge
    annotation(Placement(transformation(extent={{82,-52},{90,-44}})));
  Foundation.Interfaces.AttitudeControlStateSignalBridge informationAttitudeStateBridge
    annotation(Placement(transformation(extent={{82,-64},{90,-56}})));
equation
  // ReferenceGenerator
  quaternionSign=noEvent(if environment.quaternion[1] >= 0 then 1 else -1);
  quaternionError=2*quaternionSign*environment.quaternion[2:4];
  quaternionAngle=2*acos(noEvent(max(0,min(1,abs(environment.quaternion[1])))));
  sunMode=information.command.desiredControlMode == NISSA_12UCubeSat.Foundation.Types.ControlMode.SunPointing or
    information.command.desiredControlMode == NISSA_12UCubeSat.Foundation.Types.ControlMode.SafeMode;
  targetMode=information.command.desiredControlMode == NISSA_12UCubeSat.Foundation.Types.ControlMode.TargetPointing;
  groundMode=information.command.desiredControlMode == NISSA_12UCubeSat.Foundation.Types.ControlMode.GroundPointing;
  vectorMode=sunMode or targetMode or groundMode;
  taskVectorMode=targetMode or groundMode;
  rawPrimaryReference=if targetMode then environment.activeTargetVectorBody else
    if groundMode then environment.activeGroundStationVectorBody else environment.sunVectorBody;
  primaryReferenceNorm=sqrt(noEvent(max(1e-12,rawPrimaryReference*rawPrimaryReference)));
  referenceValid=if targetMode then information.command.targetIndex > 0 and primaryReferenceNorm > 0.5 else
    if groundMode then information.command.groundStationIndex > 0 and primaryReferenceNorm > 0.5 else primaryReferenceNorm > 0.5;
  primaryReference=if referenceValid then rawPrimaryReference/primaryReferenceNorm else {0,0,0};
  primaryBoresight=if targetMode then cameraBoresightBody else if groundMode then groundBoresightBody else sunChargingBoresightBody;
  primaryCrossRaw=if vectorMode and referenceValid then cross(primaryBoresight,primaryReference) else quaternionError;
  primaryCrossNorm=sqrt(noEvent(max(1e-12,primaryCrossRaw*primaryCrossRaw)));
  primaryAngle=if vectorMode and referenceValid then acos(noEvent(max(-1,min(1,primaryBoresight*primaryReference)))) else
    if vectorMode then Modelica.Constants.pi else quaternionAngle;
  primaryCrossError=if vectorMode and referenceValid then
    noEvent(if primaryCrossNorm > 1e-5 then primaryAngle*primaryCrossRaw/primaryCrossNorm else
      primaryAngle*{0,0,1}) else quaternionError;
  sunProjectionRaw=environment.sunVectorBody-primaryReference*(environment.sunVectorBody*primaryReference);
  sunProjectionNorm=sqrt(noEvent(max(1e-12,sunProjectionRaw*sunProjectionRaw)));
  fallbackProjectionRaw={0,1,0}-primaryReference*primaryReference[2];
  fallbackProjectionNorm=sqrt(noEvent(max(1e-12,fallbackProjectionRaw*fallbackProjectionRaw)));
  secondaryReference=if taskVectorMode and referenceValid then
      (if sunProjectionNorm > 1e-5 then sunProjectionRaw/sunProjectionNorm else
       if fallbackProjectionNorm > 1e-5 then fallbackProjectionRaw/fallbackProjectionNorm else {0,0,1})
    else {0,1,0};
  secondaryCrossError=if taskVectorMode and referenceValid then
    primaryReference*(primaryReference*cross({0,1,0},secondaryReference)) else {0,0,0};
  secondaryAngle=if taskVectorMode and referenceValid then acos(noEvent(max(-1,min(1,secondaryReference[2])))) else 0;
  referenceTrackingRate=if targetMode then environment.activeTargetTrackingRateBody else
    if groundMode then environment.activeGroundTrackingRateBody else {0,0,0};
  // AttitudeService
  primarySlewAxis=if primaryCrossNorm > 1e-5 then primaryCrossRaw/primaryCrossNorm else {0,0,0};
  primarySlewRate=if vectorMode and referenceValid then
    noEvent(min(maxManeuverRate,primaryAngle/max(0.1,maneuverTimeConstant))) else 0;
  secondarySlewRate=if taskVectorMode and referenceValid then
    noEvent(min(0.25*maxManeuverRate,secondaryAngle/max(0.1,maneuverTimeConstant))) else 0;
  for i in 1:3 loop
    desiredBodyRate[i]=referenceTrackingRate[i]+primarySlewRate*primarySlewAxis[i]+
      secondarySlewRate*secondaryCrossError[i];
    bodyTorqueCommand[i]=noEvent(max(-wheelTorqueLimit[i],min(wheelTorqueLimit[i],
      massProperties.inertiaDiagonal[i]*(desiredBodyRate[i]-environment.bodyRate[i])/max(0.05,rateServoTimeConstant))));
  end for;
  // WheelMomentumManager
  rotorTorqueBase[4]=noEvent(max(-wheelTorqueLimit[4],min(wheelTorqueLimit[4],
    -skewAllocationFraction*(bodyTorqueCommand*skewAxis))));
  for i in 1:3 loop
    rotorTorqueBase[i]=noEvent(max(-wheelTorqueLimit[i],min(wheelTorqueLimit[i],
      -bodyTorqueCommand[i]-skewAxis[i]*rotorTorqueBase[4])));
  end for;
  for i in 1:4 loop
    normalizedWheelSpeed[i]=information.device.wheelSpeed[i]/wheelSpeedLimit;
    wheelMomentum[i]=wheelInertia[i]*information.device.wheelSpeed[i];
    normalizedWheelMomentum[i]=wheelMomentum[i]/(9.7e-5*wheelSpeedLimit);
    softBalanceActivation[i]=noEvent(max(0,min(1,
      (abs(normalizedWheelSpeed[i])-wheelBalanceSoftStart)/
      max(1e-6,wheelBalanceStrongStart-wheelBalanceSoftStart))));
    strongBalanceActivation[i]=noEvent(max(0,min(1,
      (abs(normalizedWheelSpeed[i])-wheelBalanceStrongStart)/
      max(1e-6,wheelPreferredUtilization-wheelBalanceStrongStart))));
    wheelPenaltyActivation[i]=noEvent(max(0,min(1,
      (abs(normalizedWheelSpeed[i])-wheelBalanceSoftStart)/
      max(1e-6,wheelPreferredUtilization-wheelBalanceSoftStart))));
    softPenalty[i]=8*wheelPenaltyActivation[i]^2+4*strongBalanceActivation[i]^2;
    weightedWheelMomentum[i]=wheelBalancePriority[i]*normalizedWheelMomentum[i]*(1+softPenalty[i]);
    deltaLowerBound[i]=noEvent(min(
      (-wheelTorqueLimit[i]-rotorTorqueBase[i])/nullVector[i],
      ( wheelTorqueLimit[i]-rotorTorqueBase[i])/nullVector[i]));
    deltaUpperBound[i]=noEvent(max(
      (-wheelTorqueLimit[i]-rotorTorqueBase[i])/nullVector[i],
      ( wheelTorqueLimit[i]-rotorTorqueBase[i])/nullVector[i]));
  end for;
  balanceEnabled=information.command.desiredControlMode == NISSA_12UCubeSat.Foundation.Types.ControlMode.SunPointing and
    not information.command.safeMode;
  balanceActivation=noEvent(max(wheelPenaltyActivation));
  balanceError=nullVector*weightedWheelMomentum;
  deltaBalanceRaw=-wheelBalanceGain*balanceActivation*balanceError;
  deltaMin=noEvent(max(deltaLowerBound));
  deltaMax=noEvent(min(deltaUpperBound));
  deltaBalance=noEvent(if balanceEnabled then max(deltaMin,min(deltaMax,deltaBalanceRaw)) else 0);
  for i in 1:4 loop
    rotorTorqueCommand[i]=rotorTorqueBase[i]+nullVector[i]*deltaBalance;
    wheelSpeedOffset[i]=rotorTorqueCommand[i]/wheelSpeedServoGain[i];
    wheelCommandPublisher[i]=noEvent(max(-wheelSpeedLimit,min(wheelSpeedLimit,
      information.device.wheelSpeed[i]+wheelSpeedOffset[i])));
  end for;
  bodyRateMagnitude=sqrt(environment.bodyRate*environment.bodyRate);
  pointingRateMagnitude=if vectorMode and referenceValid then
    sqrt(cross(environment.bodyRate-referenceTrackingRate,primaryReference)*
      cross(environment.bodyRate-referenceTrackingRate,primaryReference))
    else sqrt((environment.bodyRate-referenceTrackingRate)*(environment.bodyRate-referenceTrackingRate));
  anyWheelSaturated=information.device.wheelSaturated[1] or information.device.wheelSaturated[2] or information.device.wheelSaturated[3] or information.device.wheelSaturated[4];
  attitudeEstimateValidInternal=information.device.starStatus[1] > 0;
  wheelActuationAvailableInternal=information.device.wheelStatus[1] > 0 and information.device.wheelStatus[2] > 0 and
    information.device.wheelStatus[3] > 0 and information.device.wheelStatus[4] > 0;
  pointingQualityRatio=noEvent(max(
    primaryAngle/max(1e-8,if targetMode then targetPointingTolerance else
      if groundMode then groundPointingTolerance else sunPointingTolerance),
    max(if groundMode then secondaryAngle/max(1e-8,groundSecondaryTolerance) else 0,
      max(pointingRateMagnitude/max(1e-8,if taskVectorMode then trackingRateTolerance else bodyRateTolerance),
        if referenceValid and not anyWheelSaturated then 0 else 2))));
  qualityViolation.u=pointingQualityRatio;
  pointingQuality=not qualityViolation.y;
  settlingTimer.u=pointingQuality;
  dwellComplete=settlingTimer.y >= settleDwellTime;
  attitudeErrorMagnitude=if vectorMode then sqrt(primaryAngle^2+(if taskVectorMode then (0.3*secondaryAngle)^2 else 0)) else quaternionAngle;
  primaryPointingErrorPublisher=primaryAngle;
  secondaryPointingErrorPublisher=secondaryAngle;
  attitudeErrorPublisher=attitudeErrorMagnitude;
  bodyRateMagnitudePublisher=bodyRateMagnitude;
  bodyRatePublisher=environment.bodyRate;
  attitudeSettledPublisher=dwellComplete and attitudeEstimateValidInternal and wheelActuationAvailableInternal and
    (not targetMode or environment.activeTargetVisible) and
    (not groundMode or environment.activeGroundContact);
  attitudeReadyPublisher=information.device.attitudeSettled;
  imagingWindowReadyPublisher=targetMode and
    environment.activeTargetVisible and environment.cameraFOVValid and
    environment.targetIlluminationValid;
  imagingAttitudeReadyPublisher=targetMode and dwellComplete and attitudeEstimateValidInternal and
    wheelActuationAvailableInternal and not anyWheelSaturated and environment.activeTargetVisible and
    environment.offNadirValid and environment.cameraFOVValid and environment.targetIlluminationValid;
  groundLinkQuality=groundMode and referenceValid and environment.activeGroundContact and
    attitudeEstimateValidInternal and wheelActuationAvailableInternal and not anyWheelSaturated and
    primaryAngle <= groundPointingTolerance and pointingRateMagnitude <= trackingRateTolerance;
  groundLinkSettlingTimer.u=groundLinkQuality;
  groundLinkAttitudeReadyPublisher=groundLinkSettlingTimer.y >= settleDwellTime;
  actualControlModePublisher=if dwellComplete then information.command.desiredControlMode else
    NISSA_12UCubeSat.Foundation.Types.ControlMode.Initialization;
  attitudeControlStatePublisher=if anyWheelSaturated then NISSA_12UCubeSat.Foundation.Types.AttitudeControlState.Saturated else
    if information.command.desiredControlMode == NISSA_12UCubeSat.Foundation.Types.ControlMode.Initialization then NISSA_12UCubeSat.Foundation.Types.AttitudeControlState.Initialization else
    if not pointingQuality then NISSA_12UCubeSat.Foundation.Types.AttitudeControlState.Slewing else
    if not dwellComplete then NISSA_12UCubeSat.Foundation.Types.AttitudeControlState.Settling else
    if information.command.desiredControlMode == NISSA_12UCubeSat.Foundation.Types.ControlMode.SafeMode then NISSA_12UCubeSat.Foundation.Types.AttitudeControlState.SafeMode else
    if information.command.desiredControlMode == NISSA_12UCubeSat.Foundation.Types.ControlMode.SunPointing then NISSA_12UCubeSat.Foundation.Types.AttitudeControlState.SunPointing else NISSA_12UCubeSat.Foundation.Types.AttitudeControlState.Tracking;
  connect(wheelCommandPublisher[1],informationRealBridge[1].u) annotation(Line(points={{78,60},{102,60},{102,0}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.command.wheelCommand[1]) annotation(Line(points={{78,60},{102,60},{102,0}},color={0,0,127}));
  connect(wheelCommandPublisher[2],informationRealBridge[2].u) annotation(Line(points={{78,60},{102,60},{102,0}},color={0,0,127}));
  connect(informationRealBridge[2].y,information.command.wheelCommand[2]) annotation(Line(points={{78,60},{102,60},{102,0}},color={0,0,127}));
  connect(wheelCommandPublisher[3],informationRealBridge[3].u) annotation(Line(points={{78,60},{102,60},{102,0}},color={0,0,127}));
  connect(informationRealBridge[3].y,information.command.wheelCommand[3]) annotation(Line(points={{78,60},{102,60},{102,0}},color={0,0,127}));
  connect(wheelCommandPublisher[4],informationRealBridge[4].u) annotation(Line(points={{78,60},{102,60},{102,0}},color={0,0,127}));
  connect(informationRealBridge[4].y,information.command.wheelCommand[4]) annotation(Line(points={{78,60},{102,60},{102,0}},color={0,0,127}));
  connect(primaryPointingErrorPublisher,informationRealBridge[5].u) annotation(Line(points={{78,48},{102,48},{102,0}},color={0,0,127}));
  connect(informationRealBridge[5].y,information.device.primaryPointingError) annotation(Line(points={{78,48},{102,48},{102,0}},color={0,0,127}));
  connect(secondaryPointingErrorPublisher,informationRealBridge[6].u) annotation(Line(points={{78,36},{102,36},{102,0}},color={0,0,127}));
  connect(informationRealBridge[6].y,information.device.secondaryPointingError) annotation(Line(points={{78,36},{102,36},{102,0}},color={0,0,127}));
  connect(attitudeErrorPublisher,informationRealBridge[7].u) annotation(Line(points={{78,24},{102,24},{102,0}},color={0,0,127}));
  connect(informationRealBridge[7].y,information.device.attitudeError) annotation(Line(points={{78,24},{102,24},{102,0}},color={0,0,127}));
  connect(bodyRateMagnitudePublisher,informationRealBridge[8].u) annotation(Line(points={{78,12},{102,12},{102,0}},color={0,0,127}));
  connect(informationRealBridge[8].y,information.device.bodyRateMagnitude) annotation(Line(points={{78,12},{102,12},{102,0}},color={0,0,127}));
  connect(bodyRatePublisher[1],informationRealBridge[9].u) annotation(Line(points={{78,0},{102,0}},color={0,0,127}));
  connect(informationRealBridge[9].y,information.device.bodyRate[1]) annotation(Line(points={{78,0},{102,0}},color={0,0,127}));
  connect(bodyRatePublisher[2],informationRealBridge[10].u) annotation(Line(points={{78,0},{102,0}},color={0,0,127}));
  connect(informationRealBridge[10].y,information.device.bodyRate[2]) annotation(Line(points={{78,0},{102,0}},color={0,0,127}));
  connect(bodyRatePublisher[3],informationRealBridge[11].u) annotation(Line(points={{78,0},{102,0}},color={0,0,127}));
  connect(informationRealBridge[11].y,information.device.bodyRate[3]) annotation(Line(points={{78,0},{102,0}},color={0,0,127}));
  connect(attitudeSettledPublisher,informationBooleanBridge[1].u) annotation(Line(points={{78,-12},{102,-12},{102,0}},color={255,0,255}));
  connect(informationBooleanBridge[1].y,information.device.attitudeSettled) annotation(Line(points={{78,-12},{102,-12},{102,0}},color={255,0,255}));
  connect(attitudeReadyPublisher,informationBooleanBridge[2].u) annotation(Line(points={{78,-24},{102,-24},{102,0}},color={255,0,255}));
  connect(informationBooleanBridge[2].y,information.device.attitudeReady) annotation(Line(points={{78,-24},{102,-24},{102,0}},color={255,0,255}));
  connect(imagingWindowReadyPublisher,informationBooleanBridge[3].u) annotation(Line(points={{78,-36},{102,-36},{102,0}},color={255,0,255}));
  connect(informationBooleanBridge[3].y,information.device.imagingWindowReady) annotation(Line(points={{78,-36},{102,-36},{102,0}},color={255,0,255}));
  connect(imagingAttitudeReadyPublisher,informationBooleanBridge[4].u) annotation(Line(points={{78,-40},{82,-40}},color={255,0,255}));
  connect(informationBooleanBridge[4].y,information.device.imagingAttitudeReady) annotation(Line(points={{90,-40},{102,-40},{102,0}},color={255,0,255}));
  connect(groundLinkAttitudeReadyPublisher,informationBooleanBridge[5].u) annotation(Line(points={{78,-44},{82,-44}},color={255,0,255}));
  connect(informationBooleanBridge[5].y,information.device.groundLinkAttitudeReady) annotation(Line(points={{90,-44},{102,-44},{102,0}},color={255,0,255}));
  connect(actualControlModePublisher,informationControlModeBridge.u) annotation(Line(points={{78,-48},{82,-48}},color={255,127,0}));
  connect(informationControlModeBridge.y,information.device.actualControlMode) annotation(Line(points={{90.4,-48},{102,-48},{102,0}},color={255,127,0}));
  connect(attitudeControlStatePublisher,informationAttitudeStateBridge.u) annotation(Line(points={{78,-60},{82,-60}},color={255,127,0}));
  connect(informationAttitudeStateBridge.y,information.device.attitudeControlState) annotation(Line(points={{90.4,-60},{102,-60},{102,0}},color={255,127,0}));
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={130,80,20},fillColor={250,239,220},fillPattern=FillPattern.Solid),Ellipse(extent={{-40,40},{40,-40}},lineColor={130,80,20}),Line(points={{-40,0},{40,0}},color={130,80,20}),Line(points={{0,-40},{0,40}},color={130,80,20}),Text(extent={{-94,-64},{94,-42}},textString="TWO-VECTOR AOCS")}),Documentation(info="<html><h4>功能定位</h4><p>以系统级低阶方程完成任务参考生成、有限速率姿态服务、四飞轮分配、指向资格和动量均衡。</p><h4>输入与接口关系</h4><p>environment提供姿态、角速度及太阳/目标/地面站视线和跟踪率；information提供期望控制模式、实际轮速与任务状态，并接收轮命令和姿控诊断。</p><h4>内部职责与实现</h4><p>ReferenceGenerator按Sun/Target/Ground模式构造主次参考；AttitudeService计算四元数等价误差、双矢量误差、速率前馈、受限控制力矩及驻留资格；WheelMomentumManager按X/Y/Z/S轴矩阵分配转矩并在太阳指向阶段做零空间均衡。</p><h4>输出</h4><p>输出四轮速度命令、主/次指向误差、姿态误差、本体速率、稳定/准备标志、实际控制模式和姿态控制状态；因果量均经Bridge回写共享information。</p><h4>连续/离散状态</h4><p>含连续姿态/轮速相关方程以及Hysteresis、Timer带来的资格记忆；新增接口Bridge仅为无状态恒等映射。</p><h4>使用与观察</h4><p>由GNCComputerUnit调用。重点查看指向误差、bodyRate、dwellComplete、轮命令与实际轮速、饱和状态和模式，不建议把大量受保护中间向量作为生产结果。</p><h4>建模边界</h4><p>不是完整飞控软件或EKF，不模拟星敏滤波、执行器电流环和柔性模态；参数已用于当前任务闭环，不应在接口兼容性整理中重调。</p></html>"));
end EquivalentAOCSCore;
