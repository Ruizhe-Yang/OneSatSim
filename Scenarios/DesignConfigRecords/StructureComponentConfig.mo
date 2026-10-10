within OneSatSim.Scenarios.DesignConfigRecords;
record StructureComponentConfig "structure硬件设计配置"
  parameter Modelica.Units.SI.Mass PrimaryStructureMass
    "主结构总质量；Excel工程单位kg";
  parameter Modelica.Units.SI.Length PrimaryFrameWidth
    "主框架宽度；Excel工程单位m";
  parameter Modelica.Units.SI.Length PrimaryFrameHeight
    "主框架高度；Excel工程单位m";
  parameter Modelica.Units.SI.Length PrimaryFrameLength
    "主框架长度；Excel工程单位m";
  parameter Modelica.Units.SI.Length PayloadDeckOffsetZ
    "载荷舱板安装偏置Z；Excel工程单位m";
  parameter Modelica.Units.SI.Length AvionicsDeckOffsetZ
    "电子舱板安装偏置Z；Excel工程单位m";
  parameter Modelica.Units.SI.Length LowerDeckWidth
    "下舱板宽度；Excel工程单位m";
  parameter Modelica.Units.SI.Length LowerDeckHeight
    "下舱板高度；Excel工程单位m";
  parameter Modelica.Units.SI.Length LowerDeckThickness
    "下舱板厚度；Excel工程单位m";
  parameter Modelica.Units.SI.Density LowerDeckDensity
    "下舱板等效密度；Excel工程单位kg/m³";
  parameter Modelica.Units.SI.HeatCapacity RailHeatCapacity
    "导轨热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.HeatCapacity PanelHeatCapacity
    "结构面板热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.ThermalConductance RailPanelConductance
    "导轨-面板导热；Excel工程单位W/K";
  parameter Modelica.Units.SI.ThermalConductance MountInterfaceConductance
    "结构安装界面导热；Excel工程单位W/K";
  annotation(Documentation(info="<html><h2>structure硬件设计配置</h2><p><b>类路径：</b><code>OneSatSim.Scenarios.DesignConfigRecords.StructureComponentConfig</code>　<b>类型：</b>record</p><h3>用途与定位</h3><p>structure硬件设计配置</p><h3>配置与调用</h3><p>由使用者声明或传入本类型；记录与常量保存静态配置，不单独代表一套物理状态。修改设计输入后应通过项目既有离线配置入口生成生效快照。</p><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>PrimaryStructureMass</code></td><td>Modelica.Units.SI.Mass</td><td>主结构总质量；Excel工程单位kg</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>PrimaryFrameWidth</code></td><td>Modelica.Units.SI.Length</td><td>主框架宽度；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>PrimaryFrameHeight</code></td><td>Modelica.Units.SI.Length</td><td>主框架高度；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>PrimaryFrameLength</code></td><td>Modelica.Units.SI.Length</td><td>主框架长度；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>PayloadDeckOffsetZ</code></td><td>Modelica.Units.SI.Length</td><td>载荷舱板安装偏置Z；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>AvionicsDeckOffsetZ</code></td><td>Modelica.Units.SI.Length</td><td>电子舱板安装偏置Z；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>LowerDeckWidth</code></td><td>Modelica.Units.SI.Length</td><td>下舱板宽度；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>LowerDeckHeight</code></td><td>Modelica.Units.SI.Length</td><td>下舱板高度；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>LowerDeckThickness</code></td><td>Modelica.Units.SI.Length</td><td>下舱板厚度；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>LowerDeckDensity</code></td><td>Modelica.Units.SI.Density</td><td>下舱板等效密度；Excel工程单位kg/m³</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RailHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>导轨热容；Excel工程单位J/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>PanelHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>结构面板热容；Excel工程单位J/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RailPanelConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>导轨-面板导热；Excel工程单位W/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>MountInterfaceConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>结构安装界面导热；Excel工程单位W/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={113,122,132}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Polygon(points={{-21,31.8},{11.4,39},{25.2,27.6},{-7.2,20.4},{-21,31.8}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-21,31.8},{-7.2,20.4},{-7.2,-15.6},{-21,-4.2},{-21,31.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-7.2,20.4},{25.2,27.6},{25.2,-8.4},{-7.2,-15.6},{-7.2,20.4}}, lineColor={0,0,0}, fillColor={246,247,248}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{-21,19.8},{-7.2,8.4},{25.2,15.6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-21,7.8},{-7.2,-3.6},{25.2,3.6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-4.608,20.976},{-4.608,-15.024}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{22.608,27.024},{22.608,-8.976}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-21,31.8},{-7.2,-15.6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-7.2,20.4},{-21,-4.2}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-7.2,20.4},{25.2,-8.4}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{25.2,27.6},{-7.2,-15.6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Ellipse(extent={{-3.6,27.6},{6,35.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{-1.2,29.4},{3.6,33.6}}, lineColor={0,0,0}, fillColor={223,233,238}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Ellipse(extent={{-22.02,30.78},{-19.98,32.82}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-21.51,31.8},{-20.49,31.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-8.22,19.38},{-6.18,21.42}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-7.71,20.4},{-6.69,20.4}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{24.18,26.58},{26.22,28.62}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{24.69,27.6},{25.71,27.6}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-22.02,-5.22},{-19.98,-3.18}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-21.51,-4.2},{-20.49,-4.2}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-8.22,-16.62},{-6.18,-14.58}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-7.71,-15.6},{-6.69,-15.6}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{24.18,-9.42},{26.22,-7.38}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{24.69,-8.4},{25.71,-8.4}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="12U Structure Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={113,122,132}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Polygon(points={{-21,31.8},{11.4,39},{25.2,27.6},{-7.2,20.4},{-21,31.8}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-21,31.8},{-7.2,20.4},{-7.2,-15.6},{-21,-4.2},{-21,31.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-7.2,20.4},{25.2,27.6},{25.2,-8.4},{-7.2,-15.6},{-7.2,20.4}}, lineColor={0,0,0}, fillColor={246,247,248}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{-21,19.8},{-7.2,8.4},{25.2,15.6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-21,7.8},{-7.2,-3.6},{25.2,3.6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-4.608,20.976},{-4.608,-15.024}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{22.608,27.024},{22.608,-8.976}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-21,31.8},{-7.2,-15.6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-7.2,20.4},{-21,-4.2}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-7.2,20.4},{25.2,-8.4}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{25.2,27.6},{-7.2,-15.6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Ellipse(extent={{-3.6,27.6},{6,35.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{-1.2,29.4},{3.6,33.6}}, lineColor={0,0,0}, fillColor={223,233,238}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Ellipse(extent={{-22.02,30.78},{-19.98,32.82}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-21.51,31.8},{-20.49,31.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-8.22,19.38},{-6.18,21.42}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-7.71,20.4},{-6.69,20.4}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{24.18,26.58},{26.22,28.62}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{24.69,27.6},{25.71,27.6}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-22.02,-5.22},{-19.98,-3.18}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-21.51,-4.2},{-20.49,-4.2}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-8.22,-16.62},{-6.18,-14.58}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-7.71,-15.6},{-6.69,-15.6}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{24.18,-9.42},{26.22,-7.38}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{24.69,-8.4},{25.71,-8.4}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="12U Structure Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));
end StructureComponentConfig;