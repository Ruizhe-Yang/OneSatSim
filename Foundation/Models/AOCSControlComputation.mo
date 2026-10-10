within OneSatSim.Foundation.Models;
model AOCSControlComputation "低阶双矢量姿态控制核心"
  parameter OneSatSim.Foundation.Types.MassProperties massProperties "由活动机械刚体离线汇总的统一整星质量、质心与惯量" ;
  parameter OneSatSim.Foundation.Types.WheelGroupCapabilities wheelCapabilities
    "飞轮Capabilities；Shared X/Y/Z/S wheel inertia, torque, speed and mounting axes";
  OneSatSim.Foundation.Interfaces.EnvironmentPort environment 
     "外部环境接口或实例" annotation(Placement(visible=true, transformation(origin={-270,77}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.InformationPort information 
     "计算/接口量 information" annotation(Placement(visible=true, transformation(origin={-270,45}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-6.4,-6.4},{6.4,6.4}}, rotation=0)));
  parameter Real maxManeuverRate(unit="rad/s")=2*Modelica.Constants.pi/180
    "系统级 finite attitude-service slew limit";
  parameter Real maneuverTimeConstant(unit="s")=5
    "maneuver时间Constant [s]；First-order large/small-angle maneuver scaling";
  parameter Real rateServoTimeConstant(unit="s")=5
    "速率Servo时间Constant [s]；Low-order body-rate service time constant";
  parameter Real wheelSpeedServoGain[4](each unit="N.m.s/rad")
    "飞轮速度Servo增益 [N.m.s/rad]；Control gains shared with the four physical wheel servos";
  parameter Real skewAllocationFraction(min=0,max=0.5)=0.30
    "配置项 skewAllocationFraction；Share of commanded body torque assigned to the diagonal S wheel";
  parameter Real wheelBalanceSoftStart(min=0,max=1)=0.38
    "飞轮BalanceSoftStart；Below this wheel-speed utilization the null-space balancer is inactive";
  parameter Real wheelBalanceStrongStart(min=0,max=1)=0.58
    "飞轮BalanceStrongStart；Utilization at which the null-space wheel-speed penalty is strengthened";
  parameter Real wheelPreferredUtilization(min=0,max=1)=0.70
    "飞轮PreferredUtilization；Soft design target; physical hard limits come from wheelCapabilities.maxSpeed";
  parameter Real wheelBalanceGain(unit="N.m")=0.004
    "飞轮Balance增益 [N.m]；Idle/SunPointing-only continuous null-space momentum balancing gain";
  parameter Real wheelBalancePriority[4]=fill(1,4)
    "飞轮BalancePriority；Optional per-wheel balancing cost; unity was used in the accepted configuration";
  parameter Real sunChargingBoresightBody[3]={0.7071067811865476,0.7071067811865476,0}
    "sunChargingBoresight本体；45 degree bisector of body-mounted +X and +Y solar faces";
  parameter Real cameraBoresightBody[3]={1,0,0} "cameraBoresight本体" ;
  parameter Real groundBoresightBody[3]={1,0,0} "地面Boresight本体" ;
  parameter Real targetPointingTolerance(unit="rad")=0.5*Modelica.Constants.pi/180
    "目标PointingTolerance [rad]；Earth-camera attitude qualification, independent of the 7 degree half-FOV";
  parameter Real sunPointingTolerance(unit="rad")=0.035
    "配置项 sunPointingTolerance [rad]；Two-face charging needs coarse, not payload-grade, primary alignment";
  parameter Real groundPointingTolerance(unit="rad")=0.12
    "地面PointingTolerance [rad]；Patch-antenna ground LOS qualification (6.9 degree)";
  parameter Real secondaryTolerance(unit="rad")=0.30
    "配置项 secondaryTolerance [rad]；Roll-about-LOS qualification; camera FOV and target illumination remain independently enforced";
  parameter Real groundSecondaryTolerance(unit="rad")=0.50
    "地面SecondaryTolerance [rad]；Solar-aware roll qualification during wide-beam ground tracking";
  parameter Real bodyRateTolerance(unit="rad/s")=0.002 "本体速率Tolerance [rad/s]" ;
  parameter Real trackingRateTolerance(unit="rad/s")=0.05*Modelica.Constants.pi/180
    "跟踪速率Tolerance [rad/s]；Maximum body-to-LOS relative tracking-rate error";
  parameter Real settleDwellTime(unit="s")
    "settleDwell时间 [s]；Passed through from the effective imaging capability record";
  Modelica.Blocks.Interfaces.RealOutput wheelCommandPublisher[4](each unit="rad/s")  "飞轮指令Publisher [rad/s]" annotation(Placement(visible=true, transformation(origin={270,247}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,70}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput primaryPointingErrorPublisher(unit="rad")  "primaryPointing误差Publisher [rad]" annotation(Placement(visible=true, transformation(origin={270,143}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,60}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput secondaryPointingErrorPublisher(unit="rad")  "secondaryPointing误差Publisher [rad]" annotation(Placement(visible=true, transformation(origin={270,117}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,50}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput attitudeErrorPublisher(unit="rad")  "姿态误差Publisher [rad]" annotation(Placement(visible=true, transformation(origin={270,91}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,40}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput bodyRateMagnitudePublisher(unit="rad/s")  "本体速率MagnitudePublisher [rad/s]" annotation(Placement(visible=true, transformation(origin={270,195}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,30}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput bodyRatePublisher[3](each unit="rad/s")  "本体速率Publisher [rad/s]" annotation(Placement(visible=true, transformation(origin={270,221}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,20}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput attitudeSettledPublisher  "姿态SettledPublisher" annotation(Placement(visible=true, transformation(origin={270,39}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,10}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput attitudeReadyPublisher  "姿态就绪Publisher" annotation(Placement(visible=true, transformation(origin={270,13}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput imagingWindowReadyPublisher  "成像Window就绪Publisher" annotation(Placement(visible=true, transformation(origin={270,-13}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-10}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput imagingAttitudeReadyPublisher  "成像姿态就绪Publisher" annotation(Placement(visible=true, transformation(origin={270,-39}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-20}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput groundLinkAttitudeReadyPublisher  "地面链路姿态就绪Publisher" annotation(Placement(visible=true, transformation(origin={270,-65}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-30}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.ControlModeOutput actualControlModePublisher  "actual控制模式Publisher" annotation(Placement(visible=true, transformation(origin={270,-117}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-40}, extent={{-6.4,-6.4},{6.4,6.4}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.AttitudeControlStateOutput attitudeControlStatePublisher  "姿态控制状态Publisher" annotation(Placement(visible=true, transformation(origin={270,-143}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-50}, extent={{-6.4,-6.4},{6.4,6.4}}, rotation=0)));
  // ReferenceGenerator：依据任务模式构造太阳、目标或地面站双矢量参考
  Real quaternionSign "四元数Sign" ;
  Real quaternionError[3] "四元数误差" ;
  Real quaternionAngle(unit="rad") "四元数Angle [rad]" ;
  Real measuredQuaternionNorm "measured四元数Norm" ;
  Real measuredQuaternion[4]
    "measured四元数；Star-Y measured world-to-body quaternion in MSL vector-first order";
  Real measuredBodyRate[3](each unit="rad/s")
    "measured本体速率 [rad/s]；Precision gyro during task pointing, MEMS gyro otherwise";
  Real measuredSunVectorBody[3] "measuredSunVector本体" ;
  Boolean sunMode "sun模式" ;
  Boolean targetMode "目标模式" ;
  Boolean groundMode "地面模式" ;
  Boolean vectorMode "vector模式" ;
  Boolean referenceValid "计算/接口量 referenceValid" ;
  Boolean taskVectorMode "taskVector模式" ;
  Real rawPrimaryReference[3] "计算/接口量 rawPrimaryReference" ;
  Real primaryReferenceNorm "计算/接口量 primaryReferenceNorm" ;
  Real primaryReference[3] "计算/接口量 primaryReference" ;
  Real primaryBoresight[3] "计算/接口量 primaryBoresight" ;
  Real primaryCrossRaw[3] "计算/接口量 primaryCrossRaw" ;
  Real primaryCrossNorm "计算/接口量 primaryCrossNorm" ;
  Real primaryCrossError[3] "primaryCross误差" ;
  Real primaryAngle(unit="rad") "计算/接口量 primaryAngle [rad]" ;
  Real sunProjectionRaw[3] "计算/接口量 sunProjectionRaw" ;
  Real sunProjectionNorm "计算/接口量 sunProjectionNorm" ;
  Real fallbackProjectionRaw[3] "计算/接口量 fallbackProjectionRaw" ;
  Real fallbackProjectionNorm "计算/接口量 fallbackProjectionNorm" ;
  Real secondaryReference[3] "计算/接口量 secondaryReference" ;
  Real secondaryCrossError[3] "secondaryCross误差" ;
  Real secondaryAngle(unit="rad") "计算/接口量 secondaryAngle [rad]" ;
  // AttitudeService：形成有限速率姿态服务并计算本体控制力矩
  Real primarySlewAxis[3] "计算/接口量 primarySlewAxis" ;
  Real primarySlewRate(unit="rad/s") "primarySlew速率 [rad/s]" ;
  Real secondarySlewRate(unit="rad/s") "secondarySlew速率 [rad/s]" ;
  Real desiredBodyRate[3](each unit="rad/s") "desired本体速率 [rad/s]" ;
  Real bodyTorqueCommand[3](each unit="N.m") "本体Torque指令 [N.m]" ;
  // WheelMomentumManager：四轮分配、限幅和太阳指向阶段零空间均衡
  Real rotorTorqueBase[4](each unit="N.m") "计算/接口量 rotorTorqueBase [N.m]" ;
  Real rotorTorqueCommand[4](each unit="N.m") "rotorTorque指令 [N.m]" ;
  Real wheelSpeedOffset[4](each unit="rad/s") "飞轮速度偏移 [rad/s]" ;
  final parameter Real skewAxis[3]={wheelCapabilities.axes[1,4],
    wheelCapabilities.axes[2,4],wheelCapabilities.axes[3,4]}
    "配置项 skewAxis；S-wheel mounting axis from the shared physical capability";
  final parameter Real nullVector[4]={-skewAxis[1],-skewAxis[2],-skewAxis[3],1}
    "配置项 nullVector；One-dimensional null space for the configured X/Y/Z/S wheel-axis matrix with the verified X/Y/Z basis";
  final parameter Real nominalWheelInertia(unit="kg.m2")=sum(wheelCapabilities.J)/4
    "nominal飞轮惯量 [kg.m2]；Former 9.7e-5 kg.m2 normalization, now derived from the four configured rotors";
  Real normalizedWheelSpeed[4] "normalized飞轮速度" ;
  Real wheelMomentum[4](each unit="N.m.s") "飞轮Momentum [N.m.s]" ;
  Real normalizedWheelMomentum[4] "normalized飞轮Momentum" ;
  Real softBalanceActivation[4] "计算/接口量 softBalanceActivation" ;
  Real strongBalanceActivation[4] "计算/接口量 strongBalanceActivation" ;
  Real wheelPenaltyActivation[4] "飞轮PenaltyActivation" ;
  Real softPenalty[4] "计算/接口量 softPenalty" ;
  Real weightedWheelMomentum[4] "weighted飞轮Momentum" ;
  Boolean balanceEnabled "balance启用" ;
  Real balanceActivation "计算/接口量 balanceActivation" ;
  Real balanceError "balance误差" ;
  Real deltaBalanceRaw(unit="N.m") "计算/接口量 deltaBalanceRaw [N.m]" ;
  Real deltaLowerBound[4](each unit="N.m") "delta下界Bound [N.m]" ;
  Real deltaUpperBound[4](each unit="N.m") "delta上界Bound [N.m]" ;
  Real deltaMin(unit="N.m") "计算/接口量 deltaMin [N.m]" ;
  Real deltaMax(unit="N.m") "计算/接口量 deltaMax [N.m]" ;
  Real deltaBalance(unit="N.m") "计算/接口量 deltaBalance [N.m]" ;
  // AttitudeService：指向资格、回差、驻留和状态输出
  Real attitudeErrorMagnitude(unit="rad") "姿态误差Magnitude [rad]" ;
  Real bodyRateMagnitude(unit="rad/s") "本体速率Magnitude [rad/s]" ;
  Real pointingRateMagnitude(unit="rad/s")
    "pointing速率Magnitude [rad/s]；Rate that disturbs the active pointing objective";
  Real referenceTrackingRate[3](each unit="rad/s") "reference跟踪速率 [rad/s]" ;
  Boolean anyWheelSaturated "any飞轮Saturated" ;
  Modelica.Blocks.Interfaces.BooleanOutput pointingQuality 
     "pointing质量标记" annotation(Placement(visible=true, transformation(origin={270,-195}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-60}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput pointingQualityRatio
    "pointing质量标记Ratio；Active primary/rate/secondary qualification expressed as a worst normalized ratio" 
    annotation(Placement(visible=true, transformation(origin={270,-221}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-70}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Boolean dwellComplete "计算/接口量 dwellComplete" ;
  Boolean attitudeEstimateValidInternal "姿态EstimateValidInternal" ;
  Boolean wheelActuationAvailableInternal "飞轮ActuationAvailableInternal" ;
  Modelica.Blocks.Interfaces.BooleanOutput groundLinkQuality 
     "地面链路质量标记" annotation(Placement(visible=true, transformation(origin={270,-247}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInput qualityViolationSignal 
     "质量标记Violation信号" annotation(Placement(visible=true, transformation(origin={-270,-13}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,26.666667}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput settlingElapsed(unit="s") 
     "计算/接口量 settlingElapsed [s]" annotation(Placement(visible=true, transformation(origin={-270,-45}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-26.666667}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput groundLinkElapsed(unit="s") 
     "地面链路Elapsed [s]" annotation(Placement(visible=true, transformation(origin={-270,-77}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-6,-6},{6,6}}, rotation=0)));
equation
  // ReferenceGenerator
  measuredQuaternionNorm=sqrt(noEvent(max(1e-12,
    sum(information.device.starQuaternion[1,i]^2 for i in 1:4))));
  measuredQuaternion=if measuredQuaternionNorm > 0.5 then 
    {information.device.starQuaternion[1,2],information.device.starQuaternion[1,3],
      information.device.starQuaternion[1,4],information.device.starQuaternion[1,1]}/measuredQuaternionNorm 
    else {0,0,0,1};
  quaternionSign=noEvent(if measuredQuaternion[4] >= 0 then 1 else -1);
  quaternionError=2*quaternionSign*measuredQuaternion[1:3];
  quaternionAngle=2*acos(noEvent(max(0,min(1,abs(measuredQuaternion[4])))));
  sunMode=information.command.desiredControlMode == OneSatSim.Foundation.Types.ControlMode.SunPointing or 
    information.command.desiredControlMode == OneSatSim.Foundation.Types.ControlMode.SafeMode;
  targetMode=information.command.desiredControlMode == OneSatSim.Foundation.Types.ControlMode.TargetPointing;
  groundMode=information.command.desiredControlMode == OneSatSim.Foundation.Types.ControlMode.GroundPointing;
  vectorMode=sunMode or targetMode or groundMode;
  taskVectorMode=targetMode or groundMode;
  measuredBodyRate=if taskVectorMode then information.device.yh50Rate else 
    information.device.mems[1:3];
  measuredSunVectorBody=Modelica.Mechanics.MultiBody.Frames.Quaternions.resolve2(
    measuredQuaternion,environment.sunVectorGCRS);
  rawPrimaryReference=Modelica.Mechanics.MultiBody.Frames.Quaternions.resolve2(
    measuredQuaternion,if targetMode then environment.activeTargetVectorGCRS else 
      if groundMode then environment.activeGroundStationVectorGCRS else environment.sunVectorGCRS);
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
  sunProjectionRaw=measuredSunVectorBody-primaryReference*(measuredSunVectorBody*primaryReference);
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
  referenceTrackingRate=Modelica.Mechanics.MultiBody.Frames.Quaternions.resolve2(
    measuredQuaternion,if targetMode then environment.activeTargetTrackingRateGCRS else 
      if groundMode then environment.activeGroundTrackingRateGCRS else {0,0,0});
  // AttitudeService
  primarySlewAxis=if primaryCrossNorm > 1e-5 then primaryCrossRaw/primaryCrossNorm else {0,0,0};
  primarySlewRate=if vectorMode and referenceValid then 
    noEvent(min(maxManeuverRate,primaryAngle/max(0.1,maneuverTimeConstant))) else 0;
  secondarySlewRate=if taskVectorMode and referenceValid then 
    noEvent(min(0.25*maxManeuverRate,secondaryAngle/max(0.1,maneuverTimeConstant))) else 0;
  for i in 1:3 loop
    desiredBodyRate[i]=referenceTrackingRate[i]+primarySlewRate*primarySlewAxis[i]+
      secondarySlewRate*secondaryCrossError[i];
    bodyTorqueCommand[i]=noEvent(max(-wheelCapabilities.maxTorque[i],min(wheelCapabilities.maxTorque[i],
      massProperties.inertiaDiagonal[i]*(desiredBodyRate[i]-measuredBodyRate[i])/max(0.05,rateServoTimeConstant))));
  end for;
  // WheelMomentumManager
  rotorTorqueBase[4]=noEvent(max(-wheelCapabilities.maxTorque[4],min(wheelCapabilities.maxTorque[4],
    -skewAllocationFraction*(bodyTorqueCommand*skewAxis))));
  for i in 1:3 loop
    rotorTorqueBase[i]=noEvent(max(-wheelCapabilities.maxTorque[i],min(wheelCapabilities.maxTorque[i],
      -bodyTorqueCommand[i]-skewAxis[i]*rotorTorqueBase[4])));
  end for;
  for i in 1:4 loop
    normalizedWheelSpeed[i]=information.device.wheelSpeed[i]/wheelCapabilities.maxSpeed[i];
    wheelMomentum[i]=wheelCapabilities.J[i]*information.device.wheelSpeed[i];
    normalizedWheelMomentum[i]=wheelMomentum[i]/(nominalWheelInertia*wheelCapabilities.maxSpeed[i]);
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
      (-wheelCapabilities.maxTorque[i]-rotorTorqueBase[i])/nullVector[i],
      ( wheelCapabilities.maxTorque[i]-rotorTorqueBase[i])/nullVector[i]));
    deltaUpperBound[i]=noEvent(max(
      (-wheelCapabilities.maxTorque[i]-rotorTorqueBase[i])/nullVector[i],
      ( wheelCapabilities.maxTorque[i]-rotorTorqueBase[i])/nullVector[i]));
  end for;
  balanceEnabled=information.command.desiredControlMode == OneSatSim.Foundation.Types.ControlMode.SunPointing and 
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
    wheelCommandPublisher[i]=noEvent(max(-wheelCapabilities.maxSpeed[i],min(wheelCapabilities.maxSpeed[i],
      information.device.wheelSpeed[i]+wheelSpeedOffset[i])));
  end for;
  bodyRateMagnitude=sqrt(measuredBodyRate*measuredBodyRate);
  pointingRateMagnitude=if vectorMode and referenceValid then 
    sqrt(cross(measuredBodyRate-referenceTrackingRate,primaryReference)*
      cross(measuredBodyRate-referenceTrackingRate,primaryReference)) 
    else sqrt((measuredBodyRate-referenceTrackingRate)*(measuredBodyRate-referenceTrackingRate));
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
    pointingQuality=not qualityViolationSignal;
    dwellComplete=settlingElapsed >= settleDwellTime;
  attitudeErrorMagnitude=if vectorMode then sqrt(primaryAngle^2+(if taskVectorMode then (0.3*secondaryAngle)^2 else 0)) else quaternionAngle;
  primaryPointingErrorPublisher=primaryAngle;
  secondaryPointingErrorPublisher=secondaryAngle;
  attitudeErrorPublisher=attitudeErrorMagnitude;
  bodyRateMagnitudePublisher=bodyRateMagnitude;
  bodyRatePublisher=measuredBodyRate;
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
    groundLinkAttitudeReadyPublisher=groundLinkElapsed >= settleDwellTime;
  actualControlModePublisher=if dwellComplete then information.command.desiredControlMode else 
    OneSatSim.Foundation.Types.ControlMode.Initialization;
  attitudeControlStatePublisher=if anyWheelSaturated then OneSatSim.Foundation.Types.AttitudeControlState.Saturated else 
    if information.command.desiredControlMode == OneSatSim.Foundation.Types.ControlMode.Initialization then OneSatSim.Foundation.Types.AttitudeControlState.Initialization else 
    if not pointingQuality then OneSatSim.Foundation.Types.AttitudeControlState.Slewing else 
    if not dwellComplete then OneSatSim.Foundation.Types.AttitudeControlState.Settling else 
    if information.command.desiredControlMode == OneSatSim.Foundation.Types.ControlMode.SafeMode then OneSatSim.Foundation.Types.AttitudeControlState.SafeMode else 
    if information.command.desiredControlMode == OneSatSim.Foundation.Types.ControlMode.SunPointing then OneSatSim.Foundation.Types.AttitudeControlState.SunPointing else OneSatSim.Foundation.Types.AttitudeControlState.Tracking;
  annotation(Documentation(info="<html><h2>低阶双矢量姿态控制核心</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Models.AOCSControlComputation</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>根据现有测量与参考输入执行低阶双矢量姿态控制计算，形成轮系或相应执行请求；使用当前参考系与角度/角速度单位。</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Foundation.Models.EquivalentAOCSCore\">OneSatSim.Foundation.Models.EquivalentAOCSCore</a> 的 <code>logic</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>environment</code></td><td>OneSatSim.Foundation.Interfaces.EnvironmentPort</td><td>public</td><td>按声明/类型合同</td><td>外部环境接口或实例</td></tr><tr><td><code>information</code></td><td>OneSatSim.Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr><tr><td><code>wheelCommandPublisher[4]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>rad/s</td><td>飞轮指令Publisher [rad/s]</td></tr><tr><td><code>primaryPointingErrorPublisher</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>rad</td><td>primaryPointing误差Publisher [rad]</td></tr><tr><td><code>secondaryPointingErrorPublisher</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>rad</td><td>secondaryPointing误差Publisher [rad]</td></tr><tr><td><code>attitudeErrorPublisher</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>rad</td><td>姿态误差Publisher [rad]</td></tr><tr><td><code>bodyRateMagnitudePublisher</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>rad/s</td><td>本体速率MagnitudePublisher [rad/s]</td></tr><tr><td><code>bodyRatePublisher[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>rad/s</td><td>本体速率Publisher [rad/s]</td></tr><tr><td><code>attitudeSettledPublisher</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>姿态SettledPublisher</td></tr><tr><td><code>attitudeReadyPublisher</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>姿态就绪Publisher</td></tr><tr><td><code>imagingWindowReadyPublisher</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>成像Window就绪Publisher</td></tr><tr><td><code>imagingAttitudeReadyPublisher</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>成像姿态就绪Publisher</td></tr><tr><td><code>groundLinkAttitudeReadyPublisher</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>地面链路姿态就绪Publisher</td></tr><tr><td><code>actualControlModePublisher</code></td><td>OneSatSim.Foundation.Interfaces.ControlModeOutput</td><td>public</td><td>按声明/类型合同</td><td>actual控制模式Publisher</td></tr><tr><td><code>attitudeControlStatePublisher</code></td><td>OneSatSim.Foundation.Interfaces.AttitudeControlStateOutput</td><td>public</td><td>按声明/类型合同</td><td>姿态控制状态Publisher</td></tr><tr><td><code>pointingQuality</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>pointing质量标记</td></tr><tr><td><code>pointingQualityRatio</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>pointing质量标记Ratio；Active primary/rate/secondary qualification expressed as a worst normalized ratio</td></tr><tr><td><code>groundLinkQuality</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>地面链路质量标记</td></tr><tr><td><code>qualityViolationSignal</code></td><td>Modelica.Blocks.Interfaces.BooleanInput</td><td>public</td><td>按声明/类型合同</td><td>质量标记Violation信号</td></tr><tr><td><code>settlingElapsed</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>s</td><td>计算/接口量 settlingElapsed [s]</td></tr><tr><td><code>groundLinkElapsed</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>s</td><td>地面链路Elapsed [s]</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>massProperties</code></td><td>OneSatSim.Foundation.Types.MassProperties</td><td>由活动机械刚体离线汇总的统一整星质量、质心与惯量</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>wheelCapabilities</code></td><td>OneSatSim.Foundation.Types.WheelGroupCapabilities</td><td>飞轮Capabilities；Shared X/Y/Z/S wheel inertia, torque, speed and mounting axes</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>maxManeuverRate</code></td><td>Real</td><td>系统级 finite attitude-service slew limit</td><td><code>=2*Modelica.Constants.pi/180</code></td></tr><tr><td><code>maneuverTimeConstant</code></td><td>Real</td><td>maneuver时间Constant [s]；First-order large/small-angle maneuver scaling</td><td><code>=5</code></td></tr><tr><td><code>rateServoTimeConstant</code></td><td>Real</td><td>速率Servo时间Constant [s]；Low-order body-rate service time constant</td><td><code>=5</code></td></tr><tr><td><code>wheelSpeedServoGain[4]</code></td><td>Real</td><td>飞轮速度Servo增益 [N.m.s/rad]；Control gains shared with the four physical wheel servos</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>skewAllocationFraction</code></td><td>Real</td><td>配置项 skewAllocationFraction；Share of commanded body torque assigned to the diagonal S wheel</td><td><code>=0.30</code></td></tr><tr><td><code>wheelBalanceSoftStart</code></td><td>Real</td><td>飞轮BalanceSoftStart；Below this wheel-speed utilization the null-space balancer is inactive</td><td><code>=0.38</code></td></tr><tr><td><code>wheelBalanceStrongStart</code></td><td>Real</td><td>飞轮BalanceStrongStart；Utilization at which the null-space wheel-speed penalty is strengthened</td><td><code>=0.58</code></td></tr><tr><td><code>wheelPreferredUtilization</code></td><td>Real</td><td>飞轮PreferredUtilization；Soft design target; physical hard limits come from wheelCapabilities.maxSpeed</td><td><code>=0.70</code></td></tr><tr><td><code>wheelBalanceGain</code></td><td>Real</td><td>飞轮Balance增益 [N.m]；Idle/SunPointing-only continuous null-space momentum balancing gain</td><td><code>=0.004</code></td></tr><tr><td><code>wheelBalancePriority[4]</code></td><td>Real</td><td>飞轮BalancePriority；Optional per-wheel balancing cost; unity was used in the accepted configuration</td><td><code>=fill(1,4)</code></td></tr><tr><td><code>sunChargingBoresightBody[3]</code></td><td>Real</td><td>sunChargingBoresight本体；45 degree bisector of body-mounted +X and +Y solar faces</td><td><code>={0.7071067811865476,0.7071067811865476,0}</code></td></tr><tr><td><code>cameraBoresightBody[3]</code></td><td>Real</td><td>cameraBoresight本体</td><td><code>={1,0,0}</code></td></tr><tr><td><code>groundBoresightBody[3]</code></td><td>Real</td><td>地面Boresight本体</td><td><code>={1,0,0}</code></td></tr><tr><td><code>targetPointingTolerance</code></td><td>Real</td><td>目标PointingTolerance [rad]；Earth-camera attitude qualification, independent of the 7 degree half-FOV</td><td><code>=0.5*Modelica.Constants.pi/180</code></td></tr><tr><td><code>sunPointingTolerance</code></td><td>Real</td><td>配置项 sunPointingTolerance [rad]；Two-face charging needs coarse, not payload-grade, primary alignment</td><td><code>=0.035</code></td></tr><tr><td><code>groundPointingTolerance</code></td><td>Real</td><td>地面PointingTolerance [rad]；Patch-antenna ground LOS qualification (6.9 degree)</td><td><code>=0.12</code></td></tr><tr><td><code>secondaryTolerance</code></td><td>Real</td><td>配置项 secondaryTolerance [rad]；Roll-about-LOS qualification; camera FOV and target illumination remain independently enforced</td><td><code>=0.30</code></td></tr><tr><td><code>groundSecondaryTolerance</code></td><td>Real</td><td>地面SecondaryTolerance [rad]；Solar-aware roll qualification during wide-beam ground tracking</td><td><code>=0.50</code></td></tr><tr><td><code>bodyRateTolerance</code></td><td>Real</td><td>本体速率Tolerance [rad/s]</td><td><code>=0.002</code></td></tr><tr><td><code>trackingRateTolerance</code></td><td>Real</td><td>跟踪速率Tolerance [rad/s]；Maximum body-to-LOS relative tracking-rate error</td><td><code>=0.05*Modelica.Constants.pi/180</code></td></tr><tr><td><code>settleDwellTime</code></td><td>Real</td><td>settleDwell时间 [s]；Passed through from the effective imaging capability record</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>skewAxis[3]</code></td><td>Real</td><td>配置项 skewAxis；S-wheel mounting axis from the shared physical capability</td><td><code>={wheelCapabilities.axes[1,4], wheelCapabilities.axes[2,4],wheelCapabilities.axes[3,4]}</code></td></tr><tr><td><code>nullVector[4]</code></td><td>Real</td><td>配置项 nullVector；One-dimensional null space for the configured X/Y/Z/S wheel-axis matrix with the verified X/Y/Z basis</td><td><code>={-skewAxis[1],-skewAxis[2],-skewAxis[3],1}</code></td></tr><tr><td><code>nominalWheelInertia</code></td><td>Real</td><td>nominal飞轮惯量 [kg.m2]；Former 9.7e-5 kg.m2 normalization, now derived from the four configured rotors</td><td><code>=sum(wheelCapabilities.J)/4</code></td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] measuredQuaternionNorm=sqrt(noEvent(max(1e-12, sum(information.device.starQuaternion[1,i]^2 for i in 1:4))));\n[equation] measuredQuaternion=if measuredQuaternionNorm &gt; 0.5 then {information.device.starQuaternion[1,2],information.device.starQuaternion[1,3], information.device.starQuaternion[1,4],information.device.starQuaternion[1,1]}/measuredQuaternionNorm else {0,0,0,1};\n[equation] quaternionSign=noEvent(if measuredQuaternion[4] &gt;= 0 then 1 else -1);\n[equation] quaternionError=2*quaternionSign*measuredQuaternion[1:3];\n[equation] quaternionAngle=2*acos(noEvent(max(0,min(1,abs(measuredQuaternion[4])))));\n[equation] sunMode=information.command.desiredControlMode == OneSatSim.Foundation.Types.ControlMode.SunPointing or information.command.desiredControlMode == OneSatSim.Foundation.Types.ControlMode.SafeMode;\n[equation] targetMode=information.command.desiredControlMode == OneSatSim.Foundation.Types.ControlMode.TargetPointing;\n[equation] groundMode=information.command.desiredControlMode == OneSatSim.Foundation.Types.ControlMode.GroundPointing;\n[equation] vectorMode=sunMode or targetMode or groundMode;\n[equation] taskVectorMode=targetMode or groundMode;</pre><p>本类另有72段语句；阅读完整源码可查看其余边界与逻辑。</p><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>quaternionSign</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>四元数Sign</td></tr><tr><td><code>quaternionError[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>四元数误差</td></tr><tr><td><code>quaternionAngle</code></td><td>Real</td><td>public</td><td>rad</td><td>四元数Angle [rad]</td></tr><tr><td><code>measuredQuaternionNorm</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>measured四元数Norm</td></tr><tr><td><code>measuredQuaternion[4]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>measured四元数；Star-Y measured world-to-body quaternion in MSL vector-first order</td></tr><tr><td><code>measuredBodyRate[3]</code></td><td>Real</td><td>public</td><td>rad/s</td><td>measured本体速率 [rad/s]；Precision gyro during task pointing, MEMS gyro otherwise</td></tr><tr><td><code>measuredSunVectorBody[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>measuredSunVector本体</td></tr><tr><td><code>sunMode</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>sun模式</td></tr><tr><td><code>targetMode</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>目标模式</td></tr><tr><td><code>groundMode</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>地面模式</td></tr><tr><td><code>vectorMode</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>vector模式</td></tr><tr><td><code>referenceValid</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 referenceValid</td></tr><tr><td><code>taskVectorMode</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>taskVector模式</td></tr><tr><td><code>rawPrimaryReference[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 rawPrimaryReference</td></tr><tr><td><code>primaryReferenceNorm</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 primaryReferenceNorm</td></tr><tr><td><code>primaryReference[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 primaryReference</td></tr><tr><td><code>primaryBoresight[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 primaryBoresight</td></tr><tr><td><code>primaryCrossRaw[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 primaryCrossRaw</td></tr><tr><td><code>primaryCrossNorm</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 primaryCrossNorm</td></tr><tr><td><code>primaryCrossError[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>primaryCross误差</td></tr><tr><td><code>primaryAngle</code></td><td>Real</td><td>public</td><td>rad</td><td>计算/接口量 primaryAngle [rad]</td></tr><tr><td><code>sunProjectionRaw[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 sunProjectionRaw</td></tr><tr><td><code>sunProjectionNorm</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 sunProjectionNorm</td></tr><tr><td><code>fallbackProjectionRaw[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 fallbackProjectionRaw</td></tr><tr><td><code>fallbackProjectionNorm</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 fallbackProjectionNorm</td></tr><tr><td><code>secondaryReference[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 secondaryReference</td></tr><tr><td><code>secondaryCrossError[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>secondaryCross误差</td></tr><tr><td><code>secondaryAngle</code></td><td>Real</td><td>public</td><td>rad</td><td>计算/接口量 secondaryAngle [rad]</td></tr><tr><td><code>primarySlewAxis[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 primarySlewAxis</td></tr><tr><td><code>primarySlewRate</code></td><td>Real</td><td>public</td><td>rad/s</td><td>primarySlew速率 [rad/s]</td></tr><tr><td><code>secondarySlewRate</code></td><td>Real</td><td>public</td><td>rad/s</td><td>secondarySlew速率 [rad/s]</td></tr><tr><td><code>desiredBodyRate[3]</code></td><td>Real</td><td>public</td><td>rad/s</td><td>desired本体速率 [rad/s]</td></tr><tr><td><code>bodyTorqueCommand[3]</code></td><td>Real</td><td>public</td><td>N.m</td><td>本体Torque指令 [N.m]</td></tr><tr><td><code>rotorTorqueBase[4]</code></td><td>Real</td><td>public</td><td>N.m</td><td>计算/接口量 rotorTorqueBase [N.m]</td></tr><tr><td><code>rotorTorqueCommand[4]</code></td><td>Real</td><td>public</td><td>N.m</td><td>rotorTorque指令 [N.m]</td></tr><tr><td><code>wheelSpeedOffset[4]</code></td><td>Real</td><td>public</td><td>rad/s</td><td>飞轮速度偏移 [rad/s]</td></tr><tr><td><code>normalizedWheelSpeed[4]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>normalized飞轮速度</td></tr><tr><td><code>wheelMomentum[4]</code></td><td>Real</td><td>public</td><td>N.m.s</td><td>飞轮Momentum [N.m.s]</td></tr><tr><td><code>normalizedWheelMomentum[4]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>normalized飞轮Momentum</td></tr><tr><td><code>softBalanceActivation[4]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 softBalanceActivation</td></tr><tr><td><code>strongBalanceActivation[4]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 strongBalanceActivation</td></tr><tr><td><code>wheelPenaltyActivation[4]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>飞轮PenaltyActivation</td></tr><tr><td><code>softPenalty[4]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 softPenalty</td></tr><tr><td><code>weightedWheelMomentum[4]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>weighted飞轮Momentum</td></tr><tr><td><code>balanceEnabled</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>balance启用</td></tr><tr><td><code>balanceActivation</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 balanceActivation</td></tr><tr><td><code>balanceError</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>balance误差</td></tr><tr><td><code>deltaBalanceRaw</code></td><td>Real</td><td>public</td><td>N.m</td><td>计算/接口量 deltaBalanceRaw [N.m]</td></tr><tr><td><code>deltaLowerBound[4]</code></td><td>Real</td><td>public</td><td>N.m</td><td>delta下界Bound [N.m]</td></tr><tr><td><code>deltaUpperBound[4]</code></td><td>Real</td><td>public</td><td>N.m</td><td>delta上界Bound [N.m]</td></tr><tr><td><code>deltaMin</code></td><td>Real</td><td>public</td><td>N.m</td><td>计算/接口量 deltaMin [N.m]</td></tr><tr><td><code>deltaMax</code></td><td>Real</td><td>public</td><td>N.m</td><td>计算/接口量 deltaMax [N.m]</td></tr><tr><td><code>deltaBalance</code></td><td>Real</td><td>public</td><td>N.m</td><td>计算/接口量 deltaBalance [N.m]</td></tr><tr><td><code>attitudeErrorMagnitude</code></td><td>Real</td><td>public</td><td>rad</td><td>姿态误差Magnitude [rad]</td></tr><tr><td><code>bodyRateMagnitude</code></td><td>Real</td><td>public</td><td>rad/s</td><td>本体速率Magnitude [rad/s]</td></tr><tr><td><code>pointingRateMagnitude</code></td><td>Real</td><td>public</td><td>rad/s</td><td>pointing速率Magnitude [rad/s]；Rate that disturbs the active pointing objective</td></tr><tr><td><code>referenceTrackingRate[3]</code></td><td>Real</td><td>public</td><td>rad/s</td><td>reference跟踪速率 [rad/s]</td></tr><tr><td><code>anyWheelSaturated</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>any飞轮Saturated</td></tr><tr><td><code>dwellComplete</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 dwellComplete</td></tr><tr><td><code>attitudeEstimateValidInternal</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>姿态EstimateValidInternal</td></tr><tr><td><code>wheelActuationAvailableInternal</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>飞轮ActuationAvailableInternal</td></tr></table><h3>使用边界</h3><p>本工程的轨道环境采用离线固化数据；任务、姿态、电热及信息边界按当前配置和接口使用。已有未完成任务目标与平台状态见根README，不由本次注释更新改写。</p></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-41.336,20.2416},{-15.6752,25.944},{-4.7456,16.9152},{-30.4064,11.2128},{-41.336,20.2416}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-41.336,20.2416},{-30.4064,11.2128},{-30.4064,-17.2992},{-41.336,-8.2704},{-41.336,20.2416}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-30.4064,11.2128},{-4.7456,16.9152},{-4.7456,-11.5968},{-30.4064,-17.2992},{-30.4064,11.2128}}, lineColor={0,0,0}, fillColor={246,247,248}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{-41.336,10.7376},{-30.4064,1.7088},{-4.7456,7.4112}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-41.336,1.2336},{-30.4064,-7.7952},{-4.7456,-2.0928}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-28.353536,11.668992},{-28.353536,-16.843008}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-6.798464,16.459008},{-6.798464,-12.052992}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-41.336,20.2416},{-30.4064,-17.2992}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-30.4064,11.2128},{-41.336,-8.2704}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-30.4064,11.2128},{-4.7456,-11.5968}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-4.7456,16.9152},{-30.4064,-17.2992}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Ellipse(extent={{-27.5552,16.9152},{-19.952,23.0928}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{-25.6544,18.3408},{-21.8528,21.6672}}, lineColor={0,0,0}, fillColor={223,233,238}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Ellipse(extent={{-42.14384,19.43376},{-40.52816,21.04944}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-41.73992,20.2416},{-40.93208,20.2416}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-31.21424,10.40496},{-29.59856,12.02064}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-30.81032,11.2128},{-30.00248,11.2128}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-5.55344,16.10736},{-3.93776,17.72304}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-5.14952,16.9152},{-4.34168,16.9152}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-42.14384,-9.07824},{-40.52816,-7.46256}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-41.73992,-8.2704},{-40.93208,-8.2704}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-31.21424,-18.10704},{-29.59856,-16.49136}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-30.81032,-17.2992},{-30.00248,-17.2992}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-5.55344,-12.40464},{-3.93776,-10.78896}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-5.14952,-11.5968},{-4.34168,-11.5968}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{11.8,-12},{31.24,-12}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{11.8,-12},{1.6912,0.4416}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{11.8,-12},{11.8,7.44}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-49.4,28.32},{-31.4,41.28},{-10.52,39.84},{2.44,29.04}}, color={76,128,143}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{-58.76,3.84},{-55.88,-12.72},{-41.48,-24.24}}, color={76,128,143}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{-4.04,6},{12.52,15.36},{31.24,15.36}}, color={76,128,143}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-4.04,6},{19,35.52}}, color={113,122,132}, thickness=0.55, pattern=LinePattern.Dash),
      Ellipse(extent={{17.56,31.2},{26.2,39.84}}, lineColor={76,128,143}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, startAngle=0, endAngle=360),
      Rectangle(extent={{43,-31},{72,28}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{47,15},{68,15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,0},{68,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,-15},{68,-15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-57,-51},{37,-34}}, textString="reference -> torque", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Attitude Computation", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-314,-291},{348.8,351}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-78.32,-85.36},{78.32,83.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-66.88,56.32},{66.88,56.32}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-73.92,60.72},{-56.32,78.32}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-53.68,62.48},{66.88,75.68}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-36.3757,17.8126},{-13.7942,22.8307},{-4.1761,14.8854},{-26.7576,9.8673},{-36.3757,17.8126}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-36.3757,17.8126},{-26.7576,9.8673},{-26.7576,-15.2233},{-36.3757,-7.278},{-36.3757,17.8126}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-26.7576,9.8673},{-4.1761,14.8854},{-4.1761,-10.2052},{-26.7576,-15.2233},{-26.7576,9.8673}}, lineColor={0,0,0}, fillColor={246,247,248}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{-36.3757,9.4491},{-26.7576,1.5037},{-4.1761,6.5219}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-36.3757,1.0856},{-26.7576,-6.8598},{-4.1761,-1.8417}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-24.9511,10.2687},{-24.9511,-14.8218}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-5.9826,14.4839},{-5.9826,-10.6066}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-36.3757,17.8126},{-26.7576,-15.2233}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-26.7576,9.8673},{-36.3757,-7.278}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-26.7576,9.8673},{-4.1761,-10.2052}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-4.1761,14.8854},{-26.7576,-15.2233}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Ellipse(extent={{-24.2486,14.8854},{-17.5578,20.3217}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{-22.5759,16.1399},{-19.2305,19.0671}}, lineColor={0,0,0}, fillColor={223,233,238}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Ellipse(extent={{-37.0866,17.1017},{-35.6648,18.5235}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-36.7311,17.8126},{-36.0202,17.8126}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-27.4685,9.1564},{-26.0467,10.5782}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-27.1131,9.8673},{-26.4022,9.8673}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-4.887,14.1745},{-3.4652,15.5963}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-4.5316,14.8854},{-3.8207,14.8854}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-37.0866,-7.9889},{-35.6648,-6.5671}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-36.7311,-7.278},{-36.0202,-7.278}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-27.4685,-15.9342},{-26.0467,-14.5124}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-27.1131,-15.2233},{-26.4022,-15.2233}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-4.887,-10.9161},{-3.4652,-9.4943}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-4.5316,-10.2052},{-3.8207,-10.2052}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{10.384,-10.56},{27.4912,-10.56}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{10.384,-10.56},{1.4883,0.3886}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{10.384,-10.56},{10.384,6.5472}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-43.472,24.9216},{-27.632,36.3264},{-9.2576,35.0592},{2.1472,25.5552}}, color={76,128,143}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{-51.7088,3.3792},{-49.1744,-11.1936},{-36.5024,-21.3312}}, color={76,128,143}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{-3.5552,5.28},{11.0176,13.5168},{27.4912,13.5168}}, color={76,128,143}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-3.5552,5.28},{16.72,31.2576}}, color={113,122,132}, thickness=0.55, pattern=LinePattern.Dash),
      Ellipse(extent={{15.4528,27.456},{23.056,35.0592}}, lineColor={76,128,143}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, startAngle=0, endAngle=360),
      Rectangle(extent={{37.84,-27.28},{63.36,24.64}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{41.36,13.2},{59.84,13.2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{41.36,0},{59.84,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{41.36,-13.2},{59.84,-13.2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-50.16,-44.88},{32.56,-29.92}}, textString="reference -> torque", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-66.88,-51.04},{66.88,-51.04}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-70.4,-69.52},{70.4,-56.32}}, textString="Attitude Computation", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{222,263},{317,281}}, textString="CONTROL", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{222,159},{317,177}}, textString="ERRORS", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{222,55},{317,73}}, textString="READINESS", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{222,-101},{322.8,-83}}, textString="MODE / STATE", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{222,-179},{317,-161}}, textString="QUALITY", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-302,306},{336.8,335}}, textString="AOCS Control Computation", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-302,298},{336.8,298}}, color={215,220,226}, thickness=0.25)
    }));
end AOCSControlComputation;