within OneSatSim.Scenarios.DesignConfigRecords;
record NaviEnhanceComponentConfig "naviEnhance硬件设计配置"
  parameter Modelica.Units.SI.Resistance ActiveResistance
    "导航增强激活负载电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.Resistance StandbyResistance
    "导航增强待机负载电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.HeatCapacity HeatCapacity
    "导航增强处理器热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.ThermalConductance MountConductance
    "导航增强安装导热；Excel工程单位W/K";
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
  annotation(Documentation(info="<html><h2>naviEnhance硬件设计配置</h2><p><b>类路径：</b><code>OneSatSim.Scenarios.DesignConfigRecords.NaviEnhanceComponentConfig</code>　<b>类型：</b>record</p><h3>用途与定位</h3><p>naviEnhance硬件设计配置</p><h3>配置与调用</h3><p>由使用者声明或传入本类型；记录与常量保存静态配置，不单独代表一套物理状态。修改设计输入后应通过项目既有离线配置入口生成生效快照。</p><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>ActiveResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>导航增强激活负载电阻；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>StandbyResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>导航增强待机负载电阻；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>HeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>导航增强处理器热容；Excel工程单位J/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>MountConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>导航增强安装导热；Excel工程单位W/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel工程单位kg</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={152,118,71}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-34.8,-10.8},{28.8,36}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Rectangle(extent={{-19.2,0},{7.8,27}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Rectangle(extent={{-15,4.2},{3.6,22.8}}, lineColor={0,0,0}, fillColor={234,240,245}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-24.6,3.6},{-19.2,3.6}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{7.8,3.6},{13.2,3.6}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-14.4,0},{-14.4,-5.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-14.4,27},{-14.4,32.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-24.6,10.2},{-19.2,10.2}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{7.8,10.2},{13.2,10.2}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-7.8,0},{-7.8,-5.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-7.8,27},{-7.8,32.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-24.6,16.8},{-19.2,16.8}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{7.8,16.8},{13.2,16.8}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-1.2,0},{-1.2,-5.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-1.2,27},{-1.2,32.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-24.6,23.4},{-19.2,23.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{7.8,23.4},{13.2,23.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{5.4,0},{5.4,-5.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{5.4,27},{5.4,32.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Ellipse(extent={{-31.68,-7.68},{-29.52,-5.52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-31.14,-6.6},{-30.06,-6.6}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{23.52,-7.68},{25.68,-5.52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{24.06,-6.6},{25.14,-6.6}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-31.68,30.72},{-29.52,32.88}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-31.14,31.8},{-30.06,31.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{23.52,30.72},{25.68,32.88}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{24.06,31.8},{25.14,31.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{16.8,21},{23.4,29.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{16.8,9},{23.4,16.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{16.8,-3},{23.4,4.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Ellipse(extent={{-12.6,6},{1.2,19.8}}, lineColor={76,128,143}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Line(points={{-6,3},{-6,22.8}}, color={76,128,143}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-16.2,12.6},{4.8,12.6}}, color={76,128,143}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-43.8,21},{-37.2,24}}, color={76,128,143}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-43.8,12},{-37.2,12}}, color={76,128,143}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-43.8,3},{-37.2,0}}, color={76,128,143}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Nav Enhancer Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={152,118,71}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-34.8,-10.8},{28.8,36}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Rectangle(extent={{-19.2,0},{7.8,27}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Rectangle(extent={{-15,4.2},{3.6,22.8}}, lineColor={0,0,0}, fillColor={234,240,245}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-24.6,3.6},{-19.2,3.6}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{7.8,3.6},{13.2,3.6}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-14.4,0},{-14.4,-5.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-14.4,27},{-14.4,32.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-24.6,10.2},{-19.2,10.2}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{7.8,10.2},{13.2,10.2}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-7.8,0},{-7.8,-5.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-7.8,27},{-7.8,32.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-24.6,16.8},{-19.2,16.8}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{7.8,16.8},{13.2,16.8}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-1.2,0},{-1.2,-5.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-1.2,27},{-1.2,32.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-24.6,23.4},{-19.2,23.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{7.8,23.4},{13.2,23.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{5.4,0},{5.4,-5.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{5.4,27},{5.4,32.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Ellipse(extent={{-31.68,-7.68},{-29.52,-5.52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-31.14,-6.6},{-30.06,-6.6}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{23.52,-7.68},{25.68,-5.52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{24.06,-6.6},{25.14,-6.6}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-31.68,30.72},{-29.52,32.88}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-31.14,31.8},{-30.06,31.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{23.52,30.72},{25.68,32.88}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{24.06,31.8},{25.14,31.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{16.8,21},{23.4,29.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{16.8,9},{23.4,16.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{16.8,-3},{23.4,4.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Ellipse(extent={{-12.6,6},{1.2,19.8}}, lineColor={76,128,143}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Line(points={{-6,3},{-6,22.8}}, color={76,128,143}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-16.2,12.6},{4.8,12.6}}, color={76,128,143}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-43.8,21},{-37.2,24}}, color={76,128,143}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-43.8,12},{-37.2,12}}, color={76,128,143}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-43.8,3},{-37.2,0}}, color={76,128,143}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Nav Enhancer Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));
end NaviEnhanceComponentConfig;