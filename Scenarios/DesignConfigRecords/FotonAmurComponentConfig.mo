within OneSatSim.Scenarios.DesignConfigRecords;
record FotonAmurComponentConfig "fotonAmur硬件设计配置"
  parameter Boolean MissionEnabled
    "FotonAmur载荷启用；Excel工程单位Boolean";
  parameter Modelica.Units.SI.Resistance ElectronicsResistance
    "FotonAmur电子学负载电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.Resistance EMIResistance
    "FotonAmur EMI等效串联电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.HeatCapacity HeatCapacity
    "FotonAmur热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.ThermalConductance MountConductance
    "FotonAmur安装导热；Excel工程单位W/K";
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
  annotation(Documentation(info="<html><h2>fotonAmur硬件设计配置</h2><p><b>类路径：</b><code>OneSatSim.Scenarios.DesignConfigRecords.FotonAmurComponentConfig</code>　<b>类型：</b>record</p><h3>用途与定位</h3><p>fotonAmur硬件设计配置</p><h3>配置与调用</h3><p>由使用者声明或传入本类型；记录与常量保存静态配置，不单独代表一套物理状态。修改设计输入后应通过项目既有离线配置入口生成生效快照。</p><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>MissionEnabled</code></td><td>Boolean</td><td>FotonAmur载荷启用；Excel工程单位Boolean</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>ElectronicsResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>FotonAmur电子学负载电阻；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>EMIResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>FotonAmur EMI等效串联电阻；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>HeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>FotonAmur热容；Excel工程单位J/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>MountConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>FotonAmur安装导热；Excel工程单位W/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel工程单位kg</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={152,118,71}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-24.6,-5.4},{18.6,29.4}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Rectangle(extent={{-17.4,2.4},{11.4,22.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Polygon(points={{-16.8,22.8},{-10.8,30.6},{4.8,30.6},{10.8,22.8},{-16.8,22.8}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.6),
      Ellipse(extent={{-9,7.2},{3,19.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Line(points={{-31.8,12},{-24.6,12}}, color={77,126,172}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{18.6,12},{30,12},{30,23.4},{39,23.4}}, color={83,131,109}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Ellipse(extent={{-22.02,-2.82},{-19.98,-0.78}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-21.51,-1.8},{-20.49,-1.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{13.98,-2.82},{16.02,-0.78}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{14.49,-1.8},{15.51,-1.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-22.02,24.78},{-19.98,26.82}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-21.51,25.8},{-20.49,25.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{13.98,24.78},{16.02,26.82}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{14.49,25.8},{15.51,25.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-38.4,37.2},{-28.2,37.2},{-28.2,41.4},{-18,41.4},{-18,37.2},{-8.4,37.2}}, color={152,118,71}, thickness=0.75, pattern=LinePattern.Solid),
      Text(extent={{-29.4,-18.6},{23.4,-8.4}}, textString="SCIENCE", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Foton-Amur Payload Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={152,118,71}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-24.6,-5.4},{18.6,29.4}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Rectangle(extent={{-17.4,2.4},{11.4,22.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Polygon(points={{-16.8,22.8},{-10.8,30.6},{4.8,30.6},{10.8,22.8},{-16.8,22.8}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.6),
      Ellipse(extent={{-9,7.2},{3,19.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Line(points={{-31.8,12},{-24.6,12}}, color={77,126,172}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{18.6,12},{30,12},{30,23.4},{39,23.4}}, color={83,131,109}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Ellipse(extent={{-22.02,-2.82},{-19.98,-0.78}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-21.51,-1.8},{-20.49,-1.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{13.98,-2.82},{16.02,-0.78}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{14.49,-1.8},{15.51,-1.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-22.02,24.78},{-19.98,26.82}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-21.51,25.8},{-20.49,25.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{13.98,24.78},{16.02,26.82}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{14.49,25.8},{15.51,25.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-38.4,37.2},{-28.2,37.2},{-28.2,41.4},{-18,41.4},{-18,37.2},{-8.4,37.2}}, color={152,118,71}, thickness=0.75, pattern=LinePattern.Solid),
      Text(extent={{-29.4,-18.6},{23.4,-8.4}}, textString="SCIENCE", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Foton-Amur Payload Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));
end FotonAmurComponentConfig;