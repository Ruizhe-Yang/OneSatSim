within OneSatSim.Foundation.Models;
model MissionOpportunityGenerator "原始机会与活动对象几何生成器"
  parameter OneSatSim.Foundation.Types.ImagingCapabilities imagingCapabilities
    "成像Capabilities；Capability and timing shared with camera, AOCS and sequencer";
  final parameter Real requiredImagingOpportunityTime(unit="s")=
    imagingCapabilities.requiredOpportunityTime_s
    "required成像Opportunity时间 [s]；Pre-slew, camera preparation, pointing dwell, exposure, store, shutdown and margin";
  parameter Real requiredDownlinkOpportunityTime(unit="s")=30
    "上电、初始化、主视轴驻留、建链、最小有效发送和关机余量";
  OneSatSim.Foundation.Interfaces.EnvironmentPort environment  "外部环境接口或实例" annotation(Placement(visible=true, transformation(origin={-185,0}, extent={{-14,-14},{14,14}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.OpportunitySignals opportunity  "计算/接口量 opportunity" annotation(Placement(visible=true, transformation(origin={185,16}, extent={{-14,-14},{14,14}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.ActiveGeometrySignals activeGeometry  "激活几何" annotation(Placement(visible=true, transformation(origin={185,-16}, extent={{-14,-14},{14,14}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-12,-12},{12,12}}, rotation=0)));
protected
  discrete Integer targetWindow(start=0,fixed=true) "目标Window" ;
  discrete Integer groundWindow(start=0,fixed=true) "地面Window" ;
equation
  opportunity.imagingOpportunity=environment.earlyTargetPrePointOpportunity;
  opportunity.downlinkOpportunity=environment.groundPrePointOpportunity;
  opportunity.targetPrePointOpportunity=environment.targetPrePointOpportunity;
  opportunity.earlyTargetPrePointOpportunity=environment.earlyTargetPrePointOpportunity;
  opportunity.groundPrePointOpportunity=environment.groundPrePointOpportunity;
  opportunity.imagingOpportunityTimeRemaining=environment.targetOpportunityTimeRemaining;
  opportunity.downlinkOpportunityTimeRemaining=environment.groundOpportunityTimeRemaining;
  opportunity.imagingOpportunityFeasible=environment.earlyTargetPrePointOpportunity and 
    environment.targetOpportunityTimeRemaining >= requiredImagingOpportunityTime;
  opportunity.downlinkOpportunityFeasible=environment.groundPrePointOpportunity and 
    environment.groundOpportunityTimeRemaining >= requiredDownlinkOpportunityTime;
  opportunity.targetPrePointIndex=environment.targetPrePointIndex;
  opportunity.earlyTargetPrePointIndex=environment.earlyTargetPrePointIndex;
  opportunity.groundPrePointIndex=environment.groundPrePointIndex;
  opportunity.targetWindowId=targetWindow;
  opportunity.groundWindowId=groundWindow;
  opportunity.eclipse=environment.eclipse;
  opportunity.sunlightAvailable=not environment.eclipse and environment.solarFlux > 100;
  opportunity.groundContact=environment.groundContact;
  opportunity.targetVisible=environment.targetVisible;
  opportunity.groundStationIndex=environment.groundStationIndex;
  opportunity.targetIndex=environment.targetIndex;
  activeGeometry.activeTargetVisible=environment.activeTargetVisible;
  activeGeometry.activeTargetPreparationOpportunity=environment.activeTargetPreparationOpportunity;
  activeGeometry.activeTargetEarlyPrePointOpportunity=environment.activeTargetEarlyPrePointOpportunity;
  activeGeometry.activeGroundContact=environment.activeGroundContact;
  activeGeometry.targetElevationRate=environment.targetElevationRate;
  activeGeometry.groundElevationRate=environment.groundElevationRate;
  activeGeometry.targetElevationIncreasing=environment.targetElevationIncreasing;
  activeGeometry.groundElevationIncreasing=environment.groundElevationIncreasing;
  activeGeometry.offNadirAngle=environment.offNadirAngle;
  activeGeometry.cameraLookAngle=environment.cameraLookAngle;
  activeGeometry.targetSunElevation=environment.targetSunElevation;
  activeGeometry.offNadirValid=environment.offNadirValid;
  activeGeometry.cameraFOVValid=environment.cameraFOVValid;
  activeGeometry.targetIlluminationValid=environment.targetIlluminationValid;
  activeGeometry.imagingValid=environment.imagingValid;
algorithm
  when initial() then
    targetWindow:=0;
    groundWindow:=0;
  elsewhen edge(environment.earlyTargetPrePointOpportunity) or 
      (environment.earlyTargetPrePointOpportunity and change(environment.earlyTargetPrePointIndex)) then
    targetWindow:=pre(targetWindow)+1;
  elsewhen edge(environment.groundPrePointOpportunity) or 
      (environment.groundPrePointOpportunity and change(environment.groundPrePointIndex)) then
    groundWindow:=pre(groundWindow)+1;
  end when;
  annotation(Documentation(info="<html><h2>原始机会与活动对象几何生成器</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Models.MissionOpportunityGenerator</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>原始机会与活动对象几何生成器</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.MissionControlUnit\">OneSatSim.Components.MissionControlUnit</a> 的 <code>opportunity</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>environment</code></td><td>OneSatSim.Foundation.Interfaces.EnvironmentPort</td><td>public</td><td>按声明/类型合同</td><td>外部环境接口或实例</td></tr><tr><td><code>opportunity</code></td><td>OneSatSim.Foundation.Interfaces.OpportunitySignals</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 opportunity</td></tr><tr><td><code>activeGeometry</code></td><td>OneSatSim.Foundation.Interfaces.ActiveGeometrySignals</td><td>public</td><td>按声明/类型合同</td><td>激活几何</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>imagingCapabilities</code></td><td>OneSatSim.Foundation.Types.ImagingCapabilities</td><td>成像Capabilities；Capability and timing shared with camera, AOCS and sequencer</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>requiredImagingOpportunityTime</code></td><td>Real</td><td>required成像Opportunity时间 [s]；Pre-slew, camera preparation, pointing dwell, exposure, store, shutdown and margin</td><td><code>= imagingCapabilities.requiredOpportunityTime_s</code></td></tr><tr><td><code>requiredDownlinkOpportunityTime</code></td><td>Real</td><td>上电、初始化、主视轴驻留、建链、最小有效发送和关机余量</td><td><code>=30</code></td></tr></table><h3>状态与初始化</h3><p>本类源码中显式出现的导数对象或离散声明：<code>targetWindow, groundWindow</code>。初始化取当前声明的 start/fixed、initial 方程/算法及继承设置。此处是源码级说明，不等同于编译后连续状态统计。</p><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] opportunity.imagingOpportunity=environment.earlyTargetPrePointOpportunity;\n[equation] opportunity.downlinkOpportunity=environment.groundPrePointOpportunity;\n[equation] opportunity.targetPrePointOpportunity=environment.targetPrePointOpportunity;\n[equation] opportunity.earlyTargetPrePointOpportunity=environment.earlyTargetPrePointOpportunity;\n[equation] opportunity.groundPrePointOpportunity=environment.groundPrePointOpportunity;\n[equation] opportunity.imagingOpportunityTimeRemaining=environment.targetOpportunityTimeRemaining;\n[equation] opportunity.downlinkOpportunityTimeRemaining=environment.groundOpportunityTimeRemaining;\n[equation] opportunity.imagingOpportunityFeasible=environment.earlyTargetPrePointOpportunity and environment.targetOpportunityTimeRemaining &gt;= requiredImagingOpportunityTime;\n[equation] opportunity.downlinkOpportunityFeasible=environment.groundPrePointOpportunity and environment.groundOpportunityTimeRemaining &gt;= requiredDownlinkOpportunityTime;\n[equation] opportunity.targetPrePointIndex=environment.targetPrePointIndex;</pre><p>本类另有30段语句；阅读完整源码可查看其余边界与逻辑。</p><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>targetWindow</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>目标Window</td></tr><tr><td><code>groundWindow</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>地面Window</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Ellipse(extent={{-42.2,-16.32},{-3.32,22.56}}, lineColor={0,0,0}, fillColor={239,246,250}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-30.536,-16.32},{-14.984,22.56}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Ellipse(extent={{-42.2,-3.684},{-3.32,9.924}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Line(points={{-42.2,3.12},{-3.32,3.12}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-22.76,-16.32},{-22.76,22.56}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-65.24,-19.92},{28.36,37.68}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.7, startAngle=0, endAngle=360),
      Rectangle(extent={{12.52,21.12},{19.72,28.32}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Rectangle(extent={{6.76,21.84},{11.8,27.6}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{20.44,21.84},{25.48,27.6}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{16.12,21.12},{-14.84,13.92}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Line(points={{16.12,21.12},{-6.2,-4.08}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Ellipse(extent={{-17,11.76},{-12.68,16.08}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Ellipse(extent={{-8.36,-6.24},{-4.04,-1.92}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Rectangle(extent={{43,-31},{72,28}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{47,15},{68,15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,0},{68,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,-15},{68,-15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-57,-51},{37,-34}}, textString="window / budget", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Mission Opportunities", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-230,-89.8},{230,133.8}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-51.62,-56.26},{51.62,55.1}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-44.08,37.12},{44.08,37.12}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-48.72,40.02},{-37.12,51.62}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-35.38,41.18},{44.08,49.88}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Ellipse(extent={{-24.476,-9.4656},{-1.9256,13.0848}}, lineColor={0,0,0}, fillColor={239,246,250}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-17.7109,-9.4656},{-8.6907,13.0848}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Ellipse(extent={{-24.476,-2.1367},{-1.9256,5.7559}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Line(points={{-24.476,1.8096},{-1.9256,1.8096}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-13.2008,-9.4656},{-13.2008,13.0848}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-37.8392,-11.5536},{16.4488,21.8544}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.7, startAngle=0, endAngle=360),
      Rectangle(extent={{7.2616,12.2496},{11.4376,16.4256}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Rectangle(extent={{3.9208,12.6672},{6.844,16.008}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{11.8552,12.6672},{14.7784,16.008}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{9.3496,12.2496},{-8.6072,8.0736}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Line(points={{9.3496,12.2496},{-3.596,-2.3664}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Ellipse(extent={{-9.86,6.8208},{-7.3544,9.3264}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Ellipse(extent={{-4.8488,-3.6192},{-2.3432,-1.1136}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Rectangle(extent={{24.94,-17.98},{41.76,16.24}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{27.26,8.7},{39.44,8.7}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{27.26,0},{39.44,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{27.26,-8.7},{39.44,-8.7}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-33.06,-29.58},{21.46,-19.72}}, textString="window / budget", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-44.08,-33.64},{44.08,-33.64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-46.4,-45.82},{46.4,-37.12}}, textString="Mission Opportunities", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-218,88.8},{218,117.8}}, textString="Mission Opportunity Generator", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-218,80.8},{218,80.8}}, color={215,220,226}, thickness=0.25)
    }));
end MissionOpportunityGenerator;