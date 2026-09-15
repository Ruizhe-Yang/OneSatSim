within OneSatSim.Components;
model RateGyroUnit "三轴角速率陀螺组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.RateGyroComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance loadResistance=config.LoadResistance
    "rateGyro等效负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity heatCapacity=config.HeatCapacity
    "rateGyro等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountConductance=config.MountConductance
    "rateGyro安装导热；Excel单位W/K，当前设计基线";
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
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}}),iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Basic.Conductor unused5Rail(G=0) annotation(Placement(transformation(extent={{42,76},{54,88}})));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0) annotation(Placement(transformation(extent={{66,76},{78,88}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  Foundation.Calculations.RateGyroModeCalculation modeCalculation annotation(Placement(transformation(extent={{-96,64},{-72,80}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor supplyCurrent annotation(Placement(transformation(extent={{-88,10},{-72,30}})));
  Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngularVelocity angularRate(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a) annotation(Placement(transformation(extent={{-87,-31},{-57,-1}})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch gyroPowerSwitch annotation(Placement(transformation(extent={{-68,10},{-48,30}})));
  Modelica.Electrical.Analog.Basic.Resistor opticalLoad(R=loadResistance,useHeatPort=true) annotation(Placement(transformation(extent={{-38,10},{-18,30}})));
  Modelica.Blocks.Sources.Constant zeroRate[3](each k=0) annotation(Placement(transformation(extent={{10,18},{28,32}})));
  Modelica.Blocks.Logical.Switch reportedRate[3] annotation(Placement(transformation(extent={{36,32},{56,52}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor gyroThermalMass(C=heatCapacity,T(start=276.40,fixed=false)) annotation(Placement(transformation(extent={{-25,-45},{-5,-25}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor flangePath(G=mountConductance) annotation(Placement(transformation(extent={{15,-43},{35,-27}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor thermistor3 annotation(Placement(transformation(extent={{-25,-75},{-5,-55}})));
  Modelica.Mechanics.MultiBody.Parts.Body gyroBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-52,-26},{-32,-6}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[5] annotation(Placement(transformation(extent={{78,20},{86,28}})));
equation
  connect(information.command.desiredControlMode,modeCalculation.desiredControlMode) annotation(Line(points={{100,0},{94,0},{94,72},{-96,72}},color={255,127,0}));
  connect(power.p5,unused5Rail.p) annotation(Line(points={{0,100},{0,94},{42,94},{42,82}},color={0,0,255}));
  connect(unused5Rail.n,power.n5) annotation(Line(points={{54,82},{54,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,82}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{78,82},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(mechanical,angularRate.frame_a) annotation(Line(points={{-100,0},{-94,0},{-94,-16},{-87,-16}},color={95,95,95},thickness=0.5));
  connect(mechanical,gyroBody.frame_a) annotation(Line(points={{-100,0},{-100,0.5},{-52,0.5},{-52,-16}},color={95,95,95},thickness=0.5));
  connect(angularRate.w,reportedRate.u1) annotation(Line(points={{-55.5,-16},{-55.5,8.5},{36,8.5},{36,50}},color={0,0,127}));
  connect(modeCalculation.precisionEnabled,reportedRate[1].u2) annotation(Line(points={{-73.2,72},{30,72},{30,42},{36,42}},color={255,0,255}));
  connect(modeCalculation.precisionEnabled,reportedRate[2].u2) annotation(Line(points={{-73.2,72},{30,72},{30,42},{36,42}},color={255,0,255}));
  connect(modeCalculation.precisionEnabled,reportedRate[3].u2) annotation(Line(points={{-73.2,72},{30,72},{30,42},{36,42}},color={255,0,255}));
  connect(zeroRate.y,reportedRate.u3) annotation(Line(points={{28.9,25},{32,25},{32,34},{36,34}},color={0,0,127}));
  connect(reportedRate[1].y,informationRealBridge[1].u) annotation(Line(points={{57,42},{78,42},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.yh50Rate[1]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(reportedRate[2].y,informationRealBridge[2].u) annotation(Line(points={{57,42},{78,42},{78,24}},color={0,0,127}));
  connect(informationRealBridge[2].y,information.device.yh50Rate[2]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(reportedRate[3].y,informationRealBridge[3].u) annotation(Line(points={{57,42},{78,42},{78,24}},color={0,0,127}));
  connect(informationRealBridge[3].y,information.device.yh50Rate[3]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(power.p12,supplyCurrent.p) annotation(Line(points={{0,100},{0,31.5},{-88,31.5},{-88,20}},color={0,0,255}));
  connect(supplyCurrent.n,gyroPowerSwitch.p) annotation(Line(points={{-72,20},{-68,20}},color={0,0,255}));
  connect(gyroPowerSwitch.n,opticalLoad.p) annotation(Line(points={{-48,20},{-38,20}},color={0,0,255}));
  connect(modeCalculation.precisionEnabled,gyroPowerSwitch.control) annotation(Line(points={{-73.2,72},{-58,72},{-58,32}},color={255,0,255}));
  connect(supplyCurrent.i,informationRealBridge[4].u) annotation(Line(points={{-80,10},{78,10},{78,24}},color={0,0,127}));
  connect(informationRealBridge[4].y,information.device.tcCurrent[16]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(opticalLoad.n,power.n12) annotation(Line(points={{-18,20},{-18,94},{0,94},{0,100}},color={0,0,255}));
  connect(opticalLoad.heatPort,gyroThermalMass.port) annotation(Line(points={{-28,10},{-28,-25},{-15,-25}},color={191,0,0}));
  connect(gyroThermalMass.port,flangePath.port_a) annotation(Line(points={{-15,-45},{-15,-35},{15,-35}},color={191,0,0}));
  connect(flangePath.port_b,thermal) annotation(Line(points={{35,-35},{35,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(gyroThermalMass.port,thermistor3.port) annotation(Line(points={{-15,-45},{-15,-65},{-25,-65}},color={191,0,0}));
  connect(thermistor3.T,informationRealBridge[5].u) annotation(Line(points={{-5,-65},{78,-65},{78,24}},color={0,0,127}));
  connect(informationRealBridge[5].y,information.device.thermistorTemperature[3]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={60,85,120},fillColor={235,241,248},fillPattern=FillPattern.Solid),Ellipse(extent={{-48,48},{48,-48}},lineColor={60,85,120},fillColor={180,195,220},fillPattern=FillPattern.Solid),Line(points={{-45,0},{45,0}},color={60,85,120}),Line(points={{0,-45},{0,45}},color={60,85,120}),Text(extent={{-92,-74},{92,-52}},textString="YH50 / TC16 / T3")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Text(extent={{-90,70},{90,58}},textString="精确指向门控-MultiBody角速度测量-断电状态归零")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>在高精度指向阶段测量本体绝对角速度并表示光学陀螺电热安装特性</p><p><b>白箱实现：</b>AbsoluteAngularVelocity测量结构保持；TargetPointing或GroundPointing时理想电源开关闭合，约5 W光学负载上电。Idle/SunPointing/Safe模式关闭电负载并把设备输出状态归零，MEMS链路继续承担普通速率感知。</p><p><b>对外接口：</b>thermal、mechanical、information和power</p><p><b>状态语义：</b>tcCurrent[16]=0且yh50Rate[3]=0表示YH50未上电；热敏3仍监视设备温度。</p><h4>功能与接口</h4><p>本组件表示YH50级高精度角速度陀螺。information中的desiredControlMode决定精密测量是否使能，同时发布三轴角速度、状态、电流和温度；power、thermal、mechanical分别表示供电、板级散热和安装质量。</p><h4>工作行为与结果</h4><p>RateGyroModeCalculation在目标指向或地面站指向阶段打开精密通道，机械角速度传感器提供本体速率，设备负载和温升随使能状态变化。优先查看modeCalculation.precisionEnabled、角速度输出、supplyCurrent.i和gyroNode.T，并以rad/s与deg/s单位转换核对工程遥测量级。</p><h4>建模边界</h4><p>不模拟零偏随机游走、比例因子、轴不正交、温度漂移、采样量化和标定滤波；当前输出用于总体姿态稳定性与遥测链验证。</p></html>"));
end RateGyroUnit;
