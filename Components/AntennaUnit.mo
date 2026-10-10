within OneSatSim.Components;
model AntennaUnit "X波段贴片与测控天线组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.AntennaComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.HeatCapacity patchHeatCapacity=config.PatchHeatCapacity
    "天线贴片等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance rfDeckConductance=config.RFDeckConductance
    "天线射频舱板导热；Excel单位W/K，当前设计基线";
  parameter Modelica.Units.SI.Length mastOffsetZ=config.MastOffsetZ
    "天线桅杆Z向安装偏置；Excel单位m，当前设计基线";
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
  Foundation.Interfaces.ThermalPort thermal  "热学" annotation(Placement(visible=true, transformation(origin={220,-107}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,-97}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(visible=true, transformation(origin={-230,70}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor patchNode(C=patchHeatCapacity,T(start=288.15,fixed=false))  "计算/接口量 patchNode" annotation(Placement(visible=true, transformation(origin={-60,-75}, extent={{-32,-32},{32,32}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor rfDeck(G=rfDeckConductance)  "计算/接口量 rfDeck" annotation(Placement(visible=true, transformation(origin={75,-107}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.Body antennaMass(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ)  "antenna质量" annotation(Placement(visible=true, transformation(origin={-10,70}, extent={{-40,-40},{40,40}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation antennaMast(r={0,0,mastOffsetZ})  "计算/接口量 antennaMast" annotation(Placement(visible=true, transformation(origin={-140,70}, extent={{-30,-30},{30,30}}, rotation=0)));
equation
  connect(mechanical,antennaMast.frame_a) annotation(Line(points={{-230,70},{-170,70}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(antennaMast.frame_b,antennaMass.frame_a) annotation(Line(points={{-110,70},{-50,70}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(patchNode.port,rfDeck.port_a) annotation(Line(points={{-60,-107},{-60,-117},{41,-117},{41,-107},{51,-107}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(rfDeck.port_b,thermal) annotation(Line(points={{99,-107},{220,-107}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>X波段贴片与测控天线组件</h2><p><b>类路径：</b><code>OneSatSim.Components.AntennaUnit</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>X波段贴片与测控天线组件</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.N_systems.CommunicationSystem\">OneSatSim.Systems.N_systems.CommunicationSystem</a> 的 <code>antenna</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>config</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.AntennaComponentConfig</td><td>由所属N-System传入的硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>patchHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>天线贴片等效热容；Excel单位J/K，当前设计基线</td><td><code>=config.PatchHeatCapacity</code></td></tr><tr><td><code>rfDeckConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>天线射频舱板导热；Excel单位W/K，当前设计基线</td><td><code>=config.RFDeckConductance</code></td></tr><tr><td><code>mastOffsetZ</code></td><td>Modelica.Units.SI.Length</td><td>天线桅杆Z向安装偏置；Excel单位m，当前设计基线</td><td><code>=config.MastOffsetZ</code></td></tr><tr><td><code>mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel单位kg，当前设计基线</td><td><code>=config.Mass</code></td></tr><tr><td><code>rcm_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel单位m，当前设计基线</td><td><code>=config.RCM_X</code></td></tr><tr><td><code>rcm_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel单位m，当前设计基线</td><td><code>=config.RCM_Y</code></td></tr><tr><td><code>rcm_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel单位m，当前设计基线</td><td><code>=config.RCM_Z</code></td></tr><tr><td><code>inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_XX</code></td></tr><tr><td><code>inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_YY</code></td></tr><tr><td><code>inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_ZZ</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>patchNode</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a></td><td>计算/接口量 patchNode</td></tr><tr><td><code>rfDeck</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">Modelica.Thermal.HeatTransfer.Components.ThermalConductor</a></td><td>计算/接口量 rfDeck</td></tr><tr><td><code>antennaMass</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">Modelica.Mechanics.MultiBody.Parts.Body</a></td><td>antenna质量</td></tr><tr><td><code>antennaMast</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.FixedTranslation\">Modelica.Mechanics.MultiBody.Parts.FixedTranslation</a></td><td>计算/接口量 antennaMast</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="RF hardware", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-38,20},{26,30},{48,5},{-18,-7},{-38,20}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-22,17},{20,23},{32,9},{-9,1},{-22,17}}, lineColor={0,0,0}, fillColor={229,239,245}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{0,-4},{0,-28}}, color={0,0,0}, thickness=1, pattern=LinePattern.Solid),
      Rectangle(extent={{-21,-34},{23,-28}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{-9,34},{-9,49}}, color={73,112,158}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{10,36},{17,53}}, color={73,112,158}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{30,31},{43,45}}, color={73,112,158}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Patch Antenna", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-274,-169},{264,237}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-205,149},{-45.4,167}}, textString="Mechanical mounting", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-135,-21},{33,-3}}, textString="Passive thermal path", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-262,192},{252,221}}, textString="Antenna: mount and thermal paths", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-262,184},{252,184}}, color={215,220,226}, thickness=0.25)
    }));
end AntennaUnit;