within OneSatSim.Scenarios.DesignConfigRecords;
record SpaceTimeComponentConfig "spaceTime硬件设计配置"
  parameter Modelica.Units.SI.Resistance ActiveResistance
    "时空基准激活负载电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.Resistance StandbyResistance
    "时空基准待机负载电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.Resistance EMIResistance
    "时空载荷EMI等效串联电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.HeatCapacity HeatCapacity
    "时空基准热容；Excel工程单位J/K";
  parameter Real ThermalResistance(unit="K/W")
    "时空载荷安装热阻；Excel工程单位K/W";
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
  annotation(Documentation(info="<html><h2>spaceTime硬件设计配置</h2><p><b>类路径：</b><code>OneSatSim.Scenarios.DesignConfigRecords.SpaceTimeComponentConfig</code>　<b>类型：</b>record</p><h3>用途与定位</h3><p>spaceTime硬件设计配置</p><h3>配置与调用</h3><p>由使用者声明或传入本类型；记录与常量保存静态配置，不单独代表一套物理状态。修改设计输入后应通过项目既有离线配置入口生成生效快照。</p><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>ActiveResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>时空基准激活负载电阻；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>StandbyResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>时空基准待机负载电阻；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>EMIResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>时空载荷EMI等效串联电阻；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>HeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>时空基准热容；Excel工程单位J/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>ThermalResistance</code></td><td>Real</td><td>时空载荷安装热阻；Excel工程单位K/W</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel工程单位kg</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={152,118,71}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-34.8,-5.4},{25.2,33.6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Ellipse(extent={{-25.8,1.8},{1.8,29.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Line(points={{-12,25.8},{-12,15.6},{-3,12}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-1.2,15.6},{0.6,15.6}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-2.646926,21},{-1.08808,21.9}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-6.6,24.953074},{-5.7,26.51192}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-12,26.4},{-12,28.2}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-17.4,24.953074},{-18.3,26.51192}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-21.353074,21},{-22.91192,21.9}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-22.8,15.6},{-24.6,15.6}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-21.353074,10.2},{-22.91192,9.3}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-17.4,6.246926},{-18.3,4.68808}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-12,4.8},{-12,3}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-6.6,6.246926},{-5.7,4.68808}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-2.646926,10.2},{-1.08808,9.3}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{9.6,6.6},{18.6,19.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{13.8,1.2},{13.8,6.6}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{13.8,19.8},{13.8,26.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-32.4,-13.8},{-21.6,-13.8},{-21.6,-8.4},{-12,-8.4},{-12,-13.8},{-2.4,-13.8},{-2.4,-8.4},{7.2,-8.4},{7.2,-13.8},{16.8,-13.8},{16.8,-8.4},{26.4,-8.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Space-Time Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={152,118,71}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-34.8,-5.4},{25.2,33.6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Ellipse(extent={{-25.8,1.8},{1.8,29.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Line(points={{-12,25.8},{-12,15.6},{-3,12}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-1.2,15.6},{0.6,15.6}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-2.646926,21},{-1.08808,21.9}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-6.6,24.953074},{-5.7,26.51192}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-12,26.4},{-12,28.2}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-17.4,24.953074},{-18.3,26.51192}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-21.353074,21},{-22.91192,21.9}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-22.8,15.6},{-24.6,15.6}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-21.353074,10.2},{-22.91192,9.3}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-17.4,6.246926},{-18.3,4.68808}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-12,4.8},{-12,3}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-6.6,6.246926},{-5.7,4.68808}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-2.646926,10.2},{-1.08808,9.3}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{9.6,6.6},{18.6,19.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{13.8,1.2},{13.8,6.6}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{13.8,19.8},{13.8,26.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-32.4,-13.8},{-21.6,-13.8},{-21.6,-8.4},{-12,-8.4},{-12,-13.8},{-2.4,-13.8},{-2.4,-8.4},{7.2,-8.4},{7.2,-13.8},{16.8,-13.8},{16.8,-8.4},{26.4,-8.4}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Space-Time Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));
end SpaceTimeComponentConfig;