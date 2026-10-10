within OneSatSim.Foundation.Models;
model DownlinkSequencer "请求驱动的下行动作时序器"
  OneSatSim.Foundation.Interfaces.MissionFeedbackBus feedback  "反馈" annotation(Placement(visible=true, transformation(origin={-225,77}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.ActiveGeometrySignals activeGeometry  "激活几何" annotation(Placement(visible=true, transformation(origin={-225,45}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,40}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.SafetySignals safety  "计算/接口量 safety" annotation(Placement(visible=true, transformation(origin={-225,13}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-12,-12},{12,12}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput actionRequestId  "action请求Id" annotation(Placement(visible=true, transformation(origin={-225,-45}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-40}, extent={{-6,-6},{6,6}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.ActiveMissionSelectionInput activeMissionSelection  "来自OBC的任务对象锁存索引" annotation(Placement(visible=true, transformation(origin={-225,-77}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-12,-12},{12,12}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput startedEventId  "计算/接口量 startedEventId" annotation(Placement(visible=true, transformation(origin={225,78}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput completedEventId  "计算/接口量 completedEventId" annotation(Placement(visible=true, transformation(origin={225,52}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,48}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput failedEventId  "计算/接口量 failedEventId" annotation(Placement(visible=true, transformation(origin={225,26}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,16}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput abortedEventId  "计算/接口量 abortedEventId" annotation(Placement(visible=true, transformation(origin={225,0}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-16}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput timeoutEventId  "计算/接口量 timeoutEventId" annotation(Placement(visible=true, transformation(origin={225,-26}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-48}, extent={{-6,-6},{6,6}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.DownlinkActionSignals action  "计算/接口量 action" annotation(Placement(visible=true, transformation(origin={225,-78}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-12,-12},{12,12}}, rotation=0)));
  parameter Real powerOnTime(unit="s")=2 "功率On时间 [s]" ;
  parameter Real initializationTime(unit="s")=5 "initialization时间 [s]" ;
  parameter Real pointingWaitTimeout(unit="s")=171 "配置项 pointingWaitTimeout [s]" ;
  parameter Real linkAcquisitionTime(unit="s")=2 "链路Acquisition时间 [s]" ;
  parameter Real shutdownTime(unit="s")=2 "shutdown时间 [s]" ;
  parameter Real eventSettleDelay(unit="s")=1e-4 "配置项 eventSettleDelay [s]" ;
protected
  discrete OneSatSim.Foundation.Types.DownlinkPhase phase(start=OneSatSim.Foundation.Types.DownlinkPhase.Idle,fixed=true) "计算/接口量 phase" ;
  discrete Real phaseDeadline(start=1e100,fixed=true) "计算/接口量 phaseDeadline" ;
  discrete Real resetDeadline(start=1e100,fixed=true) "计算/接口量 resetDeadline" ;
  discrete Integer activeRequest(start=0,fixed=true) "激活请求" ;
  discrete Integer startedId(start=0,fixed=true) "计算/接口量 startedId" ;
  discrete Integer completedId(start=0,fixed=true) "计算/接口量 completedId" ;
  discrete Integer abortedId(start=0,fixed=true) "计算/接口量 abortedId" ;
  discrete Integer timeoutId(start=0,fixed=true) "计算/接口量 timeoutId" ;
  discrete Boolean abortedLatch(start=false,fixed=true) "计算/接口量 abortedLatch" ;
  discrete Boolean timeoutLatch(start=false,fixed=true) "计算/接口量 timeoutLatch" ;
  Boolean linkReady "链路就绪" ;
  Boolean transmitReady "transmit就绪" ;
equation
  // Transmitter-ready is the equipment response to this sequencer's own power
  // command.  Use its preceding stable event value to avoid a same-event
  // power-command/readiness loop; dataAvailable remains a live external event.
  linkReady=pre(activeRequest) > 0 and activeGeometry.activeGroundContact and 
    activeMissionSelection.groundStationIndex > 0 and feedback.groundLinkAttitudeReady and 
    pre(feedback.transmitterReady) and feedback.dataAvailable;
  transmitReady=linkReady;
  action.phase=phase;
  action.communicationPowerCommand=phase == OneSatSim.Foundation.Types.DownlinkPhase.PowerOn or 
    phase == OneSatSim.Foundation.Types.DownlinkPhase.Initialize or 
    phase == OneSatSim.Foundation.Types.DownlinkPhase.WaitGroundPointing or 
    phase == OneSatSim.Foundation.Types.DownlinkPhase.EstablishLink or 
    phase == OneSatSim.Foundation.Types.DownlinkPhase.Transmit or 
    phase == OneSatSim.Foundation.Types.DownlinkPhase.Shutdown;
  action.transmitCommand=phase == OneSatSim.Foundation.Types.DownlinkPhase.Transmit;
  action.busy=action.communicationPowerCommand;
  action.active=phase == OneSatSim.Foundation.Types.DownlinkPhase.Transmit or phase == OneSatSim.Foundation.Types.DownlinkPhase.Shutdown;
  action.completed=phase == OneSatSim.Foundation.Types.DownlinkPhase.Complete;
  action.failed=phase == OneSatSim.Foundation.Types.DownlinkPhase.Failed;
  action.aborted=abortedLatch;
  action.timeout=timeoutLatch;
  action.startedEventId=startedId;
  action.completedEventId=completedId;
  // Downlink terminal failures are classified explicitly as abort or timeout;
  // the generic failure channel therefore remains inactive.
  action.failedEventId=0;
  action.abortedEventId=abortedId;
  action.timeoutEventId=timeoutId;
  startedEventId=startedId;
  completedEventId=completedId;
  failedEventId=0;
  abortedEventId=abortedId;
  timeoutEventId=timeoutId;
  assert(activeRequest >= 0,"Downlink action request identifiers must be non-negative");
algorithm
  when {change(actionRequestId),change(activeMissionSelection.groundStationIndex),change(activeGeometry.activeGroundContact),
      change(feedback.groundLinkAttitudeReady),change(feedback.dataAvailable),
      edge(safety.safeModeRequired),time >= phaseDeadline,time >= resetDeadline} then
    if change(actionRequestId) and actionRequestId > 0 then
      activeRequest:=actionRequestId;
      phase:=OneSatSim.Foundation.Types.DownlinkPhase.PowerOn;
      phaseDeadline:=time+powerOnTime;
      resetDeadline:=1e100;
      abortedLatch:=false;
      timeoutLatch:=false;
    elseif safety.safeModeRequired and activeRequest > 0 and 
        not (pre(phase) == OneSatSim.Foundation.Types.DownlinkPhase.Idle or 
             pre(phase) == OneSatSim.Foundation.Types.DownlinkPhase.Complete or 
             pre(phase) == OneSatSim.Foundation.Types.DownlinkPhase.Failed) then
      phase:=OneSatSim.Foundation.Types.DownlinkPhase.Failed;
      phaseDeadline:=1e100;
      resetDeadline:=time+eventSettleDelay;
      abortedLatch:=true;
      timeoutLatch:=false;
      abortedId:=activeRequest;
    elseif pre(activeRequest) > 0 and activeMissionSelection.groundStationIndex <= 0 and 
        not (pre(phase) == OneSatSim.Foundation.Types.DownlinkPhase.Idle or 
             pre(phase) == OneSatSim.Foundation.Types.DownlinkPhase.Complete or 
             pre(phase) == OneSatSim.Foundation.Types.DownlinkPhase.Failed) then
      phase:=OneSatSim.Foundation.Types.DownlinkPhase.Failed;
      phaseDeadline:=1e100;
      resetDeadline:=time+eventSettleDelay;
      abortedLatch:=true;
      timeoutLatch:=false;
      abortedId:=pre(activeRequest);
    elseif time >= pre(resetDeadline) then
      phase:=OneSatSim.Foundation.Types.DownlinkPhase.Idle;
      phaseDeadline:=1e100;
      resetDeadline:=1e100;
      activeRequest:=0;
      abortedLatch:=false;
      timeoutLatch:=false;
    elseif pre(phase) == OneSatSim.Foundation.Types.DownlinkPhase.WaitGroundPointing and linkReady and 
        time+linkAcquisitionTime <= pre(phaseDeadline) then
      phase:=OneSatSim.Foundation.Types.DownlinkPhase.EstablishLink;
      phaseDeadline:=time+linkAcquisitionTime;
      startedId:=activeRequest;
    elseif pre(phase) == OneSatSim.Foundation.Types.DownlinkPhase.Transmit and not transmitReady then
      phase:=OneSatSim.Foundation.Types.DownlinkPhase.Shutdown;
      phaseDeadline:=time+shutdownTime;
    elseif pre(phase) == OneSatSim.Foundation.Types.DownlinkPhase.EstablishLink and not linkReady then
      phase:=OneSatSim.Foundation.Types.DownlinkPhase.Shutdown;
      phaseDeadline:=time+shutdownTime;
    elseif time >= pre(phaseDeadline) then
      if pre(phase) == OneSatSim.Foundation.Types.DownlinkPhase.PowerOn then
        phase:=OneSatSim.Foundation.Types.DownlinkPhase.Initialize;
        phaseDeadline:=time+initializationTime;
      elseif pre(phase) == OneSatSim.Foundation.Types.DownlinkPhase.Initialize and linkReady then
        phase:=OneSatSim.Foundation.Types.DownlinkPhase.EstablishLink;
        phaseDeadline:=time+linkAcquisitionTime;
        startedId:=activeRequest;
      elseif pre(phase) == OneSatSim.Foundation.Types.DownlinkPhase.Initialize then
        phase:=OneSatSim.Foundation.Types.DownlinkPhase.WaitGroundPointing;
        phaseDeadline:=time+pointingWaitTimeout;
      elseif pre(phase) == OneSatSim.Foundation.Types.DownlinkPhase.WaitGroundPointing then
        phase:=OneSatSim.Foundation.Types.DownlinkPhase.Failed;
        phaseDeadline:=1e100;
        resetDeadline:=time+eventSettleDelay;
        timeoutLatch:=true;
        timeoutId:=activeRequest;
      elseif pre(phase) == OneSatSim.Foundation.Types.DownlinkPhase.EstablishLink and transmitReady then
        phase:=OneSatSim.Foundation.Types.DownlinkPhase.Transmit;
        phaseDeadline:=1e100;
      elseif pre(phase) == OneSatSim.Foundation.Types.DownlinkPhase.EstablishLink then
        phase:=OneSatSim.Foundation.Types.DownlinkPhase.Shutdown;
        phaseDeadline:=time+shutdownTime;
      elseif pre(phase) == OneSatSim.Foundation.Types.DownlinkPhase.Shutdown then
        phase:=OneSatSim.Foundation.Types.DownlinkPhase.Complete;
        phaseDeadline:=1e100;
        resetDeadline:=time+eventSettleDelay;
        completedId:=activeRequest;
      else
        phaseDeadline:=1e100;
      end if;
    end if;
  end when;
equation
  annotation(Documentation(info="<html><h2>请求驱动的下行动作时序器</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Models.DownlinkSequencer</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>请求驱动的下行动作时序器</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.MissionControlUnit\">OneSatSim.Components.MissionControlUnit</a> 的 <code>downlinkSequencer</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>feedback</code></td><td>OneSatSim.Foundation.Interfaces.MissionFeedbackBus</td><td>public</td><td>按声明/类型合同</td><td>反馈</td></tr><tr><td><code>activeGeometry</code></td><td>OneSatSim.Foundation.Interfaces.ActiveGeometrySignals</td><td>public</td><td>按声明/类型合同</td><td>激活几何</td></tr><tr><td><code>safety</code></td><td>OneSatSim.Foundation.Interfaces.SafetySignals</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 safety</td></tr><tr><td><code>actionRequestId</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>action请求Id</td></tr><tr><td><code>activeMissionSelection</code></td><td>OneSatSim.Foundation.Interfaces.ActiveMissionSelectionInput</td><td>public</td><td>按声明/类型合同</td><td>来自OBC的任务对象锁存索引</td></tr><tr><td><code>startedEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 startedEventId</td></tr><tr><td><code>completedEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 completedEventId</td></tr><tr><td><code>failedEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 failedEventId</td></tr><tr><td><code>abortedEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 abortedEventId</td></tr><tr><td><code>timeoutEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 timeoutEventId</td></tr><tr><td><code>action</code></td><td>OneSatSim.Foundation.Interfaces.DownlinkActionSignals</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 action</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>powerOnTime</code></td><td>Real</td><td>功率On时间 [s]</td><td><code>=2</code></td></tr><tr><td><code>initializationTime</code></td><td>Real</td><td>initialization时间 [s]</td><td><code>=5</code></td></tr><tr><td><code>pointingWaitTimeout</code></td><td>Real</td><td>配置项 pointingWaitTimeout [s]</td><td><code>=171</code></td></tr><tr><td><code>linkAcquisitionTime</code></td><td>Real</td><td>链路Acquisition时间 [s]</td><td><code>=2</code></td></tr><tr><td><code>shutdownTime</code></td><td>Real</td><td>shutdown时间 [s]</td><td><code>=2</code></td></tr><tr><td><code>eventSettleDelay</code></td><td>Real</td><td>配置项 eventSettleDelay [s]</td><td><code>=1e-4</code></td></tr></table><h3>状态与初始化</h3><p>本类源码中显式出现的导数对象或离散声明：<code>phase, phaseDeadline, resetDeadline, activeRequest, startedId, completedId, abortedId, timeoutId, abortedLatch, timeoutLatch</code>。初始化取当前声明的 start/fixed、initial 方程/算法及继承设置。此处是源码级说明，不等同于编译后连续状态统计。</p><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] linkReady=pre(activeRequest) &gt; 0 and activeGeometry.activeGroundContact and activeMissionSelection.groundStationIndex &gt; 0 and feedback.groundLinkAttitudeReady and pre(feedback.transmitterReady) and feedback.dataAvailable;\n[equation] transmitReady=linkReady;\n[equation] action.phase=phase;\n[equation] action.communicationPowerCommand=phase == OneSatSim.Foundation.Types.DownlinkPhase.PowerOn or phase == OneSatSim.Foundation.Types.DownlinkPhase.Initialize or phase == OneSatSim.Foundation.Types.DownlinkPhase.WaitGroundPointing or phase == OneSatSim.Foundation.Types.DownlinkPhase.EstablishLink or phase == OneSatSim.Foundation.Types.DownlinkPhase.Transmit or phase == OneSatSim.Foundation.Types.DownlinkPhase.Shutdown;\n[equation] action.transmitCommand=phase == OneSatSim.Foundation.Types.DownlinkPhase.Transmit;\n[equation] action.busy=action.communicationPowerCommand;\n[equation] action.active=phase == OneSatSim.Foundation.Types.DownlinkPhase.Transmit or phase == OneSatSim.Foundation.Types.DownlinkPhase.Shutdown;\n[equation] action.completed=phase == OneSatSim.Foundation.Types.DownlinkPhase.Complete;\n[equation] action.failed=phase == OneSatSim.Foundation.Types.DownlinkPhase.Failed;\n[equation] action.aborted=abortedLatch;</pre><p>本类另有67段语句；阅读完整源码可查看其余边界与逻辑。</p><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>phase</code></td><td>OneSatSim.Foundation.Types.DownlinkPhase</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 phase</td></tr><tr><td><code>phaseDeadline</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 phaseDeadline</td></tr><tr><td><code>resetDeadline</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 resetDeadline</td></tr><tr><td><code>activeRequest</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>激活请求</td></tr><tr><td><code>startedId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 startedId</td></tr><tr><td><code>completedId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 completedId</td></tr><tr><td><code>abortedId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 abortedId</td></tr><tr><td><code>timeoutId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 timeoutId</td></tr><tr><td><code>abortedLatch</code></td><td>Boolean</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 abortedLatch</td></tr><tr><td><code>timeoutLatch</code></td><td>Boolean</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 timeoutLatch</td></tr><tr><td><code>linkReady</code></td><td>Boolean</td><td>protected</td><td>按声明/类型合同</td><td>链路就绪</td></tr><tr><td><code>transmitReady</code></td><td>Boolean</td><td>protected</td><td>按声明/类型合同</td><td>transmit就绪</td></tr></table></html>"),
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
      Rectangle(extent={{25.9,26.5},{42.7,41.9}}, lineColor={0,0,0}, fillColor={236,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Ellipse(extent={{31.5,31.4},{37.1,37}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.4, startAngle=0, endAngle=360),
      Rectangle(extent={{25.9,-7.8},{42.7,7.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{-8.4,-7.8},{8.4,7.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{-42,-7.8},{-25.2,7.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Line(points={{-33.6,-9.2},{-33.6,-16.2},{0,-16.2},{0,-9.2}}, color={113,122,132}, thickness=0.55, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-62,-26},{65,-26}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{-50,-39},{-33,-28}}, lineColor={128,97,151}, fillColor={235,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{-27,-39},{-11,-28}}, lineColor={128,97,151}, fillColor={235,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{-5,-39},{51,-28}}, lineColor={128,97,151}, fillColor={235,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{49,-48},{56,-41},{64,-48}}, color={73,112,158}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Downlink Sequence", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-269,-122},{269,166}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-66.75,-72.75},{66.75,71.25}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-57,48},{57,48}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-63,51.75},{-48,66.75}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-45.75,53.25},{57,64.5}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-18.9,25.65},{-5.775,25.65}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{6.825,25.65},{19.425,25.65}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{25.725,19.35},{25.725,6.225}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{19.425,-0.075},{6.3,-0.075}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-6.3,-0.075},{-18.9,-0.075}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{-31.5,19.875},{-18.9,31.425}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{-5.775,19.875},{6.825,31.425}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{19.425,19.875},{32.025,31.425}}, lineColor={0,0,0}, fillColor={236,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Ellipse(extent={{23.625,23.55},{27.825,27.75}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.4, startAngle=0, endAngle=360),
      Rectangle(extent={{19.425,-5.85},{32.025,5.7}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{-6.3,-5.85},{6.3,5.7}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{-31.5,-5.85},{-18.9,5.7}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Line(points={{-25.2,-6.9},{-25.2,-12.15},{0,-12.15},{0,-6.9}}, color={113,122,132}, thickness=0.55, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-46.5,-19.5},{48.75,-19.5}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{-37.5,-29.25},{-24.75,-21}}, lineColor={128,97,151}, fillColor={235,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{-20.25,-29.25},{-8.25,-21}}, lineColor={128,97,151}, fillColor={235,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{-3.75,-29.25},{38.25,-21}}, lineColor={128,97,151}, fillColor={235,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{36.75,-36},{42,-30.75},{48,-36}}, color={73,112,158}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-57,-43.5},{57,-43.5}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-60,-59.25},{60,-48}}, textString="Downlink Sequence", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-257,121},{257,150}}, textString="Downlink Sequencer", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-257,113},{257,113}}, color={215,220,226}, thickness=0.25)
    }));
end DownlinkSequencer;