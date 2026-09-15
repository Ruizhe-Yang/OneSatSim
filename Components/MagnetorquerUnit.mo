within OneSatSim.Components;
model MagnetorquerUnit "三轴磁力矩器组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.MagnetorquerComponentConfig config
    "由所属N-System传入的硬件设计配置";
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
    "Below this field strength the low-order B-dot equivalent is disabled";
  parameter Modelica.Units.SI.Current coilCurrentLimit=config.CoilCurrentLimit;
  parameter Real dipolePerAmpere[3]={config.DipolePerAmpere_X,config.DipolePerAmpere_Y,config.DipolePerAmpere_Z}
    "任务级参数: 1.0 A.m2 maximum moment per axis at 0.28 A";
  parameter Real momentumDumpEnterSpeed(unit="rad/s")=240.8554368
    "2300 rpm entry threshold; starts physical momentum unloading earlier in SunPointing";
  parameter Real momentumDumpExitSpeed(unit="rad/s")=157.0796327
    "1500 rpm exit threshold";
  parameter Real momentumDumpTorque(unit="N.m")=3e-4
    "Low-order unloading torque magnitude";
  parameter Real normalRateDampingGain(unit="N.m.s")=5e-4
    "Sun/Idle B-dot equivalent used to remove residual rigid-body momentum";
  parameter Real normalRateDampingEnter(unit="rad/s")=1.2e-4;
  parameter Real normalRateDampingExit(unit="rad/s")=6e-5;
  parameter Real wheelInertia[4](each unit="kg.m2")={9.5e-5,9.8e-5,9.3e-5,1.02e-4}
    "X/Y/Z/S physical rotor inertias used for body-frame stored momentum";
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}}),iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Basic.Conductor unused12Rail(G=0) annotation(Placement(transformation(extent={{66,76},{78,88}})));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0) annotation(Placement(transformation(extent={{66,52},{78,64}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  Foundation.Interfaces.RealSignalReader wheelSpeedFromInformation[4]
    annotation(Placement(transformation(extent={{-96,70},{-80,82}})));
  Foundation.Interfaces.RealSignalReader bodyRateMagnitudeFromInformation
    annotation(Placement(transformation(extent={{-72,54},{-56,66}})));
  Foundation.Interfaces.RealSignalReader bodyRateFromInformation[3]
    annotation(Placement(transformation(extent={{-72,38},{-56,50}})));
  Foundation.Interfaces.RealSignalReader magneticFieldFromInformation[3]
    annotation(Placement(transformation(extent={{-96,22},{-80,34}})));
  Foundation.Interfaces.RealSignalReader supplyVoltageFromInformation
    annotation(Placement(transformation(extent={{-96,6},{-80,18}})));
  Foundation.Interfaces.BooleanSignalReader safeModeFromInformation
    annotation(Placement(transformation(extent={{68,-2},{84,10}})));
  Foundation.Calculations.MomentumUnloadingCalculation unloadingCalculation(
    safeModeActivationBodyRate=safeModeActivationBodyRate,
    detumbleDampingTorque=detumbleDampingTorque,
    minimumFieldSquared=minimumFieldSquared,
    coilCurrentLimit=coilCurrentLimit,
    dipolePerAmpere=dipolePerAmpere,
    momentumDumpTorque=momentumDumpTorque,
    normalRateDampingGain=normalRateDampingGain,
    wheelInertia=wheelInertia)
    annotation(Placement(transformation(extent={{16,-22},{56,22}})));
  Modelica.Blocks.Logical.Hysteresis momentumDumpLatch(
    uLow=momentumDumpExitSpeed,
    uHigh=momentumDumpEnterSpeed)
    "2300 rpm enter / 1500 rpm exit hysteresis" annotation(Placement(transformation(extent={{18,56},{34,72}})));
  Modelica.Blocks.Logical.Hysteresis normalRateDampingLatch(
    uLow=normalRateDampingExit,
    uHigh=normalRateDampingEnter) annotation(Placement(transformation(extent={{42,56},{58,72}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor mainSupplyCurrent annotation(Placement(transformation(extent={{-92,48},{-78,68}})));
  Modelica.Electrical.Analog.Basic.VariableConductor coilRX(useHeatPort=true) annotation(Placement(transformation(extent={{-35,48},{-15,68}})));
  Modelica.Electrical.Analog.Basic.VariableConductor coilRY(useHeatPort=true) annotation(Placement(transformation(extent={{-35,18},{-15,38}})));
  Modelica.Electrical.Analog.Basic.VariableConductor coilRZ(useHeatPort=true) annotation(Placement(transformation(extent={{-35,-12},{-15,8}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor coilThermalMass(C=heatCapacity,T(start=293.15,fixed=false)) annotation(Placement(transformation(extent={{-20,-52},{0,-32}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor framePath(G=mountConductance) annotation(Placement(transformation(extent={{20,-50},{40,-34}})));
  Modelica.Mechanics.MultiBody.Parts.Body rods(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-70,12},{-50,32}})));
  Modelica.Mechanics.MultiBody.Forces.WorldTorque torqueSource(
    resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameB.frame_b,
    animation=false) annotation(Placement(transformation(extent={{-82,-28},{-62,-8}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[4] annotation(Placement(transformation(extent={{78,20},{86,28}})));
  Foundation.Interfaces.BooleanSignalBridge informationBooleanBridge[1] annotation(Placement(transformation(extent={{78,-20},{86,-12}})));
equation
  connect(power.p12,unused12Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,82}},color={0,0,255}));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{78,82},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,58}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{78,58},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(information.device.wheelSpeed[1],wheelSpeedFromInformation[1].u) annotation(Line(points={{100,0},{94,0},{94,76},{-96,76}},color={0,0,127}));
  connect(information.device.wheelSpeed[2],wheelSpeedFromInformation[2].u) annotation(Line(points={{100,0},{94,0},{94,76},{-96,76}},color={0,0,127}));
  connect(information.device.wheelSpeed[3],wheelSpeedFromInformation[3].u) annotation(Line(points={{100,0},{94,0},{94,76},{-96,76}},color={0,0,127}));
  connect(information.device.wheelSpeed[4],wheelSpeedFromInformation[4].u) annotation(Line(points={{100,0},{94,0},{94,76},{-96,76}},color={0,0,127}));
  connect(wheelSpeedFromInformation.y,unloadingCalculation.wheelSpeed) annotation(Line(points={{-80,76},{16,76},{16,18.5}},color={0,0,127}));
  connect(information.device.bodyRateMagnitude,bodyRateMagnitudeFromInformation.u) annotation(Line(points={{100,0},{100,39.5},{-54.5,39.5},{-54.5,60},{-72,60}},color={0,0,127}));
  connect(bodyRateMagnitudeFromInformation.y,unloadingCalculation.bodyRateMagnitude) annotation(Line(points={{-56,60},{-36.5,60},{-36.5,12},{16,12}},color={0,0,127}));
  connect(information.device.bodyRate,bodyRateFromInformation.u) annotation(Line(points={{100,0},{94,0},{94,44},{-72,44}},color={0,0,127}));
  connect(bodyRateFromInformation.y,unloadingCalculation.bodyRate) annotation(Line(points={{-56,44},{16,44},{16,5.4}},color={0,0,127}));
  connect(information.device.magneticField,magneticFieldFromInformation.u) annotation(Line(points={{100,0},{100,39.5},{-54.5,39.5},{-54.5,33.5},{-96,33.5},{-96,28}},color={0,0,127}));
  connect(magneticFieldFromInformation.y,unloadingCalculation.magneticField) annotation(Line(points={{-80,28},{-71.5,28},{-71.5,9.5},{16,9.5},{16,-1.2}},color={0,0,127}));
  connect(information.device.busVoltage[2],supplyVoltageFromInformation.u) annotation(Line(points={{100,0},{100,29.5},{-13.5,29.5},{-13.5,10.5},{-88.5,10.5},{-88.5,12},{-96,12}},color={0,0,127}));
  connect(supplyVoltageFromInformation.y,unloadingCalculation.supplyVoltage) annotation(Line(points={{-80,12},{-80,9.5},{16,9.5},{16,-7.8}},color={0,0,127}));
  connect(information.command.safeMode,safeModeFromInformation.u) annotation(Line(points={{100,0},{94,0},{94,4},{68,4}},color={255,0,255}));
  connect(safeModeFromInformation.y,unloadingCalculation.safeMode) annotation(Line(points={{84,4},{16,4},{16,-14.4}},color={255,0,255}));
  connect(information.command.desiredControlMode,unloadingCalculation.desiredControlMode) annotation(Line(points={{100,0},{94,0},{94,-24.2},{36,-24.2}},color={255,127,0}));
  connect(unloadingCalculation.maximumWheelSpeed,momentumDumpLatch.u) annotation(Line(points={{54,18.7},{10,18.7},{10,64},{16.4,64}},color={0,0,127}));
  connect(momentumDumpLatch.y,unloadingCalculation.momentumDumpLatched) annotation(Line(points={{34.8,64},{36,64},{36,24.2},{20,24.2}},color={255,0,255}));
  connect(unloadingCalculation.bodyRateForDamping,normalRateDampingLatch.u) annotation(Line(points={{54,13.2},{38,13.2},{38,64},{40.4,64}},color={0,0,127}));
  connect(normalRateDampingLatch.y,unloadingCalculation.rateDampingLatched) annotation(Line(points={{58.8,64},{62,64},{62,24.2},{45,24.2}},color={255,0,255}));
  connect(unloadingCalculation.momentumDumpActive,informationBooleanBridge[1].u) annotation(Line(points={{54,7.7},{54,-16},{78,-16}},color={255,0,255}));
  connect(informationBooleanBridge[1].y,information.device.momentumDumpActive) annotation(Line(points={{86,-16},{94,-16},{94,0},{100,0}},color={255,0,255}));
  connect(power.p5,mainSupplyCurrent.p) annotation(Line(points={{0,100},{-73.5,100},{-73.5,58},{-92,58}},color={0,0,255}));
  connect(mainSupplyCurrent.n,coilRX.p) annotation(Line(points={{-78,58},{-78,52.5},{-35,52.5},{-35,58}},color={0,0,255}));
  connect(mainSupplyCurrent.n,coilRY.p) annotation(Line(points={{-78,58},{-78,33.5},{-35,33.5},{-35,28}},color={0,0,255}));
  connect(mainSupplyCurrent.n,coilRZ.p) annotation(Line(points={{-78,58},{-76,58},{-76,-2},{-35,-2}},color={0,0,255}));
  connect(mainSupplyCurrent.i,informationRealBridge[1].u) annotation(Line(points={{-85,48},{-85,36.5},{-36.5,36.5},{-36.5,39.5},{78,39.5},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.tcCurrent[23]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(unloadingCalculation.coilConductanceCommand[1],coilRX.G) annotation(Line(points={{54,-3.5},{8,-3.5},{8,70},{-25,70}},color={0,0,127}));
  connect(unloadingCalculation.coilConductanceCommand[2],coilRY.G) annotation(Line(points={{54,-3.5},{8,-3.5},{8,40},{-25,40}},color={0,0,127}));
  connect(unloadingCalculation.coilConductanceCommand[3],coilRZ.G) annotation(Line(points={{54,-3.5},{8,-3.5},{8,10},{-25,10}},color={0,0,127}));
  connect(coilRX.n,power.n5) annotation(Line(points={{-15,58},{-15,94},{0,94},{0,100}},color={0,0,255}));
  connect(coilRY.n,power.n5) annotation(Line(points={{-15,28},{-15,94},{0,94},{0,100}},color={0,0,255}));
  connect(coilRZ.n,power.n5) annotation(Line(points={{-15,-2},{-15,94},{0,94},{0,100}},color={0,0,255}));
  connect(coilRX.heatPort,coilThermalMass.port) annotation(Line(points={{-25,48},{-10,48},{-10,-32}},color={191,0,0}));
  connect(coilRY.heatPort,coilThermalMass.port) annotation(Line(points={{-25,18},{-10,18},{-10,-32}},color={191,0,0}));
  connect(coilRZ.heatPort,coilThermalMass.port) annotation(Line(points={{-25,-12},{-25,-32},{-10,-32}},color={191,0,0}));
  connect(coilThermalMass.port,framePath.port_a) annotation(Line(points={{-10,-52},{-10,-42},{20,-42}},color={191,0,0}));
  connect(framePath.port_b,thermal) annotation(Line(points={{40,-42},{40,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(rods.frame_a,mechanical) annotation(Line(points={{-70,22},{-70,0},{-100,0}},color={95,95,95},thickness=0.5));
  connect(unloadingCalculation.magneticTorque,torqueSource.torque) annotation(Line(points={{54,-10.1},{54,-18},{-82,-18}},color={0,0,127}));
  connect(torqueSource.frame_b,mechanical) annotation(Line(points={{-62,-18},{-94,-18},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  connect(unloadingCalculation.magneticTorque[1],informationRealBridge[2].u) annotation(Line(points={{54,-10.1},{54,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[2].y,information.device.magnetorquerTorque[1]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(unloadingCalculation.magneticTorque[2],informationRealBridge[3].u) annotation(Line(points={{54,-10.1},{54,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[3].y,information.device.magnetorquerTorque[2]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(unloadingCalculation.magneticTorque[3],informationRealBridge[4].u) annotation(Line(points={{54,-10.1},{54,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[4].y,information.device.magnetorquerTorque[3]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={95,60,125},fillColor={241,234,247},fillPattern=FillPattern.Solid),Line(points={{-70,35},{70,35}},color={140,75,170},thickness=5),Line(points={{-70,0},{70,0}},color={75,145,90},thickness=5),Line(points={{-70,-35},{70,-35}},color={60,95,180},thickness=5),Text(extent={{-92,-74},{92,-52}},textString="3-AXIS MAG TORQUER")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Text(extent={{-98,96},{98,86}},textString="信息字段 -> Forward -> 动量卸载计算 -> 三轴线圈/本体力矩")}),Documentation(info="<html><h4>用途与系统角色</h4><p>提供四轮动量卸载、安全模式消旋和日指向残余角速度阻尼，并计入电负载、热损耗和机械反作用。</p><h4>白箱信号路径</h4><p>四轮转速、本体角速度、地磁场、5 V母线和安全模式分别经过显式Forward进入MomentumUnloadingCalculation；两个标准Hysteresis保存进入/退出回差；计算输出驱动三路VariableConductor和WorldTorque。</p><h4>工程计算</h4><p>Calculation集中完成H=J·omega、卸载/阻尼力矩、B×tau逆映射、H桥有符号电流限幅、正耗能电导和m×B磁力矩。父Component只组织连线和标准物理元件。</p><h4>边界</h4><p>线圈电感、PWM和H桥开关级动态未展开；电流符号表示桥臂极性，供电电导保持正值。</p><h4>功能与接口</h4><p>三轴磁力矩器用于太阳指向空闲阶段的轮系动量卸载、残余角速度阻尼以及安全模式消旋。information读取四轮速度、本体角速度、地磁场、母线电压、控制模式和安全状态，并发布线圈电流、磁矩/力矩和执行状态；power、thermal、mechanical分别表示供电、焦耳热和安装质量。</p><h4>内部计算与执行路径</h4><p>共享信息字段先由Real/Boolean SignalReader形成窄因果输入。MomentumUnloadingCalculation计算轮系角动量，依据外部回差锁存决定正常卸载或速率阻尼，再用磁场叉乘逆映射得到三轴线圈电流并限幅。VariableConductor按照命令电导从5 V母线取电，电阻损耗进入线圈热节点。</p><h4>关键结果与使用</h4><p>查看unloadingCalculation.momentumDumpActive、safeDetumbleActive、coilCurrentCommand、magneticTorque、最大轮速及coilThermalMass.T，并结合magneticField判断低磁场禁用是否合理。电流方向遵循各线圈正轴，力矩方向由m×B确定。</p><h4>建模边界</h4><p>模型保留回差、动量方向、B场几何、电流限幅、功耗和热效应，不展开PWM/H桥、线圈电感快动态、剩磁、磁滞和结构磁洁净度。它不能替代磁执行机构详细设计。</p></html>"));
end MagnetorquerUnit;
