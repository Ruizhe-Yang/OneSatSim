within OneSatSim.Foundation.Models;
model SafeModeSequencer "请求驱动的安全进入、保持与恢复时序器"
  Modelica.Blocks.Interfaces.IntegerInput actionRequestId  "action请求Id" annotation(Placement(visible=true, transformation(origin={-185,32}, extent={{-7,-7},{7,7}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.CommandTypeInput actionCommand  "action指令" annotation(Placement(visible=true, transformation(origin={-185,0}, extent={{-14,-14},{14,14}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-12,-12},{12,12}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput safeEntryCompleteEventId  "安全模式EntryCompleteEventId" annotation(Placement(visible=true, transformation(origin={185,45}, extent={{-7,-7},{7,7}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput recoveryCompleteEventId  "计算/接口量 recoveryCompleteEventId" annotation(Placement(visible=true, transformation(origin={185,13}, extent={{-7,-7},{7,7}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-6,-6},{6,6}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.SafetySignals safety  "计算/接口量 safety" annotation(Placement(visible=true, transformation(origin={-185,-32}, extent={{-14,-14},{14,14}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.SafeModeActionSignals action  "计算/接口量 action" annotation(Placement(visible=true, transformation(origin={185,-45}, extent={{-14,-14},{14,14}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-12,-12},{12,12}}, rotation=0)));
  parameter Real safeEntryTime(unit="s")=5 "安全模式Entry时间 [s]" ;
  parameter Real recoveryHoldTime(unit="s")=600 "recoveryHold时间 [s]" ;
  parameter Real stagedRecoveryTime(unit="s")=30 "stagedRecovery时间 [s]" ;
protected
  discrete Real safeEntryDeadline(start=1e100,fixed=true) "安全模式EntryDeadline" ;
  discrete Real recoveryDeadline(start=1e100,fixed=true) "计算/接口量 recoveryDeadline" ;
  discrete Real stagedRecoveryDeadline(start=1e100,fixed=true) "计算/接口量 stagedRecoveryDeadline" ;
  discrete Boolean safeEntryCompleteLatch(start=false,fixed=true) "安全模式EntryCompleteLatch" ;
  discrete Boolean recoveryReadyLatch(start=false,fixed=true) "recovery就绪Latch" ;
  discrete Boolean recoveryCompleteLatch(start=false,fixed=true) "计算/接口量 recoveryCompleteLatch" ;
  discrete Integer activeRequest(start=0,fixed=true) "激活请求" ;
  discrete Integer safeEntryEventId(start=0,fixed=true) "安全模式EntryEventId" ;
  discrete Integer recoveryEventId(start=0,fixed=true) "计算/接口量 recoveryEventId" ;
equation
  action.safeEntryComplete=safeEntryCompleteLatch;
  action.recoveryReady=recoveryReadyLatch;
  action.recoveryComplete=recoveryCompleteLatch;
  action.safeEntryCompleteEventId=safeEntryEventId;
  action.recoveryCompleteEventId=recoveryEventId;
  safeEntryCompleteEventId=safeEntryEventId;
  recoveryCompleteEventId=recoveryEventId;
algorithm
  when {change(actionRequestId),change(safety.recoveryAllowed),
      time >= safeEntryDeadline,time >= recoveryDeadline,time >= stagedRecoveryDeadline} then
    if change(actionRequestId) and 
        actionCommand == OneSatSim.Foundation.Types.CommandType.EnterSafeMode then
      activeRequest:=actionRequestId;
      safeEntryDeadline:=time+safeEntryTime;
      recoveryDeadline:=1e100;
      stagedRecoveryDeadline:=1e100;
      safeEntryCompleteLatch:=false;
      recoveryReadyLatch:=false;
      recoveryCompleteLatch:=false;
    elseif change(actionRequestId) and 
        actionCommand == OneSatSim.Foundation.Types.CommandType.ExitSafeMode then
      activeRequest:=actionRequestId;
      safeEntryDeadline:=1e100;
      recoveryDeadline:=1e100;
      stagedRecoveryDeadline:=time+stagedRecoveryTime;
      recoveryReadyLatch:=false;
      recoveryCompleteLatch:=false;
    elseif time >= pre(safeEntryDeadline) then
      safeEntryDeadline:=1e100;
      safeEntryCompleteLatch:=true;
      safeEntryEventId:=activeRequest;
      recoveryDeadline:=if safety.recoveryAllowed then time+recoveryHoldTime else 1e100;
    elseif change(safety.recoveryAllowed) and safeEntryCompleteLatch then
      recoveryDeadline:=if safety.recoveryAllowed then time+recoveryHoldTime else 1e100;
      recoveryReadyLatch:=false;
    elseif time >= pre(recoveryDeadline) then
      recoveryDeadline:=1e100;
      recoveryReadyLatch:=true;
    elseif time >= pre(stagedRecoveryDeadline) then
      stagedRecoveryDeadline:=1e100;
      recoveryCompleteLatch:=true;
      recoveryEventId:=activeRequest;
    end if;
  end when;
equation
  annotation(Documentation(info="<html><h2>请求驱动的安全进入、保持与恢复时序器</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Models.SafeModeSequencer</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>请求驱动的安全进入、保持与恢复时序器</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.MissionControlUnit\">OneSatSim.Components.MissionControlUnit</a> 的 <code>safeSequencer</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>actionRequestId</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>action请求Id</td></tr><tr><td><code>actionCommand</code></td><td>OneSatSim.Foundation.Interfaces.CommandTypeInput</td><td>public</td><td>按声明/类型合同</td><td>action指令</td></tr><tr><td><code>safeEntryCompleteEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>安全模式EntryCompleteEventId</td></tr><tr><td><code>recoveryCompleteEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 recoveryCompleteEventId</td></tr><tr><td><code>safety</code></td><td>OneSatSim.Foundation.Interfaces.SafetySignals</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 safety</td></tr><tr><td><code>action</code></td><td>OneSatSim.Foundation.Interfaces.SafeModeActionSignals</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 action</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>safeEntryTime</code></td><td>Real</td><td>安全模式Entry时间 [s]</td><td><code>=5</code></td></tr><tr><td><code>recoveryHoldTime</code></td><td>Real</td><td>recoveryHold时间 [s]</td><td><code>=600</code></td></tr><tr><td><code>stagedRecoveryTime</code></td><td>Real</td><td>stagedRecovery时间 [s]</td><td><code>=30</code></td></tr></table><h3>状态与初始化</h3><p>本类源码中显式出现的导数对象或离散声明：<code>safeEntryDeadline, recoveryDeadline, stagedRecoveryDeadline, safeEntryCompleteLatch, recoveryReadyLatch, recoveryCompleteLatch, activeRequest, safeEntryEventId, recoveryEventId</code>。初始化取当前声明的 start/fixed、initial 方程/算法及继承设置。此处是源码级说明，不等同于编译后连续状态统计。</p><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] action.safeEntryComplete=safeEntryCompleteLatch;\n[equation] action.recoveryReady=recoveryReadyLatch;\n[equation] action.recoveryComplete=recoveryCompleteLatch;\n[equation] action.safeEntryCompleteEventId=safeEntryEventId;\n[equation] action.recoveryCompleteEventId=recoveryEventId;\n[equation] safeEntryCompleteEventId=safeEntryEventId;\n[equation] recoveryCompleteEventId=recoveryEventId;\n[algorithm] when {change(actionRequestId),change(safety.recoveryAllowed), time &gt;= safeEntryDeadline,time &gt;= recoveryDeadline,time &gt;= stagedRecoveryDeadline} then if change(actionRequestId) and actionCommand == OneSatSim.Foundation.Types.CommandType.EnterSafeMode then activeRequest:=actionRequestId;\n[algorithm] safeEntryDeadline:=time+safeEntryTime;\n[algorithm] recoveryDeadline:=1e100;</pre><p>本类另有23段语句；阅读完整源码可查看其余边界与逻辑。</p><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>safeEntryDeadline</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>安全模式EntryDeadline</td></tr><tr><td><code>recoveryDeadline</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 recoveryDeadline</td></tr><tr><td><code>stagedRecoveryDeadline</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 stagedRecoveryDeadline</td></tr><tr><td><code>safeEntryCompleteLatch</code></td><td>Boolean</td><td>discrete</td><td>按声明/类型合同</td><td>安全模式EntryCompleteLatch</td></tr><tr><td><code>recoveryReadyLatch</code></td><td>Boolean</td><td>discrete</td><td>按声明/类型合同</td><td>recovery就绪Latch</td></tr><tr><td><code>recoveryCompleteLatch</code></td><td>Boolean</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 recoveryCompleteLatch</td></tr><tr><td><code>activeRequest</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>激活请求</td></tr><tr><td><code>safeEntryEventId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>安全模式EntryEventId</td></tr><tr><td><code>recoveryEventId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 recoveryEventId</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-25.2,34.2},{-7.7,34.2}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{9.1,34.2},{25.9,34.2}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{34.3,25.8},{34.3,8.3}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{25.9,-0.1},{8.4,-0.1}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-8.4,-0.1},{-25.2,-0.1}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{-42,26.5},{-25.2,41.9}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{-7.7,26.5},{9.1,41.9}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{25.9,26.5},{42.7,41.9}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{25.9,-7.8},{42.7,7.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{-8.4,-7.8},{8.4,7.6}}, lineColor={0,0,0}, fillColor={236,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Ellipse(extent={{-2.8,-2.9},{2.8,2.7}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.4, startAngle=0, endAngle=360),
      Rectangle(extent={{-42,-7.8},{-25.2,7.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Line(points={{-33.6,-9.2},{-33.6,-16.2},{0,-16.2},{0,-9.2}}, color={113,122,132}, thickness=0.55, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-62,-26},{65,-26}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{-50,-39},{-31,-28}}, lineColor={128,97,151}, fillColor={235,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{-26,-39},{11,-28}}, lineColor={128,97,151}, fillColor={235,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{17,-39},{51,-28}}, lineColor={128,97,151}, fillColor={235,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Polygon(points={{51,-34},{65,-39},{62,-49},{57,-52},{51,-48},{51,-34}}, lineColor={196,94,56}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Safe-Mode Sequence", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-230,-90},{230,134}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-51.62,-56.26},{51.62,55.1}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-44.08,37.12},{44.08,37.12}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-48.72,40.02},{-37.12,51.62}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-35.38,41.18},{44.08,49.88}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-14.616,19.836},{-4.466,19.836}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{5.278,19.836},{15.022,19.836}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{19.894,14.964},{19.894,4.814}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{15.022,-0.058},{4.872,-0.058}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-4.872,-0.058},{-14.616,-0.058}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{-24.36,15.37},{-14.616,24.302}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{-4.466,15.37},{5.278,24.302}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{15.022,15.37},{24.766,24.302}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{15.022,-4.524},{24.766,4.408}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{-4.872,-4.524},{4.872,4.408}}, lineColor={0,0,0}, fillColor={236,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Ellipse(extent={{-1.624,-1.682},{1.624,1.566}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.4, startAngle=0, endAngle=360),
      Rectangle(extent={{-24.36,-4.524},{-14.616,4.408}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Line(points={{-19.488,-5.336},{-19.488,-9.396},{0,-9.396},{0,-5.336}}, color={113,122,132}, thickness=0.55, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-35.96,-15.08},{37.7,-15.08}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{-29,-22.62},{-17.98,-16.24}}, lineColor={128,97,151}, fillColor={235,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{-15.08,-22.62},{6.38,-16.24}}, lineColor={128,97,151}, fillColor={235,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{9.86,-22.62},{29.58,-16.24}}, lineColor={128,97,151}, fillColor={235,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Polygon(points={{29.58,-19.72},{37.7,-22.62},{35.96,-28.42},{33.06,-30.16},{29.58,-27.84},{29.58,-19.72}}, lineColor={196,94,56}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Line(points={{-44.08,-33.64},{44.08,-33.64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-46.4,-45.82},{46.4,-37.12}}, textString="Safe-Mode Sequence", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-218,89},{218,118}}, textString="Safe Mode Sequencer", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-218,81},{218,81}}, color={215,220,226}, thickness=0.25)
    }));
end SafeModeSequencer;