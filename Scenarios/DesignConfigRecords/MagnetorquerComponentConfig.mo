within OneSatSim.Scenarios.DesignConfigRecords;
record MagnetorquerComponentConfig "magnetorquer硬件设计配置"
  parameter Modelica.Units.SI.Current CoilCurrentLimit
    "磁力矩器线圈电流上限；Excel工程单位A";
  parameter Modelica.Units.SI.Area DipolePerAmpere_X
    "X轴单位电流磁矩；Excel工程单位A·m²/A";
  parameter Modelica.Units.SI.Area DipolePerAmpere_Y
    "Y轴单位电流磁矩；Excel工程单位A·m²/A";
  parameter Modelica.Units.SI.Area DipolePerAmpere_Z
    "Z轴单位电流磁矩；Excel工程单位A·m²/A";
  parameter Modelica.Units.SI.HeatCapacity HeatCapacity
    "磁力矩器线圈热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.ThermalConductance MountConductance
    "磁力矩器安装导热；Excel工程单位W/K";
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
  annotation(Documentation(info="<html><h2>magnetorquer硬件设计配置</h2><p><b>类路径：</b><code>OneSatSim.Scenarios.DesignConfigRecords.MagnetorquerComponentConfig</code>　<b>类型：</b>record</p><h3>用途与定位</h3><p>magnetorquer硬件设计配置</p><h3>配置与调用</h3><p>由使用者声明或传入本类型；记录与常量保存静态配置，不单独代表一套物理状态。修改设计输入后应通过项目既有离线配置入口生成生效快照。</p><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>CoilCurrentLimit</code></td><td>Modelica.Units.SI.Current</td><td>磁力矩器线圈电流上限；Excel工程单位A</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>DipolePerAmpere_X</code></td><td>Modelica.Units.SI.Area</td><td>X轴单位电流磁矩；Excel工程单位A·m²/A</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>DipolePerAmpere_Y</code></td><td>Modelica.Units.SI.Area</td><td>Y轴单位电流磁矩；Excel工程单位A·m²/A</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>DipolePerAmpere_Z</code></td><td>Modelica.Units.SI.Area</td><td>Z轴单位电流磁矩；Excel工程单位A·m²/A</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>HeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>磁力矩器线圈热容；Excel工程单位J/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>MountConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>磁力矩器安装导热；Excel工程单位W/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel工程单位kg</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-33.6,16.2},{-4.8,23.4}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{-29.4,15},{-31.2,24.6}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-26.4,15},{-28.2,24.6}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-23.4,15},{-25.2,24.6}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-20.4,15},{-22.2,24.6}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-17.4,15},{-19.2,24.6}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-14.4,15},{-16.2,24.6}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-11.4,15},{-13.2,24.6}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-37.2,19.8},{-33.6,19.8},{-33.6,10.8},{-3.6,10.8}}, color={0,0,0}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{-10.8,3},{18,10.2}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{-6.6,1.8},{-8.4,11.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-3.6,1.8},{-5.4,11.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-0.6,1.8},{-2.4,11.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{2.4,1.8},{0.6,11.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{5.4,1.8},{3.6,11.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{8.4,1.8},{6.6,11.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{11.4,1.8},{9.6,11.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-14.4,6.6},{-10.8,6.6},{-10.8,-2.4},{19.2,-2.4}}, color={0,0,0}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{3.6,27},{32.4,34.2}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{7.8,25.8},{6,35.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{10.8,25.8},{9,35.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{13.8,25.8},{12,35.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{16.8,25.8},{15,35.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{19.8,25.8},{18,35.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{22.8,25.8},{21,35.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{25.8,25.8},{24,35.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{0,30.6},{3.6,30.6},{3.6,21.6},{33.6,21.6}}, color={0,0,0}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-30,38.4},{-17.4,45},{3,45},{19.8,41.4}}, color={76,128,143}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{27.6,-6},{40.2,-6}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{27.6,-6},{21.048,2.064}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{27.6,-6},{27.6,6.6}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Magnetorquer Set Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-33.6,16.2},{-4.8,23.4}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{-29.4,15},{-31.2,24.6}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-26.4,15},{-28.2,24.6}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-23.4,15},{-25.2,24.6}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-20.4,15},{-22.2,24.6}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-17.4,15},{-19.2,24.6}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-14.4,15},{-16.2,24.6}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-11.4,15},{-13.2,24.6}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-37.2,19.8},{-33.6,19.8},{-33.6,10.8},{-3.6,10.8}}, color={0,0,0}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{-10.8,3},{18,10.2}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{-6.6,1.8},{-8.4,11.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-3.6,1.8},{-5.4,11.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-0.6,1.8},{-2.4,11.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{2.4,1.8},{0.6,11.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{5.4,1.8},{3.6,11.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{8.4,1.8},{6.6,11.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{11.4,1.8},{9.6,11.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-14.4,6.6},{-10.8,6.6},{-10.8,-2.4},{19.2,-2.4}}, color={0,0,0}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{3.6,27},{32.4,34.2}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{7.8,25.8},{6,35.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{10.8,25.8},{9,35.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{13.8,25.8},{12,35.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{16.8,25.8},{15,35.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{19.8,25.8},{18,35.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{22.8,25.8},{21,35.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{25.8,25.8},{24,35.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{0,30.6},{3.6,30.6},{3.6,21.6},{33.6,21.6}}, color={0,0,0}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-30,38.4},{-17.4,45},{3,45},{19.8,41.4}}, color={76,128,143}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{27.6,-6},{40.2,-6}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{27.6,-6},{21.048,2.064}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{27.6,-6},{27.6,6.6}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Magnetorquer Set Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));
end MagnetorquerComponentConfig;