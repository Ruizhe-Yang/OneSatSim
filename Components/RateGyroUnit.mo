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
  Foundation.Interfaces.PowerPort power  "功率" annotation(Placement(visible=true, transformation(origin={-360,230}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,95}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Conductor unused5Rail(G=0)  "计算/接口量 unused5Rail" annotation(Placement(visible=true, transformation(origin={-200,320}, extent={{-20,-20},{20,20}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0)  "计算/接口量 unused33Rail" annotation(Placement(visible=true, transformation(origin={-290,320}, extent={{-20,-20},{20,20}}, rotation=0)));
  Foundation.Interfaces.ThermalPort thermal  "热学" annotation(Placement(visible=true, transformation(origin={320,-223}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,-97}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(visible=true, transformation(origin={-370,30}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.InformationPort information  "计算/接口量 information" annotation(Placement(visible=true, transformation(origin={360,30}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Calculations.RateGyroModeCalculation modeCalculation  "高精度角速率陀螺工作模式计算实例" annotation(Placement(visible=true, transformation(origin={-90,95}, extent={{-22,-22},{22,22}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor supplyCurrent  "供给电流" annotation(Placement(visible=true, transformation(origin={-240,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngularVelocity angularRate(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)  "angular速率" annotation(Placement(visible=true, transformation(origin={-250,35}, extent={{-40,-40},{40,40}}, rotation=0)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch gyroPowerSwitch  "gyro功率Switch" annotation(Placement(visible=true, transformation(origin={-125,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor opticalLoad(R=loadResistance,useHeatPort=true)  "optical负载" annotation(Placement(visible=true, transformation(origin={-10,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Blocks.Sources.Constant zeroRate[3](each k=0)  "零值速率" annotation(Placement(visible=true, transformation(origin={-75,-85}, extent={{-22,-22},{22,22}}, rotation=0)));
  Modelica.Blocks.Logical.Switch reportedRate[3]  "reported速率" annotation(Placement(visible=true, transformation(origin={80,10}, extent={{-38,-38},{38,38}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor gyroThermalMass(C=heatCapacity,T(start=276.40,fixed=false))  "gyro热学质量" annotation(Placement(visible=true, transformation(origin={-30,-195}, extent={{-28,-28},{28,28}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor flangePath(G=mountConductance)  "计算/接口量 flangePath" annotation(Placement(visible=true, transformation(origin={165,-223}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor thermistor3  "计算/接口量 thermistor3" annotation(Placement(visible=true, transformation(origin={80,-235}, extent={{-22,-22},{22,22}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.Body gyroBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ)  "gyro本体" annotation(Placement(visible=true, transformation(origin={-255,-150}, extent={{-30,-30},{30,30}}, rotation=0)));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[5]  "实数因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={245,15}, extent={{-16,-16},{16,16}}, rotation=0)));
equation
  connect(information.command.desiredControlMode,modeCalculation.desiredControlMode) annotation(Line(points={{360,30},{360,163.9},{-155.18,163.9},{-155.18,95},{-109.58,95}}, color={0,102,255}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p5,unused5Rail.p) annotation(Line(points={{-360,230},{-360,264},{-230,264},{-230,320},{-220,320}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused5Rail.n,power.n5) annotation(Line(points={{-180,320},{-170,320},{-170,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{-360,230},{-360,320},{-310,320}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{-270,320},{-260,320},{-260,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,angularRate.frame_a) annotation(Line(points={{-370,30},{-370,35},{-290,35}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,gyroBody.frame_a) annotation(Line(points={{-370,30},{-370,-150},{-285,-150}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(angularRate.w,reportedRate.u1) annotation(Line(points={{-206,35},{-196,35},{-196,24.86},{24.4,24.86},{24.4,40.4},{34.4,40.4}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(modeCalculation.precisionEnabled,reportedRate[1].u2) annotation(Line(points={{-70.42,95},{8,95},{8,10},{34.4,10}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(modeCalculation.precisionEnabled,reportedRate[2].u2) annotation(Line(points={{-70.42,95},{8,95},{8,10},{34.4,10}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(modeCalculation.precisionEnabled,reportedRate[3].u2) annotation(Line(points={{-70.42,95},{8,95},{8,10},{34.4,10}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(zeroRate.y,reportedRate.u3) annotation(Line(points={{-50.8,-85},{8,-85},{8,-20.4},{34.4,-20.4}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(reportedRate[1].y,informationRealBridge[1].u) annotation(Line(points={{121.8,10},{197.62,10},{197.62,15},{230.76,15}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[1].y,information.device.yh50Rate[1]) annotation(Line(points={{259.24,15},{360,15},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(reportedRate[2].y,informationRealBridge[2].u) annotation(Line(points={{121.8,10},{197.62,10},{197.62,15},{230.76,15}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[2].y,information.device.yh50Rate[2]) annotation(Line(points={{259.24,15},{360,15},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(reportedRate[3].y,informationRealBridge[3].u) annotation(Line(points={{121.8,10},{197.62,10},{197.62,15},{230.76,15}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[3].y,information.device.yh50Rate[3]) annotation(Line(points={{259.24,15},{360,15},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p12,supplyCurrent.p) annotation(Line(points={{-360,230},{-264,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(supplyCurrent.n,gyroPowerSwitch.p) annotation(Line(points={{-216,230},{-149,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(gyroPowerSwitch.n,opticalLoad.p) annotation(Line(points={{-101,230},{-34,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(modeCalculation.precisionEnabled,gyroPowerSwitch.control) annotation(Line(points={{-70.42,95},{24,95},{24,268.8},{-125,268.8},{-125,258.8}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(supplyCurrent.i,informationRealBridge[4].u) annotation(Line(points={{-240,203.6},{-240,163.9},{197.62,163.9},{197.62,15},{230.76,15}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[4].y,information.device.tcCurrent[16]) annotation(Line(points={{259.24,15},{360,15},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(opticalLoad.n,power.n12) annotation(Line(points={{14,230},{24,230},{24,196},{-360,196},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(opticalLoad.heatPort,gyroThermalMass.port) annotation(Line(points={{-10,206},{-10,196},{8,196},{8,-233},{-30,-233},{-30,-223}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(gyroThermalMass.port,flangePath.port_a) annotation(Line(points={{-30,-223},{-30,-267},{131,-267},{131,-223},{141,-223}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(flangePath.port_b,thermal) annotation(Line(points={{189,-223},{320,-223}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(gyroThermalMass.port,thermistor3.port) annotation(Line(points={{-30,-223},{-30,-235},{58,-235}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermistor3.T,informationRealBridge[5].u) annotation(Line(points={{104.2,-235},{128,-235},{128,15},{230.76,15}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[5].y,information.device.thermistorTemperature[3]) annotation(Line(points={{259.24,15},{360,15},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>三轴角速率陀螺组件</h2><p><b>类路径：</b><code>OneSatSim.Components.RateGyroUnit</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>三轴角速率陀螺组件</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.N_systems.GNCSystem\">OneSatSim.Systems.N_systems.GNCSystem</a> 的 <code>yh50</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>power</code></td><td>Foundation.Interfaces.PowerPort</td><td>public</td><td>按声明/类型合同</td><td>功率</td></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr><tr><td><code>information</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr><tr><td><code>informationRealBridge[5]</code></td><td>Foundation.Interfaces.RealSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>实数因果输出到可扩展信息总线的无状态恒等桥实例</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>config</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.RateGyroComponentConfig</td><td>由所属N-System传入的硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>loadResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>rateGyro等效负载电阻；Excel单位Ω，当前设计基线</td><td><code>=config.LoadResistance</code></td></tr><tr><td><code>heatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>rateGyro等效热容；Excel单位J/K，当前设计基线</td><td><code>=config.HeatCapacity</code></td></tr><tr><td><code>mountConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>rateGyro安装导热；Excel单位W/K，当前设计基线</td><td><code>=config.MountConductance</code></td></tr><tr><td><code>mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel单位kg，当前设计基线</td><td><code>=config.Mass</code></td></tr><tr><td><code>rcm_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel单位m，当前设计基线</td><td><code>=config.RCM_X</code></td></tr><tr><td><code>rcm_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel单位m，当前设计基线</td><td><code>=config.RCM_Y</code></td></tr><tr><td><code>rcm_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel单位m，当前设计基线</td><td><code>=config.RCM_Z</code></td></tr><tr><td><code>inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_XX</code></td></tr><tr><td><code>inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_YY</code></td></tr><tr><td><code>inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_ZZ</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>unused5Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused5Rail</td></tr><tr><td><code>unused33Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused33Rail</td></tr><tr><td><code>modeCalculation</code></td><td><a href=\"modelica://OneSatSim.Foundation.Calculations.RateGyroModeCalculation\">OneSatSim.Foundation.Calculations.RateGyroModeCalculation</a></td><td>高精度角速率陀螺工作模式计算实例</td></tr><tr><td><code>supplyCurrent</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Sensors.CurrentSensor\">Modelica.Electrical.Analog.Sensors.CurrentSensor</a></td><td>供给电流</td></tr><tr><td><code>angularRate</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngularVelocity\">Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngularVelocity</a></td><td>angular速率</td></tr><tr><td><code>gyroPowerSwitch</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealClosingSwitch\">Modelica.Electrical.Analog.Ideal.IdealClosingSwitch</a></td><td>gyro功率Switch</td></tr><tr><td><code>opticalLoad</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Resistor\">Modelica.Electrical.Analog.Basic.Resistor</a></td><td>optical负载</td></tr><tr><td><code>zeroRate[3]</code></td><td><a href=\"modelica://Modelica.Blocks.Sources.Constant\">Modelica.Blocks.Sources.Constant</a></td><td>零值速率</td></tr><tr><td><code>reportedRate[3]</code></td><td><a href=\"modelica://Modelica.Blocks.Logical.Switch\">Modelica.Blocks.Logical.Switch</a></td><td>reported速率</td></tr><tr><td><code>gyroThermalMass</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a></td><td>gyro热学质量</td></tr><tr><td><code>flangePath</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">Modelica.Thermal.HeatTransfer.Components.ThermalConductor</a></td><td>计算/接口量 flangePath</td></tr><tr><td><code>thermistor3</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor\">Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor</a></td><td>计算/接口量 thermistor3</td></tr><tr><td><code>gyroBody</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">Modelica.Mechanics.MultiBody.Parts.Body</a></td><td>gyro本体</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Inertial sensor", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-39,-29},{29,29}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=3),
      Ellipse(extent={{-30,-23},{20,23}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{-30,-8},{20,8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{-13,-23},{3,23}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.6, startAngle=0, endAngle=360),
      Line(points={{-35,-21},{25,21}}, color={76,128,143}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-5,-34},{-5,35}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Ellipse(extent={{-10,-5},{0,5}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-31,39},{-7,48},{17,44},{31,33}}, color={76,128,143}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Ellipse(extent={{-35.6,-25.6},{-32.4,-22.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-34.8,-24},{-33.2,-24}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{22.4,-25.6},{25.6,-22.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{23.2,-24},{24.8,-24}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-35.6,22.4},{-32.4,25.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-34.8,24},{-33.2,24}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{22.4,22.4},{25.6,25.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{23.2,24},{24.8,24}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{49,-23},{69,-23}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{49,-23},{38.6,-10.2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{49,-23},{49,-3}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Rate Gyroscope", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-414,-295},{404,486}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-295,369},{-51.4,387}}, textString="Functional core and telemetry", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-330,398},{-229.2,416}}, textString="Power supply", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-325,-82},{-157,-64}}, textString="Thermal and mounting", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-402,441},{392,470}}, textString="Precision gyro: mode-gated rate measurement", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-402,433},{392,433}}, color={215,220,226}, thickness=0.25)
    }));
end RateGyroUnit;