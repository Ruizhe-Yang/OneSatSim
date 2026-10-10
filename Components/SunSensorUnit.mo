within OneSatSim.Components;
model SunSensorUnit "二维太阳敏感器组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.SunSensorComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance loadResistance=config.LoadResistance
    "sunSensor等效负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity heatCapacity=config.HeatCapacity
    "sunSensor等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountConductance=config.MountConductance
    "sunSensor安装导热；Excel单位W/K，当前设计基线";
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
  Modelica.Electrical.Analog.Basic.Conductor unused12Rail(G=0)  "计算/接口量 unused12Rail" annotation(Placement(visible=true, transformation(origin={-290,320}, extent={{-20,-20},{20,20}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0)  "计算/接口量 unused33Rail" annotation(Placement(visible=true, transformation(origin={-200,320}, extent={{-20,-20},{20,20}}, rotation=0)));
  Foundation.Interfaces.ThermalPort thermal  "热学" annotation(Placement(visible=true, transformation(origin={300,-148}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,-97}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(visible=true, transformation(origin={-360,-160}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-12,-12},{12,12}}, rotation=0)));
  Foundation.Interfaces.EnvironmentPort environment  "外部环境接口或实例" annotation(Placement(visible=true, transformation(origin={-360,45}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-12,-12},{12,12}}, rotation=0)));
  Foundation.Interfaces.InformationPort information  "计算/接口量 information" annotation(Placement(visible=true, transformation(origin={360,30}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.RealSignalReader sunVectorInput[3]  "可扩展总线实数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-170,55}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Calculations.InertialVectorToBody sunFrameTransform(vectorUnit="1")  "惯性系至本体系无状态矢量变换实例" annotation(Placement(transformation(origin={-75,55}, extent={{-22,-22},{22,22}})));
  Foundation.Calculations.SunSensorCalculation angleCalculation  "太阳敏感器视线角计算实例" annotation(Placement(visible=true, transformation(origin={15,55}, extent={{-22,-22},{22,22}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor  "电流传感器" annotation(Placement(visible=true, transformation(origin={-240,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor quadrantLoad(R=loadResistance,useHeatPort=true) "任务级参数 33 mA supply work point" annotation(Placement(visible=true, transformation(origin={-125,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor head(C=heatCapacity,T(start=292.15,fixed=false))  "计算/接口量 head" annotation(Placement(visible=true, transformation(origin={15,-120}, extent={{-28,-28},{28,28}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor mount(G=mountConductance)  "计算/接口量 mount" annotation(Placement(visible=true, transformation(origin={165,-148}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.Body headBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ)  "head本体" annotation(Placement(visible=true, transformation(origin={-260,-160}, extent={{-30,-30},{30,30}}, rotation=0)));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[3]  "实数因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={240,55}, extent={{-16,-16},{16,16}}, rotation=0)));
equation
  connect(environment.sunVectorGCRS,sunVectorInput.u) annotation(Line(points={{-360,45},{-184.24,45},{-184.24,55}},color={0,0,127},thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(sunVectorInput.y,sunFrameTransform.vectorIn) annotation(Line(points={{-155.76,55},{-97,55}},color={0,0,127},thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,sunFrameTransform.frame_a) annotation(Line(points={{-360,-160},{-97,-160},{-97,37.4}},color={95,95,95},thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(sunFrameTransform.vectorOut,angleCalculation.sunVectorBody) annotation(Line(points={{-53,55},{-4.58,55}},color={0,0,127},thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p12,unused12Rail.p) annotation(Line(points={{-360,230},{-360,320},{-310,320}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{-270,320},{-260,320},{-260,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{-360,230},{-360,264},{-230,264},{-230,320},{-220,320}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{-180,320},{-170,320},{-170,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(angleCalculation.alpha,informationRealBridge[1].u) annotation(Line(points={{73.74,107.8},{83.74,107.8},{83.74,55},{225.76,55}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[1].y,information.device.sunAngle[1]) annotation(Line(points={{254.24,55},{360,55},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(angleCalculation.beta,informationRealBridge[2].u) annotation(Line(points={{73.74,2.2},{83.74,2.2},{83.74,55},{225.76,55}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[2].y,information.device.sunAngle[2]) annotation(Line(points={{254.24,55},{360,55},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p5,currentSensor.p) annotation(Line(points={{-360,230},{-264,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(currentSensor.n,quadrantLoad.p) annotation(Line(points={{-216,230},{-149,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(quadrantLoad.n,power.n5) annotation(Line(points={{-101,230},{-91,230},{-91,196},{-360,196},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(currentSensor.i,informationRealBridge[3].u) annotation(Line(points={{-240,203.6},{-240,193.6},{83.74,193.6},{83.74,55},{225.76,55}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[3].y,information.device.pdCurrent[12]) annotation(Line(points={{254.24,55},{360,55},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(quadrantLoad.heatPort,head.port) annotation(Line(points={{-125,206},{-125,196},{83.74,196},{83.74,-158},{15,-158},{15,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(head.port,mount.port_a) annotation(Line(points={{15,-148},{15,-158},{131,-158},{131,-148},{141,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mount.port_b,thermal) annotation(Line(points={{189,-148},{300,-148}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(headBody.frame_a,mechanical) annotation(Line(points={{-290,-160},{-360,-160}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>二维太阳敏感器组件</h2><p><b>类路径：</b><code>OneSatSim.Components.SunSensorUnit</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>二维太阳敏感器组件</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.N_systems.GNCSystem\">OneSatSim.Systems.N_systems.GNCSystem</a> 的 <code>sunSensor</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>power</code></td><td>Foundation.Interfaces.PowerPort</td><td>public</td><td>按声明/类型合同</td><td>功率</td></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr><tr><td><code>environment</code></td><td>Foundation.Interfaces.EnvironmentPort</td><td>public</td><td>按声明/类型合同</td><td>外部环境接口或实例</td></tr><tr><td><code>information</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr><tr><td><code>sunVectorInput[3]</code></td><td>Foundation.Interfaces.RealSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线实数信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>informationRealBridge[3]</code></td><td>Foundation.Interfaces.RealSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>实数因果输出到可扩展信息总线的无状态恒等桥实例</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>config</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.SunSensorComponentConfig</td><td>由所属N-System传入的硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>loadResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>sunSensor等效负载电阻；Excel单位Ω，当前设计基线</td><td><code>=config.LoadResistance</code></td></tr><tr><td><code>heatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>sunSensor等效热容；Excel单位J/K，当前设计基线</td><td><code>=config.HeatCapacity</code></td></tr><tr><td><code>mountConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>sunSensor安装导热；Excel单位W/K，当前设计基线</td><td><code>=config.MountConductance</code></td></tr><tr><td><code>mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel单位kg，当前设计基线</td><td><code>=config.Mass</code></td></tr><tr><td><code>rcm_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel单位m，当前设计基线</td><td><code>=config.RCM_X</code></td></tr><tr><td><code>rcm_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel单位m，当前设计基线</td><td><code>=config.RCM_Y</code></td></tr><tr><td><code>rcm_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel单位m，当前设计基线</td><td><code>=config.RCM_Z</code></td></tr><tr><td><code>inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_XX</code></td></tr><tr><td><code>inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_YY</code></td></tr><tr><td><code>inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_ZZ</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>unused12Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused12Rail</td></tr><tr><td><code>unused33Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused33Rail</td></tr><tr><td><code>sunFrameTransform</code></td><td><a href=\"modelica://OneSatSim.Foundation.Calculations.InertialVectorToBody\">OneSatSim.Foundation.Calculations.InertialVectorToBody</a></td><td>惯性系至本体系无状态矢量变换实例</td></tr><tr><td><code>angleCalculation</code></td><td><a href=\"modelica://OneSatSim.Foundation.Calculations.SunSensorCalculation\">OneSatSim.Foundation.Calculations.SunSensorCalculation</a></td><td>太阳敏感器视线角计算实例</td></tr><tr><td><code>currentSensor</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Sensors.CurrentSensor\">Modelica.Electrical.Analog.Sensors.CurrentSensor</a></td><td>电流传感器</td></tr><tr><td><code>quadrantLoad</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Resistor\">Modelica.Electrical.Analog.Basic.Resistor</a></td><td>任务级参数 33 mA supply work point</td></tr><tr><td><code>head</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a></td><td>计算/接口量 head</td></tr><tr><td><code>mount</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">Modelica.Thermal.HeatTransfer.Components.ThermalConductor</a></td><td>计算/接口量 mount</td></tr><tr><td><code>headBody</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">Modelica.Mechanics.MultiBody.Parts.Body</a></td><td>head本体</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Optical sensor", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Ellipse(extent={{-57,23},{-39,41}}, lineColor={0,0,0}, fillColor={255,246,210}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Line(points={{-36,32},{-31,32}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-39.514719,40.485281},{-35.979185,44.020815}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-48,44},{-48,49}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-56.485281,40.485281},{-60.020815,44.020815}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-60,32},{-65,32}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-56.485281,23.514719},{-60.020815,19.979185}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-48,20},{-48,15}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-39.514719,23.514719},{-35.979185,19.979185}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Polygon(points={{-11,19},{45,30},{65,9},{8,-4},{-11,19}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{8,-4},{65,9},{65,-14},{8,-29},{8,-4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6),
      Polygon(points={{-11,19},{8,-4},{8,-29},{-11,-7},{-11,19}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6),
      Polygon(points={{4,14},{19,17},{13,10},{-2,7},{4,14}}, lineColor={0,0,0}, fillColor={228,239,247}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Polygon(points={{-2,6},{13,9},{7,2},{-8,-1},{-2,6}}, lineColor={0,0,0}, fillColor={228,239,247}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Polygon(points={{23,18},{38,21},{32,14},{17,11},{23,18}}, lineColor={0,0,0}, fillColor={228,239,247}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Polygon(points={{17,10},{32,13},{26,6},{11,3},{17,10}}, lineColor={0,0,0}, fillColor={228,239,247}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Line(points={{-31,21},{-4,2}}, color={212,109,62}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-24,32},{16,22}}, color={212,109,62}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-40,-25},{-20,-25}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-40,-25},{-50.4,-12.2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-40,-25},{-40,-5}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Sun Sensor", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-404,-228},{404,462}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-295,145},{-51.4,163}}, textString="Functional core and telemetry", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-330,374},{-229.2,392}}, textString="Power supply", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-325,-106},{-157,-88}}, textString="Thermal and mounting", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-392,417},{392,446}}, textString="Sun sensor: environment to angle measurement", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-392,409},{392,409}}, color={215,220,226}, thickness=0.25)
    }));
end SunSensorUnit;