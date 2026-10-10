within OneSatSim.Components;
model RadioReceiverUnit "测控接收机组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.TtcReceiverComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance receiverLoadResistance=config.ReceiverLoadResistance
    "测控接收机负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.Resistance rfChokeResistance=config.RFChokeResistance
    "射频串联等效损耗；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity heatCapacity=config.HeatCapacity
    "接收机等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountConductance=config.MountConductance
    "接收机安装导热；Excel单位W/K，当前设计基线";
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
  Modelica.Electrical.Analog.Basic.Resistor receiverLoad(R=receiverLoadResistance,useHeatPort=true) "任务级参数 TTC 5 V receive current about 24 mA" annotation(Placement(visible=true, transformation(origin={-240,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor rfChoke(R=rfChokeResistance)  "计算/接口量 rfChoke" annotation(Placement(visible=true, transformation(origin={-125,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Conductor demodFilter(G=0)  "demod滤波" annotation(Placement(visible=true, transformation(origin={20,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Blocks.Sources.IntegerConstant receiverStatus(k=1)  "计算/接口量 receiverStatus" annotation(Placement(visible=true, transformation(origin={80,30}, extent={{-26,-26},{26,26}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor rfNode(C=heatCapacity,T(start=294.15,fixed=false))  "计算/接口量 rfNode" annotation(Placement(visible=true, transformation(origin={15,-120}, extent={{-28,-28},{28,28}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor chassis(G=mountConductance)  "计算/接口量 chassis" annotation(Placement(visible=true, transformation(origin={165,-148}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.Body receiverBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ)  "receiver本体" annotation(Placement(visible=true, transformation(origin={-260,-160}, extent={{-30,-30},{30,30}}, rotation=0)));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[1]  "整数因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={240,30}, extent={{-16,-16},{16,16}}, rotation=0)));
equation
  connect(power.p12,unused12Rail.p) annotation(Line(points={{-360,230},{-360,320},{-310,320}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{-270,320},{-260,320},{-260,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{-360,230},{-360,264},{-230,264},{-230,320},{-220,320}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{-180,320},{-170,320},{-170,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p5,receiverLoad.p) annotation(Line(points={{-360,230},{-264,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(receiverLoad.n,rfChoke.p) annotation(Line(points={{-216,230},{-149,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(rfChoke.n,power.n5) annotation(Line(points={{-101,230},{-91,230},{-91,197},{-360,197},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(demodFilter.p,power.p5) annotation(Line(points={{-4,230},{-14,230},{-14,197},{-360,197},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(demodFilter.n,power.n5) annotation(Line(points={{44,230},{54,230},{54,197},{-360,197},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(receiverStatus.y,informationIntegerBridge[1].u) annotation(Line(points={{80,30},{225.76,30}}, color={255,127,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationIntegerBridge[1].y,information.device.ttcStatus) annotation(Line(points={{254.24,30},{360,30}}, color={255,127,0}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(receiverLoad.heatPort,rfNode.port) annotation(Line(points={{-240,206},{-240,196},{-41.4,196},{-41.4,-158},{15,-158},{15,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(rfNode.port,chassis.port_a) annotation(Line(points={{15,-148},{15,-158},{131,-158},{131,-148},{141,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(chassis.port_b,thermal) annotation(Line(points={{189,-148},{300,-148}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(receiverBody.frame_a,mechanical) annotation(Line(points={{-290,-160},{-360,-160}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>测控接收机组件</h2><p><b>类路径：</b><code>OneSatSim.Components.RadioReceiverUnit</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>测控接收机组件</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.N_systems.CommunicationSystem\">OneSatSim.Systems.N_systems.CommunicationSystem</a> 的 <code>ttc</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>power</code></td><td>Foundation.Interfaces.PowerPort</td><td>public</td><td>按声明/类型合同</td><td>功率</td></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr><tr><td><code>information</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr><tr><td><code>informationIntegerBridge[1]</code></td><td>Foundation.Interfaces.IntegerSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>整数因果输出到可扩展信息总线的无状态恒等桥实例</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>config</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.TtcReceiverComponentConfig</td><td>由所属N-System传入的硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>receiverLoadResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>测控接收机负载电阻；Excel单位Ω，当前设计基线</td><td><code>=config.ReceiverLoadResistance</code></td></tr><tr><td><code>rfChokeResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>射频串联等效损耗；Excel单位Ω，当前设计基线</td><td><code>=config.RFChokeResistance</code></td></tr><tr><td><code>heatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>接收机等效热容；Excel单位J/K，当前设计基线</td><td><code>=config.HeatCapacity</code></td></tr><tr><td><code>mountConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>接收机安装导热；Excel单位W/K，当前设计基线</td><td><code>=config.MountConductance</code></td></tr><tr><td><code>mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel单位kg，当前设计基线</td><td><code>=config.Mass</code></td></tr><tr><td><code>rcm_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel单位m，当前设计基线</td><td><code>=config.RCM_X</code></td></tr><tr><td><code>rcm_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel单位m，当前设计基线</td><td><code>=config.RCM_Y</code></td></tr><tr><td><code>rcm_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel单位m，当前设计基线</td><td><code>=config.RCM_Z</code></td></tr><tr><td><code>inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_XX</code></td></tr><tr><td><code>inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_YY</code></td></tr><tr><td><code>inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_ZZ</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>unused12Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused12Rail</td></tr><tr><td><code>unused33Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused33Rail</td></tr><tr><td><code>receiverLoad</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Resistor\">Modelica.Electrical.Analog.Basic.Resistor</a></td><td>任务级参数 TTC 5 V receive current about 24 mA</td></tr><tr><td><code>rfChoke</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Resistor\">Modelica.Electrical.Analog.Basic.Resistor</a></td><td>计算/接口量 rfChoke</td></tr><tr><td><code>demodFilter</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>demod滤波</td></tr><tr><td><code>receiverStatus</code></td><td><a href=\"modelica://Modelica.Blocks.Sources.IntegerConstant\">Modelica.Blocks.Sources.IntegerConstant</a></td><td>计算/接口量 receiverStatus</td></tr><tr><td><code>rfNode</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a></td><td>计算/接口量 rfNode</td></tr><tr><td><code>chassis</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">Modelica.Thermal.HeatTransfer.Components.ThermalConductor</a></td><td>计算/接口量 chassis</td></tr><tr><td><code>receiverBody</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">Modelica.Mechanics.MultiBody.Parts.Body</a></td><td>receiver本体</td></tr></table></html>"
),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Communication", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-56,-27},{5,23}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Rectangle(extent={{-48,-18},{-4,13}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Polygon(points={{-37,-12},{-37,9},{-17,-2},{-37,-12}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{-51,-2},{-37,-2}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-17,-2},{4,-2}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{6,-2},{36,-2},{36,30}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Polygon(points={{23,40},{36,22},{49,40},{23,40}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Ellipse(extent={{21,7},{51,37}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.65, startAngle=-35, endAngle=35),
      Ellipse(extent={{12,-2},{60,46}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.65, startAngle=-35, endAngle=35),
      Ellipse(extent={{3,-11},{69,55}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.65, startAngle=-35, endAngle=35),
      Line(points={{67,-31},{25,-31}}, color={73,112,158}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Radio Receiver", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-404,-228},{404,462}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-295,169},{-51.4,187}}, textString="Functional core and telemetry", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-330,374},{-229.2,392}}, textString="Power supply", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-325,-106},{-157,-88}}, textString="Thermal and mounting", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-392,417},{392,446}}, textString="Radio receiver: RF power and thermal path", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-392,409},{392,409}}, color={215,220,226}, thickness=0.25)
    }));
end RadioReceiverUnit;