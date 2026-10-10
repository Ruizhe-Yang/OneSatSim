within OneSatSim.Scenarios;
record GroundStationConfig "单个地面站配置"
  import SI=Modelica.Units.SI;
  parameter Boolean enabled "是否参与可见性计算";
  parameter Integer id "用户定义的正整数标识";
  parameter String name "地面站名称";
  parameter SI.Angle latitude "地理纬度";
  parameter SI.Angle longitude "地理经度";
  parameter SI.Length altitude "海拔高度";
  parameter SI.Angle minimumElevation "最低仰角";
  parameter Integer priority "选择优先级；数值越大越优先";
  annotation(Documentation(info="<html><h2>单个地面站配置</h2><p><b>类路径：</b><code>OneSatSim.Scenarios.GroundStationConfig</code>　<b>类型：</b>record</p><h3>用途与定位</h3><p>单个地面站配置</p><h3>配置与调用</h3><p>由使用者声明或传入本类型；记录与常量保存静态配置，不单独代表一套物理状态。修改设计输入后应通过项目既有离线配置入口生成生效快照。</p><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>enabled</code></td><td>Boolean</td><td>是否参与可见性计算</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>id</code></td><td>Integer</td><td>用户定义的正整数标识</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>name</code></td><td>String</td><td>地面站名称</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>latitude</code></td><td>SI.Angle</td><td>地理纬度</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>longitude</code></td><td>SI.Angle</td><td>地理经度</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>altitude</code></td><td>SI.Length</td><td>海拔高度</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>minimumElevation</code></td><td>SI.Angle</td><td>最低仰角</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>priority</code></td><td>Integer</td><td>选择优先级；数值越大越优先</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Configuration", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Polygon(points={{-25.8,24},{12.6,30},{25.8,15},{-13.8,7.8},{-25.8,24}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-16.2,22.2},{9,25.8},{16.2,17.4},{-8.4,12.6},{-16.2,22.2}}, lineColor={0,0,0}, fillColor={229,239,245}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{-3,9.6},{-3,-4.8}}, color={0,0,0}, thickness=1, pattern=LinePattern.Solid),
      Rectangle(extent={{-15.6,-8.4},{10.8,-4.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{-8.4,32.4},{-8.4,41.4}}, color={73,112,158}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{3,33.6},{7.2,43.8}}, color={73,112,158}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{15,30.6},{22.8,39}}, color={73,112,158}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Ground Station Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Configuration", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Polygon(points={{-25.8,24},{12.6,30},{25.8,15},{-13.8,7.8},{-25.8,24}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-16.2,22.2},{9,25.8},{16.2,17.4},{-8.4,12.6},{-16.2,22.2}}, lineColor={0,0,0}, fillColor={229,239,245}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{-3,9.6},{-3,-4.8}}, color={0,0,0}, thickness=1, pattern=LinePattern.Solid),
      Rectangle(extent={{-15.6,-8.4},{10.8,-4.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{-8.4,32.4},{-8.4,41.4}}, color={73,112,158}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{3,33.6},{7.2,43.8}}, color={73,112,158}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{15,30.6},{22.8,39}}, color={73,112,158}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Ground Station Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));
end GroundStationConfig;