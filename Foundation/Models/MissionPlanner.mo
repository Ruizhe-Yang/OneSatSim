within OneSatSim.Foundation.Models;
model MissionPlanner "对象感知的任务规划器"
  OneSatSim.Foundation.Interfaces.OpportunitySignals opportunity  "计算/接口量 opportunity" annotation(Placement(visible=true, transformation(origin={-185,16}, extent={{-14,-14},{14,14}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.MissionFeedbackBus feedback  "反馈" annotation(Placement(visible=true, transformation(origin={-185,-16}, extent={{-14,-14},{14,14}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.PlannerRequestSignals request  "请求" annotation(Placement(visible=true, transformation(origin={185,0}, extent={{-14,-14},{14,14}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
protected
  OneSatSim.Foundation.Types.CommandType candidate "计算/接口量 candidate" ;
  Integer candidateTarget "candidate目标" ;
  Integer candidateStation "candidate站点" ;
  Integer candidateWindow "计算/接口量 candidateWindow" ;
  Integer id "用户定义的正整数标识" ;
equation
  candidate=if opportunity.imagingOpportunityFeasible and not feedback.storageHigh then 
      OneSatSim.Foundation.Types.CommandType.Imaging else 
    if opportunity.downlinkOpportunityFeasible and feedback.dataAvailable then 
      OneSatSim.Foundation.Types.CommandType.Downlink else 
      OneSatSim.Foundation.Types.CommandType.None;
  candidateTarget=if candidate == OneSatSim.Foundation.Types.CommandType.Imaging then opportunity.earlyTargetPrePointIndex else 0;
  candidateStation=if candidate == OneSatSim.Foundation.Types.CommandType.Downlink then opportunity.groundPrePointIndex else 0;
  candidateWindow=if candidate == OneSatSim.Foundation.Types.CommandType.Imaging then opportunity.targetWindowId else 
    if candidate == OneSatSim.Foundation.Types.CommandType.Downlink then opportunity.groundWindowId else 0;
  id=if candidate == OneSatSim.Foundation.Types.CommandType.Imaging then 1000000+1000*candidateWindow+candidateTarget else 
    if candidate == OneSatSim.Foundation.Types.CommandType.Downlink then 2000000+1000*candidateWindow+candidateStation else 0;
  request.requestedCommand=candidate;
  request.requestedTargetIndex=candidateTarget;
  request.requestedGroundStationIndex=candidateStation;
  request.requestWindowId=candidateWindow;
  request.requestValid=candidate <> OneSatSim.Foundation.Types.CommandType.None;
  request.requestId=id;
  request.planningRejectReason=if opportunity.earlyTargetPrePointOpportunity and not opportunity.imagingOpportunityFeasible then 
      OneSatSim.Foundation.Types.RejectReason.InsufficientOpportunityTime else 
    if opportunity.groundPrePointOpportunity and not opportunity.downlinkOpportunityFeasible then 
      OneSatSim.Foundation.Types.RejectReason.InsufficientOpportunityTime else 
      OneSatSim.Foundation.Types.RejectReason.None;
  request.requestedOpportunityTimeRemaining=if candidate == OneSatSim.Foundation.Types.CommandType.Imaging then opportunity.imagingOpportunityTimeRemaining else 
    if candidate == OneSatSim.Foundation.Types.CommandType.Downlink then opportunity.downlinkOpportunityTimeRemaining else 
    max(opportunity.imagingOpportunityTimeRemaining,opportunity.downlinkOpportunityTimeRemaining);
  annotation(Documentation(info="<html><h2>对象感知的任务规划器</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Models.MissionPlanner</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>对象感知的任务规划器</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.MissionControlUnit\">OneSatSim.Components.MissionControlUnit</a> 的 <code>planner</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>opportunity</code></td><td>OneSatSim.Foundation.Interfaces.OpportunitySignals</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 opportunity</td></tr><tr><td><code>feedback</code></td><td>OneSatSim.Foundation.Interfaces.MissionFeedbackBus</td><td>public</td><td>按声明/类型合同</td><td>反馈</td></tr><tr><td><code>request</code></td><td>OneSatSim.Foundation.Interfaces.PlannerRequestSignals</td><td>public</td><td>按声明/类型合同</td><td>请求</td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] candidate=if opportunity.imagingOpportunityFeasible and not feedback.storageHigh then OneSatSim.Foundation.Types.CommandType.Imaging else if opportunity.downlinkOpportunityFeasible and feedback.dataAvailable then OneSatSim.Foundation.Types.CommandType.Downlink else OneSatSim.Foundation.Types.CommandType.None;\n[equation] candidateTarget=if candidate == OneSatSim.Foundation.Types.CommandType.Imaging then opportunity.earlyTargetPrePointIndex else 0;\n[equation] candidateStation=if candidate == OneSatSim.Foundation.Types.CommandType.Downlink then opportunity.groundPrePointIndex else 0;\n[equation] candidateWindow=if candidate == OneSatSim.Foundation.Types.CommandType.Imaging then opportunity.targetWindowId else if candidate == OneSatSim.Foundation.Types.CommandType.Downlink then opportunity.groundWindowId else 0;\n[equation] id=if candidate == OneSatSim.Foundation.Types.CommandType.Imaging then 1000000+1000*candidateWindow+candidateTarget else if candidate == OneSatSim.Foundation.Types.CommandType.Downlink then 2000000+1000*candidateWindow+candidateStation else 0;\n[equation] request.requestedCommand=candidate;\n[equation] request.requestedTargetIndex=candidateTarget;\n[equation] request.requestedGroundStationIndex=candidateStation;\n[equation] request.requestWindowId=candidateWindow;\n[equation] request.requestValid=candidate &lt;&gt; OneSatSim.Foundation.Types.CommandType.None;</pre><p>本类另有3段语句；阅读完整源码可查看其余边界与逻辑。</p><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>candidate</code></td><td>OneSatSim.Foundation.Types.CommandType</td><td>protected</td><td>按声明/类型合同</td><td>计算/接口量 candidate</td></tr><tr><td><code>candidateTarget</code></td><td>Integer</td><td>protected</td><td>按声明/类型合同</td><td>candidate目标</td></tr><tr><td><code>candidateStation</code></td><td>Integer</td><td>protected</td><td>按声明/类型合同</td><td>candidate站点</td></tr><tr><td><code>candidateWindow</code></td><td>Integer</td><td>protected</td><td>按声明/类型合同</td><td>计算/接口量 candidateWindow</td></tr><tr><td><code>id</code></td><td>Integer</td><td>protected</td><td>按声明/类型合同</td><td>用户定义的正整数标识</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-72,23},{-29,23},{0,1}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-72,-23},{-29,-23},{0,1}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Polygon(points={{0,23},{23,1},{0,-21},{-23,1},{0,23}}, lineColor={0,0,0}, fillColor={239,232,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{23,1},{38,1},{38,26},{65,26}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{38,1},{38,-27},{65,-27}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{58,34},{63,30},{71,40}}, color={83,131,109}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{60,-40},{70,-30}}, color={196,94,56}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{60,-30},{70,-40}}, color={196,94,56}, thickness=0.8, pattern=LinePattern.Solid),
      Text(extent={{-45,-50},{28,-34}}, textString="PLAN", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Mission Planner", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-230,-89.8},{230,133.8}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-51.62,-56.26},{51.62,55.1}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-44.08,37.12},{44.08,37.12}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-48.72,40.02},{-37.12,51.62}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-35.38,41.18},{44.08,49.88}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-41.76,13.34},{-16.82,13.34},{0,0.58}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-41.76,-13.34},{-16.82,-13.34},{0,0.58}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Polygon(points={{0,13.34},{13.34,0.58},{0,-12.18},{-13.34,0.58},{0,13.34}}, lineColor={0,0,0}, fillColor={239,232,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{13.34,0.58},{22.04,0.58},{22.04,15.08},{37.7,15.08}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{22.04,0.58},{22.04,-15.66},{37.7,-15.66}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{33.64,19.72},{36.54,17.4},{41.18,23.2}}, color={83,131,109}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{34.8,-23.2},{40.6,-17.4}}, color={196,94,56}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{34.8,-17.4},{40.6,-23.2}}, color={196,94,56}, thickness=0.8, pattern=LinePattern.Solid),
      Text(extent={{-26.1,-29},{16.24,-19.72}}, textString="PLAN", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-44.08,-33.64},{44.08,-33.64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-46.4,-45.82},{46.4,-37.12}}, textString="Mission Planner", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-218,88.8},{218,117.8}}, textString="Mission Planner", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-218,80.8},{218,80.8}}, color={215,220,226}, thickness=0.25)
    }));
end MissionPlanner;