within OneSatSim.Components;
model ReactionWheelZUnit "Z轴反作用飞轮组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.WheelZComponentConfig config
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
  parameter Modelica.Units.SI.AngularVelocity initialSpeed=-199.7364500 "场景初始轮速";
  parameter Modelica.Units.SI.AngularVelocity wheelSpeedLimit=config.SpeedLimit "任务级参数: 6000 rpm";
  parameter Real motorEfficiency(min=0.1,max=1)=config.MotorEfficiency "平均值电机效率，待器件数据标定";
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}}),iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Basic.Conductor unused5Rail(G=0) annotation(Placement(transformation(extent={{42,76},{54,88}})));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0) annotation(Placement(transformation(extent={{66,76},{78,88}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  Foundation.Interfaces.RealSignalReader commandedSpeed annotation(Placement(transformation(extent={{-96,2},{-76,18}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentShunt annotation(Placement(transformation(extent={{-72,42},{-52,62}})));
  Modelica.Electrical.Analog.Basic.Resistor inverterLoss(R=standbyResistance,useHeatPort=true) "任务级参数 45 mA supply work point" annotation(Placement(transformation(extent={{-40,42},{-20,62}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent dynamicMotorLoad
    "由实际轴功率驱动的12 V平均值电机负载" annotation(Placement(transformation(extent={{-40,66},{-20,86}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor motorBusVoltage
    annotation(Placement(transformation(origin={-8,74},extent={{-8,-8},{8,8}},rotation=270)));
  Modelica.Blocks.Math.Feedback speedError annotation(Placement(transformation(extent={{-70,4},{-50,24}})));
  Modelica.Blocks.Math.Gain proportional(k=1.7e-4) "系统级 task-rate wheel servo" annotation(Placement(transformation(extent={{-40,4},{-20,24}})));
  Modelica.Blocks.Nonlinear.Limiter torqueLimit(uMax=maxTorque,uMin=-0.010,strict=true) annotation(Placement(transformation(extent={{20,4},{40,24}})));
  Modelica.Mechanics.Rotational.Sources.Torque motor(useSupport=true) annotation(Placement(transformation(extent={{48,4},{68,24}})));
  Modelica.Mechanics.Rotational.Components.Inertia rotor(J=rotorInertia,w(start=initialSpeed,fixed=true)) annotation(Placement(transformation(extent={{75,4},{95,24}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed annotation(Placement(transformation(extent={{75,-22},{95,-2}})));
  Foundation.Calculations.ReactionWheelTelemetryCalculation telemetryCalculation(
    rotorInertia=9.3e-5,wheelSpeedLimit=wheelSpeedLimit) annotation(Placement(transformation(extent={{48,-84},{70,-56}})));
  Foundation.Calculations.ReactionWheelPowerCalculation powerCalculation(etaMotor=motorEfficiency)
    annotation(Placement(transformation(extent={{12,-92},{40,-64}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow dynamicMotorHeat
    annotation(Placement(transformation(extent={{-52,-62},{-32,-42}})));
  Modelica.Mechanics.Rotational.Components.Damper bearing(d=bearingDamping,useHeatPort=true) annotation(Placement(transformation(origin={58,-24},extent={{-8,-8},{8,8}},rotation=270)));
  Modelica.Mechanics.MultiBody.Parts.Mounting1D mount(n={axis_X,axis_Y,axis_Z}) annotation(Placement(transformation(origin={-70,-22},extent={{-10,-10},{10,10}},rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.Body wheelHousing(
    m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ)
    "Z轮壳体与安装件，位于结构基准-X/+Y上舱角" annotation(Placement(transformation(extent={{-52,-26},{-32,-6}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor thermalMass(C=heatCapacity,T(start=282.44,fixed=true)) "热敏电阻10对应的初始工作点" annotation(Placement(transformation(extent={{-32,-60},{-12,-40}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor chassisPath(G=mountConductance) "系统级 wheel Z chassis path" annotation(Placement(transformation(extent={{0,-58},{20,-42}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor thermistor10 annotation(Placement(transformation(extent={{-32,-86},{-12,-66}})));
  Modelica.Blocks.Sources.IntegerConstant status(k=1) annotation(Placement(transformation(extent={{23,-32},{43,-12}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[5] annotation(Placement(transformation(extent={{78,32},{86,40}})));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[1] annotation(Placement(transformation(extent={{78,-46},{86,-38}})));
  Foundation.Interfaces.BooleanSignalBridge informationBooleanBridge[1] annotation(Placement(transformation(extent={{80,-64},{88,-56}})));
equation
  connect(speed.w,telemetryCalculation.angularVelocity) annotation(Line(points={{95,-12},{44,-12},{44,-70},{48,-70}},color={0,0,127}));
  connect(information.command.wheelCommand[3],commandedSpeed.u) annotation(Line(points={{100,0},{-90,0},{-90,10},{-96,10}},color={0,0,127}));
  connect(power.p5,unused5Rail.p) annotation(Line(points={{0,100},{0,94},{42,94},{42,82}},color={0,0,255}));
  connect(unused5Rail.n,power.n5) annotation(Line(points={{54,82},{54,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,82}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{78,82},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p12,currentShunt.p) annotation(Line(points={{0,100},{0,94},{-72,94},{-72,52}},color={0,0,255}));
  connect(currentShunt.n,inverterLoss.p) annotation(Line(points={{-52,52},{-46,52},{-40,52}},color={0,0,255}));
  connect(currentShunt.n,dynamicMotorLoad.p) annotation(Line(points={{-52,52},{-46,52},{-46,76},{-40,76}},color={0,0,255}));
  connect(inverterLoss.n,power.n12) annotation(Line(points={{-20,52},{-20,94},{0,94},{0,100}},color={0,0,255}));
  connect(dynamicMotorLoad.n,power.n12) annotation(Line(points={{-20,76},{-20,94},{0,94},{0,100}},color={0,0,255}));
  connect(motorBusVoltage.p,currentShunt.n) annotation(Line(points={{-8,82},{-8,90},{-46,90},{-46,52},{-52,52}},color={0,0,255}));
  connect(motorBusVoltage.n,power.n12) annotation(Line(points={{-8,66},{-8,94},{0,94},{0,100}},color={0,0,255}));
  connect(commandedSpeed.y,speedError.u1) annotation(Line(points={{-76,10},{-70,10},{-70,14},{-68,14}},color={0,0,127}));
  connect(speed.w,speedError.u2) annotation(Line(points={{95,-12},{95,-34},{-60,-34},{-60,6}},color={0,0,127}));
  connect(speedError.y,proportional.u) annotation(Line(points={{-51,14},{-42,14}},color={0,0,127}));
  connect(proportional.y,torqueLimit.u) annotation(Line(points={{-19,14},{0,14},{18,14}},color={0,0,127}));
  connect(torqueLimit.y,motor.tau) annotation(Line(points={{41,14},{46,14}},color={0,0,127}));
  connect(torqueLimit.y,powerCalculation.motorTorque) annotation(Line(points={{41,14},{44,14},{44,-62.3},{12,-62.3},{12,-70.3}},color={0,0,127}));
  connect(speed.w,powerCalculation.angularVelocity) annotation(Line(points={{95,-12},{44,-12},{44,-70},{12,-70},{12,-78}},color={0,0,127}));
  connect(motorBusVoltage.v,powerCalculation.busVoltage) annotation(Line(points={{0,74},{-1.5,74},{-1.5,-85.7},{12,-85.7}},color={0,0,127}));
  connect(powerCalculation.dynamicCurrentCommand,dynamicMotorLoad.i) annotation(Line(points={{40,-79.4},{40,-33.5},{-18.5,-33.5},{-18.5,88},{-30,88}},color={0,0,127}));
  connect(powerCalculation.dynamicLossHeat,dynamicMotorHeat.Q_flow) annotation(Line(points={{40,-85},{40,-61.5},{-52,-61.5},{-52,-52}},color={0,0,127}));
  connect(motor.flange,rotor.flange_a) annotation(Line(points={{68,14},{75,14}},color={0,0,0}));
  connect(rotor.flange_b,speed.flange) annotation(Line(points={{95,14},{88.5,14},{88.5,-12},{95,-12}},color={0,0,0}));
  connect(rotor.flange_b,bearing.flange_a) annotation(Line(points={{95,14},{69.5,14},{69.5,-16},{58,-16}},color={0,0,0}));
  connect(bearing.flange_b,mount.flange_b) annotation(Line(points={{58,-32},{58,-33.5},{-60,-33.5},{-60,-22}},color={0,0,0}));
  connect(motor.support,mount.flange_b) annotation(Line(points={{58,4},{58,-4.5},{-60,-4.5},{-60,-22}},color={0,0,0}));
  connect(mount.frame_a,mechanical) annotation(Line(points={{-80,-22},{-94,-22},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  connect(wheelHousing.frame_a,mechanical) annotation(Line(points={{-52,-16},{-52,0},{-100,0}},color={95,95,95},thickness=0.5));
  connect(inverterLoss.heatPort,thermalMass.port) annotation(Line(points={{-30,42},{-18.5,42},{-18.5,-40},{-22,-40}},color={191,0,0}));
  connect(dynamicMotorHeat.port,thermalMass.port) annotation(Line(points={{-32,-52},{-22,-52},{-22,-40}},color={191,0,0}));
  connect(bearing.heatPort,thermalMass.port) annotation(Line(points={{50,-24},{50,-40},{-22,-40}},color={191,0,0}));
  connect(thermalMass.port,chassisPath.port_a) annotation(Line(points={{-22,-60},{-22,-50},{0,-50}},color={191,0,0}));
  connect(chassisPath.port_b,thermal) annotation(Line(points={{20,-50},{0,-50},{0,-100}},color={191,0,0}));
  connect(thermalMass.port,thermistor10.port) annotation(Line(points={{-22,-60},{-22,-76},{-32,-76}},color={191,0,0}));
  connect(speed.w,informationRealBridge[1].u) annotation(Line(points={{95,-12},{73.5,-12},{73.5,36},{78,36}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.wheelSpeed[3]) annotation(Line(points={{86,36},{100,36},{100,0}},color={0,0,127}));
  connect(currentShunt.i,informationRealBridge[2].u) annotation(Line(points={{-62,42},{78,42},{78,36}},color={0,0,127}));
  connect(informationRealBridge[2].y,information.device.wheelCurrent[3]) annotation(Line(points={{86,36},{100,36},{100,0}},color={0,0,127}));
  connect(currentShunt.i,informationRealBridge[3].u) annotation(Line(points={{-62,42},{78,42},{78,36}},color={0,0,127}));
  connect(informationRealBridge[3].y,information.device.pdCurrent[15]) annotation(Line(points={{86,36},{100,36},{100,0}},color={0,0,127}));
  connect(thermistor10.T,informationRealBridge[4].u) annotation(Line(points={{-12,-76},{-1.5,-76},{-1.5,36},{78,36}},color={0,0,127}));
  connect(informationRealBridge[4].y,information.device.thermistorTemperature[10]) annotation(Line(points={{86,36},{100,36},{100,0}},color={0,0,127}));
  connect(status.y,informationIntegerBridge[1].u) annotation(Line(points={{44,-22},{44,-42},{78,-42}},color={255,127,0}));
  connect(informationIntegerBridge[1].y,information.device.wheelStatus[3]) annotation(Line(points={{86,-42},{100,-42},{100,0}},color={255,127,0}));
  connect(telemetryCalculation.momentum,informationRealBridge[5].u) annotation(Line(points={{68.9,-65.1},{73.5,-65.1},{73.5,36},{78,36}},color={0,0,127}));
  connect(informationRealBridge[5].y,information.device.wheelMomentum[3]) annotation(Line(points={{86,36},{100,36},{100,0}},color={0,0,127}));
  connect(telemetryCalculation.saturated,informationBooleanBridge[1].u) annotation(Line(points={{68.9,-74.9},{80,-74.9},{80,-60}},color={255,0,255}));
  connect(informationBooleanBridge[1].y,information.device.wheelSaturated[3]) annotation(Line(points={{88,-60},{100,-60},{100,0}},color={255,0,255}));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={65,85,115},fillColor={235,241,249},fillPattern=FillPattern.Solid),Ellipse(extent={{-50,50},{50,-50}},fillColor={150,170,200},fillPattern=FillPattern.Solid),Ellipse(extent={{-18,18},{18,-18}},fillColor={65,75,95},fillPattern=FillPattern.Solid),Line(points={{-50,-50},{50,50}},color={40,90,190},thickness=2),Text(extent={{-92,-75},{92,-53}},textString="RW-Z / PD15 / T10")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Rectangle(extent={{-80,30},{98,-35}},lineColor={80,80,80},pattern=LinePattern.Dash),Text(extent={{-78,38},{62,28}},textString="斜率限制-限矩-Z支承")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>独立执行Z轴轮速命令并产生角动量、电流和热状态</p><h4>实现与接口</h4><p><b>系统级等效：</b>反馈误差经任务级比例增益和转矩限幅直接驱动Torque与Inertia；原0.05 s命令整形状态已删除。保留J·der(w)、机械反作用、转速、动量、饱和、电流损耗和10号热敏。</p><p><b>对外接口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、information（InformationPort）</p><p><b>数据路径：</b>Z轮为wheelSpeed/current/status索引3，速度转换为rpm进入SAT-S2。</p><h4>物理对象与接口</h4><p>Z轮独立读取wheelCommand[3]并在Z轴安装框架上传递反作用，信息、电源、热和机械接口与其他轮一致，但参数与内部限速结构独立。</p><h4>内部控制与特性</h4><p>命令经RealSignalReader进入反馈误差、比例增益和SlewRateLimiter，随后由转矩限幅器驱动转子。斜率限制抑制任务切换造成的瞬时转矩尖峰；电流分流测量、10号热敏与ReactionWheelTelemetryCalculation形成设备反馈。</p><h4>结果查看与边界</h4><p>优先查看slewLimiter.y、rotor.w、driveCurrent.i、thermistor10.T、momentum与saturated，遥测索引为3。模型不包含电流环和微振动高频模态。</p></html>"));
end ReactionWheelZUnit;
