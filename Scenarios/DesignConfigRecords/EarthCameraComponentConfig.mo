within OneSatSim.Scenarios.DesignConfigRecords;
record EarthCameraComponentConfig "earthCamera硬件设计配置"
  parameter Real RawImageSize(unit="1")
    "单景原始数据量；Excel工程单位byte";
  parameter Real StoredImageSize(unit="1")
    "单景存储数据量；Excel工程单位byte";
  parameter Modelica.Units.SI.Time CaptureDuration
    "成像持续时间；Excel工程单位s";
  parameter Modelica.Units.SI.Resistance FocalElectronicsResistance
    "焦面电子学负载电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.Resistance FocalHeaterResistance
    "焦面加热器电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.HeatCapacity OpticalBenchHeatCapacity
    "光机结构热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.HeatCapacity FocalBoxHeatCapacity
    "焦面盒热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.ThermalConductance OpticalMountConductance
    "光机结构安装导热；Excel工程单位W/K";
  parameter Modelica.Units.SI.ThermalConductance FocalCouplingConductance
    "焦面-光机耦合导热；Excel工程单位W/K";
  parameter Modelica.Units.SI.ThermalConductance FocalMountConductance
    "焦面盒安装导热；Excel工程单位W/K";
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
  annotation(Documentation(info="<html><h2>earthCamera硬件设计配置</h2><p><b>类路径：</b><code>OneSatSim.Scenarios.DesignConfigRecords.EarthCameraComponentConfig</code>　<b>类型：</b>record</p><h3>用途与定位</h3><p>earthCamera硬件设计配置</p><h3>配置与调用</h3><p>由使用者声明或传入本类型；记录与常量保存静态配置，不单独代表一套物理状态。修改设计输入后应通过项目既有离线配置入口生成生效快照。</p><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>RawImageSize</code></td><td>Real</td><td>单景原始数据量；Excel工程单位byte</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>StoredImageSize</code></td><td>Real</td><td>单景存储数据量；Excel工程单位byte</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>CaptureDuration</code></td><td>Modelica.Units.SI.Time</td><td>成像持续时间；Excel工程单位s</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>FocalElectronicsResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>焦面电子学负载电阻；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>FocalHeaterResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>焦面加热器电阻；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>OpticalBenchHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>光机结构热容；Excel工程单位J/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>FocalBoxHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>焦面盒热容；Excel工程单位J/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>OpticalMountConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>光机结构安装导热；Excel工程单位W/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>FocalCouplingConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>焦面-光机耦合导热；Excel工程单位W/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>FocalMountConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>焦面盒安装导热；Excel工程单位W/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel工程单位kg</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={152,118,71}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-33,-4.2},{-3,28.8}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Polygon(points={{-3,27},{12,33.6},{12,-9},{-3,-1.8},{-3,27}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Ellipse(extent={{5.4,-9},{20.4,33.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.75, startAngle=0, endAngle=360),
      Ellipse(extent={{8.4,-3},{17.4,27}}, lineColor={0,0,0}, fillColor={224,237,246}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{11.4,3.6},{15,21}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-30.6,-7.8},{1.8,-7.8}}, color={0,0,0}, thickness=0.75, pattern=LinePattern.Solid),
      Rectangle(extent={{-25.8,15},{-10.8,23.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Ellipse(extent={{-29.88,-1.08},{-27.72,1.08}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-29.34,0},{-28.26,0}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-9.48,-1.08},{-7.32,1.08}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-8.94,0},{-7.86,0}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{25.224,-9.576},{40.776,5.976}}, lineColor={0,0,0}, fillColor={239,246,250}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{29.8896,-9.576},{36.1104,5.976}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Ellipse(extent={{25.224,-4.5216},{40.776,0.9216}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Line(points={{25.224,-1.8},{40.776,-1.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{33,-9.576},{33,5.976}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{20.4,22.8},{37.8,5.4}}, color={73,112,158}, thickness=0.55, pattern=LinePattern.Dash),
      Line(points={{20.4,0},{28.2,-10.2}}, color={73,112,158}, thickness=0.55, pattern=LinePattern.Dash),
      Line(points={{-25.8,19.2},{-18,19.2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Earth Camera Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={152,118,71}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-33,-4.2},{-3,28.8}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Polygon(points={{-3,27},{12,33.6},{12,-9},{-3,-1.8},{-3,27}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Ellipse(extent={{5.4,-9},{20.4,33.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.75, startAngle=0, endAngle=360),
      Ellipse(extent={{8.4,-3},{17.4,27}}, lineColor={0,0,0}, fillColor={224,237,246}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{11.4,3.6},{15,21}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-30.6,-7.8},{1.8,-7.8}}, color={0,0,0}, thickness=0.75, pattern=LinePattern.Solid),
      Rectangle(extent={{-25.8,15},{-10.8,23.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Ellipse(extent={{-29.88,-1.08},{-27.72,1.08}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-29.34,0},{-28.26,0}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-9.48,-1.08},{-7.32,1.08}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-8.94,0},{-7.86,0}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{25.224,-9.576},{40.776,5.976}}, lineColor={0,0,0}, fillColor={239,246,250}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{29.8896,-9.576},{36.1104,5.976}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Ellipse(extent={{25.224,-4.5216},{40.776,0.9216}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Line(points={{25.224,-1.8},{40.776,-1.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{33,-9.576},{33,5.976}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{20.4,22.8},{37.8,5.4}}, color={73,112,158}, thickness=0.55, pattern=LinePattern.Dash),
      Line(points={{20.4,0},{28.2,-10.2}}, color={73,112,158}, thickness=0.55, pattern=LinePattern.Dash),
      Line(points={{-25.8,19.2},{-18,19.2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Earth Camera Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));
end EarthCameraComponentConfig;