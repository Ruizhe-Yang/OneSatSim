within OneSatSim.Components;
model MagnetorquerUnit "三轴磁力矩器组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.MagnetorquerComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter OneSatSim.Foundation.Types.WheelGroupCapabilities wheelCapabilities "飞轮Capabilities" ;
  parameter Modelica.Units.SI.HeatCapacity heatCapacity=config.HeatCapacity
    "磁力矩器线圈热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountConductance=config.MountConductance
    "磁力矩器安装导热；Excel单位W/K，当前设计基线";
  parameter Modelica.Units.SI.Mass mass=config.Mass
    "质量；Excel单位kg，当前设计基线";
  parameter Modelica.Units.SI.Length rcm_X=config.RCM_X
    "质心偏置X；Excel单位m，当前设计基线";
  parameter Modelica.Units.SI.Length rcm_Y=config.RCM_Y
    "质心偏置Y；Excel单位m，当前设计基线";
  parameter Modelica.Units.SI.Length rcm_Z=config.RCM_Z
    "质心偏置Z；Excel单位m，当前设计基线";
  parameter Modelica.Units.SI.Inertia inertia_XX=config.Inertia_XX
    "局部惯量 Ixx；Excel单位kg·m²，当前设计基线";
  parameter Modelica.Units.SI.Inertia inertia_YY=config.Inertia_YY
    "局部惯量 Iyy；Excel单位kg·m²，当前设计基线";
  parameter Modelica.Units.SI.Inertia inertia_ZZ=config.Inertia_ZZ
    "局部惯量 Izz；Excel单位kg·m²，当前设计基线";
  parameter Real safeModeActivationBodyRate(unit="rad/s")=0.02
    "任务级参数: energize rods only for actual safe-mode detumbling";
  parameter Real detumbleDampingTorque(unit="N.m.s")=2e-5
    "任务级参数: equivalent rate-damping gain";
  parameter Real minimumFieldSquared(unit="T2")=4e-10
    "配置项 minimumFieldSquared [T2]；Below this field strength the low-order B-dot equivalent is disabled";
  parameter Modelica.Units.SI.Current coilCurrentLimit=config.CoilCurrentLimit "coil电流限制 [A]" ;
  parameter Real dipolePerAmpere[3]={config.DipolePerAmpere_X,config.DipolePerAmpere_Y,config.DipolePerAmpere_Z}
    "任务级参数: 1.0 A.m2 maximum moment per axis at 0.28 A";
  parameter Real momentumDumpEnterSpeed(unit="rad/s")=240.8554368
    "momentumDumpEnter速度 [rad/s]；2300 rpm entry threshold; starts physical momentum unloading earlier in SunPointing";
  parameter Real momentumDumpExitSpeed(unit="rad/s")=157.0796327
    "momentumDumpExit速度 [rad/s]；1500 rpm exit threshold";
  parameter Real momentumDumpTorque(unit="N.m")=3e-4
    "配置项 momentumDumpTorque [N.m]；Low-order unloading torque magnitude";
  parameter Real normalRateDampingGain(unit="N.m.s")=5e-4
    "normal速率Damping增益 [N.m.s]；Sun/Idle B-dot equivalent used to remove residual rigid-body momentum";
  parameter Real normalRateDampingEnter(unit="rad/s")=1.2e-4 "normal速率DampingEnter [rad/s]" ;
  parameter Real normalRateDampingExit(unit="rad/s")=6e-5 "normal速率DampingExit [rad/s]" ;
  parameter Real wheelInertia[4](each unit="kg.m2")=wheelCapabilities.J
    "飞轮惯量 [kg.m2]；X/Y/Z/S physical rotor inertias used for body-frame stored momentum";
  Foundation.Interfaces.PowerPort power  "功率" annotation(Placement(visible=true, transformation(origin={-455,355}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,95}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Conductor unused12Rail(G=0)  "计算/接口量 unused12Rail" annotation(Placement(visible=true, transformation(origin={-345,440}, extent={{-20,-20},{20,20}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0)  "计算/接口量 unused33Rail" annotation(Placement(visible=true, transformation(origin={-245,440}, extent={{-20,-20},{20,20}}, rotation=0)));
  Foundation.Interfaces.ThermalPort thermal  "热学" annotation(Placement(visible=true, transformation(origin={490,-275}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,-97}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(visible=true, transformation(origin={340,-70}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.InformationPort information  "计算/接口量 information" annotation(Placement(visible=true, transformation(origin={605,60}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.RealSignalReader wheelSpeedFromInformation[4] 
     "可扩展总线实数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-335,215}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.RealSignalReader bodyRateMagnitudeFromInformation 
     "可扩展总线实数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-335,85}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.RealSignalReader bodyRateFromInformation[3] 
     "可扩展总线实数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-335,-45}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.RealSignalReader magneticFieldFromInformation[3] 
     "可扩展总线实数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-185,-165}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.RealSignalReader supplyVoltageFromInformation 
     "可扩展总线实数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-50,-165}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.BooleanSignalReader safeModeFromInformation 
     "可扩展总线布尔信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-335,-185}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Calculations.MomentumUnloadingCalculation unloadingCalculation(
    safeModeActivationBodyRate=safeModeActivationBodyRate,
    detumbleDampingTorque=detumbleDampingTorque,
    minimumFieldSquared=minimumFieldSquared,
    coilCurrentLimit=coilCurrentLimit,
    dipolePerAmpere=dipolePerAmpere,
    momentumDumpTorque=momentumDumpTorque,
    normalRateDampingGain=normalRateDampingGain,
    wheelInertia=wheelInertia,
    wheelAxes=wheelCapabilities.axes) 
     "磁力矩器动量卸载与消旋计算实例" annotation(Placement(visible=true, transformation(origin={-15,65}, extent={{-78,-78},{78,78}}, rotation=0)));
  Modelica.Blocks.Logical.Hysteresis momentumDumpLatch(
    uLow=momentumDumpExitSpeed,
    uHigh=momentumDumpEnterSpeed)
    "计算/接口量 momentumDumpLatch；2300 rpm enter / 1500 rpm exit hysteresis" annotation(Placement(visible=true, transformation(origin={-150,265}, extent={{-28,-28},{28,28}}, rotation=0)));
  Modelica.Blocks.Logical.Hysteresis normalRateDampingLatch(
    uLow=normalRateDampingExit,
    uHigh=normalRateDampingEnter)  "normal速率DampingLatch" annotation(Placement(visible=true, transformation(origin={-20,265}, extent={{-28,-28},{28,28}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor mainSupplyCurrent  "main供给电流" annotation(Placement(visible=true, transformation(origin={100,355}, extent={{-26,-26},{26,26}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.VariableConductor coilRX(useHeatPort=true)  "计算/接口量 coilRX" annotation(Placement(visible=true, transformation(origin={220,315}, extent={{-26,-26},{26,26}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.VariableConductor coilRY(useHeatPort=true)  "计算/接口量 coilRY" annotation(Placement(visible=true, transformation(origin={325,315}, extent={{-26,-26},{26,26}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.VariableConductor coilRZ(useHeatPort=true)  "计算/接口量 coilRZ" annotation(Placement(visible=true, transformation(origin={430,315}, extent={{-26,-26},{26,26}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor coilThermalMass(C=heatCapacity,T(start=293.15,fixed=false))  "coil热学质量" annotation(Placement(visible=true, transformation(origin={215,-245}, extent={{-30,-30},{30,30}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor framePath(G=mountConductance)  "参考系Path" annotation(Placement(visible=true, transformation(origin={350,-275}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.Body rods(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ)  "计算/接口量 rods" annotation(Placement(visible=true, transformation(origin={205,-70}, extent={{-34,-34},{34,34}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Forces.WorldTorque torqueSource(
    resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b,
    animation=false)  "torque源" annotation(Placement(visible=true, transformation(origin={205,70}, extent={{-36,-36},{36,36}}, rotation=0)));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[4]  "实数因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={455,90}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.BooleanSignalBridge informationBooleanBridge[1]  "布尔因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={455,-65}, extent={{-16,-16},{16,16}}, rotation=0)));
equation
  connect(power.p12,unused12Rail.p) annotation(Line(points={{-455,355},{-455,440},{-365,440}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{-325,440},{-315,440},{-315,402},{-455,402},{-455,355}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{-455,355},{-455,402},{-275,402},{-275,440},{-265,440}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{-225,440},{-215,440},{-215,355},{-455,355}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information.device.wheelSpeed[1],wheelSpeedFromInformation[1].u) annotation(Line(points={{605,60},{605,149.1},{-382.38,149.1},{-382.38,215},{-349.24,215}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information.device.wheelSpeed[2],wheelSpeedFromInformation[2].u) annotation(Line(points={{605,60},{605,149.1},{-382.38,149.1},{-382.38,215},{-349.24,215}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information.device.wheelSpeed[3],wheelSpeedFromInformation[3].u) annotation(Line(points={{605,60},{605,149.1},{-382.38,149.1},{-382.38,215},{-349.24,215}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information.device.wheelSpeed[4],wheelSpeedFromInformation[4].u) annotation(Line(points={{605,60},{605,149.1},{-382.38,149.1},{-382.38,215},{-349.24,215}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(wheelSpeedFromInformation.y,unloadingCalculation.wheelSpeed) annotation(Line(points={{-320.76,215},{-287.62,215},{-287.62,127.4},{-84.42,127.4}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information.device.bodyRateMagnitude,bodyRateMagnitudeFromInformation.u) annotation(Line(points={{605,60},{605,149.1},{-382.38,149.1},{-382.38,85},{-349.24,85}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(bodyRateMagnitudeFromInformation.y,unloadingCalculation.bodyRateMagnitude) annotation(Line(points={{-320.76,85},{-94.42,85},{-94.42,111.8},{-84.42,111.8}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information.device.bodyRate,bodyRateFromInformation.u) annotation(Line(points={{605,60},{605,-114},{-382.38,-114},{-382.38,-45},{-349.24,-45}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(bodyRateFromInformation.y,unloadingCalculation.bodyRate) annotation(Line(points={{-320.76,-45},{-94.42,-45},{-94.42,96.2},{-84.42,96.2}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information.device.magneticField,magneticFieldFromInformation.u) annotation(Line(points={{605,60},{605,-115.74},{-232.38,-115.74},{-232.38,-165},{-199.24,-165}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(magneticFieldFromInformation.y,unloadingCalculation.magneticField) annotation(Line(points={{-170.76,-165},{-137.62,-165},{-137.62,-92},{-87,-92},{-87,-15.1},{-94.42,-15.1},{-94.42,80.6},{-84.42,80.6}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information.device.busVoltage[2],supplyVoltageFromInformation.u) annotation(Line(points={{605,60},{605,-115.74},{-97.38,-115.74},{-97.38,-165},{-64.24,-165}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(supplyVoltageFromInformation.y,unloadingCalculation.supplyVoltage) annotation(Line(points={{-35.76,-165},{-2.62,-165},{-2.62,-54},{-94.42,-54},{-94.42,65},{-84.42,65}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information.command.safeMode,safeModeFromInformation.u) annotation(Line(points={{605,60},{605,-115.74},{-382.38,-115.74},{-382.38,-185},{-349.24,-185}}, color={255,0,255}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(safeModeFromInformation.y,unloadingCalculation.safeMode) annotation(Line(points={{-320.76,-185},{-287.62,-185},{-287.62,-54},{-94.42,-54},{-94.42,49.4},{-84.42,49.4}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information.command.desiredControlMode,unloadingCalculation.desiredControlMode) annotation(Line(points={{605,60},{605,-15.1},{-94.42,-15.1},{-94.42,33.8},{-84.42,33.8}}, color={0,102,255}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unloadingCalculation.maximumWheelSpeed,momentumDumpLatch.u) annotation(Line(points={{54.42,127.4},{64.42,127.4},{64.42,197},{-193.6,197},{-193.6,265},{-183.6,265}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(momentumDumpLatch.y,unloadingCalculation.momentumDumpLatched) annotation(Line(points={{-119.2,265},{-109.2,265},{-109.2,197},{-11.4,197},{-11.4,159},{-94.42,159},{-94.42,18.2},{-84.42,18.2}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unloadingCalculation.bodyRateForDamping,normalRateDampingLatch.u) annotation(Line(points={{54.42,106.6},{64.42,106.6},{64.42,197},{-63.6,197},{-63.6,265},{-53.6,265}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(normalRateDampingLatch.y,unloadingCalculation.rateDampingLatched) annotation(Line(points={{10.8,265},{20.8,265},{20.8,149.1},{-94.42,149.1},{-94.42,2.6},{-84.42,2.6}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unloadingCalculation.momentumDumpActive,informationBooleanBridge[1].u) annotation(Line(points={{54.42,85.8},{64.42,85.8},{64.42,-26},{407.62,-26},{407.62,-65},{440.76,-65}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationBooleanBridge[1].y,information.device.momentumDumpActive) annotation(Line(points={{469.24,-65},{605,-65},{605,60}}, color={255,0,255}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p5,mainSupplyCurrent.p) annotation(Line(points={{-455,355},{74,355}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mainSupplyCurrent.n,coilRX.p) annotation(Line(points={{126,355},{184,355},{184,315},{194,315}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mainSupplyCurrent.n,coilRY.p) annotation(Line(points={{126,355},{289,355},{289,315},{299,315}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mainSupplyCurrent.n,coilRZ.p) annotation(Line(points={{126,355},{394,355},{394,315},{404,315}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mainSupplyCurrent.i,informationRealBridge[1].u) annotation(Line(points={{100,326.4},{100,279},{405.84,279},{405.84,90},{440.76,90}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[1].y,information.device.tcCurrent[23]) annotation(Line(points={{469.24,90},{605,90},{605,60}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unloadingCalculation.coilConductanceCommand[1],coilRX.G) annotation(Line(points={{54.42,44.2},{136,44.2},{136,356.2},{220,356.2},{220,346.2}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unloadingCalculation.coilConductanceCommand[2],coilRY.G) annotation(Line(points={{54.42,44.2},{136,44.2},{136,356.2},{325,356.2},{325,346.2}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unloadingCalculation.coilConductanceCommand[3],coilRZ.G) annotation(Line(points={{54.42,44.2},{136,44.2},{136,356.2},{430,356.2},{430,346.2}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(coilRX.n,power.n5) annotation(Line(points={{246,315},{256,315},{256,402},{-455,402},{-455,355}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(coilRY.n,power.n5) annotation(Line(points={{351,315},{361,315},{361,402},{-455,402},{-455,355}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(coilRZ.n,power.n5) annotation(Line(points={{456,315},{466,315},{466,402},{-455,402},{-455,355}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(coilRX.heatPort,coilThermalMass.port) annotation(Line(points={{220,289},{220,279},{249,279},{249,-285},{215,-285},{215,-275}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(coilRY.heatPort,coilThermalMass.port) annotation(Line(points={{325,289},{325,279},{249,279},{249,-285},{215,-285},{215,-275}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(coilRZ.heatPort,coilThermalMass.port) annotation(Line(points={{430,289},{430,279},{249,279},{249,-285},{215,-285},{215,-275}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(coilThermalMass.port,framePath.port_a) annotation(Line(points={{215,-275},{215,-285},{316,-285},{316,-275},{326,-275}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(framePath.port_b,thermal) annotation(Line(points={{374,-275},{490,-275}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(rods.frame_a,mechanical) annotation(Line(points={{171,-70},{161,-70},{161,-114},{340,-114},{340,-70}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unloadingCalculation.magneticTorque,torqueSource.torque) annotation(Line(points={{54.42,23.4},{151.8,23.4},{151.8,70},{161.8,70}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(torqueSource.frame_b,mechanical) annotation(Line(points={{241,70},{340,70},{340,-70}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unloadingCalculation.magneticTorque[1],informationRealBridge[2].u) annotation(Line(points={{54.42,23.4},{249,23.4},{249,90},{440.76,90}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[2].y,information.device.magnetorquerTorque[1]) annotation(Line(points={{469.24,90},{605,90},{605,60}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unloadingCalculation.magneticTorque[2],informationRealBridge[3].u) annotation(Line(points={{54.42,23.4},{249,23.4},{249,90},{440.76,90}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[3].y,information.device.magnetorquerTorque[2]) annotation(Line(points={{469.24,90},{605,90},{605,60}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unloadingCalculation.magneticTorque[3],informationRealBridge[4].u) annotation(Line(points={{54.42,23.4},{249,23.4},{249,90},{440.76,90}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[4].y,information.device.magnetorquerTorque[3]) annotation(Line(points={{469.24,90},{605,90},{605,60}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>三轴磁力矩器组件</h2><p><b>类路径：</b><code>OneSatSim.Components.MagnetorquerUnit</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>三轴磁力矩器组件</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.N_systems.GNCSystem\">OneSatSim.Systems.N_systems.GNCSystem</a> 的 <code>magnetorquer</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>power</code></td><td>Foundation.Interfaces.PowerPort</td><td>public</td><td>按声明/类型合同</td><td>功率</td></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr><tr><td><code>information</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr><tr><td><code>wheelSpeedFromInformation[4]</code></td><td>Foundation.Interfaces.RealSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线实数信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>bodyRateMagnitudeFromInformation</code></td><td>Foundation.Interfaces.RealSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线实数信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>bodyRateFromInformation[3]</code></td><td>Foundation.Interfaces.RealSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线实数信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>magneticFieldFromInformation[3]</code></td><td>Foundation.Interfaces.RealSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线实数信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>supplyVoltageFromInformation</code></td><td>Foundation.Interfaces.RealSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线实数信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>safeModeFromInformation</code></td><td>Foundation.Interfaces.BooleanSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线布尔信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>informationRealBridge[4]</code></td><td>Foundation.Interfaces.RealSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>实数因果输出到可扩展信息总线的无状态恒等桥实例</td></tr><tr><td><code>informationBooleanBridge[1]</code></td><td>Foundation.Interfaces.BooleanSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>布尔因果输出到可扩展信息总线的无状态恒等桥实例</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>config</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.MagnetorquerComponentConfig</td><td>由所属N-System传入的硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>wheelCapabilities</code></td><td>OneSatSim.Foundation.Types.WheelGroupCapabilities</td><td>飞轮Capabilities</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>heatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>磁力矩器线圈热容；Excel单位J/K，当前设计基线</td><td><code>=config.HeatCapacity</code></td></tr><tr><td><code>mountConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>磁力矩器安装导热；Excel单位W/K，当前设计基线</td><td><code>=config.MountConductance</code></td></tr><tr><td><code>mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel单位kg，当前设计基线</td><td><code>=config.Mass</code></td></tr><tr><td><code>rcm_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel单位m，当前设计基线</td><td><code>=config.RCM_X</code></td></tr><tr><td><code>rcm_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel单位m，当前设计基线</td><td><code>=config.RCM_Y</code></td></tr><tr><td><code>rcm_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel单位m，当前设计基线</td><td><code>=config.RCM_Z</code></td></tr><tr><td><code>inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_XX</code></td></tr><tr><td><code>inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_YY</code></td></tr><tr><td><code>inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_ZZ</code></td></tr><tr><td><code>safeModeActivationBodyRate</code></td><td>Real</td><td>任务级参数: energize rods only for actual safe-mode detumbling</td><td><code>=0.02</code></td></tr><tr><td><code>detumbleDampingTorque</code></td><td>Real</td><td>任务级参数: equivalent rate-damping gain</td><td><code>=2e-5</code></td></tr><tr><td><code>minimumFieldSquared</code></td><td>Real</td><td>配置项 minimumFieldSquared [T2]；Below this field strength the low-order B-dot equivalent is disabled</td><td><code>=4e-10</code></td></tr><tr><td><code>coilCurrentLimit</code></td><td>Modelica.Units.SI.Current</td><td>coil电流限制 [A]</td><td><code>=config.CoilCurrentLimit</code></td></tr><tr><td><code>dipolePerAmpere[3]</code></td><td>Real</td><td>任务级参数: 1.0 A.m2 maximum moment per axis at 0.28 A</td><td><code>={config.DipolePerAmpere_X,config.DipolePerAmpere_Y,config.DipolePerAmpere_Z}</code></td></tr><tr><td><code>momentumDumpEnterSpeed</code></td><td>Real</td><td>momentumDumpEnter速度 [rad/s]；2300 rpm entry threshold; starts physical momentum unloading earlier in SunPointing</td><td><code>=240.8554368</code></td></tr><tr><td><code>momentumDumpExitSpeed</code></td><td>Real</td><td>momentumDumpExit速度 [rad/s]；1500 rpm exit threshold</td><td><code>=157.0796327</code></td></tr><tr><td><code>momentumDumpTorque</code></td><td>Real</td><td>配置项 momentumDumpTorque [N.m]；Low-order unloading torque magnitude</td><td><code>=3e-4</code></td></tr><tr><td><code>normalRateDampingGain</code></td><td>Real</td><td>normal速率Damping增益 [N.m.s]；Sun/Idle B-dot equivalent used to remove residual rigid-body momentum</td><td><code>=5e-4</code></td></tr><tr><td><code>normalRateDampingEnter</code></td><td>Real</td><td>normal速率DampingEnter [rad/s]</td><td><code>=1.2e-4</code></td></tr><tr><td><code>normalRateDampingExit</code></td><td>Real</td><td>normal速率DampingExit [rad/s]</td><td><code>=6e-5</code></td></tr><tr><td><code>wheelInertia[4]</code></td><td>Real</td><td>飞轮惯量 [kg.m2]；X/Y/Z/S physical rotor inertias used for body-frame stored momentum</td><td><code>=wheelCapabilities.J</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>unused12Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused12Rail</td></tr><tr><td><code>unused33Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused33Rail</td></tr><tr><td><code>unloadingCalculation</code></td><td><a href=\"modelica://OneSatSim.Foundation.Calculations.MomentumUnloadingCalculation\">OneSatSim.Foundation.Calculations.MomentumUnloadingCalculation</a></td><td>磁力矩器动量卸载与消旋计算实例</td></tr><tr><td><code>momentumDumpLatch</code></td><td><a href=\"modelica://Modelica.Blocks.Logical.Hysteresis\">Modelica.Blocks.Logical.Hysteresis</a></td><td>计算/接口量 momentumDumpLatch；2300 rpm enter / 1500 rpm exit hysteresis</td></tr><tr><td><code>normalRateDampingLatch</code></td><td><a href=\"modelica://Modelica.Blocks.Logical.Hysteresis\">Modelica.Blocks.Logical.Hysteresis</a></td><td>normal速率DampingLatch</td></tr><tr><td><code>mainSupplyCurrent</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Sensors.CurrentSensor\">Modelica.Electrical.Analog.Sensors.CurrentSensor</a></td><td>main供给电流</td></tr><tr><td><code>coilRX</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.VariableConductor\">Modelica.Electrical.Analog.Basic.VariableConductor</a></td><td>计算/接口量 coilRX</td></tr><tr><td><code>coilRY</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.VariableConductor\">Modelica.Electrical.Analog.Basic.VariableConductor</a></td><td>计算/接口量 coilRY</td></tr><tr><td><code>coilRZ</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.VariableConductor\">Modelica.Electrical.Analog.Basic.VariableConductor</a></td><td>计算/接口量 coilRZ</td></tr><tr><td><code>coilThermalMass</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a></td><td>coil热学质量</td></tr><tr><td><code>framePath</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">Modelica.Thermal.HeatTransfer.Components.ThermalConductor</a></td><td>参考系Path</td></tr><tr><td><code>rods</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">Modelica.Mechanics.MultiBody.Parts.Body</a></td><td>计算/接口量 rods</td></tr><tr><td><code>torqueSource</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Forces.WorldTorque\">Modelica.Mechanics.MultiBody.Forces.WorldTorque</a></td><td>torque源</td></tr></table></html>"
),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Magnetic actuator", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-51,7},{-3,19}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{-44,5},{-47,21}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-39,5},{-42,21}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-34,5},{-37,21}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-29,5},{-32,21}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-24,5},{-27,21}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-19,5},{-22,21}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-14,5},{-17,21}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-57,13},{-51,13},{-51,-2},{-1,-2}}, color={0,0,0}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{-13,-15},{35,-3}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{-6,-17},{-9,-1}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-1,-17},{-4,-1}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{4,-17},{1,-1}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{9,-17},{6,-1}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{14,-17},{11,-1}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{19,-17},{16,-1}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{24,-17},{21,-1}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-19,-9},{-13,-9},{-13,-24},{37,-24}}, color={0,0,0}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{11,25},{59,37}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{18,23},{15,39}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{23,23},{20,39}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{28,23},{25,39}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{33,23},{30,39}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{38,23},{35,39}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{43,23},{40,39}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{48,23},{45,39}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{5,31},{11,31},{11,16},{61,16}}, color={0,0,0}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-45,44},{-24,55},{10,55},{38,49}}, color={76,128,143}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{51,-30},{72,-30}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{51,-30},{40.08,-16.56}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{51,-30},{51,-9}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Magnetorquer Set", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-499,-337},{649,542}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-265,169},{-21.4,187}}, textString="Functional core and telemetry", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-330,374},{-229.2,392}}, textString="Power supply", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-265,-82},{-97,-64}}, textString="Thermal and mounting", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-487,497},{637,526}}, textString="Magnetorquer: momentum unloading and rod actuation", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-487,489},{637,489}}, color={215,220,226}, thickness=0.25)
    }));
end MagnetorquerUnit;