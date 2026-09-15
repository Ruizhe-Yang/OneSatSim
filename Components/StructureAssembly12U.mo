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
  final parameter Modelica.Units.SI.Mass lowerDeckMass=lowerDeckWidth*lowerDeckHeight*lowerDeckThickness*lowerDeckDensity;
  final parameter Modelica.Units.SI.Density primaryFrameDensity=
    (primaryStructureMass-lowerDeckMass)/(primaryFrameWidth*primaryFrameHeight*primaryFrameLength);
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation payloadDeck(r={0,0,payloadDeckOffsetZ}) annotation(Placement(transformation(extent={{-70,12},{-50,32}})));
  Modelica.Mechanics.MultiBody.Parts.BodyBox primaryFrame(r={0,0,primaryFrameLength},width=primaryFrameWidth,height=primaryFrameHeight,length=primaryFrameLength,density=primaryFrameDensity) annotation(Placement(transformation(extent={{-35,8},{-5,38}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation avionicsDeck(r={0,0,avionicsDeckOffsetZ}) annotation(Placement(transformation(extent={{10,12},{30,32}})));
  Modelica.Mechanics.MultiBody.Parts.BodyBox lowerDeck(r={0,0,lowerDeckThickness},width=lowerDeckWidth,height=lowerDeckHeight,length=lowerDeckThickness,density=lowerDeckDensity) annotation(Placement(transformation(extent={{40,8},{65,33}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor railNode(C=railHeatCapacity,T(start=291.15,fixed=false)) annotation(Placement(transformation(extent={{-45,-25},{-25,-5}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor panelNode(C=panelHeatCapacity,T(start=290.15,fixed=false)) annotation(Placement(transformation(extent={{-5,-25},{15,-5}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor railPanel(G=railPanelConductance) annotation(Placement(transformation(extent={{-20,-48},{0,-32}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor mountInterface(G=mountInterfaceConductance) annotation(Placement(transformation(extent={{30,-48},{50,-32}})));
equation
  connect(mechanical,payloadDeck.frame_a) annotation(Line(points={{-100,0},{-94,0},{-94,22},{-70,22}},color={95,95,95},thickness=0.5));
  connect(payloadDeck.frame_b,primaryFrame.frame_a) annotation(Line(points={{-50,22},{-35,22}},color={95,95,95},thickness=0.5));
  connect(primaryFrame.frame_b,avionicsDeck.frame_a) annotation(Line(points={{-5,22},{10,22}},color={95,95,95},thickness=0.5));
  connect(avionicsDeck.frame_b,lowerDeck.frame_a) annotation(Line(points={{30,22},{40,22}},color={95,95,95},thickness=0.5));
  connect(railNode.port,railPanel.port_a) annotation(Line(points={{-35,-25},{-35,-40},{-20,-40}},color={191,0,0}));
  connect(railPanel.port_b,panelNode.port) annotation(Line(points={{0,-40},{0,-25},{5,-25}},color={191,0,0}));
  connect(panelNode.port,mountInterface.port_a) annotation(Line(points={{5,-25},{5,-40},{30,-40}},color={191,0,0}));
  connect(mountInterface.port_b,thermal) annotation(Line(points={{50,-40},{50,-94},{0,-94},{0,-100}},color={191,0,0}));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={90,90,95},fillColor={225,225,228},fillPattern=FillPattern.Solid),Rectangle(extent={{-55,55},{55,-55}},lineColor={70,70,75},fillColor={245,245,245},fillPattern=FillPattern.Solid),Line(points={{-75,75},{-55,55}},color={70,70,75},thickness=2),Line(points={{75,75},{55,55}},color={70,70,75},thickness=2),Line(points={{-75,-75},{-55,-55}},color={70,70,75},thickness=2),Line(points={{75,-75},{55,-55}},color={70,70,75},thickness=2),Text(extent={{-92,-94},{92,-72}},textString="12U FRAME")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Text(extent={{-92,78},{92,65}},textString="承力框-载荷舱板-电子舱板")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>提供整星机械基准、分舱安装几何、结构质量与热传导路径</p><p><b>建模层级：</b>Components层设备级白箱；主要由Modelica 4.0.0标准库元件和图形连线组成</p><h4>实现与接口</h4><p><b>白箱实现：</b>两层BodyBox、FixedTranslation安装偏置、导轨/面板热容和结构导热网络组合</p><p><b>关键内部元件：</b>payloadDeck（FixedTranslation）、primaryFrame（BodyBox）、avionicsDeck（FixedTranslation）、lowerDeck（BodyBox）、railNode（HeatCapacitor）、panelNode（HeatCapacitor）、railPanel（ThermalConductor）、mountInterface（ThermalConductor）</p><p><b>对外接口：</b>mechanical（MechanicalPort）、information（InformationPort）</p><h4>工作行为与状态</h4><p><b>运行行为：</b>所有分系统机械端最终汇入该结构；导轨和面板热节点经总体热网交换热量</p><p><b>关键参数：</b>主框架/下层舱质量惯量、舱板偏置、导轨面板热容和导热</p><p><b>关键状态：</b>多体位姿、速度、导轨温度和面板温度</p><p><b>物理域：</b>结构机械、热、信息</p><h4>信息与遥测关系</h4><p><b>数据路径：</b>结构本体不设独立遥测字段，机械和热状态用于系统级诊断</p><p><b>使用说明：</b>设备测量与机器反馈均写入同一个InformationPort.device语义域；不存在平行的传感器遥测接口。应从N-System画布下钻本组件，并结合总体公共电/热/机械网络解释结果。</p></html>"));
end StructureAssembly12U;
