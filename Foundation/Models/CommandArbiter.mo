within OneSatSim.Foundation.Models;
model CommandArbiter "任务请求的单入口事件锁存仲裁器"
  OneSatSim.Foundation.Interfaces.PlannerRequestSignals request  "请求" annotation(Placement(visible=true, transformation(origin={-185,16}, extent={{-14,-14},{14,14}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.SafetySignals safety  "计算/接口量 safety" annotation(Placement(visible=true, transformation(origin={-185,-16}, extent={{-14,-14},{14,14}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.ArbiterDecisionSignals decision  "计算/接口量 decision" annotation(Placement(visible=true, transformation(origin={185,0}, extent={{-14,-14},{14,14}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
protected
  discrete Integer decisionCounter(start=0,fixed=true) "计算/接口量 decisionCounter" ;
  discrete Integer lastHandledRequest(start=-999,fixed=true) "lastHandled请求" ;
  discrete Boolean acceptedLatch(start=false,fixed=true) "计算/接口量 acceptedLatch" ;
  discrete Boolean rejectedLatch(start=false,fixed=true) "计算/接口量 rejectedLatch" ;
  discrete OneSatSim.Foundation.Types.CommandType acceptedCommandLatch(
    start=OneSatSim.Foundation.Types.CommandType.None,fixed=true) "accepted指令Latch" ;
  discrete Integer acceptedCommandIdLatch(start=0,fixed=true) "accepted指令IdLatch" ;
  discrete Integer acceptedTargetLatch(start=0,fixed=true) "accepted目标Latch" ;
  discrete Integer acceptedStationLatch(start=0,fixed=true) "accepted站点Latch" ;
  discrete Real acceptedOpportunityTimeRemainingLatch(start=0,fixed=true) "acceptedOpportunity时间RemainingLatch" ;
  discrete OneSatSim.Foundation.Types.RejectReason rejectReasonLatch(
    start=OneSatSim.Foundation.Types.RejectReason.None,fixed=true) "计算/接口量 rejectReasonLatch" ;
equation
  decision.decisionId=decisionCounter;
  decision.accepted=acceptedLatch;
  decision.rejected=rejectedLatch;
  decision.acceptedCommand=acceptedCommandLatch;
  decision.acceptedCommandId=acceptedCommandIdLatch;
  decision.acceptedTargetIndex=acceptedTargetLatch;
  decision.acceptedGroundStationIndex=acceptedStationLatch;
  decision.acceptedOpportunityTimeRemaining=acceptedOpportunityTimeRemainingLatch;
  decision.rejectReason=rejectReasonLatch;
  decision.requestPending=request.requestValid and request.requestId <> lastHandledRequest;
algorithm
  when initial() then
    decisionCounter:=0;
    lastHandledRequest:=-999;
    acceptedLatch:=false;
    rejectedLatch:=false;
    acceptedCommandLatch:=OneSatSim.Foundation.Types.CommandType.None;
    acceptedCommandIdLatch:=0;
    acceptedTargetLatch:=0;
    acceptedStationLatch:=0;
    acceptedOpportunityTimeRemainingLatch:=0;
    rejectReasonLatch:=OneSatSim.Foundation.Types.RejectReason.None;
  elsewhen edge(safety.safeModeRequired) then
    decisionCounter:=pre(decisionCounter)+1;
    acceptedLatch:=true;
    rejectedLatch:=false;
    acceptedCommandLatch:=OneSatSim.Foundation.Types.CommandType.EnterSafeMode;
    acceptedCommandIdLatch:=-1;
    acceptedTargetLatch:=0;
    acceptedStationLatch:=0;
    acceptedOpportunityTimeRemainingLatch:=1e100;
    rejectReasonLatch:=OneSatSim.Foundation.Types.RejectReason.None;
  elsewhen change(request.requestId) then
    if request.requestValid and request.requestId <> pre(lastHandledRequest) then
      decisionCounter:=pre(decisionCounter)+1;
      lastHandledRequest:=request.requestId;
      acceptedLatch:=((request.requestedCommand == OneSatSim.Foundation.Types.CommandType.Imaging and safety.imagingAllowed) or 
         (request.requestedCommand == OneSatSim.Foundation.Types.CommandType.Downlink and safety.downlinkAllowed));
      rejectedLatch:=not (((request.requestedCommand == OneSatSim.Foundation.Types.CommandType.Imaging and safety.imagingAllowed) or 
         (request.requestedCommand == OneSatSim.Foundation.Types.CommandType.Downlink and safety.downlinkAllowed)));
      acceptedCommandLatch:=if ((request.requestedCommand == OneSatSim.Foundation.Types.CommandType.Imaging and safety.imagingAllowed) or 
         (request.requestedCommand == OneSatSim.Foundation.Types.CommandType.Downlink and safety.downlinkAllowed)) then request.requestedCommand 
        else OneSatSim.Foundation.Types.CommandType.None;
      acceptedCommandIdLatch:=request.requestId;
      acceptedTargetLatch:=request.requestedTargetIndex;
      acceptedStationLatch:=request.requestedGroundStationIndex;
      acceptedOpportunityTimeRemainingLatch:=request.requestedOpportunityTimeRemaining;
      rejectReasonLatch:=if request.requestedCommand == OneSatSim.Foundation.Types.CommandType.Imaging and not safety.imagingAllowed then safety.safetyReason else 
        if request.requestedCommand == OneSatSim.Foundation.Types.CommandType.Downlink and not safety.downlinkAllowed then safety.safetyReason else 
        OneSatSim.Foundation.Types.RejectReason.InvalidState;
    else
      acceptedLatch:=false;
      rejectedLatch:=false;
    end if;
  end when;
  annotation(Documentation(info="<html><h2>任务请求的单入口事件锁存仲裁器</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Models.CommandArbiter</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>任务请求的单入口事件锁存仲裁器</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.MissionControlUnit\">OneSatSim.Components.MissionControlUnit</a> 的 <code>arbiter</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>request</code></td><td>OneSatSim.Foundation.Interfaces.PlannerRequestSignals</td><td>public</td><td>按声明/类型合同</td><td>请求</td></tr><tr><td><code>safety</code></td><td>OneSatSim.Foundation.Interfaces.SafetySignals</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 safety</td></tr><tr><td><code>decision</code></td><td>OneSatSim.Foundation.Interfaces.ArbiterDecisionSignals</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 decision</td></tr></table><h3>状态与初始化</h3><p>本类源码中显式出现的导数对象或离散声明：<code>decisionCounter, lastHandledRequest, acceptedLatch, rejectedLatch, acceptedCommandLatch, acceptedCommandIdLatch, acceptedTargetLatch, acceptedStationLatch, acceptedOpportunityTimeRemainingLatch, rejectReasonLatch</code>。初始化取当前声明的 start/fixed、initial 方程/算法及继承设置。此处是源码级说明，不等同于编译后连续状态统计。</p><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] decision.decisionId=decisionCounter;\n[equation] decision.accepted=acceptedLatch;\n[equation] decision.rejected=rejectedLatch;\n[equation] decision.acceptedCommand=acceptedCommandLatch;\n[equation] decision.acceptedCommandId=acceptedCommandIdLatch;\n[equation] decision.acceptedTargetIndex=acceptedTargetLatch;\n[equation] decision.acceptedGroundStationIndex=acceptedStationLatch;\n[equation] decision.acceptedOpportunityTimeRemaining=acceptedOpportunityTimeRemainingLatch;\n[equation] decision.rejectReason=rejectReasonLatch;\n[equation] decision.requestPending=request.requestValid and request.requestId &lt;&gt; lastHandledRequest;</pre><p>本类另有33段语句；阅读完整源码可查看其余边界与逻辑。</p><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>decisionCounter</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 decisionCounter</td></tr><tr><td><code>lastHandledRequest</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>lastHandled请求</td></tr><tr><td><code>acceptedLatch</code></td><td>Boolean</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 acceptedLatch</td></tr><tr><td><code>rejectedLatch</code></td><td>Boolean</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 rejectedLatch</td></tr><tr><td><code>acceptedCommandLatch</code></td><td>OneSatSim.Foundation.Types.CommandType</td><td>discrete</td><td>按声明/类型合同</td><td>accepted指令Latch</td></tr><tr><td><code>acceptedCommandIdLatch</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>accepted指令IdLatch</td></tr><tr><td><code>acceptedTargetLatch</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>accepted目标Latch</td></tr><tr><td><code>acceptedStationLatch</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>accepted站点Latch</td></tr><tr><td><code>acceptedOpportunityTimeRemainingLatch</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>acceptedOpportunity时间RemainingLatch</td></tr><tr><td><code>rejectReasonLatch</code></td><td>OneSatSim.Foundation.Types.RejectReason</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 rejectReasonLatch</td></tr></table></html>"),
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
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Command Arbiter", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
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
      Line(points={{-44.08,-33.64},{44.08,-33.64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-46.4,-45.82},{46.4,-37.12}}, textString="Command Arbiter", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-218,88.8},{218,117.8}}, textString="Command Arbiter", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-218,80.8},{218,80.8}}, color={215,220,226}, thickness=0.25)
    }));
end CommandArbiter;