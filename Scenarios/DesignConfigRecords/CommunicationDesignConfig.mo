within OneSatSim.Scenarios.DesignConfigRecords;
record CommunicationDesignConfig "communication分系统设计配置"
  parameter AntennaComponentConfig antenna "配置项 antenna" ;
  parameter BasebandComponentConfig baseband "配置项 baseband" ;
  parameter TtcReceiverComponentConfig ttcReceiver "配置项 ttcReceiver" ;
  parameter XbandComponentConfig xband "配置项 xband" ;
  annotation(Documentation(info="<html><h2>communication分系统设计配置</h2><p><b>类路径：</b><code>OneSatSim.Scenarios.DesignConfigRecords.CommunicationDesignConfig</code>　<b>类型：</b>record</p><h3>用途与定位</h3><p>communication分系统设计配置</p><h3>配置与调用</h3><p>由使用者声明或传入本类型；记录与常量保存静态配置，不单独代表一套物理状态。修改设计输入后应通过项目既有离线配置入口生成生效快照。</p><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>antenna</code></td><td>AntennaComponentConfig</td><td>配置项 antenna</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>baseband</code></td><td>BasebandComponentConfig</td><td>配置项 baseband</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>ttcReceiver</code></td><td>TtcReceiverComponentConfig</td><td>配置项 ttcReceiver</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>xband</code></td><td>XbandComponentConfig</td><td>配置项 xband</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="System record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-28.2,2.85},{-0.75,25.35}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Rectangle(extent={{-24.6,6.9},{-4.8,20.85}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Polygon(points={{-19.65,9.6},{-19.65,19.05},{-10.65,14.1},{-19.65,9.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{-25.95,14.1},{-19.65,14.1}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-10.65,14.1},{-1.2,14.1}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-0.3,14.1},{13.2,14.1},{13.2,28.5}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Polygon(points={{7.35,33},{13.2,24.9},{19.05,33},{7.35,33}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Ellipse(extent={{6.45,18.15},{19.95,31.65}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.65, startAngle=-35, endAngle=35),
      Ellipse(extent={{2.4,14.1},{24,35.7}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.65, startAngle=-35, endAngle=35),
      Ellipse(extent={{-1.65,10.05},{28.05,39.75}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.65, startAngle=-35, endAngle=35),
      Line(points={{6.45,1.05},{26.7,1.05}}, color={73,112,158}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Text(extent={{-25.05,27.6},{-14.7,37.05}}, textString="X", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Line(points={{-39,-13.8},{33,-13.8}}, color={83,131,109}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Communication Design", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="System record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-28.2,2.85},{-0.75,25.35}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Rectangle(extent={{-24.6,6.9},{-4.8,20.85}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Polygon(points={{-19.65,9.6},{-19.65,19.05},{-10.65,14.1},{-19.65,9.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{-25.95,14.1},{-19.65,14.1}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-10.65,14.1},{-1.2,14.1}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-0.3,14.1},{13.2,14.1},{13.2,28.5}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Polygon(points={{7.35,33},{13.2,24.9},{19.05,33},{7.35,33}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Ellipse(extent={{6.45,18.15},{19.95,31.65}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.65, startAngle=-35, endAngle=35),
      Ellipse(extent={{2.4,14.1},{24,35.7}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.65, startAngle=-35, endAngle=35),
      Ellipse(extent={{-1.65,10.05},{28.05,39.75}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.65, startAngle=-35, endAngle=35),
      Line(points={{6.45,1.05},{26.7,1.05}}, color={73,112,158}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Text(extent={{-25.05,27.6},{-14.7,37.05}}, textString="X", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Line(points={{-39,-13.8},{33,-13.8}}, color={83,131,109}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Communication Design", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));
end CommunicationDesignConfig;