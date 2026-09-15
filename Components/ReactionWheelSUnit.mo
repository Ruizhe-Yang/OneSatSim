within NISSA_12UCubeSat.Components;
model ReactionWheelSUnit "斜置反作用飞轮组件"
  parameter NISSA_12UCubeSat.Scenarios.DesignConfigRecords.WheelSComponentConfig config
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
  parameter Modelica.Units.SI.AngularVelocity initialSpeed=0 "场景初始轮速";
  parameter Modelica.Units.SI.AngularVelocity wheelSpeedLimit=config.SpeedLimit "任务级参数: 6000 rpm";
  parameter Real motorEfficiency(min=0.1,max=1)=config.MotorEfficiency "平均值电机效率，待器件数据标定";
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}}),iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Basic.Conductor unused5Rail(G=0) annotation(Placement(transformation(extent={{42,76},{54,88}})));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0) annotation(Placement(transformation(extent={{66,76},{78,88}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  Foundation.Interfaces.RealSignalReader commandedSpeed annotation(Placement(transformation(extent={{-96,2},{-76,18}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor supplyCurrent annotation(Placement(transformation(extent={{-75,40},{-55,60}})));
  Modelica.Electrical.Analog.Basic.Resistor controllerLoss(R=standbyResistance,useHeatPort=true) "任务级参数 standby redundant wheel supply work point" annotation(Placement(transformation(extent={{-42,40},{-22,60}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent dynamicMotorLoad
    "由实际轴功率驱动的12 V平均值电机负载" annotation(Placement(transformation(extent={{-42,64},{-22,84}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor motorBusVoltage
    annotation(Placement(transformation(origin={-10,72},extent={{-8,-8},{8,8}},rotation=270)));
  Modelica.Blocks.Math.Feedback speedError annotation(Placement(transformation(extent={{-72,4},{-52,24}})));
  Modelica.Blocks.Math.Gain compensator(k=1.5e-4) "系统级 task-rate wheel servo" annotation(Placement(transformation(extent={{-42,4},{-22,24}})));
  Modelica.Blocks.Nonlinear.Limiter torqueLimit(uMax=maxTorque,uMin=-0.0038,strict=true) annotation(Placement(transformation(extent={{-12,4},{8,24}})));
  Modelica.Mechanics.Rotational.Sources.Torque motor(useSupport=true) annotation(Placement(transformation(extent={{18,4},{38,24}})));
  Modelica.Mechanics.Rotational.Components.Inertia rotor(J=rotorInertia,w(start=initialSpeed,fixed=true)) annotation(Placement(transformation(extent={{48,4},{68,24}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed annotation(Placement(transformation(extent={{74,-22},{94,-2}})));
  Foundation.Calculations.ReactionWheelTelemetryCalculation telemetryCalculation(
    rotorInertia=1.02e-4,wheelSpeedLimit=wheelSpeedLimit) annotation(Placement(transformation(extent={{48,-84},{70,-56}})));
  Foundation.Calculations.ReactionWheelPowerCalculation powerCalculation(etaMotor=motorEfficiency)
    annotation(Placement(transformation(extent={{12,-92},{40,-64}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow dynamicMotorHeat
    annotation(Placement(transformation(extent={{-54,-63},{-34,-43}})));
  Modelica.Mechanics.Rotational.Components.Damper bearing(d=bearingDamping,useHeatPort=true) annotation(Placement(transformation(origin={58,-25},extent={{-8,-8},{8,8}},rotation=270)));
  Modelica.Mechanics.MultiBody.Parts.Mounting1D mount(n={axis_X,axis_Y,axis_Z}) annotation(Placement(transformation(origin={-70,-22},extent={{-10,-10},{10,10}},rotation=90)));
  Modelica.Mechanics.MultiBody.Parts.Body wheelHousing(
    m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ)
    "斜置轮壳体与安装件，位于结构基准+X/+Y上舱角" annotation(Placement(transformation(extent={{-52,-26},{-32,-6}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor thermalMass(C=heatCapacity,T(start=275.19,fixed=true)) "热敏电阻11对应的初始工作点" annotation(Placement(transformation(extent={{-34,-61},{-14,-41}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor isolatorPath(G=mountConductance) "系统级 standby wheel isolation path" annotation(Placement(transformation(extent={{0,-59},{20,-43}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor thermistor11 annotation(Placement(transformation(extent={{-34,-87},{-14,-67}})));
  Modelica.Blocks.Sources.IntegerConstant status(k=1) annotation(Placement(transformation(extent={{23,-32},{43,-12}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[5] annotation(Placement(transformation(extent={{78,32},{86,40}})));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[1] annotation(Placement(transformation(extent={{78,-46},{86,-38}})));
  Foundation.Interfaces.BooleanSignalBridge informationBooleanBridge[1] annotation(Placement(transformation(extent={{80,-64},{88,-56}})));
equation
  connect(speed.w,telemetryCalculation.angularVelocity) annotation(Line(points={{94,-12},{44,-12},{44,-70},{48,-70}},color={0,0,127}));
  connect(information.command.wheelCommand[4],commandedSpeed.u) annotation(Line(points={{100,0},{-90,0},{-90,10},{-96,10}},color={0,0,127}));
  connect(power.p5,unused5Rail.p) annotation(Line(points={{0,100},{0,94},{42,94},{42,82}},color={0,0,255}));
  connect(unused5Rail.n,power.n5) annotation(Line(points={{54,82},{54,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,82}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{78,82},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p12,supplyCurrent.p) annotation(Line(points={{0,100},{0,94},{-75,94},{-75,50}},color={0,0,255}));
  connect(supplyCurrent.n,controllerLoss.p) annotation(Line(points={{-55,50},{-48,50},{-42,50}},color={0,0,255}));
  connect(supplyCurrent.n,dynamicMotorLoad.p) annotation(Line(points={{-55,50},{-48,50},{-48,74},{-42,74}},color={0,0,255}));
  connect(controllerLoss.n,power.n12) annotation(Line(points={{-22,50},{-22,94},{0,94},{0,100}},color={0,0,255}));
  connect(dynamicMotorLoad.n,power.n12) annotation(Line(points={{-22,74},{-22,94},{0,94},{0,100}},color={0,0,255}));
  connect(motorBusVoltage.p,supplyCurrent.n) annotation(Line(points={{-10,80},{-10,88},{-48,88},{-48,50},{-55,50}},color={0,0,255}));
  connect(motorBusVoltage.n,power.n12) annotation(Line(points={{-10,64},{-10,94},{0,94},{0,100}},color={0,0,255}));
  connect(commandedSpeed.y,speedError.u1) annotation(Line(points={{-76,10},{-72,10},{-72,14},{-70,14}},color={0,0,127}));
  connect(speed.w,speedError.u2) annotation(Line(points={{94,-12},{44.5,-12},{44.5,2.5},{-62,2.5},{-62,6}},color={0,0,127}));
  connect(speedError.y,compensator.u) annotation(Line(points={{-53,14},{-44,14}},color={0,0,127}));
  connect(compensator.y,torqueLimit.u) annotation(Line(points={{-21,14},{-14,14}},color={0,0,127}));
  connect(torqueLimit.y,motor.tau) annotation(Line(points={{9,14},{16,14}},color={0,0,127}));
  connect(torqueLimit.y,powerCalculation.motorTorque) annotation(Line(points={{9,14},{-1.5,14},{-1.5,-70.3},{12,-70.3}},color={0,0,127}));
  connect(speed.w,powerCalculation.angularVelocity) annotation(Line(points={{94,-12},{44,-12},{44,-70},{12,-70},{12,-78}},color={0,0,127}));
  connect(motorBusVoltage.v,powerCalculation.busVoltage) annotation(Line(points={{-2,72},{16.5,72},{16.5,-41.5},{21.5,-41.5},{21.5,-85.7},{12,-85.7}},color={0,0,127}));
  connect(powerCalculation.dynamicCurrentCommand,dynamicMotorLoad.i) annotation(Line(points={{40,-79.4},{40,-33.5},{-20.5,-33.5},{-20.5,86},{-32,86}},color={0,0,127}));
  connect(powerCalculation.dynamicLossHeat,dynamicMotorHeat.Q_flow) annotation(Line(points={{40,-85},{40,-62.5},{-54,-62.5},{-54,-53}},color={0,0,127}));
  connect(motor.flange,rotor.flange_a) annotation(Line(points={{38,14},{48,14}},color={0,0,0}));
  connect(rotor.flange_b,speed.flange) annotation(Line(points={{68,14},{68,-12},{94,-12}},color={0,0,0}));
  connect(rotor.flange_b,bearing.flange_a) annotation(Line(points={{68,14},{58,14},{58,-17}},color={0,0,0}));
  connect(bearing.flange_b,mount.flange_b) annotation(Line(points={{58,-33},{58,-33.5},{-60,-33.5},{-60,-22}},color={0,0,0}));
  connect(motor.support,mount.flange_b) annotation(Line(points={{28,4},{28,-4.5},{-60,-4.5},{-60,-22}},color={0,0,0}));
  connect(mount.frame_a,mechanical) annotation(Line(points={{-80,-22},{-94,-22},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  connect(wheelHousing.frame_a,mechanical) annotation(Line(points={{-52,-16},{-52,0},{-100,0}},color={95,95,95},thickness=0.5));
  connect(controllerLoss.heatPort,thermalMass.port) annotation(Line(points={{-32,40},{-20.5,40},{-20.5,-41},{-24,-41}},color={191,0,0}));
  connect(dynamicMotorHeat.port,thermalMass.port) annotation(Line(points={{-34,-53},{-24,-53},{-24,-41}},color={191,0,0}));
  connect(bearing.heatPort,thermalMass.port) annotation(Line(points={{50,-25},{50,-41},{-24,-41}},color={191,0,0}));
  connect(thermalMass.port,isolatorPath.port_a) annotation(Line(points={{-24,-61},{-24,-51},{0,-51}},color={191,0,0}));
  connect(isolatorPath.port_b,thermal) annotation(Line(points={{20,-51},{0,-51},{0,-100}},color={191,0,0}));
  connect(thermalMass.port,thermistor11.port) annotation(Line(points={{-24,-61},{-24,-77},{-34,-77}},color={191,0,0}));
  connect(speed.w,informationRealBridge[1].u) annotation(Line(points={{94,-12},{78,-12},{78,36}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.wheelSpeed[4]) annotation(Line(points={{86,36},{94,36},{94,0},{100,0}},color={0,0,127}));
  connect(supplyCurrent.i,informationRealBridge[2].u) annotation(Line(points={{-65,40},{78,40},{78,36}},color={0,0,127}));
  connect(informationRealBridge[2].y,information.device.wheelCurrent[4]) annotation(Line(points={{86,36},{94,36},{94,0},{100,0}},color={0,0,127}));
  connect(supplyCurrent.i,informationRealBridge[3].u) annotation(Line(points={{-65,40},{78,40},{78,36}},color={0,0,127}));
  connect(informationRealBridge[3].y,information.device.pdCurrent[16]) annotation(Line(points={{86,36},{94,36},{94,0},{100,0}},color={0,0,127}));
  connect(thermistor11.T,informationRealBridge[4].u) annotation(Line(points={{-14,-77},{-14,-62.5},{46.5,-62.5},{46.5,36},{78,36}},color={0,0,127}));
  connect(informationRealBridge[4].y,information.device.thermistorTemperature[11]) annotation(Line(points={{86,36},{94,36},{94,0},{100,0}},color={0,0,127}));
  connect(status.y,informationIntegerBridge[1].u) annotation(Line(points={{44,-22},{44,-42},{78,-42}},color={255,127,0}));
  connect(informationIntegerBridge[1].y,information.device.wheelStatus[4]) annotation(Line(points={{86,-42},{94,-42},{94,0},{100,0}},color={255,127,0}));
  connect(telemetryCalculation.momentum,informationRealBridge[5].u) annotation(Line(points={{68.9,-65.1},{72.5,-65.1},{72.5,36},{78,36}},color={0,0,127}));
  connect(informationRealBridge[5].y,information.device.wheelMomentum[4]) annotation(Line(points={{86,36},{94,36},{94,0},{100,0}},color={0,0,127}));
  connect(telemetryCalculation.saturated,informationBooleanBridge[1].u) annotation(Line(points={{68.9,-74.9},{80,-74.9},{80,-60}},color={255,0,255}));
  connect(informationBooleanBridge[1].y,information.device.wheelSaturated[4]) annotation(Line(points={{88,-60},{94,-60},{94,0},{100,0}},color={255,0,255}));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={70,85,115},fillColor={236,241,249},fillPattern=FillPattern.Solid),Ellipse(extent={{-50,50},{50,-50}},fillColor={155,175,205},fillPattern=FillPattern.Solid),Ellipse(extent={{-18,18},{18,-18}},fillColor={65,75,95},fillPattern=FillPattern.Solid),Line(points={{-50,50},{50,-50}},color={145,65,180},thickness=2),Text(extent={{-92,-75},{92,-53}},textString="RW-S / PD16 / T11")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Rectangle(extent={{-82,30},{100,-36}},lineColor={80,80,80},pattern=LinePattern.Dash),Text(extent={{-80,38},{75,28}},textString="冗余斜装-柔性联接-独立热路")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>作为第四台独立飞轮执行斜置轴速度指令并产生角动量、电流和热状态</p><h4>实现与接口</h4><p><b>系统级等效：</b>速度误差经任务级比例增益和转矩限幅直接驱动Torque与Inertia；原0.06 s补偿状态和柔性轴状态已删除。保留J·der(w)、斜置轴机械反作用、转速、动量、饱和、电流损耗和11号热敏。</p><p><b>对外接口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、information（InformationPort）</p><p><b>数据路径：</b>斜置轮对应wheelSpeed[4]、wheelCurrent[4]和wheelStatus[4]，转速以rpm进入SAT-S2。</p><h4>物理对象与接口</h4><p>S轮是沿{1,1,1}归一化斜轴安装的第四台独立飞轮，读取wheelCommand[4]。它不是X/Y/Z轮的复制件，安装方向、转子惯量、转矩限值、损耗与温度测点均独立。</p><h4>内部控制与特性</h4><p>命令经RealSignalReader、速度误差和死区环节后驱动伺服与转子。死区降低小误差下的无意义抖动，斜轴力矩通过三轴分解参与冗余分配和零空间均衡；电流、11号热敏、角动量和饱和状态回写统一信息接口。</p><h4>结果查看与边界</h4><p>优先查看deadZone.y、rotor.w、driveCurrent.i、thermistor11.T和遥测索引4。判断整星轮组余度时必须连同X/Y/Z轮及EquivalentAOCSCore分配结果分析。</p></html>"));
end ReactionWheelSUnit;
