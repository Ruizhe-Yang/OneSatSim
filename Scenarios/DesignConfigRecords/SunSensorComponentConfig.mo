within OneSatSim.Scenarios.DesignConfigRecords;
record SunSensorComponentConfig "sunSensor硬件设计配置"
  parameter Modelica.Units.SI.Resistance LoadResistance
    "sunSensor等效负载电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.HeatCapacity HeatCapacity
    "sunSensor等效热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.ThermalConductance MountConductance
    "sunSensor安装导热；Excel工程单位W/K";
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
  annotation(Documentation(info="<html><h2>sunSensor硬件设计配置</h2><p><b>类路径：</b><code>OneSatSim.Scenarios.DesignConfigRecords.SunSensorComponentConfig</code>　<b>类型：</b>record</p><h3>用途与定位</h3><p>sunSensor硬件设计配置</p><h3>配置与调用</h3><p>由使用者声明或传入本类型；记录与常量保存静态配置，不单独代表一套物理状态。修改设计输入后应通过项目既有离线配置入口生成生效快照。</p><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>LoadResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>sunSensor等效负载电阻；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>HeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>sunSensor等效热容；Excel工程单位J/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>MountConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>sunSensor安装导热；Excel工程单位W/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel工程单位kg</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Ellipse(extent={{-37.2,25.8},{-26.4,36.6}}, lineColor={0,0,0}, fillColor={255,246,210}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Line(points={{-24.6,31.2},{-21.6,31.2}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-26.708831,36.291169},{-24.587511,38.412489}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-31.8,38.4},{-31.8,41.4}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-36.891169,36.291169},{-39.012489,38.412489}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-39,31.2},{-42,31.2}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-36.891169,26.108831},{-39.012489,23.987511}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-31.8,24},{-31.8,21}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-26.708831,26.108831},{-24.587511,23.987511}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Polygon(points={{-9.6,23.4},{24,30},{36,17.4},{1.8,9.6},{-9.6,23.4}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{1.8,9.6},{36,17.4},{36,3.6},{1.8,-5.4},{1.8,9.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6),
      Polygon(points={{-9.6,23.4},{1.8,9.6},{1.8,-5.4},{-9.6,7.8},{-9.6,23.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6),
      Polygon(points={{-0.6,20.4},{8.4,22.2},{4.8,18},{-4.2,16.2},{-0.6,20.4}}, lineColor={0,0,0}, fillColor={228,239,247}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Polygon(points={{-4.2,15.6},{4.8,17.4},{1.2,13.2},{-7.8,11.4},{-4.2,15.6}}, lineColor={0,0,0}, fillColor={228,239,247}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Polygon(points={{10.8,22.8},{19.8,24.6},{16.2,20.4},{7.2,18.6},{10.8,22.8}}, lineColor={0,0,0}, fillColor={228,239,247}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Polygon(points={{7.2,18},{16.2,19.8},{12.6,15.6},{3.6,13.8},{7.2,18}}, lineColor={0,0,0}, fillColor={228,239,247}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Line(points={{-21.6,24.6},{-5.4,13.2}}, color={212,109,62}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-17.4,31.2},{6.6,25.2}}, color={212,109,62}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-27,-3},{-15,-3}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-27,-3},{-33.24,4.68}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-27,-3},{-27,9}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Sun Sensor Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Ellipse(extent={{-37.2,25.8},{-26.4,36.6}}, lineColor={0,0,0}, fillColor={255,246,210}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Line(points={{-24.6,31.2},{-21.6,31.2}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-26.708831,36.291169},{-24.587511,38.412489}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-31.8,38.4},{-31.8,41.4}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-36.891169,36.291169},{-39.012489,38.412489}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-39,31.2},{-42,31.2}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-36.891169,26.108831},{-39.012489,23.987511}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-31.8,24},{-31.8,21}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-26.708831,26.108831},{-24.587511,23.987511}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Polygon(points={{-9.6,23.4},{24,30},{36,17.4},{1.8,9.6},{-9.6,23.4}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{1.8,9.6},{36,17.4},{36,3.6},{1.8,-5.4},{1.8,9.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6),
      Polygon(points={{-9.6,23.4},{1.8,9.6},{1.8,-5.4},{-9.6,7.8},{-9.6,23.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6),
      Polygon(points={{-0.6,20.4},{8.4,22.2},{4.8,18},{-4.2,16.2},{-0.6,20.4}}, lineColor={0,0,0}, fillColor={228,239,247}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Polygon(points={{-4.2,15.6},{4.8,17.4},{1.2,13.2},{-7.8,11.4},{-4.2,15.6}}, lineColor={0,0,0}, fillColor={228,239,247}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Polygon(points={{10.8,22.8},{19.8,24.6},{16.2,20.4},{7.2,18.6},{10.8,22.8}}, lineColor={0,0,0}, fillColor={228,239,247}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Polygon(points={{7.2,18},{16.2,19.8},{12.6,15.6},{3.6,13.8},{7.2,18}}, lineColor={0,0,0}, fillColor={228,239,247}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Line(points={{-21.6,24.6},{-5.4,13.2}}, color={212,109,62}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-17.4,31.2},{6.6,25.2}}, color={212,109,62}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-27,-3},{-15,-3}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-27,-3},{-33.24,4.68}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-27,-3},{-27,9}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Sun Sensor Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));
end SunSensorComponentConfig;