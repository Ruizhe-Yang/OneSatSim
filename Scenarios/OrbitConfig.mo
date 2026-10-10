within OneSatSim.Scenarios;
record OrbitConfig "真实历元轨道输入与生成环境配置"
  import SI=Modelica.Units.SI;
  parameter SI.Length semiMajorAxis "半长轴";
  parameter Real eccentricity "偏心率";
  parameter SI.Angle inclination "倾角";
  parameter SI.Angle initialRAAN "初始升交点赤经";
  parameter SI.Angle initialMeanAnomaly "初始平近点角";
  parameter SI.Angle argumentOfPerigee "近地点幅角";
  parameter SI.Time initialEpoch "相对仿真初始时刻的轨道历元";
  parameter String stateInputMode "Cartesian或Keplerian；由生成器严格校验";
  parameter String stateFrame "输入状态坐标系；本实现仅支持GCRS";
  parameter String simulationStartUTC "规范化UTC仿真起始时刻";
  parameter String stateEpochUTC "输入状态对应的规范化UTC历元";
  parameter SI.Position inputPosition[3] "状态历元处的GCRS输入位置";
  parameter SI.Velocity inputVelocity[3] "状态历元处的GCRS输入速度";
  parameter SI.Position propagatedPositionAtStart[3] "传播到仿真起点的GCRS位置";
  parameter SI.Velocity propagatedVelocityAtStart[3] "传播到仿真起点的GCRS速度";
  parameter SI.Length referenceSemiMajorAxis "由生效起点状态推导的参考半长轴";
  parameter SI.Time simulationDuration "生成环境覆盖的仿真时长";
  parameter SI.Time environmentSampleInterval "环境表最终采样间隔";
  parameter Integer environmentTableRows(min=2) "环境表行数";
  annotation(Documentation(info="<html><h2>真实历元轨道输入与生成环境配置</h2><p><b>类路径：</b><code>OneSatSim.Scenarios.OrbitConfig</code>　<b>类型：</b>record</p><h3>用途与定位</h3><p>真实历元轨道输入与生成环境配置</p><h3>配置与调用</h3><p>由使用者声明或传入本类型；记录与常量保存静态配置，不单独代表一套物理状态。修改设计输入后应通过项目既有离线配置入口生成生效快照。</p><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>semiMajorAxis</code></td><td>SI.Length</td><td>半长轴</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>eccentricity</code></td><td>Real</td><td>偏心率</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>inclination</code></td><td>SI.Angle</td><td>倾角</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>initialRAAN</code></td><td>SI.Angle</td><td>初始升交点赤经</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>initialMeanAnomaly</code></td><td>SI.Angle</td><td>初始平近点角</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>argumentOfPerigee</code></td><td>SI.Angle</td><td>近地点幅角</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>initialEpoch</code></td><td>SI.Time</td><td>相对仿真初始时刻的轨道历元</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>stateInputMode</code></td><td>String</td><td>Cartesian或Keplerian；由生成器严格校验</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>stateFrame</code></td><td>String</td><td>输入状态坐标系；本实现仅支持GCRS</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>simulationStartUTC</code></td><td>String</td><td>规范化UTC仿真起始时刻</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>stateEpochUTC</code></td><td>String</td><td>输入状态对应的规范化UTC历元</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>inputPosition[3]</code></td><td>SI.Position</td><td>状态历元处的GCRS输入位置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>inputVelocity[3]</code></td><td>SI.Velocity</td><td>状态历元处的GCRS输入速度</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>propagatedPositionAtStart[3]</code></td><td>SI.Position</td><td>传播到仿真起点的GCRS位置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>propagatedVelocityAtStart[3]</code></td><td>SI.Velocity</td><td>传播到仿真起点的GCRS速度</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>referenceSemiMajorAxis</code></td><td>SI.Length</td><td>由生效起点状态推导的参考半长轴</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>simulationDuration</code></td><td>SI.Time</td><td>生成环境覆盖的仿真时长</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>environmentSampleInterval</code></td><td>SI.Time</td><td>环境表最终采样间隔</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>environmentTableRows</code></td><td>Integer</td><td>环境表行数</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Configuration", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Ellipse(extent={{-24,-6.6},{8.4,25.8}}, lineColor={0,0,0}, fillColor={239,246,250}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-14.28,-6.6},{-1.32,25.8}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Ellipse(extent={{-24,3.93},{8.4,15.27}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Line(points={{-24,9.6},{8.4,9.6}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-7.8,-6.6},{-7.8,25.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-43.2,-9.6},{34.8,38.4}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.7, startAngle=0, endAngle=360),
      Rectangle(extent={{21.6,24.6},{27.6,30.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Rectangle(extent={{16.8,25.2},{21,30}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{28.2,25.2},{32.4,30}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{32.4,15.6},{36.6,10.2},{34.8,4.8}}, color={73,112,158}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Orbit Configuration", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Configuration", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Ellipse(extent={{-24,-6.6},{8.4,25.8}}, lineColor={0,0,0}, fillColor={239,246,250}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-14.28,-6.6},{-1.32,25.8}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Ellipse(extent={{-24,3.93},{8.4,15.27}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Line(points={{-24,9.6},{8.4,9.6}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-7.8,-6.6},{-7.8,25.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-43.2,-9.6},{34.8,38.4}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.7, startAngle=0, endAngle=360),
      Rectangle(extent={{21.6,24.6},{27.6,30.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Rectangle(extent={{16.8,25.2},{21,30}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{28.2,25.2},{32.4,30}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{32.4,15.6},{36.6,10.2},{34.8,4.8}}, color={73,112,158}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Orbit Configuration", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));
end OrbitConfig;