within OneSatSim.Components;
model ReactionWheelXUnit "X轴反作用飞轮组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.WheelXComponentConfig config
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
  parameter Modelica.Units.SI.AngularVelocity initialSpeed=51.9085773 "场景初始轮速";
  parameter Modelica.Units.SI.AngularVelocity wheelSpeedLimit=config.SpeedLimit "任务级参数: 6000 rpm";
  parameter Real motorEfficiency(min=0.1,max=1)=config.MotorEfficiency "平均值电机效率，待器件数据标定";
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}}),iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Basic.Conductor unused5Rail(G=0) annotation(Placement(transformation(extent={{42,76},{54,88}})));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0) annotation(Placement(transformation(extent={{66,76},{78,88}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  Foundation.Interfaces.RealSignalReader commandedSpeed annotation(Placement(transformation(extent={{-95,2},{-75,18}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor driveCurrent annotation(Placement(transformation(extent={{-70,40},{-50,60}})));
  Modelica.Electrical.Analog.Basic.Resistor driveElectronics(R=standbyResistance,useHeatPort=true) "任务级参数 48 mA supply work point" annotation(Placement(transformation(extent={{-35,40},{-15,60}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent dynamicMotorLoad
    "由实际轴功率驱动的12 V平均值电机负载" annotation(Placement(transformation(extent={{-35,64},{-15,84}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor motorBusVoltage
    annotation(Placement(transformation(origin={-5,72},extent={{-8,-8},{8,8}},rotation=270)));
  Modelica.Blocks.Math.Feedback speedError annotation(Placement(transformation(extent={{-70,5},{-50,25}})));
  Modelica.Blocks.Math.Gain speedGain(k=1.6e-4) "系统级 task-rate wheel servo" annotation(Placement(transformation(extent={{-40,5},{-20,25}})));
  Modelica.Blocks.Nonlinear.Limiter torqueLimit(uMax=maxTorque,uMin=-0.010,strict=true) annotation(Placement(transformation(extent={{-10,5},{10,25}})));
  Modelica.Mechanics.Rotational.Sources.Torque motorTorque(useSupport=true) annotation(Placement(transformation(extent={{20,5},{40,25}})));
  Modelica.Mechanics.Rotational.Components.Inertia rotor(J=rotorInertia,w(start=initialSpeed,fixed=true)) annotation(Placement(transformation(extent={{48,5},{68,25}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation(Placement(transformation(extent={{75,5},{95,25}})));
  Foundation.Calculations.ReactionWheelTelemetryCalculation telemetryCalculation(
    rotorInertia=9.5e-5,wheelSpeedLimit=wheelSpeedLimit) annotation(Placement(transformation(extent={{48,-84},{70,-56}})));
  Foundation.Calculations.ReactionWheelPowerCalculation powerCalculation(etaMotor=motorEfficiency)
    annotation(Placement(transformation(extent={{12,-84},{40,-56}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow dynamicMotorHeat
    annotation(Placement(transformation(extent={{-48,-58},{-28,-38}})));
  Modelica.Mechanics.Rotational.Components.Damper bearing(d=bearingDamping,useHeatPort=true) annotation(Placement(transformation(origin={58,-12},extent={{-8,-8},{8,8}},rotation=270)));
  Modelica.Mechanics.MultiBody.Parts.Mounting1D mount(n={axis_X,axis_Y,axis_Z}) annotation(Placement(transformation(origin={-70,-22},extent={{-10,-10},{10,10}},rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.Body wheelHousing(
    m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ)
    "X轮壳体与安装件，位于结构基准-X/-Y上舱角" annotation(Placement(transformation(extent={{-52,-26},{-32,-6}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor wheelThermalMass(C=heatCapacity,T(start=282.89,fixed=true)) "热敏电阻6对应的初始工作点" annotation(Placement(transformation(extent={{-25,-55},{-5,-35}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor casePath(G=mountConductance) "系统级 wheel X case-to-deck path" annotation(Placement(transformation(extent={{12,-53},{32,-37}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor thermistor6 annotation(Placement(transformation(extent={{-25,-82},{-5,-62}})));
  Modelica.Blocks.Sources.IntegerConstant status(k=1) annotation(Placement(transformation(extent={{47,-51},{67,-31}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[5] annotation(Placement(transformation(extent={{78,32},{86,40}})));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[1] annotation(Placement(transformation(extent={{78,-34},{86,-26}})));
  Foundation.Interfaces.BooleanSignalBridge informationBooleanBridge[1] annotation(Placement(transformation(extent={{80,-52},{88,-44}})));
equation
  connect(speedSensor.w,telemetryCalculation.angularVelocity) annotation(Line(points={{95,15},{69.5,15},{69.5,-70},{48,-70}},color={0,0,127}));
  connect(information.command.wheelCommand[1],commandedSpeed.u) annotation(Line(points={{100,0},{-90,0},{-90,10},{-95,10}},color={0,0,127}));
  connect(power.p5,unused5Rail.p) annotation(Line(points={{0,100},{0,94},{42,94},{42,82}},color={0,0,255}));
  connect(unused5Rail.n,power.n5) annotation(Line(points={{54,82},{54,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,82}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{78,82},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p12,driveCurrent.p) annotation(Line(points={{0,100},{0,94},{-70,94},{-70,50}},color={0,0,255}));
  connect(driveCurrent.n,driveElectronics.p) annotation(Line(points={{-50,50},{-42,50},{-35,50}},color={0,0,255}));
  connect(driveCurrent.n,dynamicMotorLoad.p) annotation(Line(points={{-50,50},{-42,50},{-42,74},{-35,74}},color={0,0,255}));
  connect(driveElectronics.n,power.n12) annotation(Line(points={{-15,50},{-15,94},{0,94},{0,100}},color={0,0,255}));
  connect(dynamicMotorLoad.n,power.n12) annotation(Line(points={{-15,74},{-15,94},{0,94},{0,100}},color={0,0,255}));
  connect(motorBusVoltage.p,driveCurrent.n) annotation(Line(points={{-5,80},{-5,86},{-42,86},{-42,50},{-50,50}},color={0,0,255}));
  connect(motorBusVoltage.n,power.n12) annotation(Line(points={{-5,64},{-5,94},{0,94},{0,100}},color={0,0,255}));
  connect(commandedSpeed.y,speedError.u1) annotation(Line(points={{-75,10},{-70,10},{-70,15},{-68,15}},color={0,0,127}));
  connect(speedSensor.w,speedError.u2) annotation(Line(points={{95,15},{69.5,15},{69.5,3.5},{-60,3.5},{-60,7}},color={0,0,127}));
  connect(speedError.y,speedGain.u) annotation(Line(points={{-51,15},{-42,15}},color={0,0,127}));
  connect(speedGain.y,torqueLimit.u) annotation(Line(points={{-19,15},{-12,15}},color={0,0,127}));
  connect(torqueLimit.y,motorTorque.tau) annotation(Line(points={{11,15},{18,15}},color={0,0,127}));
  connect(torqueLimit.y,powerCalculation.motorTorque) annotation(Line(points={{11,15},{10,15},{10,-62.3},{12,-62.3}},color={0,0,127}));
  connect(speedSensor.w,powerCalculation.angularVelocity) annotation(Line(points={{95,15},{69.5,15},{69.5,-54.5},{40,-54.5},{40,-70}},color={0,0,127}));
  connect(motorBusVoltage.v,powerCalculation.busVoltage) annotation(Line(points={{3,72},{11.5,72},{11.5,-35.5},{10.5,-35.5},{10.5,-77.7},{12,-77.7}},color={0,0,127}));
  connect(powerCalculation.dynamicCurrentCommand,dynamicMotorLoad.i) annotation(Line(points={{40,-71.4},{40,3.5},{11.5,3.5},{11.5,86},{-25,86}},color={0,0,127}));
  connect(powerCalculation.dynamicLossHeat,dynamicMotorHeat.Q_flow) annotation(Line(points={{40,-77},{40,-56.5},{-48,-56.5},{-48,-48}},color={0,0,127}));
  connect(motorTorque.flange,rotor.flange_a) annotation(Line(points={{40,15},{48,15}},color={0,0,0}));
  connect(rotor.flange_b,speedSensor.flange) annotation(Line(points={{68,15},{75,15}},color={0,0,0}));
  connect(rotor.flange_b,bearing.flange_a) annotation(Line(points={{68,15},{58,15},{58,-4}},color={0,0,0}));
  connect(bearing.flange_b,mount.flange_b) annotation(Line(points={{58,-20},{58,-27.5},{-60,-27.5},{-60,-22}},color={0,0,0}));
  connect(motorTorque.support,mount.flange_b) annotation(Line(points={{30,5},{30,-4.5},{-60,-4.5},{-60,-22}},color={0,0,0}));
  connect(mount.frame_a,mechanical) annotation(Line(points={{-80,-22},{-94,-22},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  connect(wheelHousing.frame_a,mechanical) annotation(Line(points={{-52,-16},{-52,0},{-100,0}},color={95,95,95},thickness=0.5));
  connect(driveElectronics.heatPort,wheelThermalMass.port) annotation(Line(points={{-25,40},{-15,40},{-15,-35}},color={191,0,0}));
  connect(dynamicMotorHeat.port,wheelThermalMass.port) annotation(Line(points={{-28,-48},{-15,-48},{-15,-35}},color={191,0,0}));
  connect(bearing.heatPort,wheelThermalMass.port) annotation(Line(points={{50,-12},{-15,-12},{-15,-35}},color={191,0,0}));
  connect(wheelThermalMass.port,casePath.port_a) annotation(Line(points={{-15,-55},{-15,-45},{12,-45}},color={191,0,0}));
  connect(casePath.port_b,thermal) annotation(Line(points={{32,-45},{0,-45},{0,-100}},color={191,0,0}));
  connect(wheelThermalMass.port,thermistor6.port) annotation(Line(points={{-15,-55},{-15,-72},{-25,-72}},color={191,0,0}));
  connect(speedSensor.w,informationRealBridge[1].u) annotation(Line(points={{95,15},{78,15},{78,36}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.wheelSpeed[1]) annotation(Line(points={{86,36},{100,36},{100,0}},color={0,0,127}));
  connect(driveCurrent.i,informationRealBridge[2].u) annotation(Line(points={{-60,40},{78,40},{78,36}},color={0,0,127}));
  connect(informationRealBridge[2].y,information.device.wheelCurrent[1]) annotation(Line(points={{86,36},{100,36},{100,0}},color={0,0,127}));
  connect(driveCurrent.i,informationRealBridge[3].u) annotation(Line(points={{-60,40},{78,40},{78,36}},color={0,0,127}));
  connect(informationRealBridge[3].y,information.device.pdCurrent[13]) annotation(Line(points={{86,36},{100,36},{100,0}},color={0,0,127}));
  connect(thermistor6.T,informationRealBridge[4].u) annotation(Line(points={{-5,-72},{10.5,-72},{10.5,3.5},{73.5,3.5},{73.5,36},{78,36}},color={0,0,127}));
  connect(informationRealBridge[4].y,information.device.thermistorTemperature[6]) annotation(Line(points={{86,36},{100,36},{100,0}},color={0,0,127}));
  connect(status.y,informationIntegerBridge[1].u) annotation(Line(points={{68,-41},{78,-41},{78,-30}},color={255,127,0}));
  connect(informationIntegerBridge[1].y,information.device.wheelStatus[1]) annotation(Line(points={{86,-30},{94,-30},{94,0},{100,0}},color={255,127,0}));
  connect(telemetryCalculation.momentum,informationRealBridge[5].u) annotation(Line(points={{68.9,-65.1},{73.5,-65.1},{73.5,36},{78,36}},color={0,0,127}));
  connect(informationRealBridge[5].y,information.device.wheelMomentum[1]) annotation(Line(points={{86,36},{100,36},{100,0}},color={0,0,127}));
  connect(telemetryCalculation.saturated,informationBooleanBridge[1].u) annotation(Line(points={{68.9,-74.9},{80,-74.9},{80,-48}},color={255,0,255}));
  connect(informationBooleanBridge[1].y,information.device.wheelSaturated[1]) annotation(Line(points={{88,-48},{94,-48},{94,0},{100,0}},color={255,0,255}));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={65,80,110},fillColor={235,240,248},fillPattern=FillPattern.Solid),Ellipse(extent={{-48,48},{48,-48}},fillColor={145,165,195},fillPattern=FillPattern.Solid),Ellipse(extent={{-18,18},{18,-18}},fillColor={65,75,95},fillPattern=FillPattern.Solid),Line(points={{-70,0},{70,0}},color={180,50,40},thickness=2),Text(extent={{-92,-75},{92,-53}},textString="RW-X / PD13 / T6")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Rectangle(extent={{-78,30},{98,-28}},lineColor={80,80,80},pattern=LinePattern.Dash),Text(extent={{-75,38},{55,28}},textString="速度闭环-限矩-惯量-轴承")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>独立执行X轴轮速命令并产生对应角动量和设备状态</p><p><b>建模层级：</b>Components层设备级白箱；主要由Modelica 4.0.0标准库元件和图形连线组成</p><h4>实现与接口</h4><p><b>系统级等效：</b>反馈误差经任务级比例增益和转矩限幅驱动理想转矩源、转子惯量和轴承阻尼，保留J·der(w)、反作用转矩、转速、动量、电流、热与饱和结果，不解析高带宽电机伺服。</p><p><b>对外接口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、information（InformationPort）</p><h4>工作行为与状态</h4><p><b>运行行为：</b>闭环轮速跟踪与机械反作用通过Mounting1D传递到本体</p><p><b>关键状态：</b>X轮转速、轴角、电流和温度</p><p><b>物理域：</b>旋转机械、控制、电、热、信息</p><h4>物理对象与接口</h4><p>X轮是沿本体X轴安装的独立反作用飞轮。information提供wheelCommand[1]并接收转速、电流、角动量、饱和标志、状态和6号热敏；power供给驱动电子学，mechanical通过一维安装支路向本体传递反作用力矩，thermal接收电机与轴承损耗。</p><h4>内部控制与能量路径</h4><p>RealSignalReader把共享轮速命令送入速度误差和比例伺服，转矩限幅后驱动Torque源、Rotor惯量与Damper。电流传感和驱动电阻形成可观测电负载，ReactionWheelTelemetryCalculation由实际角速度计算角动量与饱和状态。</p><h4>结果查看与边界</h4><p>优先查看rotor.w、telemetryCalculation.momentum、saturated、driveCurrent.i和thermistor6.T；转速显示时由rad/s换算为rpm。模型保留独立惯量、极性、限矩和热路径，不展开无刷换相、电流环、轴承非线性和微振动频谱。</p></html>"));
end ReactionWheelXUnit;
