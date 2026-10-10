within OneSatSim.Components;
model StructureAssembly12U "12U主承力结构组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.StructureComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Mass primaryStructureMass=config.PrimaryStructureMass
    "主结构总质量；Excel单位kg，当前设计基线";
  parameter Modelica.Units.SI.Length primaryFrameWidth=config.PrimaryFrameWidth
    "主框架宽度；Excel单位m，当前设计基线";
  parameter Modelica.Units.SI.Length primaryFrameHeight=config.PrimaryFrameHeight
    "主框架高度；Excel单位m，当前设计基线";
  parameter Modelica.Units.SI.Length primaryFrameLength=config.PrimaryFrameLength
    "主框架长度；Excel单位m，当前设计基线";
  parameter Modelica.Units.SI.Length payloadDeckOffsetZ=config.PayloadDeckOffsetZ
    "载荷舱板安装偏置Z；Excel单位m，当前设计基线";
  parameter Modelica.Units.SI.Length avionicsDeckOffsetZ=config.AvionicsDeckOffsetZ
    "电子舱板安装偏置Z；Excel单位m，当前设计基线";
  parameter Modelica.Units.SI.Length lowerDeckWidth=config.LowerDeckWidth
    "下舱板宽度；Excel单位m，当前设计基线";
  parameter Modelica.Units.SI.Length lowerDeckHeight=config.LowerDeckHeight
    "下舱板高度；Excel单位m，当前设计基线";
  parameter Modelica.Units.SI.Length lowerDeckThickness=config.LowerDeckThickness
    "下舱板厚度；Excel单位m，当前设计基线";
  parameter Modelica.Units.SI.Density lowerDeckDensity=config.LowerDeckDensity
    "下舱板等效密度；Excel单位kg/m³，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity railHeatCapacity=config.RailHeatCapacity
    "导轨热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity panelHeatCapacity=config.PanelHeatCapacity
    "结构面板热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance railPanelConductance=config.RailPanelConductance
    "导轨-面板导热；Excel单位W/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountInterfaceConductance=config.MountInterfaceConductance
    "结构安装界面导热；Excel单位W/K，当前设计基线";
  final parameter Modelica.Units.SI.Mass lowerDeckMass=lowerDeckWidth*lowerDeckHeight*lowerDeckThickness*lowerDeckDensity "下界Deck质量 [kg]" ;
  final parameter Modelica.Units.SI.Density primaryFrameDensity=
    (primaryStructureMass-lowerDeckMass)/(primaryFrameWidth*primaryFrameHeight*primaryFrameLength) "primary参考系Density [kg/m3]" ;
  Foundation.Interfaces.ThermalPort thermal  "热学" annotation(Placement(visible=true, transformation(origin={340,-197}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,-97}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(visible=true, transformation(origin={-330,115}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation payloadDeck(r={0,0,payloadDeckOffsetZ})  "计算/接口量 payloadDeck" annotation(Placement(visible=true, transformation(origin={-235,115}, extent={{-32,-32},{32,32}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.BodyBox primaryFrame(r={0,0,primaryFrameLength},width=primaryFrameWidth,height=primaryFrameHeight,length=primaryFrameLength,density=primaryFrameDensity)  "primary参考系" annotation(Placement(visible=true, transformation(origin={-80,115}, extent={{-54,-54},{54,54}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation avionicsDeck(r={0,0,avionicsDeckOffsetZ})  "计算/接口量 avionicsDeck" annotation(Placement(visible=true, transformation(origin={90,70}, extent={{-32,-32},{32,32}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.BodyBox lowerDeck(r={0,0,lowerDeckThickness},width=lowerDeckWidth,height=lowerDeckHeight,length=lowerDeckThickness,density=lowerDeckDensity)  "下界Deck" annotation(Placement(visible=true, transformation(origin={225,10}, extent={{-48,-48},{48,48}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor railNode(C=railHeatCapacity,T(start=291.15,fixed=false))  "计算/接口量 railNode" annotation(Placement(visible=true, transformation(origin={-180,-165}, extent={{-32,-32},{32,32}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor panelNode(C=panelHeatCapacity,T(start=290.15,fixed=false))  "计算/接口量 panelNode" annotation(Placement(visible=true, transformation(origin={80,-165}, extent={{-32,-32},{32,32}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor railPanel(G=railPanelConductance)  "计算/接口量 railPanel" annotation(Placement(visible=true, transformation(origin={-50,-197}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor mountInterface(G=mountInterfaceConductance)  "计算/接口量 mountInterface" annotation(Placement(visible=true, transformation(origin={210,-197}, extent={{-24,-24},{24,24}}, rotation=0)));
equation
  connect(mechanical,payloadDeck.frame_a) annotation(Line(points={{-330,115},{-267,115}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(payloadDeck.frame_b,primaryFrame.frame_a) annotation(Line(points={{-203,115},{-134,115}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(primaryFrame.frame_b,avionicsDeck.frame_a) annotation(Line(points={{-26,115},{48,115},{48,70},{58,70}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(avionicsDeck.frame_b,lowerDeck.frame_a) annotation(Line(points={{122,70},{167,70},{167,10},{177,10}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(railNode.port,railPanel.port_a) annotation(Line(points={{-180,-197},{-180,-207},{-84,-207},{-84,-197},{-74,-197}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(railPanel.port_b,panelNode.port) annotation(Line(points={{-26,-197},{-16,-197},{-16,-207},{80,-207},{80,-197}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(panelNode.port,mountInterface.port_a) annotation(Line(points={{80,-197},{80,-207},{176,-207},{176,-197},{186,-197}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mountInterface.port_b,thermal) annotation(Line(points={{234,-197},{340,-197}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>12U主承力结构组件</h2><p><b>类路径：</b><code>OneSatSim.Components.StructureAssembly12U</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>12U主承力结构组件</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.N_systems.StructureSystem\">OneSatSim.Systems.N_systems.StructureSystem</a> 的 <code>structure</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>config</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.StructureComponentConfig</td><td>由所属N-System传入的硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>primaryStructureMass</code></td><td>Modelica.Units.SI.Mass</td><td>主结构总质量；Excel单位kg，当前设计基线</td><td><code>=config.PrimaryStructureMass</code></td></tr><tr><td><code>primaryFrameWidth</code></td><td>Modelica.Units.SI.Length</td><td>主框架宽度；Excel单位m，当前设计基线</td><td><code>=config.PrimaryFrameWidth</code></td></tr><tr><td><code>primaryFrameHeight</code></td><td>Modelica.Units.SI.Length</td><td>主框架高度；Excel单位m，当前设计基线</td><td><code>=config.PrimaryFrameHeight</code></td></tr><tr><td><code>primaryFrameLength</code></td><td>Modelica.Units.SI.Length</td><td>主框架长度；Excel单位m，当前设计基线</td><td><code>=config.PrimaryFrameLength</code></td></tr><tr><td><code>payloadDeckOffsetZ</code></td><td>Modelica.Units.SI.Length</td><td>载荷舱板安装偏置Z；Excel单位m，当前设计基线</td><td><code>=config.PayloadDeckOffsetZ</code></td></tr><tr><td><code>avionicsDeckOffsetZ</code></td><td>Modelica.Units.SI.Length</td><td>电子舱板安装偏置Z；Excel单位m，当前设计基线</td><td><code>=config.AvionicsDeckOffsetZ</code></td></tr><tr><td><code>lowerDeckWidth</code></td><td>Modelica.Units.SI.Length</td><td>下舱板宽度；Excel单位m，当前设计基线</td><td><code>=config.LowerDeckWidth</code></td></tr><tr><td><code>lowerDeckHeight</code></td><td>Modelica.Units.SI.Length</td><td>下舱板高度；Excel单位m，当前设计基线</td><td><code>=config.LowerDeckHeight</code></td></tr><tr><td><code>lowerDeckThickness</code></td><td>Modelica.Units.SI.Length</td><td>下舱板厚度；Excel单位m，当前设计基线</td><td><code>=config.LowerDeckThickness</code></td></tr><tr><td><code>lowerDeckDensity</code></td><td>Modelica.Units.SI.Density</td><td>下舱板等效密度；Excel单位kg/m³，当前设计基线</td><td><code>=config.LowerDeckDensity</code></td></tr><tr><td><code>railHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>导轨热容；Excel单位J/K，当前设计基线</td><td><code>=config.RailHeatCapacity</code></td></tr><tr><td><code>panelHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>结构面板热容；Excel单位J/K，当前设计基线</td><td><code>=config.PanelHeatCapacity</code></td></tr><tr><td><code>railPanelConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>导轨-面板导热；Excel单位W/K，当前设计基线</td><td><code>=config.RailPanelConductance</code></td></tr><tr><td><code>mountInterfaceConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>结构安装界面导热；Excel单位W/K，当前设计基线</td><td><code>=config.MountInterfaceConductance</code></td></tr><tr><td><code>lowerDeckMass</code></td><td>Modelica.Units.SI.Mass</td><td>下界Deck质量 [kg]</td><td><code>=lowerDeckWidth*lowerDeckHeight*lowerDeckThickness*lowerDeckDensity</code></td></tr><tr><td><code>primaryFrameDensity</code></td><td>Modelica.Units.SI.Density</td><td>primary参考系Density [kg/m3]</td><td><code>= (primaryStructureMass-lowerDeckMass)/(primaryFrameWidth*primaryFrameHeight*primaryFrameLength)</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>payloadDeck</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.FixedTranslation\">Modelica.Mechanics.MultiBody.Parts.FixedTranslation</a></td><td>计算/接口量 payloadDeck</td></tr><tr><td><code>primaryFrame</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.BodyBox\">Modelica.Mechanics.MultiBody.Parts.BodyBox</a></td><td>primary参考系</td></tr><tr><td><code>avionicsDeck</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.FixedTranslation\">Modelica.Mechanics.MultiBody.Parts.FixedTranslation</a></td><td>计算/接口量 avionicsDeck</td></tr><tr><td><code>lowerDeck</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.BodyBox\">Modelica.Mechanics.MultiBody.Parts.BodyBox</a></td><td>下界Deck</td></tr><tr><td><code>railNode</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a></td><td>计算/接口量 railNode</td></tr><tr><td><code>panelNode</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a></td><td>计算/接口量 panelNode</td></tr><tr><td><code>railPanel</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">Modelica.Thermal.HeatTransfer.Components.ThermalConductor</a></td><td>计算/接口量 railPanel</td></tr><tr><td><code>mountInterface</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">Modelica.Thermal.HeatTransfer.Components.ThermalConductor</a></td><td>计算/接口量 mountInterface</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={113,122,132}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Mechanical frame", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-30,33},{24,45},{47,26},{-7,14},{-30,33}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-30,33},{-7,14},{-7,-46},{-30,-27},{-30,33}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-7,14},{47,26},{47,-34},{-7,-46},{-7,14}}, lineColor={0,0,0}, fillColor={246,247,248}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{-30,13},{-7,-6},{47,6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-30,-7},{-7,-26},{47,-14}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-2.68,14.96},{-2.68,-45.04}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{42.68,25.04},{42.68,-34.96}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-30,33},{-7,-46}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-7,14},{-30,-27}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-7,14},{47,-34}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{47,26},{-7,-46}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Ellipse(extent={{-1,26},{15,39}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{3,29},{11,36}}, lineColor={0,0,0}, fillColor={223,233,238}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Ellipse(extent={{-31.7,31.3},{-28.3,34.7}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-30.85,33},{-29.15,33}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-8.7,12.3},{-5.3,15.7}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-7.85,14},{-6.15,14}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{45.3,24.3},{48.7,27.7}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{46.15,26},{47.85,26}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-31.7,-28.7},{-28.3,-25.3}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-30.85,-27},{-29.15,-27}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-8.7,-47.7},{-5.3,-44.3}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-7.85,-46},{-6.15,-46}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{45.3,-35.7},{48.7,-32.3}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{46.15,-34},{47.85,-34}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="12U Primary Structure", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-374,-259},{384,287}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-285,199},{-100.2,217}}, textString="Mechanical frame chain", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-245,-96},{-51.8,-78}}, textString="Structural thermal path", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-362,242},{372,271}}, textString="12U structure: decks, rails and thermal mounting", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-362,234},{372,234}}, color={215,220,226}, thickness=0.25)
    }));
end StructureAssembly12U;