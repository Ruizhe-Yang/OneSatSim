within OneSatSim.Scenarios;
record ScenarioConfig "完整静态场景配置"
  parameter OneSatSim.Foundation.Types.MassProperties massProperties
    "由活动机械刚体离线汇总的统一整星质量、质心与惯量";
  parameter Boolean operationalSnapshotStart
    "从已进入稳定在轨运行状态的快照开始24 h试验";
  parameter Modelica.Units.SI.Time targetPredictionHorizon
    "包含线性化余量的目标准备预测时域";
  parameter Modelica.Units.SI.Time earlyTargetPredictionHorizon
    "提前预机动预测时域";
  parameter OrbitConfig orbit "真实历元轨道输入及生成环境资源" ;
  parameter GroundStationConfig groundStations[8] "最多8个地面站" ;
  parameter ImagingTargetConfig imagingTargets[32] "最多32个拍摄目标" ;
  parameter InitialConditionConfig initialConditions "场景初始条件" ;
  annotation(Documentation(info="<html><h2>完整静态场景配置</h2><p><b>类路径：</b><code>OneSatSim.Scenarios.ScenarioConfig</code>　<b>类型：</b>record</p><h3>用途与定位</h3><p>完整静态场景配置</p><h3>配置与调用</h3><p>由使用者声明或传入本类型；记录与常量保存静态配置，不单独代表一套物理状态。修改设计输入后应通过项目既有离线配置入口生成生效快照。</p><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>massProperties</code></td><td>OneSatSim.Foundation.Types.MassProperties</td><td>由活动机械刚体离线汇总的统一整星质量、质心与惯量</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>operationalSnapshotStart</code></td><td>Boolean</td><td>从已进入稳定在轨运行状态的快照开始24 h试验</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>targetPredictionHorizon</code></td><td>Modelica.Units.SI.Time</td><td>包含线性化余量的目标准备预测时域</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>earlyTargetPredictionHorizon</code></td><td>Modelica.Units.SI.Time</td><td>提前预机动预测时域</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>orbit</code></td><td>OrbitConfig</td><td>真实历元轨道输入及生成环境资源</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>groundStations[8]</code></td><td>GroundStationConfig</td><td>最多8个地面站</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>imagingTargets[32]</code></td><td>ImagingTargetConfig</td><td>最多32个拍摄目标</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>initialConditions</code></td><td>InitialConditionConfig</td><td>场景初始条件</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table></html>"),
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
      Line(points={{24.6,24.6},{-1.2,18.6}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Line(points={{24.6,24.6},{6,3.6}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Ellipse(extent={{-3,16.8},{0.6,20.4}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Ellipse(extent={{4.2,1.8},{7.8,5.4}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Mission Scenario", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
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
      Line(points={{24.6,24.6},{-1.2,18.6}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Line(points={{24.6,24.6},{6,3.6}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Ellipse(extent={{-3,16.8},{0.6,20.4}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Ellipse(extent={{4.2,1.8},{7.8,5.4}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Mission Scenario", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));
end ScenarioConfig;