within OneSatSim.Components;
model NaviEnhancePayloadUnit "导航增强载荷组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.NaviEnhanceComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance activeResistance=config.ActiveResistance
    "导航增强激活负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.Resistance standbyResistance=config.StandbyResistance
    "导航增强待机负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity heatCapacity=config.HeatCapacity
    "导航增强处理器热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountConductance=config.MountConductance
    "导航增强安装导热；Excel单位W/K，当前设计基线";
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
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(visible=true, transformation(origin={-360,-160}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.InformationPort information  "计算/接口量 information" annotation(Placement(visible=true, transformation(origin={360,30}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor channelCurrent  "channel电流" annotation(Placement(visible=true, transformation(origin={-240,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.VariableConductor processorLoad(useHeatPort=true) "系统级 task-gated 5 V payload load" annotation(Placement(visible=true, transformation(origin={-125,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Foundation.Calculations.PointingModeEquipmentCalculation modeCalculation(
    activeResistance=activeResistance,standbyResistance=standbyResistance)  "精确指向阶段设备状态与负载计算实例" annotation(Placement(visible=true, transformation(origin={15,55}, extent={{-66,-66},{66,66}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Conductor computeBuffer(G=0)  "计算/接口量 computeBuffer" annotation(Placement(visible=true, transformation(origin={60,320}, extent={{-22,-22},{22,22}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor processorNode(C=heatCapacity,T(start=294.15,fixed=false))  "计算/接口量 processorNode" annotation(Placement(visible=true, transformation(origin={15,-120}, extent={{-28,-28},{28,28}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor deckPath(G=mountConductance)  "计算/接口量 deckPath" annotation(Placement(visible=true, transformation(origin={165,-148}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.Body unitBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ)  "unit本体" annotation(Placement(visible=true, transformation(origin={-260,-160}, extent={{-30,-30},{30,30}}, rotation=0)));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[1]  "实数因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={240,70}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[1]  "整数因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={240,-45}, extent={{-16,-16},{16,16}}, rotation=0)));
equation
  connect(information.command.desiredControlMode,modeCalculation.desiredControlMode) annotation(Line(points={{360,30},{360,127.7},{-53.74,127.7},{-53.74,55},{-43.74,55}}, color={0,102,255}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p12,unused12Rail.p) annotation(Line(points={{-360,230},{-360,320},{-310,320}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{-270,320},{-260,320},{-260,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{-360,230},{-360,264},{-230,264},{-230,320},{-220,320}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{-180,320},{-170,320},{-170,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p5,channelCurrent.p) annotation(Line(points={{-360,230},{-264,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(channelCurrent.n,processorLoad.p) annotation(Line(points={{-216,230},{-149,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(modeCalculation.loadConductance,processorLoad.G) annotation(Line(points={{73.74,55},{83.74,55},{83.74,264},{-125,264},{-125,268.8},{-125,258.8}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(processorLoad.n,power.n5) annotation(Line(points={{-101,230},{-91,230},{-91,196},{-360,196},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(computeBuffer.p,power.p5) annotation(Line(points={{38,320},{28,320},{28,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(computeBuffer.n,power.n5) annotation(Line(points={{82,320},{92,320},{92,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(channelCurrent.i,informationRealBridge[1].u) annotation(Line(points={{-240,203.6},{-240,193.6},{83.74,193.6},{83.74,70},{225.76,70}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[1].y,information.device.pdCurrent[4]) annotation(Line(points={{254.24,70},{360,70},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(modeCalculation.status,informationIntegerBridge[1].u) annotation(Line(points={{73.74,2.2},{83.74,2.2},{83.74,-45},{225.76,-45}}, color={255,127,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationIntegerBridge[1].y,information.device.naviEnhanceStatus) annotation(Line(points={{254.24,-45},{360,-45},{360,30}}, color={255,127,0}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(processorLoad.heatPort,processorNode.port) annotation(Line(points={{-125,206},{-125,196},{83.74,196},{83.74,-158},{15,-158},{15,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(processorNode.port,deckPath.port_a) annotation(Line(points={{15,-148},{15,-158},{131,-158},{131,-148},{141,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(deckPath.port_b,thermal) annotation(Line(points={{189,-148},{300,-148}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unitBody.frame_a,mechanical) annotation(Line(points={{-290,-160},{-360,-160}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>导航增强载荷组件</h2><p><b>类路径：</b><code>OneSatSim.Components.NaviEnhancePayloadUnit</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>导航增强载荷组件</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.N_systems.PayloadSystem\">OneSatSim.Systems.N_systems.PayloadSystem</a> 的 <code>naviEnhance</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>power</code></td><td>Foundation.Interfaces.PowerPort</td><td>public</td><td>按声明/类型合同</td><td>功率</td></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr><tr><td><code>information</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr><tr><td><code>informationRealBridge[1]</code></td><td>Foundation.Interfaces.RealSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>实数因果输出到可扩展信息总线的无状态恒等桥实例</td></tr><tr><td><code>informationIntegerBridge[1]</code></td><td>Foundation.Interfaces.IntegerSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>整数因果输出到可扩展信息总线的无状态恒等桥实例</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>config</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.NaviEnhanceComponentConfig</td><td>由所属N-System传入的硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>activeResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>导航增强激活负载电阻；Excel单位Ω，当前设计基线</td><td><code>=config.ActiveResistance</code></td></tr><tr><td><code>standbyResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>导航增强待机负载电阻；Excel单位Ω，当前设计基线</td><td><code>=config.StandbyResistance</code></td></tr><tr><td><code>heatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>导航增强处理器热容；Excel单位J/K，当前设计基线</td><td><code>=config.HeatCapacity</code></td></tr><tr><td><code>mountConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>导航增强安装导热；Excel单位W/K，当前设计基线</td><td><code>=config.MountConductance</code></td></tr><tr><td><code>mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel单位kg，当前设计基线</td><td><code>=config.Mass</code></td></tr><tr><td><code>rcm_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel单位m，当前设计基线</td><td><code>=config.RCM_X</code></td></tr><tr><td><code>rcm_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel单位m，当前设计基线</td><td><code>=config.RCM_Y</code></td></tr><tr><td><code>rcm_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel单位m，当前设计基线</td><td><code>=config.RCM_Z</code></td></tr><tr><td><code>inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_XX</code></td></tr><tr><td><code>inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_YY</code></td></tr><tr><td><code>inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_ZZ</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>unused12Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused12Rail</td></tr><tr><td><code>unused33Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused33Rail</td></tr><tr><td><code>channelCurrent</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Sensors.CurrentSensor\">Modelica.Electrical.Analog.Sensors.CurrentSensor</a></td><td>channel电流</td></tr><tr><td><code>processorLoad</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.VariableConductor\">Modelica.Electrical.Analog.Basic.VariableConductor</a></td><td>系统级 task-gated 5 V payload load</td></tr><tr><td><code>modeCalculation</code></td><td><a href=\"modelica://OneSatSim.Foundation.Calculations.PointingModeEquipmentCalculation\">OneSatSim.Foundation.Calculations.PointingModeEquipmentCalculation</a></td><td>精确指向阶段设备状态与负载计算实例</td></tr><tr><td><code>computeBuffer</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 computeBuffer</td></tr><tr><td><code>processorNode</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a></td><td>计算/接口量 processorNode</td></tr><tr><td><code>deckPath</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">Modelica.Thermal.HeatTransfer.Components.ThermalConductor</a></td><td>计算/接口量 deckPath</td></tr><tr><td><code>unitBody</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">Modelica.Mechanics.MultiBody.Parts.Body</a></td><td>unit本体</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={152,118,71}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Science payload", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-53,-38},{53,40}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Rectangle(extent={{-27,-20},{18,25}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Rectangle(extent={{-20,-13},{11,18}}, lineColor={0,0,0}, fillColor={234,240,245}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-36,-14},{-27,-14}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{18,-14},{27,-14}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-19,-20},{-19,-29}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-19,25},{-19,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-36,-3},{-27,-3}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{18,-3},{27,-3}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-8,-20},{-8,-29}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-8,25},{-8,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-36,8},{-27,8}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{18,8},{27,8}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{3,-20},{3,-29}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{3,25},{3,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-36,19},{-27,19}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{18,19},{27,19}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{14,-20},{14,-29}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{14,25},{14,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Ellipse(extent={{-47.8,-32.8},{-44.2,-29.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-46.9,-31},{-45.1,-31}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{44.2,-32.8},{47.8,-29.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{45.1,-31},{46.9,-31}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-47.8,31.2},{-44.2,34.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-46.9,33},{-45.1,33}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{44.2,31.2},{47.8,34.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{45.1,33},{46.9,33}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{33,15},{44,29}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{33,-5},{44,7}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{33,-25},{44,-13}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Ellipse(extent={{-16,-10},{7,13}}, lineColor={76,128,143}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Line(points={{-5,-15},{-5,18}}, color={76,128,143}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-22,1},{13,1}}, color={76,128,143}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-68,15},{-57,20}}, color={76,128,143}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-68,0},{-57,0}}, color={76,128,143}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-68,-15},{-57,-20}}, color={76,128,143}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Navigation Enhancer", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-404,-228},{404,462}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-295,145},{-51.4,163}}, textString="Functional core and telemetry", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-330,374},{-229.2,392}}, textString="Power supply", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-325,-106},{-157,-88}}, textString="Thermal and mounting", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-392,417},{392,446}}, textString="Navigation payload: mode and power", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-392,409},{392,409}}, color={215,220,226}, thickness=0.25)
    }));
end NaviEnhancePayloadUnit;