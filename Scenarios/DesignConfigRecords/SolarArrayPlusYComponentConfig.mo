within OneSatSim.Scenarios.DesignConfigRecords;
record SolarArrayPlusYComponentConfig "solarArrayPlusY硬件设计配置"
  parameter Modelica.Units.SI.Area ActiveArea
    "有效电池片面积；Excel工程单位m²";
  parameter Real CellEfficiency
    "太阳电池转换效率；Excel工程单位1";
  parameter Real SolarEOLFactor
    "太阳阵EOL性能系数；Excel工程单位1";
  parameter Boolean UseSolarEOL
    "启用太阳阵EOL；Excel工程单位Boolean";
  parameter Real MPPTDeliveryEfficiency
    "MPPT/线束交付效率；Excel工程单位1";
  parameter Real SolarAbsorptivity
    "太阳光吸收率；Excel工程单位1";
  parameter Real InfraredAbsorptivity
    "红外吸收率；Excel工程单位1";
  parameter Real Emissivity
    "红外发射率；Excel工程单位1";
  parameter Modelica.Units.SI.ThermalConductance MountConductance
    "面板安装导热；Excel工程单位W/K";
  parameter Modelica.Units.SI.Resistance HarnessResistance
    "太阳阵线束/阻断路径电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.HeatCapacity PanelHeatCapacity
    "面板等效热容；Excel工程单位J/K";
  parameter Real Normal_X
    "安装法向X；Excel工程单位1";
  parameter Real Normal_Y
    "安装法向Y；Excel工程单位1";
  parameter Real Normal_Z
    "安装法向Z；Excel工程单位1";
  parameter Modelica.Units.SI.Mass Mass
    "质量；Excel工程单位kg";
  parameter Modelica.Units.SI.Length RCM_X
    "质心偏置X；Excel工程单位m";
  parameter Modelica.Units.SI.Length RCM_Y
    "质心偏置Y；Excel工程单位m";
  parameter Modelica.Units.SI.Length RCM_Z
    "质心偏置Z；Excel工程单位m";
  parameter Modelica.Units.SI.Inertia Inertia_XX
    "局部惯量 Ixx；Excel工程单位kg·m²";
  parameter Modelica.Units.SI.Inertia Inertia_YY
    "局部惯量 Iyy；Excel工程单位kg·m²";
  parameter Modelica.Units.SI.Inertia Inertia_ZZ
    "局部惯量 Izz；Excel工程单位kg·m²";
  annotation(Documentation(info="<html><h2>solarArrayPlusY硬件设计配置</h2><p><b>类路径：</b><code>OneSatSim.Scenarios.DesignConfigRecords.SolarArrayPlusYComponentConfig</code>　<b>类型：</b>record</p><h3>用途与定位</h3><p>solarArrayPlusY硬件设计配置</p><h3>配置与调用</h3><p>由使用者声明或传入本类型；记录与常量保存静态配置，不单独代表一套物理状态。修改设计输入后应通过项目既有离线配置入口生成生效快照。</p><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>ActiveArea</code></td><td>Modelica.Units.SI.Area</td><td>有效电池片面积；Excel工程单位m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>CellEfficiency</code></td><td>Real</td><td>太阳电池转换效率；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>SolarEOLFactor</code></td><td>Real</td><td>太阳阵EOL性能系数；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>UseSolarEOL</code></td><td>Boolean</td><td>启用太阳阵EOL；Excel工程单位Boolean</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>MPPTDeliveryEfficiency</code></td><td>Real</td><td>MPPT/线束交付效率；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>SolarAbsorptivity</code></td><td>Real</td><td>太阳光吸收率；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>InfraredAbsorptivity</code></td><td>Real</td><td>红外吸收率；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Emissivity</code></td><td>Real</td><td>红外发射率；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>MountConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>面板安装导热；Excel工程单位W/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>HarnessResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>太阳阵线束/阻断路径电阻；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>PanelHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>面板等效热容；Excel工程单位J/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Normal_X</code></td><td>Real</td><td>安装法向X；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Normal_Y</code></td><td>Real</td><td>安装法向Y；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Normal_Z</code></td><td>Real</td><td>安装法向Z；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel工程单位kg</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={77,126,172}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-30.6,-12},{7.2,38.4}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Rectangle(extent={{-28.2,-9.6},{-20.85,-3}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-27,-8.4},{-22.05,-4.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-28.2,-1.8},{-20.85,4.8}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-27,-0.6},{-22.05,3.6}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-28.2,6},{-20.85,12.6}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-27,7.2},{-22.05,11.4}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-28.2,13.8},{-20.85,20.4}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-27,15},{-22.05,19.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-28.2,21.6},{-20.85,28.2}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-27,22.8},{-22.05,27}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-28.2,29.4},{-20.85,36}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-27,30.6},{-22.05,34.8}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-19.65,-9.6},{-12.3,-3}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-18.45,-8.4},{-13.5,-4.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-19.65,-1.8},{-12.3,4.8}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-18.45,-0.6},{-13.5,3.6}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-19.65,6},{-12.3,12.6}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-18.45,7.2},{-13.5,11.4}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-19.65,13.8},{-12.3,20.4}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-18.45,15},{-13.5,19.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-19.65,21.6},{-12.3,28.2}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-18.45,22.8},{-13.5,27}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-19.65,29.4},{-12.3,36}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-18.45,30.6},{-13.5,34.8}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-11.1,-9.6},{-3.75,-3}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-9.9,-8.4},{-4.95,-4.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-11.1,-1.8},{-3.75,4.8}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-9.9,-0.6},{-4.95,3.6}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-11.1,6},{-3.75,12.6}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-9.9,7.2},{-4.95,11.4}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-11.1,13.8},{-3.75,20.4}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-9.9,15},{-4.95,19.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-11.1,21.6},{-3.75,28.2}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-9.9,22.8},{-4.95,27}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-11.1,29.4},{-3.75,36}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-9.9,30.6},{-4.95,34.8}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-2.55,-9.6},{4.8,-3}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-1.35,-8.4},{3.6,-4.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-2.55,-1.8},{4.8,4.8}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-1.35,-0.6},{3.6,3.6}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-2.55,6},{4.8,12.6}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-1.35,7.2},{3.6,11.4}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-2.55,13.8},{4.8,20.4}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-1.35,15},{3.6,19.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-2.55,21.6},{4.8,28.2}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-1.35,22.8},{3.6,27}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-2.55,29.4},{4.8,36}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-1.35,30.6},{3.6,34.8}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Ellipse(extent={{24.6,29.4},{33,37.8}}, lineColor={0,0,0}, fillColor={255,246,210}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Line(points={{34.8,33.6},{37.8,33.6}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{33.042641,37.842641},{35.163961,39.963961}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{28.8,39.6},{28.8,42.6}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{24.557359,37.842641},{22.436039,39.963961}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{22.8,33.6},{19.8,33.6}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{24.557359,29.357359},{22.436039,27.236039}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{28.8,27.6},{28.8,24.6}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{33.042641,29.357359},{35.163961,27.236039}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{22.8,27.6},{7.2,17.4}}, color={212,109,62}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{26.4,22.8},{8.4,11.4}}, color={212,109,62}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-12,-13.2},{-12,-16.8},{15.6,-16.8},{15.6,-2.4}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid),
      Polygon(points={{12,-2.4},{19.2,-2.4},{15.6,3.6},{12,-2.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6),
      Line(points={{12,3.6},{19.2,3.6}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{15.6,3.6},{15.6,9.6},{33.6,9.6}}, color={77,126,172}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Text(extent={{18.6,-12.6},{37.2,-1.2}}, textString="+Y", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Line(points={{-27,39},{-27,42},{-13.8,42},{-13.8,39}}, color={77,126,172}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-9,39},{-9,44.4},{3.6,44.4},{3.6,39}}, color={77,126,172}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Solar Array +Y Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={77,126,172}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-30.6,-12},{7.2,38.4}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Rectangle(extent={{-28.2,-9.6},{-20.85,-3}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-27,-8.4},{-22.05,-4.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-28.2,-1.8},{-20.85,4.8}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-27,-0.6},{-22.05,3.6}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-28.2,6},{-20.85,12.6}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-27,7.2},{-22.05,11.4}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-28.2,13.8},{-20.85,20.4}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-27,15},{-22.05,19.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-28.2,21.6},{-20.85,28.2}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-27,22.8},{-22.05,27}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-28.2,29.4},{-20.85,36}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-27,30.6},{-22.05,34.8}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-19.65,-9.6},{-12.3,-3}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-18.45,-8.4},{-13.5,-4.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-19.65,-1.8},{-12.3,4.8}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-18.45,-0.6},{-13.5,3.6}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-19.65,6},{-12.3,12.6}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-18.45,7.2},{-13.5,11.4}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-19.65,13.8},{-12.3,20.4}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-18.45,15},{-13.5,19.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-19.65,21.6},{-12.3,28.2}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-18.45,22.8},{-13.5,27}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-19.65,29.4},{-12.3,36}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-18.45,30.6},{-13.5,34.8}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-11.1,-9.6},{-3.75,-3}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-9.9,-8.4},{-4.95,-4.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-11.1,-1.8},{-3.75,4.8}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-9.9,-0.6},{-4.95,3.6}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-11.1,6},{-3.75,12.6}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-9.9,7.2},{-4.95,11.4}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-11.1,13.8},{-3.75,20.4}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-9.9,15},{-4.95,19.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-11.1,21.6},{-3.75,28.2}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-9.9,22.8},{-4.95,27}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-11.1,29.4},{-3.75,36}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-9.9,30.6},{-4.95,34.8}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-2.55,-9.6},{4.8,-3}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-1.35,-8.4},{3.6,-4.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-2.55,-1.8},{4.8,4.8}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-1.35,-0.6},{3.6,3.6}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-2.55,6},{4.8,12.6}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-1.35,7.2},{3.6,11.4}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-2.55,13.8},{4.8,20.4}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-1.35,15},{3.6,19.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-2.55,21.6},{4.8,28.2}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-1.35,22.8},{3.6,27}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-2.55,29.4},{4.8,36}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-1.35,30.6},{3.6,34.8}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Ellipse(extent={{24.6,29.4},{33,37.8}}, lineColor={0,0,0}, fillColor={255,246,210}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Line(points={{34.8,33.6},{37.8,33.6}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{33.042641,37.842641},{35.163961,39.963961}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{28.8,39.6},{28.8,42.6}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{24.557359,37.842641},{22.436039,39.963961}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{22.8,33.6},{19.8,33.6}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{24.557359,29.357359},{22.436039,27.236039}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{28.8,27.6},{28.8,24.6}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{33.042641,29.357359},{35.163961,27.236039}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{22.8,27.6},{7.2,17.4}}, color={212,109,62}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{26.4,22.8},{8.4,11.4}}, color={212,109,62}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-12,-13.2},{-12,-16.8},{15.6,-16.8},{15.6,-2.4}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid),
      Polygon(points={{12,-2.4},{19.2,-2.4},{15.6,3.6},{12,-2.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6),
      Line(points={{12,3.6},{19.2,3.6}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{15.6,3.6},{15.6,9.6},{33.6,9.6}}, color={77,126,172}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Text(extent={{18.6,-12.6},{37.2,-1.2}}, textString="+Y", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Line(points={{-27,39},{-27,42},{-13.8,42},{-13.8,39}}, color={77,126,172}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-9,39},{-9,44.4},{3.6,44.4},{3.6,39}}, color={77,126,172}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Solar Array +Y Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));
end SolarArrayPlusYComponentConfig;