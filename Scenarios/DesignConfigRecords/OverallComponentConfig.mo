within OneSatSim.Scenarios.DesignConfigRecords;
record OverallComponentConfig "overall硬件设计配置"
  parameter Real BodySolarAbsorptivity
    "裸露本体太阳吸收率；Excel工程单位1";
  parameter Real BodyInfraredAbsorptivity
    "裸露本体红外吸收率；Excel工程单位1";
  parameter Real ExternalEmissivity
    "裸露本体发射率；Excel工程单位1";
  parameter Modelica.Units.SI.HeatCapacity BusDeckHeatCapacity
    "内部设备舱板热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.HeatCapacity ExternalShellHeatCapacity
    "外表面热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.ThermalConductance ShellToBusConductance
    "外壳-舱板导热；Excel工程单位W/K";
  annotation(Documentation(info="<html><h2>overall硬件设计配置</h2><p><b>类路径：</b><code>OneSatSim.Scenarios.DesignConfigRecords.OverallComponentConfig</code>　<b>类型：</b>record</p><h3>用途与定位</h3><p>overall硬件设计配置</p><h3>配置与调用</h3><p>由使用者声明或传入本类型；记录与常量保存静态配置，不单独代表一套物理状态。修改设计输入后应通过项目既有离线配置入口生成生效快照。</p><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>BodySolarAbsorptivity</code></td><td>Real</td><td>裸露本体太阳吸收率；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>BodyInfraredAbsorptivity</code></td><td>Real</td><td>裸露本体红外吸收率；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>ExternalEmissivity</code></td><td>Real</td><td>裸露本体发射率；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>BusDeckHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>内部设备舱板热容；Excel工程单位J/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>ExternalShellHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>外表面热容；Excel工程单位J/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>ShellToBusConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>外壳-舱板导热；Excel工程单位W/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={196,94,56}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="System record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-33.6,-9.6},{9,33.6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Line(points={{-28.8,-2.4},{-21.6,-2.4},{-21.6,26.4},{-13.8,26.4},{-13.8,-2.4},{-6,-2.4},{-6,26.4},{1.8,26.4},{1.8,-2.4},{7.2,-2.4}}, color={196,94,56}, thickness=1, pattern=LinePattern.Solid),
      Rectangle(extent={{14.4,-9.6},{27.6,33.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{15,-4.8},{26.4,-4.8}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{15,2.4},{26.4,2.4}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{15,9.6},{26.4,9.6}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{15,16.8},{26.4,16.8}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{15,24},{26.4,24}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{15,31.2},{26.4,31.2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{29.4,0},{33.6,3},{37.2,0},{40.8,3}}, color={196,94,56}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{29.4,15},{33.6,18},{37.2,15},{40.8,18}}, color={196,94,56}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{29.4,30},{33.6,33},{37.2,30},{40.8,33}}, color={196,94,56}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{-40.8,-2.4},{-33.6,-2.4}}, color={77,126,172}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-40.8,26.4},{-33.6,26.4}}, color={77,126,172}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Overall Thermal Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={196,94,56}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="System record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-33.6,-9.6},{9,33.6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Line(points={{-28.8,-2.4},{-21.6,-2.4},{-21.6,26.4},{-13.8,26.4},{-13.8,-2.4},{-6,-2.4},{-6,26.4},{1.8,26.4},{1.8,-2.4},{7.2,-2.4}}, color={196,94,56}, thickness=1, pattern=LinePattern.Solid),
      Rectangle(extent={{14.4,-9.6},{27.6,33.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{15,-4.8},{26.4,-4.8}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{15,2.4},{26.4,2.4}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{15,9.6},{26.4,9.6}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{15,16.8},{26.4,16.8}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{15,24},{26.4,24}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{15,31.2},{26.4,31.2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{29.4,0},{33.6,3},{37.2,0},{40.8,3}}, color={196,94,56}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{29.4,15},{33.6,18},{37.2,15},{40.8,18}}, color={196,94,56}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{29.4,30},{33.6,33},{37.2,30},{40.8,33}}, color={196,94,56}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{-40.8,-2.4},{-33.6,-2.4}}, color={77,126,172}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-40.8,26.4},{-33.6,26.4}}, color={77,126,172}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Overall Thermal Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));
end OverallComponentConfig;