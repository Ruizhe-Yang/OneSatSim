within NISSA_12UCubeSat.Components;
model ReactionWheelYUnit "Y轴反作用飞轮组件"
  parameter NISSA_12UCubeSat.Scenarios.DesignConfigRecords.WheelYComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance standbyResistance=config.StandbyResistance
    "飞轮驱动电子学待机电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.Torque maxTorque=config.MaxTorque
    "飞轮最大轴力矩；Excel单位N·m，当前设计基线";
  parameter Modelica.Units.SI.Inertia rotorInertia=config.RotorInertia
    "飞轮转子惯量；Excel单位kg·m²，当前设计基线";
  parameter Real bearingDamping(unit="N.m.s/rad")=config.BearingDamping
    "轴承等效黏性阻尼；Excel单位N·m·s/rad，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity heatCapacity=config.HeatCapacity
    "飞轮等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountConductance=config.MountConductance
    "飞轮安装导热；Excel单位W/K，当前设计基线";
  parameter Real axis_X=config.Axis_X
    "飞轮转轴方向X；Excel单位1，当前设计基线";
  parameter Real axis_Y=config.Axis_Y
    "飞轮转轴方向Y；Excel单位1，当前设计基线";
  parameter Real axis_Z=config.Axis_Z
    "飞轮转轴方向Z；Excel单位1，当前设计基线";
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
  parameter Modelica.Units.SI.AngularVelocity initialSpeed=130.7506044 "场景初始轮速";
  parameter Modelica.Units.SI.AngularVelocity wheelSpeedLimit=config.SpeedLimit "任务级参数: 6000 rpm";
  parameter Real motorEfficiency(min=0.1,max=1)=config.MotorEfficiency "平均值电机效率，待器件数据标定";
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}}),iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Basic.Conductor unused5Rail(G=0) annotation(Placement(transformation(extent={{42,76},{54,88}})));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0) annotation(Placement(transformation(extent={{66,76},{78,88}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  Foundation.Interfaces.RealSignalReader commandedSpeed annotation(Placement(transformation(extent={{-96,2},{-76,18}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor phaseCurrent annotation(Placement(transformation(extent={{-75,38},{-55,58}})));
  Modelica.Electrical.Analog.Basic.Resistor driverLoss(R=standbyResistance,useHeatPort=true) "任务级参数 36 mA supply work point" annotation(Placement(transformation(extent={{-42,38},{-22,58}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent dynamicMotorLoad
    "由实际轴功率驱动的12 V平均值电机负载" annotation(Placement(transformation(extent={{-42,62},{-22,82}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor motorBusVoltage
    annotation(Placement(transformation(origin={-10,70},extent={{-8,-8},{8,8}},rotation=270)));
  Modelica.Blocks.Math.Add commandError(k2=-1) annotation(Placement(transformation(extent={{-72,4},{-52,24}})));
  Modelica.Blocks.Math.Gain servoGain(k=1.55e-4) "系统级 task-rate wheel servo" annotation(Placement(transformation(extent={{-12,4},{8,24}})));
  Modelica.Blocks.Nonlinear.Limiter torqueLimit(uMax=maxTorque,uMin=-0.010,strict=true) annotation(Placement(transformation(extent={{18,4},{38,24}})));
  Modelica.Mechanics.Rotational.Sources.Torque motor(useSupport=true) annotation(Placement(transformation(extent={{45,4},{65,24}})));
  Modelica.Mechanics.Rotational.Components.Inertia rotor(J=rotorInertia,w(start=initialSpeed,fixed=true)) annotation(Placement(transformation(extent={{72,4},{92,24}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed annotation(Placement(transformation(extent={{72,-20},{92,0}})));
  Foundation.Calculations.ReactionWheelTelemetryCalculation telemetryCalculation(
    rotorInertia=9.8e-5,wheelSpeedLimit=wheelSpeedLimit) annotation(Placement(transformation(extent={{48,-84},{70,-56}})));
  Foundation.Calculations.ReactionWheelPowerCalculation powerCalculation(etaMotor=motorEfficiency)
    annotation(Placement(transformation(extent={{12,-84},{40,-56}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow dynamicMotorHeat
    annotation(Placement(transformation(extent={{-52,-60},{-32,-40}})));
  Modelica.Mechanics.Rotational.Components.Damper bearing(d=bearingDamping,useHeatPort=true) annotation(Placement(transformation(origin={55,-22},extent={{-8,-8},{8,8}},rotation=270)));
  Modelica.Mechanics.MultiBody.Parts.Mounting1D mount(n={axis_X,axis_Y,axis_Z}) annotation(Placement(transformation(origin={-70,-22},extent={{-10,-10},{10,10}},rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.Body wheelHousing(
    m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ)
    "Y轮壳体与安装件，位于结构基准+X/-Y上舱角" annotation(Placement(transformation(extent={{-46,6},{-26,26}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor thermalMass(C=heatCapacity,T(start=276.40,fixed=true)) "热敏电阻7对应的初始工作点" annotation(Placement(transformation(extent={{-32,-58},{-12,-38}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor mountingPath(G=mountConductance) "系统级 wheel Y conductive mounting" annotation(Placement(transformation(extent={{0,-56},{20,-40}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor thermistor7 annotation(Placement(transformation(extent={{-32,-84},{-12,-64}})));
  Modelica.Blocks.Sources.IntegerConstant status(k=1) annotation(Placement(transformation(extent={{23,-30},{43,-10}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[5] annotation(Placement(transformation(extent={{78,32},{86,40}})));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[1] annotation(Placement(transformation(extent={{78,-34},{86,-26}})));
  Foundation.Interfaces.BooleanSignalBridge informationBooleanBridge[1] annotation(Placement(transformation(extent={{78,-52},{86,-44}})));
equation
  connect(speed.w,telemetryCalculation.angularVelocity) annotation(Line(points={{92,-10},{44,-10},{44,-70},{48,-70}},color={0,0,127}));
  connect(information.command.wheelCommand[2],commandedSpeed.u) annotation(Line(points={{100,0},{-90,0},{-90,10},{-96,10}},color={0,0,127}));
  connect(power.p5,unused5Rail.p) annotation(Line(points={{0,100},{0,94},{42,94},{42,82}},color={0,0,255}));
  connect(unused5Rail.n,power.n5) annotation(Line(points={{54,82},{54,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,82}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{78,82},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p12,phaseCurrent.p) annotation(Line(points={{0,100},{0,94},{-75,94},{-75,48}},color={0,0,255}));
  connect(phaseCurrent.n,driverLoss.p) annotation(Line(points={{-55,48},{-48,48},{-42,48}},color={0,0,255}));
  connect(phaseCurrent.n,dynamicMotorLoad.p) annotation(Line(points={{-55,48},{-48,48},{-48,72},{-42,72}},color={0,0,255}));
  connect(driverLoss.n,power.n12) annotation(Line(points={{-22,48},{-22,94},{0,94},{0,100}},color={0,0,255}));
  connect(dynamicMotorLoad.n,power.n12) annotation(Line(points={{-22,72},{-22,94},{0,94},{0,100}},color={0,0,255}));
  connect(motorBusVoltage.p,phaseCurrent.n) annotation(Line(points={{-10,78},{-10,86},{-48,86},{-48,48},{-55,48}},color={0,0,255}));
  connect(motorBusVoltage.n,power.n12) annotation(Line(points={{-10,62},{-10,94},{0,94},{0,100}},color={0,0,255}));
  connect(commandedSpeed.y,commandError.u1) annotation(Line(points={{-76,10},{-74,10},{-74,20}},color={0,0,127}));
  connect(speed.w,commandError.u2) annotation(Line(points={{92,-10},{-62,-10},{-62,6}},color={0,0,127}));
  connect(commandError.y,servoGain.u) annotation(Line(points={{-51,14},{-51,4.5},{-14,4.5},{-14,14}},color={0,0,127}));
  connect(servoGain.y,torqueLimit.u) annotation(Line(points={{9,14},{16,14}},color={0,0,127}));
  connect(torqueLimit.y,motor.tau) annotation(Line(points={{39,14},{43,14}},color={0,0,127}));
  connect(torqueLimit.y,powerCalculation.motorTorque) annotation(Line(points={{39,14},{21.5,14},{21.5,-62.3},{12,-62.3}},color={0,0,127}));
  connect(speed.w,powerCalculation.angularVelocity) annotation(Line(points={{92,-10},{44,-10},{44,-70},{12,-70}},color={0,0,127}));
  connect(motorBusVoltage.v,powerCalculation.busVoltage) annotation(Line(points={{-2,70},{16.5,70},{16.5,-38.5},{21.5,-38.5},{21.5,-77.7},{12,-77.7}},color={0,0,127}));
  connect(powerCalculation.dynamicCurrentCommand,dynamicMotorLoad.i) annotation(Line(points={{40,-71.4},{40,-31.5},{-20.5,-31.5},{-20.5,84},{-32,84}},color={0,0,127}));
  connect(powerCalculation.dynamicLossHeat,dynamicMotorHeat.Q_flow) annotation(Line(points={{40,-77},{40,-59.5},{-52,-59.5},{-52,-50}},color={0,0,127}));
  connect(motor.flange,rotor.flange_a) annotation(Line(points={{65,14},{72,14}},color={0,0,0}));
  connect(rotor.flange_b,speed.flange) annotation(Line(points={{92,14},{90,14},{90,-10},{92,-10}},color={0,0,0}));
  connect(rotor.flange_b,bearing.flange_a) annotation(Line(points={{92,14},{66.5,14},{66.5,-14},{55,-14}},color={0,0,0}));
  connect(bearing.flange_b,mount.flange_b) annotation(Line(points={{55,-30},{55,-31.5},{-60,-31.5},{-60,-22}},color={0,0,0}));
  connect(motor.support,mount.flange_b) annotation(Line(points={{55,4},{55,-8.5},{-60,-8.5},{-60,-22}},color={0,0,0}));
  connect(mount.frame_a,mechanical) annotation(Line(points={{-80,-22},{-94,-22},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  connect(wheelHousing.frame_a,mechanical) annotation(Line(points={{-46,16},{-46,0},{-100,0}},color={95,95,95},thickness=0.5));
  connect(driverLoss.heatPort,thermalMass.port) annotation(Line(points={{-32,38},{-22,38},{-22,-38}},color={191,0,0}));
  connect(dynamicMotorHeat.port,thermalMass.port) annotation(Line(points={{-32,-50},{-22,-50},{-22,-38}},color={191,0,0}));
  connect(bearing.heatPort,thermalMass.port) annotation(Line(points={{47,-22},{47,-38},{-22,-38}},color={191,0,0}));
  connect(thermalMass.port,mountingPath.port_a) annotation(Line(points={{-22,-58},{-22,-48},{0,-48}},color={191,0,0}));
  connect(mountingPath.port_b,thermal) annotation(Line(points={{20,-48},{0,-48},{0,-100}},color={191,0,0}));
  connect(thermalMass.port,thermistor7.port) annotation(Line(points={{-22,-58},{-22,-74},{-32,-74}},color={191,0,0}));
  connect(speed.w,informationRealBridge[1].u) annotation(Line(points={{92,-10},{72,-10},{72,36},{78,36}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.wheelSpeed[2]) annotation(Line(points={{86,36},{94,36},{94,0},{100,0}},color={0,0,127}));
  connect(phaseCurrent.i,informationRealBridge[2].u) annotation(Line(points={{-65,38},{78,38},{78,36}},color={0,0,127}));
  connect(informationRealBridge[2].y,information.device.wheelCurrent[2]) annotation(Line(points={{86,36},{94,36},{94,0},{100,0}},color={0,0,127}));
  connect(phaseCurrent.i,informationRealBridge[3].u) annotation(Line(points={{-65,38},{78,38},{78,36}},color={0,0,127}));
  connect(informationRealBridge[3].y,information.device.pdCurrent[14]) annotation(Line(points={{86,36},{94,36},{94,0},{100,0}},color={0,0,127}));
  connect(thermistor7.T,informationRealBridge[4].u) annotation(Line(points={{-12,-74},{-1.5,-74},{-1.5,2.5},{70.5,2.5},{70.5,36},{78,36}},color={0,0,127}));
  connect(informationRealBridge[4].y,information.device.thermistorTemperature[7]) annotation(Line(points={{86,36},{94,36},{94,0},{100,0}},color={0,0,127}));
  connect(status.y,informationIntegerBridge[1].u) annotation(Line(points={{44,-20},{44,-31.5},{78,-31.5},{78,-30}},color={255,127,0}));
  connect(informationIntegerBridge[1].y,information.device.wheelStatus[2]) annotation(Line(points={{86,-30},{94,-30},{94,0},{100,0}},color={255,127,0}));
  connect(telemetryCalculation.momentum,informationRealBridge[5].u) annotation(Line(points={{68.9,-65.1},{68.9,36},{78,36}},color={0,0,127}));
  connect(informationRealBridge[5].y,information.device.wheelMomentum[2]) annotation(Line(points={{86,36},{94,36},{94,0},{100,0}},color={0,0,127}));
  connect(telemetryCalculation.saturated,informationBooleanBridge[1].u) annotation(Line(points={{68.9,-74.9},{78,-74.9},{78,-48}},color={255,0,255}));
  connect(informationBooleanBridge[1].y,information.device.wheelSaturated[2]) annotation(Line(points={{86,-48},{94,-48},{94,0},{100,0}},color={255,0,255}));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={60,85,115},fillColor={234,241,249},fillPattern=FillPattern.Solid),Ellipse(extent={{-50,50},{50,-50}},fillColor={150,175,205},fillPattern=FillPattern.Solid),Ellipse(extent={{-17,17},{17,-17}},fillColor={60,75,100},fillPattern=FillPattern.Solid),Line(points={{0,-70},{0,70}},color={35,145,60},thickness=2),Text(extent={{-92,-75},{92,-53}},textString="RW-Y / PD14 / T7")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Rectangle(extent={{-80,30},{98,-34}},lineColor={80,80,80},pattern=LinePattern.Dash),Text(extent={{-78,38},{60,28}},textString="一阶指令滤波-伺服-转子")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>独立执行Y轴轮速命令并表示任务级低阶轮系响应</p><p><b>建模层级：</b>Components层设备级白箱；主要由Modelica 4.0.0标准库元件和图形连线组成</p><h4>实现与接口</h4><p><b>系统级等效：</b>Add误差、任务级伺服增益和限幅器直接驱动转矩源与转子；原0.04 s指令滤波状态已删除，保留J·der(w)、机械反作用、相电流、驱动损耗和7号热敏。</p><p><b>对外接口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、information（InformationPort）</p><h4>工作行为与状态</h4><p><b>运行行为：</b>速度误差决定受限电机转矩，转子惯性与阻尼产生平滑响应</p><p><b>关键状态：</b>Y轮转速、轴角、电流和温度</p><p><b>物理域：</b>旋转机械、控制、电、热、信息</p><h4>信息与遥测关系</h4><p><b>数据路径：</b>Y轮为wheelSpeed/current/status索引2，速度转换为rpm进入SAT-S2</p><h4>物理对象与接口</h4><p>Y轮独立读取wheelCommand[2]，通过power、thermal、mechanical和information接入整星。其正方向由Y轴安装框架与转子角速度共同定义，不能从图标位置推断符号。</p><h4>内部控制与特性</h4><p>RealSignalReader后设置一阶命令滤波，再由速度误差、伺服增益和转矩限幅驱动转子；该滤波是Y轮有别于其他三轮的设备级动态。电流、7号热敏、角动量和饱和状态均来自实际支路或转子状态。</p><h4>结果查看与边界</h4><p>优先查看commandFilter.y、rotor.w、driveCurrent.i、thermistor7.T及遥测索引2。模型不模拟换相、齿槽转矩和结构微振动，适合任务机动、动量积累、功耗与温升分析。</p></html>"));
end ReactionWheelYUnit;
