within OneSatSim.Foundation.Models;
model EquivalentAOCSCore "低阶双矢量姿态控制核心"
  parameter OneSatSim.Foundation.Types.MassProperties massProperties "由活动机械刚体离线汇总的统一整星质量、质心与惯量" ;
  parameter OneSatSim.Foundation.Types.WheelGroupCapabilities wheelCapabilities
    "飞轮Capabilities；Derived physical capability shared with the four wheel devices";
  OneSatSim.Foundation.Interfaces.EnvironmentPort environment 
     "外部环境接口或实例" annotation(Placement(visible=true, transformation(origin={-310,100}, extent={{-18,-18},{18,18}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.InformationPort information 
     "计算/接口量 information" annotation(Placement(visible=true, transformation(origin={390,40}, extent={{-18,-18},{18,18}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
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
    "settleDwell时间 [s]；Effective imaging capability dwell; no local independent default";
  AOCSControlComputation logic(
    massProperties=massProperties,
    wheelCapabilities=wheelCapabilities,
    maxManeuverRate=maxManeuverRate,
    maneuverTimeConstant=maneuverTimeConstant,
    rateServoTimeConstant=rateServoTimeConstant,
    wheelSpeedServoGain=wheelSpeedServoGain,
    skewAllocationFraction=skewAllocationFraction,
    wheelBalanceSoftStart=wheelBalanceSoftStart,
    wheelBalanceStrongStart=wheelBalanceStrongStart,
    wheelPreferredUtilization=wheelPreferredUtilization,
    wheelBalanceGain=wheelBalanceGain,
    wheelBalancePriority=wheelBalancePriority,
    sunChargingBoresightBody=sunChargingBoresightBody,
    cameraBoresightBody=cameraBoresightBody,
    groundBoresightBody=groundBoresightBody,
    targetPointingTolerance=targetPointingTolerance,
    sunPointingTolerance=sunPointingTolerance,
    groundPointingTolerance=groundPointingTolerance,
    secondaryTolerance=secondaryTolerance,
    groundSecondaryTolerance=groundSecondaryTolerance,
    bodyRateTolerance=bodyRateTolerance,
    trackingRateTolerance=trackingRateTolerance,
    settleDwellTime=settleDwellTime) 
     "低阶双矢量姿态控制核心实例" annotation(Placement(visible=true, transformation(origin={-85,20}, extent={{-100,-100},{100,100}}, rotation=0)));
  Modelica.Blocks.Logical.Hysteresis qualityViolation(
    uLow=1.0,uHigh=1.10,pre_y_start=true)
    "质量标记Violation；Enter qualification only below the strict limit; leave above 110 percent to suppress threshold chatter" 
    annotation(Placement(visible=true, transformation(origin={80,235}, extent={{-38,-38},{38,38}}, rotation=180)));
  Modelica.Blocks.Logical.Timer settlingTimer "计算/接口量 settlingTimer；Continuous-good-pointing dwell timer" 
    annotation(Placement(visible=true, transformation(origin={-100,235}, extent={{-38,-38},{38,38}}, rotation=180)));
  Modelica.Blocks.Logical.Timer groundLinkSettlingTimer "通信主视轴连续合格驻留计时" 
    annotation(Placement(visible=true, transformation(origin={-100,-205}, extent={{-38,-38},{38,38}}, rotation=180)));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[11]  "实数因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={245,160}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.BooleanSignalBridge informationBooleanBridge[5]  "布尔因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={245,50}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.ControlModeSignalBridge informationControlModeBridge 
     "控制模式因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={245,-60}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.AttitudeControlStateSignalBridge informationAttitudeStateBridge 
     "姿态控制状态因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={245,-175}, extent={{-16,-16},{16,16}}, rotation=0)));
equation
  connect(environment,logic.environment) annotation(Line(points={{-310,100},{-174,100}}, color={0,166,81}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,logic.information) annotation(Line(points={{390,40},{390,100},{4,100}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(logic.pointingQualityRatio,qualityViolation.u) annotation(Line(points={{4,-50},{135.6,-50},{135.6,235},{125.6,235}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(qualityViolation.y,logic.qualityViolationSignal) annotation(Line(points={{38.2,235},{28.2,235},{28.2,125},{-184,125},{-184,46.66667},{-174,46.66667}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(logic.pointingQuality,settlingTimer.u) annotation(Line(points={{4,-40},{14,-40},{14,235},{-54.4,235}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(settlingTimer.y,logic.settlingElapsed) annotation(Line(points={{-141.8,235},{-230,235},{-230,-6.66667},{-174,-6.66667}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(logic.groundLinkQuality,groundLinkSettlingTimer.u) annotation(Line(points={{4,-60},{14,-60},{14,-205},{-54.4,-205}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(groundLinkSettlingTimer.y,logic.groundLinkElapsed) annotation(Line(points={{-141.8,-205},{-184,-205},{-184,-60},{-174,-60}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(logic.wheelCommandPublisher[1],informationRealBridge[1].u) annotation(Line(points={{4,90},{204.74,90},{204.74,160},{230.76,160}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[1].y,information.command.wheelCommand[1]) annotation(Line(points={{259.24,160},{390,160},{390,40}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(logic.wheelCommandPublisher[2],informationRealBridge[2].u) annotation(Line(points={{4,90},{204.74,90},{204.74,160},{230.76,160}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[2].y,information.command.wheelCommand[2]) annotation(Line(points={{259.24,160},{390,160},{390,40}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(logic.wheelCommandPublisher[3],informationRealBridge[3].u) annotation(Line(points={{4,90},{204.74,90},{204.74,160},{230.76,160}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[3].y,information.command.wheelCommand[3]) annotation(Line(points={{259.24,160},{390,160},{390,40}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(logic.wheelCommandPublisher[4],informationRealBridge[4].u) annotation(Line(points={{4,90},{204.74,90},{204.74,160},{230.76,160}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[4].y,information.command.wheelCommand[4]) annotation(Line(points={{259.24,160},{390,160},{390,40}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(logic.primaryPointingErrorPublisher,informationRealBridge[5].u) annotation(Line(points={{4,80},{204.74,80},{204.74,160},{230.76,160}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[5].y,information.device.primaryPointingError) annotation(Line(points={{259.24,160},{390,160},{390,40}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(logic.secondaryPointingErrorPublisher,informationRealBridge[6].u) annotation(Line(points={{4,70},{204.74,70},{204.74,160},{230.76,160}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[6].y,information.device.secondaryPointingError) annotation(Line(points={{259.24,160},{390,160},{390,40}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(logic.attitudeErrorPublisher,informationRealBridge[7].u) annotation(Line(points={{4,60},{204.74,60},{204.74,160},{230.76,160}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[7].y,information.device.attitudeError) annotation(Line(points={{259.24,160},{390,160},{390,40}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(logic.bodyRateMagnitudePublisher,informationRealBridge[8].u) annotation(Line(points={{4,50},{204.74,50},{204.74,160},{230.76,160}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[8].y,information.device.bodyRateMagnitude) annotation(Line(points={{259.24,160},{390,160},{390,40}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(logic.bodyRatePublisher[1],informationRealBridge[9].u) annotation(Line(points={{4,40},{204.74,40},{204.74,160},{230.76,160}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[9].y,information.device.bodyRate[1]) annotation(Line(points={{259.24,160},{390,160},{390,40}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(logic.bodyRatePublisher[2],informationRealBridge[10].u) annotation(Line(points={{4,40},{204.74,40},{204.74,160},{230.76,160}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[10].y,information.device.bodyRate[2]) annotation(Line(points={{259.24,160},{390,160},{390,40}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(logic.bodyRatePublisher[3],informationRealBridge[11].u) annotation(Line(points={{4,40},{204.74,40},{204.74,160},{230.76,160}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[11].y,information.device.bodyRate[3]) annotation(Line(points={{259.24,160},{390,160},{390,40}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(logic.attitudeSettledPublisher,informationBooleanBridge[1].u) annotation(Line(points={{4,30},{204.74,30},{204.74,50},{230.76,50}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationBooleanBridge[1].y,information.device.attitudeSettled) annotation(Line(points={{259.24,50},{390,50},{390,40}}, color={255,0,255}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(logic.attitudeReadyPublisher,informationBooleanBridge[2].u) annotation(Line(points={{4,20},{204.74,20},{204.74,50},{230.76,50}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationBooleanBridge[2].y,information.device.attitudeReady) annotation(Line(points={{259.24,50},{390,50},{390,40}}, color={255,0,255}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(logic.imagingWindowReadyPublisher,informationBooleanBridge[3].u) annotation(Line(points={{4,10},{204.74,10},{204.74,50},{230.76,50}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationBooleanBridge[3].y,information.device.imagingWindowReady) annotation(Line(points={{259.24,50},{390,50},{390,40}}, color={255,0,255}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(logic.imagingAttitudeReadyPublisher,informationBooleanBridge[4].u) annotation(Line(points={{4,0},{204.74,0},{204.74,50},{230.76,50}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationBooleanBridge[4].y,information.device.imagingAttitudeReady) annotation(Line(points={{259.24,50},{390,50},{390,40}}, color={255,0,255}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(logic.groundLinkAttitudeReadyPublisher,informationBooleanBridge[5].u) annotation(Line(points={{4,-10},{204.74,-10},{204.74,50},{230.76,50}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationBooleanBridge[5].y,information.device.groundLinkAttitudeReady) annotation(Line(points={{259.24,50},{390,50},{390,40}}, color={255,0,255}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(logic.actualControlModePublisher,informationControlModeBridge.u) annotation(Line(points={{4,-20},{206.52,-20},{206.52,-60},{230.76,-60}}, color={0,102,255}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationControlModeBridge.y,information.device.actualControlMode) annotation(Line(points={{259.24,-60},{390,-60},{390,40}}, color={0,102,255}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(logic.attitudeControlStatePublisher,informationAttitudeStateBridge.u) annotation(Line(points={{4,-30},{14,-30},{14,-175},{230.76,-175}}, color={124,58,237}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationAttitudeStateBridge.y,information.device.attitudeControlState) annotation(Line(points={{259.24,-175},{390,-175},{390,40}}, color={124,58,237}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>低阶双矢量姿态控制核心</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Models.EquivalentAOCSCore</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>装配当前低阶双矢量姿态计算及其接口适配；具体计算与状态责任依当前子组件分工。</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.GNCComputerUnit\">OneSatSim.Components.GNCComputerUnit</a> 的 <code>controlLaw</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>environment</code></td><td>OneSatSim.Foundation.Interfaces.EnvironmentPort</td><td>public</td><td>按声明/类型合同</td><td>外部环境接口或实例</td></tr><tr><td><code>information</code></td><td>OneSatSim.Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr><tr><td><code>informationRealBridge[11]</code></td><td>Foundation.Interfaces.RealSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>实数因果输出到可扩展信息总线的无状态恒等桥实例</td></tr><tr><td><code>informationBooleanBridge[5]</code></td><td>Foundation.Interfaces.BooleanSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>布尔因果输出到可扩展信息总线的无状态恒等桥实例</td></tr><tr><td><code>informationControlModeBridge</code></td><td>Foundation.Interfaces.ControlModeSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>控制模式因果输出到可扩展信息总线的无状态恒等桥实例</td></tr><tr><td><code>informationAttitudeStateBridge</code></td><td>Foundation.Interfaces.AttitudeControlStateSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>姿态控制状态因果输出到可扩展信息总线的无状态恒等桥实例</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>massProperties</code></td><td>OneSatSim.Foundation.Types.MassProperties</td><td>由活动机械刚体离线汇总的统一整星质量、质心与惯量</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>wheelCapabilities</code></td><td>OneSatSim.Foundation.Types.WheelGroupCapabilities</td><td>飞轮Capabilities；Derived physical capability shared with the four wheel devices</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>maxManeuverRate</code></td><td>Real</td><td>系统级 finite attitude-service slew limit</td><td><code>=2*Modelica.Constants.pi/180</code></td></tr><tr><td><code>maneuverTimeConstant</code></td><td>Real</td><td>maneuver时间Constant [s]；First-order large/small-angle maneuver scaling</td><td><code>=5</code></td></tr><tr><td><code>rateServoTimeConstant</code></td><td>Real</td><td>速率Servo时间Constant [s]；Low-order body-rate service time constant</td><td><code>=5</code></td></tr><tr><td><code>wheelSpeedServoGain[4]</code></td><td>Real</td><td>飞轮速度Servo增益 [N.m.s/rad]；Control gains shared with the four physical wheel servos</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>skewAllocationFraction</code></td><td>Real</td><td>配置项 skewAllocationFraction；Share of commanded body torque assigned to the diagonal S wheel</td><td><code>=0.30</code></td></tr><tr><td><code>wheelBalanceSoftStart</code></td><td>Real</td><td>飞轮BalanceSoftStart；Below this wheel-speed utilization the null-space balancer is inactive</td><td><code>=0.38</code></td></tr><tr><td><code>wheelBalanceStrongStart</code></td><td>Real</td><td>飞轮BalanceStrongStart；Utilization at which the null-space wheel-speed penalty is strengthened</td><td><code>=0.58</code></td></tr><tr><td><code>wheelPreferredUtilization</code></td><td>Real</td><td>飞轮PreferredUtilization；Soft design target; physical hard limits come from wheelCapabilities.maxSpeed</td><td><code>=0.70</code></td></tr><tr><td><code>wheelBalanceGain</code></td><td>Real</td><td>飞轮Balance增益 [N.m]；Idle/SunPointing-only continuous null-space momentum balancing gain</td><td><code>=0.004</code></td></tr><tr><td><code>wheelBalancePriority[4]</code></td><td>Real</td><td>飞轮BalancePriority；Optional per-wheel balancing cost; unity was used in the accepted configuration</td><td><code>=fill(1,4)</code></td></tr><tr><td><code>sunChargingBoresightBody[3]</code></td><td>Real</td><td>sunChargingBoresight本体；45 degree bisector of body-mounted +X and +Y solar faces</td><td><code>={0.7071067811865476,0.7071067811865476,0}</code></td></tr><tr><td><code>cameraBoresightBody[3]</code></td><td>Real</td><td>cameraBoresight本体</td><td><code>={1,0,0}</code></td></tr><tr><td><code>groundBoresightBody[3]</code></td><td>Real</td><td>地面Boresight本体</td><td><code>={1,0,0}</code></td></tr><tr><td><code>targetPointingTolerance</code></td><td>Real</td><td>目标PointingTolerance [rad]；Earth-camera attitude qualification, independent of the 7 degree half-FOV</td><td><code>=0.5*Modelica.Constants.pi/180</code></td></tr><tr><td><code>sunPointingTolerance</code></td><td>Real</td><td>配置项 sunPointingTolerance [rad]；Two-face charging needs coarse, not payload-grade, primary alignment</td><td><code>=0.035</code></td></tr><tr><td><code>groundPointingTolerance</code></td><td>Real</td><td>地面PointingTolerance [rad]；Patch-antenna ground LOS qualification (6.9 degree)</td><td><code>=0.12</code></td></tr><tr><td><code>secondaryTolerance</code></td><td>Real</td><td>配置项 secondaryTolerance [rad]；Roll-about-LOS qualification; camera FOV and target illumination remain independently enforced</td><td><code>=0.30</code></td></tr><tr><td><code>groundSecondaryTolerance</code></td><td>Real</td><td>地面SecondaryTolerance [rad]；Solar-aware roll qualification during wide-beam ground tracking</td><td><code>=0.50</code></td></tr><tr><td><code>bodyRateTolerance</code></td><td>Real</td><td>本体速率Tolerance [rad/s]</td><td><code>=0.002</code></td></tr><tr><td><code>trackingRateTolerance</code></td><td>Real</td><td>跟踪速率Tolerance [rad/s]；Maximum body-to-LOS relative tracking-rate error</td><td><code>=0.05*Modelica.Constants.pi/180</code></td></tr><tr><td><code>settleDwellTime</code></td><td>Real</td><td>settleDwell时间 [s]；Effective imaging capability dwell; no local independent default</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>logic</code></td><td><a href=\"modelica://OneSatSim.Foundation.Models.AOCSControlComputation\">OneSatSim.Foundation.Models.AOCSControlComputation</a></td><td>低阶双矢量姿态控制核心实例</td></tr><tr><td><code>qualityViolation</code></td><td><a href=\"modelica://Modelica.Blocks.Logical.Hysteresis\">Modelica.Blocks.Logical.Hysteresis</a></td><td>质量标记Violation；Enter qualification only below the strict limit; leave above 110 percent to suppress threshold chatter</td></tr><tr><td><code>settlingTimer</code></td><td><a href=\"modelica://Modelica.Blocks.Logical.Timer\">Modelica.Blocks.Logical.Timer</a></td><td>计算/接口量 settlingTimer；Continuous-good-pointing dwell timer</td></tr><tr><td><code>groundLinkSettlingTimer</code></td><td><a href=\"modelica://Modelica.Blocks.Logical.Timer\">Modelica.Blocks.Logical.Timer</a></td><td>通信主视轴连续合格驻留计时</td></tr></table><h3>使用边界</h3><p>本工程的轨道环境采用离线固化数据；任务、姿态、电热及信息边界按当前配置和接口使用。已有未完成任务目标与平台状态见根README，不由本次注释更新改写。</p></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-33.8,19.78},{1.84,27.7},{17.02,15.16},{-18.62,7.24},{-33.8,19.78}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-33.8,19.78},{-18.62,7.24},{-18.62,-32.36},{-33.8,-19.82},{-33.8,19.78}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-18.62,7.24},{17.02,15.16},{17.02,-24.44},{-18.62,-32.36},{-18.62,7.24}}, lineColor={0,0,0}, fillColor={246,247,248}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{-33.8,6.58},{-18.62,-5.96},{17.02,1.96}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-33.8,-6.62},{-18.62,-19.16},{17.02,-11.24}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-15.7688,7.8736},{-15.7688,-31.7264}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{14.1688,14.5264},{14.1688,-25.0736}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-33.8,19.78},{-18.62,-32.36}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-18.62,7.24},{-33.8,-19.82}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-18.62,7.24},{17.02,-24.44}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{17.02,15.16},{-18.62,-32.36}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Ellipse(extent={{-14.66,15.16},{-4.1,23.74}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{-12.02,17.14},{-6.74,21.76}}, lineColor={0,0,0}, fillColor={223,233,238}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Ellipse(extent={{-34.922,18.658},{-32.678,20.902}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-34.361,19.78},{-33.239,19.78}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-19.742,6.118},{-17.498,8.362}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-19.181,7.24},{-18.059,7.24}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{15.898,14.038},{18.142,16.282}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{16.459,15.16},{17.581,15.16}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-34.922,-20.942},{-32.678,-18.698}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-34.361,-19.82},{-33.239,-19.82}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-19.742,-33.482},{-17.498,-31.238}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-19.181,-32.36},{-18.059,-32.36}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{15.898,-25.562},{18.142,-23.318}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{16.459,-24.44},{17.581,-24.44}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{40,-25},{67,-25}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{40,-25},{25.96,-7.72}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{40,-25},{40,2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-45,31},{-20,49},{9,47},{27,32}}, color={76,128,143}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{-58,-3},{-54,-26},{-34,-42}}, color={76,128,143}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{18,0},{41,13},{67,13}}, color={76,128,143}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{18,0},{50,41}}, color={113,122,132}, thickness=0.55, pattern=LinePattern.Dash),
      Ellipse(extent={{48,35},{60,47}}, lineColor={76,128,143}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, startAngle=0, endAngle=360),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Attitude Control Core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-357,-281},{437,392}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-220,154},{-119.2,172}}, textString="CONTROL CORE", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-165,304},{-13.8,322}}, textString="QUALITY / SETTLING", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-165,-141},{-70,-123}}, textString="GROUND LINK", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{175,229},{359.8,247}}, textString="INFORMATION PUBLISHING", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-345,347},{425,376}}, textString="Attitude Control Computation", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-345,339},{425,339}}, color={215,220,226}, thickness=0.25)
    }));
end EquivalentAOCSCore;