within OneSatSim.Components;
model ReactionWheelYUnit "Y轴反作用飞轮组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.WheelYComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter OneSatSim.Foundation.Types.WheelGroupCapabilities wheelCapabilities "飞轮Capabilities" ;
  parameter Real wheelSpeedServoGain(unit="N.m.s/rad") "飞轮速度Servo增益 [N.m.s/rad]" ;
  parameter Modelica.Units.SI.Resistance standbyResistance=config.StandbyResistance
    "飞轮驱动电子学待机电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.Torque maxTorque=wheelCapabilities.maxTorque[2]
    "飞轮最大轴力矩；Excel单位N·m，当前设计基线";
  parameter Modelica.Units.SI.Inertia rotorInertia=wheelCapabilities.J[2]
    "飞轮转子惯量；Excel单位kg·m²，当前设计基线";
  parameter Real bearingDamping(unit="N.m.s/rad")=config.BearingDamping
    "轴承等效黏性阻尼；Excel单位N·m·s/rad，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity heatCapacity=config.HeatCapacity
    "飞轮等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountConductance=config.MountConductance
    "飞轮安装导热；Excel单位W/K，当前设计基线";
  parameter Real axis_X=wheelCapabilities.axes[1,2]
    "飞轮转轴方向X；Excel单位1，当前设计基线";
  parameter Real axis_Y=wheelCapabilities.axes[2,2]
    "飞轮转轴方向Y；Excel单位1，当前设计基线";
  parameter Real axis_Z=wheelCapabilities.axes[3,2]
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
  parameter Modelica.Units.SI.AngularVelocity wheelSpeedLimit=wheelCapabilities.maxSpeed[2] "实际转子速度上限";
  parameter Real motorEfficiency(min=0.1,max=1)=config.MotorEfficiency "平均值电机效率，待器件数据标定";
  Foundation.Interfaces.PowerPort power  "功率" annotation(Placement(visible=true, transformation(origin={-480,335}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,95}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Conductor unused5Rail(G=0)  "计算/接口量 unused5Rail" annotation(Placement(visible=true, transformation(origin={-365,415}, extent={{-20,-20},{20,20}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0)  "计算/接口量 unused33Rail" annotation(Placement(visible=true, transformation(origin={-270,415}, extent={{-20,-20},{20,20}}, rotation=0)));
  Foundation.Interfaces.ThermalPort thermal  "热学" annotation(Placement(visible=true, transformation(origin={500,-320}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,-97}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(visible=true, transformation(origin={-485,-310}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.InformationPort information  "计算/接口量 information" annotation(Placement(visible=true, transformation(origin={710,15}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.RealSignalReader commandedSpeed  "可扩展总线实数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-400,95}, extent={{-16,-16},{16,16}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor phaseCurrent  "phase电流" annotation(Placement(visible=true, transformation(origin={-365,335}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor driverLoss(R=standbyResistance,useHeatPort=true) "任务级参数 36 mA supply work point" annotation(Placement(visible=true, transformation(origin={-240,335}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Sources.SignalCurrent dynamicMotorLoad
    "由实际轴功率驱动的12 V平均值电机负载" annotation(Placement(visible=true, transformation(origin={0,335}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor motorBusVoltage 
     "电机总线电压" annotation(Placement(visible=true, transformation(origin={-125,325}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Blocks.Math.Add commandError(k2=-1)  "指令误差" annotation(Placement(visible=true, transformation(origin={-285,95}, extent={{-28,-28},{28,28}}, rotation=0)));
  Foundation.Calculations.WheelSpeedServoCalculation servoGain(k=wheelSpeedServoGain) "系统级 task-rate wheel servo" annotation(Placement(visible=true, transformation(origin={-145,95}, extent={{-22,-22},{22,22}}, rotation=0)));
  Modelica.Blocks.Nonlinear.Limiter torqueLimit(uMax=maxTorque,uMin=-maxTorque,strict=true)  "torque限制" annotation(Placement(visible=true, transformation(origin={-5,95}, extent={{-28,-28},{28,28}}, rotation=0)));
  Modelica.Mechanics.Rotational.Sources.Torque motor(useSupport=true)  "电机 [N.m]" annotation(Placement(visible=true, transformation(origin={110,95}, extent={{-32,-32},{32,32}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Inertia rotor(J=rotorInertia,w(start=initialSpeed,fixed=true))  "计算/接口量 rotor" annotation(Placement(visible=true, transformation(origin={240,95}, extent={{-56,-56},{56,56}}, rotation=0)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speed  "速度" annotation(Placement(visible=true, transformation(origin={360,95}, extent={{-30,-30},{30,30}}, rotation=0)));
  Foundation.Calculations.ReactionWheelTelemetryCalculation telemetryCalculation(
    rotorInertia=rotorInertia,wheelSpeedLimit=wheelSpeedLimit)  "反作用飞轮角动量与饱和状态计算实例" annotation(Placement(visible=true, transformation(origin={500,120}, extent={{-22,-22},{22,22}}, rotation=0)));
  Foundation.Calculations.ReactionWheelPowerCalculation powerCalculation(etaMotor=motorEfficiency) 
     "反作用飞轮平均值机电热功率计算实例" annotation(Placement(visible=true, transformation(origin={160,310}, extent={{-62,-62},{62,62}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow dynamicMotorHeat 
     "dynamic电机热流" annotation(Placement(visible=true, transformation(origin={310,290}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Damper bearing(d=bearingDamping,useHeatPort=true)  "计算/接口量 bearing" annotation(Placement(visible=true, transformation(origin={240,-100}, extent={{-28,-28},{28,28}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.Mounting1D mount(n={axis_X,axis_Y,axis_Z})  "计算/接口量 mount" annotation(Placement(visible=true, transformation(origin={90,-235}, extent={{-34,-34},{34,34}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.Body wheelHousing(
    m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ)
    "Y轮壳体与安装件，位于结构基准+X/-Y上舱角" annotation(Placement(visible=true, transformation(origin={-360,-310}, extent={{-32,-32},{32,32}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor thermalMass(C=heatCapacity,T(start=276.40,fixed=true)) "热敏电阻7对应的初始工作点" annotation(Placement(visible=true, transformation(origin={235,-290}, extent={{-30,-30},{30,30}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor mountingPath(G=mountConductance) "系统级 wheel Y conductive mounting" annotation(Placement(visible=true, transformation(origin={380,-320}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor thermistor7  "计算/接口量 thermistor7" annotation(Placement(visible=true, transformation(origin={325,-410}, extent={{-22,-22},{22,22}}, rotation=0)));
  Modelica.Blocks.Sources.IntegerConstant status(k=1)  "计算/接口量 status" annotation(Placement(visible=true, transformation(origin={420,-180}, extent={{-22,-22},{22,22}}, rotation=0)));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[5]  "实数因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={595,-35}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[1]  "整数因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={595,-180}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.BooleanSignalBridge informationBooleanBridge[1]  "布尔因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={595,280}, extent={{-16,-16},{16,16}}, rotation=0)));
equation
  connect(speed.w,telemetryCalculation.angularVelocity) annotation(Line(points={{393,95},{434.82,95},{434.82,120},{444.82,120}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information.command.wheelCommand[2],commandedSpeed.u) annotation(Line(points={{710,15},{710,14.9},{-447.38,14.9},{-447.38,95},{-414.24,95}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p5,unused5Rail.p) annotation(Line(points={{-480,335},{-480,415},{-385,415}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused5Rail.n,power.n5) annotation(Line(points={{-345,415},{-335,415},{-335,369},{-480,369},{-480,335}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{-480,335},{-480,369},{-300,369},{-300,415},{-290,415}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{-250,415},{-240,415},{-240,369},{-480,369},{-480,335}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p12,phaseCurrent.p) annotation(Line(points={{-480,335},{-389,335}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(phaseCurrent.n,driverLoss.p) annotation(Line(points={{-341,335},{-264,335}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(phaseCurrent.n,dynamicMotorLoad.p) annotation(Line(points={{-341,335},{-331,335},{-331,369},{-34,369},{-34,335},{-24,335}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(driverLoss.n,power.n12) annotation(Line(points={{-216,335},{-206,335},{-206,301},{-480,301},{-480,335}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(dynamicMotorLoad.n,power.n12) annotation(Line(points={{24,335},{34,335},{34,369},{-480,369},{-480,335}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(motorBusVoltage.p,phaseCurrent.n) annotation(Line(points={{-149,325},{-159,325},{-159,301},{-331,301},{-331,335},{-341,335}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(motorBusVoltage.n,power.n12) annotation(Line(points={{-101,325},{-91,325},{-91,291},{-480,291},{-480,335}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(commandedSpeed.y,commandError.u1) annotation(Line(points={{-385.76,95},{-328.6,95},{-328.6,111.8},{-318.6,111.8}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(speed.w,commandError.u2) annotation(Line(points={{393,95},{403,95},{403,20.98},{-328.6,20.98},{-328.6,78.2},{-318.6,78.2}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(commandError.y,servoGain.u) annotation(Line(points={{-254.2,95},{-203.74,95}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(servoGain.y,torqueLimit.u) annotation(Line(points={{-86.26,95},{-38.6,95}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(torqueLimit.y,motor.tau) annotation(Line(points={{25.8,95},{71.6,95}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(torqueLimit.y,powerCalculation.motorTorque) annotation(Line(points={{25.8,95},{35.8,95},{35.8,359.6},{104.82,359.6}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(speed.w,powerCalculation.angularVelocity) annotation(Line(points={{393,95},{403,95},{403,161},{94.82,161},{94.82,310},{104.82,310}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(motorBusVoltage.v,powerCalculation.busVoltage) annotation(Line(points={{-125,298.6},{-125,260.4},{104.82,260.4}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(powerCalculation.dynamicCurrentCommand,dynamicMotorLoad.i) annotation(Line(points={{215.18,293.46666},{225.18,293.46666},{225.18,373.8},{0,373.8},{0,363.8}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(powerCalculation.dynamicLossHeat,dynamicMotorHeat.Q_flow) annotation(Line(points={{215.18,260.4},{276,260.4},{276,290},{286,290}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(motor.flange,rotor.flange_a) annotation(Line(points={{142,95},{184,95}}, color={0,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(rotor.flange_b,speed.flange) annotation(Line(points={{296,95},{330,95}}, color={0,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(rotor.flange_b,bearing.flange_a) annotation(Line(points={{296,95},{306,95},{306,-62},{202,-62},{202,-100},{212,-100}}, color={0,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(bearing.flange_b,mount.flange_b) annotation(Line(points={{268,-100},{278,-100},{278,-235},{124,-235}}, color={0,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(motor.support,mount.flange_b) annotation(Line(points={{110,63},{110,53},{134,53},{134,-235},{124,-235}}, color={0,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mount.frame_a,mechanical) annotation(Line(points={{90,-269},{90,-352},{-485,-352},{-485,-310}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(wheelHousing.frame_a,mechanical) annotation(Line(points={{-392,-310},{-485,-310}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(driverLoss.heatPort,thermalMass.port) annotation(Line(points={{-240,311},{-240,14.9},{202,14.9},{202,-330},{235,-330},{235,-320}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(dynamicMotorHeat.port,thermalMass.port) annotation(Line(points={{334,290},{344,290},{344,133},{306,133},{306,-330},{235,-330},{235,-320}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(bearing.heatPort,thermalMass.port) annotation(Line(points={{212,-128},{202,-128},{202,-330},{235,-330},{235,-320}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermalMass.port,mountingPath.port_a) annotation(Line(points={{235,-320},{235,-330},{346,-330},{346,-320},{356,-320}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mountingPath.port_b,thermal) annotation(Line(points={{404,-320},{500,-320}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermalMass.port,thermistor7.port) annotation(Line(points={{235,-320},{235,-410},{303,-410}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(speed.w,informationRealBridge[1].u) annotation(Line(points={{393,95},{403,95},{403,-35},{580.76,-35}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[1].y,information.device.wheelSpeed[2]) annotation(Line(points={{609.24,-35},{710,-35},{710,15}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(phaseCurrent.i,informationRealBridge[2].u) annotation(Line(points={{-365,308.6},{-365,298.6},{-475,298.6},{-475,-35},{580.76,-35}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[2].y,information.device.wheelCurrent[2]) annotation(Line(points={{609.24,-35},{710,-35},{710,15}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(phaseCurrent.i,informationRealBridge[3].u) annotation(Line(points={{-365,308.6},{-365,298.6},{-475,298.6},{-475,-35},{580.76,-35}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[3].y,information.device.pdCurrent[14]) annotation(Line(points={{609.24,-35},{710,-35},{710,15}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermistor7.T,informationRealBridge[4].u) annotation(Line(points={{349.2,-410},{547.62,-410},{547.62,-35},{580.76,-35}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[4].y,information.device.thermistorTemperature[7]) annotation(Line(points={{609.24,-35},{710,-35},{710,15}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(status.y,informationIntegerBridge[1].u) annotation(Line(points={{420,-180},{580.76,-180}}, color={255,127,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationIntegerBridge[1].y,information.device.wheelStatus[2]) annotation(Line(points={{609.24,-180},{710,-180},{710,15}}, color={255,127,0}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(telemetryCalculation.momentum,informationRealBridge[5].u) annotation(Line(points={{555.18,169.6},{565.18,169.6},{565.18,14.9},{547.62,14.9},{547.62,-35},{580.76,-35}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[5].y,information.device.wheelMomentum[2]) annotation(Line(points={{609.24,-35},{710,-35},{710,15}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(telemetryCalculation.saturated,informationBooleanBridge[1].u) annotation(Line(points={{519.58,102.4},{565.18,102.4},{565.18,188.9},{547.62,188.9},{547.62,280},{580.76,280}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationBooleanBridge[1].y,information.device.wheelSaturated[2]) annotation(Line(points={{609.24,280},{710,280},{710,15}}, color={255,0,255}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>Y轴反作用飞轮组件</h2><p><b>类路径：</b><code>OneSatSim.Components.ReactionWheelYUnit</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>Y轴反作用飞轮组件</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.N_systems.GNCSystem\">OneSatSim.Systems.N_systems.GNCSystem</a> 的 <code>wheelY</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>power</code></td><td>Foundation.Interfaces.PowerPort</td><td>public</td><td>按声明/类型合同</td><td>功率</td></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr><tr><td><code>information</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr><tr><td><code>commandedSpeed</code></td><td>Foundation.Interfaces.RealSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线实数信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>informationRealBridge[5]</code></td><td>Foundation.Interfaces.RealSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>实数因果输出到可扩展信息总线的无状态恒等桥实例</td></tr><tr><td><code>informationIntegerBridge[1]</code></td><td>Foundation.Interfaces.IntegerSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>整数因果输出到可扩展信息总线的无状态恒等桥实例</td></tr><tr><td><code>informationBooleanBridge[1]</code></td><td>Foundation.Interfaces.BooleanSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>布尔因果输出到可扩展信息总线的无状态恒等桥实例</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>config</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.WheelYComponentConfig</td><td>由所属N-System传入的硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>wheelCapabilities</code></td><td>OneSatSim.Foundation.Types.WheelGroupCapabilities</td><td>飞轮Capabilities</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>wheelSpeedServoGain</code></td><td>Real</td><td>飞轮速度Servo增益 [N.m.s/rad]</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>standbyResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>飞轮驱动电子学待机电阻；Excel单位Ω，当前设计基线</td><td><code>=config.StandbyResistance</code></td></tr><tr><td><code>maxTorque</code></td><td>Modelica.Units.SI.Torque</td><td>飞轮最大轴力矩；Excel单位N·m，当前设计基线</td><td><code>=wheelCapabilities.maxTorque[2]</code></td></tr><tr><td><code>rotorInertia</code></td><td>Modelica.Units.SI.Inertia</td><td>飞轮转子惯量；Excel单位kg·m²，当前设计基线</td><td><code>=wheelCapabilities.J[2]</code></td></tr><tr><td><code>bearingDamping</code></td><td>Real</td><td>轴承等效黏性阻尼；Excel单位N·m·s/rad，当前设计基线</td><td><code>=config.BearingDamping</code></td></tr><tr><td><code>heatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>飞轮等效热容；Excel单位J/K，当前设计基线</td><td><code>=config.HeatCapacity</code></td></tr><tr><td><code>mountConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>飞轮安装导热；Excel单位W/K，当前设计基线</td><td><code>=config.MountConductance</code></td></tr><tr><td><code>axis_X</code></td><td>Real</td><td>飞轮转轴方向X；Excel单位1，当前设计基线</td><td><code>=wheelCapabilities.axes[1,2]</code></td></tr><tr><td><code>axis_Y</code></td><td>Real</td><td>飞轮转轴方向Y；Excel单位1，当前设计基线</td><td><code>=wheelCapabilities.axes[2,2]</code></td></tr><tr><td><code>axis_Z</code></td><td>Real</td><td>飞轮转轴方向Z；Excel单位1，当前设计基线</td><td><code>=wheelCapabilities.axes[3,2]</code></td></tr><tr><td><code>mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel单位kg，当前设计基线</td><td><code>=config.Mass</code></td></tr><tr><td><code>rcm_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel单位m，当前设计基线</td><td><code>=config.RCM_X</code></td></tr><tr><td><code>rcm_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel单位m，当前设计基线</td><td><code>=config.RCM_Y</code></td></tr><tr><td><code>rcm_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel单位m，当前设计基线</td><td><code>=config.RCM_Z</code></td></tr><tr><td><code>inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_XX</code></td></tr><tr><td><code>inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_YY</code></td></tr><tr><td><code>inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_ZZ</code></td></tr><tr><td><code>initialSpeed</code></td><td>Modelica.Units.SI.AngularVelocity</td><td>场景初始轮速</td><td><code>=130.7506044</code></td></tr><tr><td><code>wheelSpeedLimit</code></td><td>Modelica.Units.SI.AngularVelocity</td><td>实际转子速度上限</td><td><code>=wheelCapabilities.maxSpeed[2]</code></td></tr><tr><td><code>motorEfficiency</code></td><td>Real</td><td>平均值电机效率，待器件数据标定</td><td><code>=config.MotorEfficiency</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>unused5Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused5Rail</td></tr><tr><td><code>unused33Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused33Rail</td></tr><tr><td><code>phaseCurrent</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Sensors.CurrentSensor\">Modelica.Electrical.Analog.Sensors.CurrentSensor</a></td><td>phase电流</td></tr><tr><td><code>driverLoss</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Resistor\">Modelica.Electrical.Analog.Basic.Resistor</a></td><td>任务级参数 36 mA supply work point</td></tr><tr><td><code>dynamicMotorLoad</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Sources.SignalCurrent\">Modelica.Electrical.Analog.Sources.SignalCurrent</a></td><td>由实际轴功率驱动的12 V平均值电机负载</td></tr><tr><td><code>motorBusVoltage</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Sensors.VoltageSensor\">Modelica.Electrical.Analog.Sensors.VoltageSensor</a></td><td>电机总线电压</td></tr><tr><td><code>commandError</code></td><td><a href=\"modelica://Modelica.Blocks.Math.Add\">Modelica.Blocks.Math.Add</a></td><td>指令误差</td></tr><tr><td><code>servoGain</code></td><td><a href=\"modelica://OneSatSim.Foundation.Calculations.WheelSpeedServoCalculation\">OneSatSim.Foundation.Calculations.WheelSpeedServoCalculation</a></td><td>系统级 task-rate wheel servo</td></tr><tr><td><code>torqueLimit</code></td><td><a href=\"modelica://Modelica.Blocks.Nonlinear.Limiter\">Modelica.Blocks.Nonlinear.Limiter</a></td><td>torque限制</td></tr><tr><td><code>motor</code></td><td><a href=\"modelica://Modelica.Mechanics.Rotational.Sources.Torque\">Modelica.Mechanics.Rotational.Sources.Torque</a></td><td>电机 [N.m]</td></tr><tr><td><code>rotor</code></td><td><a href=\"modelica://Modelica.Mechanics.Rotational.Components.Inertia\">Modelica.Mechanics.Rotational.Components.Inertia</a></td><td>计算/接口量 rotor</td></tr><tr><td><code>speed</code></td><td><a href=\"modelica://Modelica.Mechanics.Rotational.Sensors.SpeedSensor\">Modelica.Mechanics.Rotational.Sensors.SpeedSensor</a></td><td>速度</td></tr><tr><td><code>telemetryCalculation</code></td><td><a href=\"modelica://OneSatSim.Foundation.Calculations.ReactionWheelTelemetryCalculation\">OneSatSim.Foundation.Calculations.ReactionWheelTelemetryCalculation</a></td><td>反作用飞轮角动量与饱和状态计算实例</td></tr><tr><td><code>powerCalculation</code></td><td><a href=\"modelica://OneSatSim.Foundation.Calculations.ReactionWheelPowerCalculation\">OneSatSim.Foundation.Calculations.ReactionWheelPowerCalculation</a></td><td>反作用飞轮平均值机电热功率计算实例</td></tr><tr><td><code>dynamicMotorHeat</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow\">Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow</a></td><td>dynamic电机热流</td></tr><tr><td><code>bearing</code></td><td><a href=\"modelica://Modelica.Mechanics.Rotational.Components.Damper\">Modelica.Mechanics.Rotational.Components.Damper</a></td><td>计算/接口量 bearing</td></tr><tr><td><code>mount</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Mounting1D\">Modelica.Mechanics.MultiBody.Parts.Mounting1D</a></td><td>计算/接口量 mount</td></tr><tr><td><code>wheelHousing</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">Modelica.Mechanics.MultiBody.Parts.Body</a></td><td>Y轮壳体与安装件，位于结构基准+X/-Y上舱角</td></tr><tr><td><code>thermalMass</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a></td><td>热敏电阻7对应的初始工作点</td></tr><tr><td><code>mountingPath</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">Modelica.Thermal.HeatTransfer.Components.ThermalConductor</a></td><td>系统级 wheel Y conductive mounting</td></tr><tr><td><code>thermistor7</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor\">Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor</a></td><td>计算/接口量 thermistor7</td></tr><tr><td><code>status</code></td><td><a href=\"modelica://Modelica.Blocks.Sources.IntegerConstant\">Modelica.Blocks.Sources.IntegerConstant</a></td><td>计算/接口量 status</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Attitude actuator", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-55,-37},{44,-29}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Rectangle(extent={{-37,-30},{-27,-19}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Rectangle(extent={{26,-30},{36,-19}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Ellipse(extent={{-48,-23},{44,35}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, startAngle=0, endAngle=360),
      Ellipse(extent={{-40,-18},{36,29}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-27,-10},{23,23}}, lineColor={0,0,0}, fillColor={234,240,244}, fillPattern=FillPattern.Solid, lineThickness=0.55, startAngle=0, endAngle=360),
      Ellipse(extent={{-12,-3},{8,15}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-6,1},{2,11}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{9,6},{32,6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{5.778175,10.949747},{22.041631,20.142136}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-2,13},{-2,26}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-9.778175,10.949747},{-26.041631,20.142136}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-13,6},{-36,6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-9.778175,1.050253},{-26.041631,-8.142136}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-2,-1},{-2,-14}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{5.778175,1.050253},{22.041631,-8.142136}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-32,42},{-13,49},{12,47},{29,40}}, color={76,128,143}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Ellipse(extent={{-50,-35},{-46,-31}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-49,-33},{-47,-33}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{35,-35},{39,-31}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{36,-33},{38,-33}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{54,-21},{73,-21}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{54,-21},{44.12,-8.84}}, color={76,128,143}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{54,-21},{54,-2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Text(extent={{47,20},{72,41}}, textString="Y", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Y Reaction Wheel", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-529,-470},{754,557}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-465,209},{-271.8,227}}, textString="Speed control and rotor", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-435,469},{-300.6,487}}, textString="Electrical drive", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-420,-31},{-193.2,-13}}, textString="Mechanical support and heat", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-517,512},{742,541}}, textString="Reaction wheel Y: speed loop and drive power", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-517,504},{742,504}}, color={215,220,226}, thickness=0.25)
    }));
end ReactionWheelYUnit;