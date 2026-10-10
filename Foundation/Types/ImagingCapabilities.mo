within OneSatSim.Foundation.Types;
record ImagingCapabilities "Single-source Earth-camera image capability"
  parameter Real storedImageBytes(unit="1") "配置项 storedImageBytes [1]；Compressed bytes for one complete image";
  parameter Real captureDuration_s(unit="s") "配置项 captureDuration_s [s]；Required exposure and write duration";
  parameter Real preSlewDuration_s(unit="s")=96 "配置项 preSlewDuration_s [s]；Target pre-slew budget";
  parameter Real powerOnTime_s(unit="s")=2 "功率On时间s [s]；Camera power-on sequence";
  parameter Real initializationTime_s(unit="s")=5 "initialization时间s [s]；Camera initialization";
  parameter Real attitudeDwell_s(unit="s")=8 "姿态Dwells [s]；AOCS continuous pointing dwell";
  parameter Real storeTime_s(unit="s")=1 "store时间s [s]；Post-exposure store sequence";
  parameter Real powerOffTime_s(unit="s")=2 "功率Off时间s [s]；Camera power-off sequence";
  parameter Real planningMargin_s(unit="s")=2 "配置项 planningMargin_s [s]；Opportunity forecast margin";
  final parameter Real nominalWriteRate_Bps(unit="1/s")=
    storedImageBytes/captureDuration_s "nominalWrite速率Bps [1/s]；Requested payload bytes per second";
  final parameter Real requiredOpportunityTime_s(unit="s")=
    preSlewDuration_s+powerOnTime_s+initializationTime_s+attitudeDwell_s+
    captureDuration_s+storeTime_s+powerOffTime_s+planningMargin_s "requiredOpportunity时间s [s]" ;
  annotation(Documentation(info="<html><h2>成像Capabilities</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Types.ImagingCapabilities</code>　<b>类型：</b>record</p><h3>用途与定位</h3><p>成像Capabilities。原源码功能描述：Single-source Earth-camera image capability</p><h3>配置与调用</h3><p>由使用者声明或传入本类型；记录与常量保存静态配置，不单独代表一套物理状态。修改设计输入后应通过项目既有离线配置入口生成生效快照。</p><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>storedImageBytes</code></td><td>Real</td><td>配置项 storedImageBytes [1]；Compressed bytes for one complete image</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>captureDuration_s</code></td><td>Real</td><td>配置项 captureDuration_s [s]；Required exposure and write duration</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>preSlewDuration_s</code></td><td>Real</td><td>配置项 preSlewDuration_s [s]；Target pre-slew budget</td><td><code>=96</code></td></tr><tr><td><code>powerOnTime_s</code></td><td>Real</td><td>功率On时间s [s]；Camera power-on sequence</td><td><code>=2</code></td></tr><tr><td><code>initializationTime_s</code></td><td>Real</td><td>initialization时间s [s]；Camera initialization</td><td><code>=5</code></td></tr><tr><td><code>attitudeDwell_s</code></td><td>Real</td><td>姿态Dwells [s]；AOCS continuous pointing dwell</td><td><code>=8</code></td></tr><tr><td><code>storeTime_s</code></td><td>Real</td><td>store时间s [s]；Post-exposure store sequence</td><td><code>=1</code></td></tr><tr><td><code>powerOffTime_s</code></td><td>Real</td><td>功率Off时间s [s]；Camera power-off sequence</td><td><code>=2</code></td></tr><tr><td><code>planningMargin_s</code></td><td>Real</td><td>配置项 planningMargin_s [s]；Opportunity forecast margin</td><td><code>=2</code></td></tr><tr><td><code>nominalWriteRate_Bps</code></td><td>Real</td><td>nominalWrite速率Bps [1/s]；Requested payload bytes per second</td><td><code>= storedImageBytes/captureDuration_s</code></td></tr><tr><td><code>requiredOpportunityTime_s</code></td><td>Real</td><td>requiredOpportunity时间s [s]</td><td><code>= preSlewDuration_s+powerOnTime_s+initializationTime_s+attitudeDwell_s+ captureDuration_s+storeTime_s+powerOffTime_s+planningMargin_s</code></td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={152,118,71}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Type definition", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
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
      Text(extent={{-80,-91},{80,-65}}, textString="Imaging Capabilities", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={152,118,71}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Type definition", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
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
      Text(extent={{-80,-91},{80,-65}}, textString="Imaging Capabilities", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));
end ImagingCapabilities;