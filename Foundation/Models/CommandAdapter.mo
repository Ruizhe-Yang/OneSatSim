within OneSatSim.Foundation.Models;
model CommandAdapter "任务接口到设备指令与状态的纯映射"
  OneSatSim.Foundation.Interfaces.OpportunitySignals opportunity  "计算/接口量 opportunity" annotation(Placement(visible=true, transformation(origin={-225,78}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.SafetySignals safety  "计算/接口量 safety" annotation(Placement(visible=true, transformation(origin={-225,52}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,48}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.ArbiterDecisionSignals decision  "计算/接口量 decision" annotation(Placement(visible=true, transformation(origin={-225,26}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,16}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.MissionStateSignals state  "状态值或模式码" annotation(Placement(visible=true, transformation(origin={-225,0}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-16}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.ImagingActionSignals imagingAction  "成像Action" annotation(Placement(visible=true, transformation(origin={-225,-52}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-48}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.DownlinkActionSignals downlinkAction  "下传Action" annotation(Placement(visible=true, transformation(origin={-225,-78}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.CommandBus command  "指令" annotation(Placement(visible=true, transformation(origin={225,16}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.CommandStatusBus status  "计算/接口量 status" annotation(Placement(visible=true, transformation(origin={225,-16}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-12,-12},{12,12}}, rotation=0)));
protected
  Boolean safeModeInternal "安全模式模式Internal" ;
  Boolean terminalImagingFailure "terminal成像Failure" ;
  Boolean terminalImagingCaptureStarted "terminal成像CaptureStarted" ;
equation
  safeModeInternal=state.missionMode == OneSatSim.Foundation.Types.MissionMode.SafeEntry or 
    state.missionMode == OneSatSim.Foundation.Types.MissionMode.SafeHold or 
    (state.missionMode == OneSatSim.Foundation.Types.MissionMode.Recovery and state.stateElapsed < 10);
  terminalImagingFailure=state.commandFailed and 
    state.terminalFailureCommand == OneSatSim.Foundation.Types.CommandType.Imaging;
  terminalImagingCaptureStarted=terminalImagingFailure and 
    state.terminalFailureRequestId == imagingAction.startedEventId;
  command.safeMode=safeModeInternal;
  command.missionOn=not safeModeInternal;
  command.payloadPowerCommand=imagingAction.payloadPowerCommand and not safeModeInternal;
  command.captureCommand=imagingAction.captureCommand and not safeModeInternal;
  command.earthObservationCaptureCommand=command.captureCommand;
  command.imagingRequestId=state.imagingActionRequestId;
  command.selfieCaptureCommand=false;
  command.communicationPowerCommand=downlinkAction.communicationPowerCommand and not safeModeInternal;
  command.transmitCommand=downlinkAction.transmitCommand and not safeModeInternal;
  command.imaging=command.captureCommand;
  command.downlink=command.transmitCommand;
  command.sunPointing=state.controlMode == OneSatSim.Foundation.Types.ControlMode.SunPointing or 
    state.controlMode == OneSatSim.Foundation.Types.ControlMode.SafeMode;
  command.desiredControlMode=state.controlMode;
  command.groundStationIndex=state.activeGroundStationIndex;
  command.targetIndex=state.activeTargetIndex;
  command.missionPriority=if safeModeInternal then 5 else 
    if state.missionMode == OneSatSim.Foundation.Types.MissionMode.Recovery then 4 else 
    if downlinkAction.busy then 3 else if imagingAction.busy then 2 else 1;
  status.currentCommand=if state.commandFailed or state.commandAborted or state.commandTimeout then 
    state.terminalFailureCommand else state.currentCommand;
  status.executionStatus=if decision.rejected then OneSatSim.Foundation.Types.CommandExecutionStatus.Rejected else state.executionStatus;
  status.rejectReason=if state.commandFailed or state.commandAborted or state.commandTimeout then 
    state.terminalFailureReason else if decision.rejected then decision.rejectReason else 
    if state.executionStatus == OneSatSim.Foundation.Types.CommandExecutionStatus.Rejected then 
      state.lastRejectReason else OneSatSim.Foundation.Types.RejectReason.None;
  status.missionMode=state.missionMode;
  status.controlMode=state.controlMode;
  status.commandId=if state.commandFailed or state.commandAborted or state.commandTimeout then 
    state.terminalFailureRequestId else if state.activeRequestId <> 0 then 
    state.activeRequestId else decision.acceptedCommandId;
  status.transitionCounter=state.transitionCounter;
  status.accepted=decision.accepted;
  status.rejected=decision.rejected;
  status.executing=state.commandExecuting;
  status.completed=state.commandCompleted;
  status.failed=state.commandFailed;
  status.aborted=state.commandAborted;
  status.timeout=state.commandTimeout;
  status.safePreemption=state.commandAborted and safeModeInternal;
  status.executionTime=state.executionTime;
  status.imagingOpportunity=opportunity.imagingOpportunity;
  status.downlinkOpportunity=opportunity.downlinkOpportunity;
  status.imagingAllowed=safety.imagingAllowed;
  status.downlinkAllowed=safety.downlinkAllowed;
  status.safeModeRequired=safety.safeModeRequired;
  status.imagingCaptureStarted=if terminalImagingFailure then 
    terminalImagingCaptureStarted else imagingAction.captureStarted;
  status.imagingImageComplete=if terminalImagingFailure then false else imagingAction.imageComplete;
  status.imagingValidImageBytes=if terminalImagingFailure and not terminalImagingCaptureStarted then 
    0 else imagingAction.validImageBytes;
  status.imagingAcceptedImageBytes=if terminalImagingFailure and not terminalImagingCaptureStarted then 
    0 else imagingAction.acceptedImageBytes;
  status.imagingAcceptedRequestId=if terminalImagingFailure then 
    state.terminalFailureRequestId else imagingAction.acceptedRequestId;
  status.imagingFailureReason=if terminalImagingFailure then 
    state.terminalFailureReason else imagingAction.failureReason;
  status.terminalFailurePhase=state.terminalFailurePhase;
  status.terminalImagingPhase=state.terminalImagingPhase;
  status.terminalFailureRequestId=state.terminalFailureRequestId;
  status.terminalFailureTargetIndex=state.terminalFailureTargetIndex;
  status.completedImagingCount=state.completedImagingCount;
  status.completedDownlinkCount=state.completedDownlinkCount;
  status.lastCompletedTargetIndex=state.lastCompletedTargetIndex;
  status.lastTerminalRequestId=state.lastTerminalRequestId;
  status.lastTerminalReason=state.lastTerminalReason;
  annotation(Documentation(info="<html><h2>任务接口到设备指令与状态的纯映射</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Models.CommandAdapter</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>任务接口到设备指令与状态的纯映射</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.MissionControlUnit\">OneSatSim.Components.MissionControlUnit</a> 的 <code>adapter</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>opportunity</code></td><td>OneSatSim.Foundation.Interfaces.OpportunitySignals</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 opportunity</td></tr><tr><td><code>safety</code></td><td>OneSatSim.Foundation.Interfaces.SafetySignals</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 safety</td></tr><tr><td><code>decision</code></td><td>OneSatSim.Foundation.Interfaces.ArbiterDecisionSignals</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 decision</td></tr><tr><td><code>state</code></td><td>OneSatSim.Foundation.Interfaces.MissionStateSignals</td><td>public</td><td>按声明/类型合同</td><td>状态值或模式码</td></tr><tr><td><code>imagingAction</code></td><td>OneSatSim.Foundation.Interfaces.ImagingActionSignals</td><td>public</td><td>按声明/类型合同</td><td>成像Action</td></tr><tr><td><code>downlinkAction</code></td><td>OneSatSim.Foundation.Interfaces.DownlinkActionSignals</td><td>public</td><td>按声明/类型合同</td><td>下传Action</td></tr><tr><td><code>command</code></td><td>OneSatSim.Foundation.Interfaces.CommandBus</td><td>public</td><td>按声明/类型合同</td><td>指令</td></tr><tr><td><code>status</code></td><td>OneSatSim.Foundation.Interfaces.CommandStatusBus</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 status</td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] safeModeInternal=state.missionMode == OneSatSim.Foundation.Types.MissionMode.SafeEntry or state.missionMode == OneSatSim.Foundation.Types.MissionMode.SafeHold or (state.missionMode == OneSatSim.Foundation.Types.MissionMode.Recovery and state.stateElapsed &lt; 10);\n[equation] terminalImagingFailure=state.commandFailed and state.terminalFailureCommand == OneSatSim.Foundation.Types.CommandType.Imaging;\n[equation] terminalImagingCaptureStarted=terminalImagingFailure and state.terminalFailureRequestId == imagingAction.startedEventId;\n[equation] command.safeMode=safeModeInternal;\n[equation] command.missionOn=not safeModeInternal;\n[equation] command.payloadPowerCommand=imagingAction.payloadPowerCommand and not safeModeInternal;\n[equation] command.captureCommand=imagingAction.captureCommand and not safeModeInternal;\n[equation] command.earthObservationCaptureCommand=command.captureCommand;\n[equation] command.imagingRequestId=state.imagingActionRequestId;\n[equation] command.selfieCaptureCommand=false;</pre><p>本类另有45段语句；阅读完整源码可查看其余边界与逻辑。</p><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>safeModeInternal</code></td><td>Boolean</td><td>protected</td><td>按声明/类型合同</td><td>安全模式模式Internal</td></tr><tr><td><code>terminalImagingFailure</code></td><td>Boolean</td><td>protected</td><td>按声明/类型合同</td><td>terminal成像Failure</td></tr><tr><td><code>terminalImagingCaptureStarted</code></td><td>Boolean</td><td>protected</td><td>按声明/类型合同</td><td>terminal成像CaptureStarted</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-60,22},{-39,40}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{-39,31},{-17,31},{-17,15.5},{3,15.5}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{-60,-9},{-39,9}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{-39,0},{-17,0},{-17,0},{3,0}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{-60,-40},{-39,-22}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{-39,-31},{-17,-31},{-17,-15.5},{3,-15.5}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{3,-25},{28,25}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{28,15},{45,15},{45,30},{68,30}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{28,0},{45,0},{45,0},{68,0}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{28,-15},{45,-15},{45,-30},{68,-30}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{10,-16},{21,16}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Command Mapping", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-269,-122},{269,166}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-66.75,-72.75},{66.75,71.25}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-57,48},{57,48}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-63,51.75},{-48,66.75}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-45.75,53.25},{57,64.5}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-45,16.5},{-29.25,30}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{-29.25,23.25},{-12.75,23.25},{-12.75,11.625},{2.25,11.625}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{-45,-6.75},{-29.25,6.75}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{-29.25,0},{-12.75,0},{-12.75,0},{2.25,0}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{-45,-30},{-29.25,-16.5}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{-29.25,-23.25},{-12.75,-23.25},{-12.75,-11.625},{2.25,-11.625}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{2.25,-18.75},{21,18.75}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{21,11.25},{33.75,11.25},{33.75,22.5},{51,22.5}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{21,0},{33.75,0},{33.75,0},{51,0}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{21,-11.25},{33.75,-11.25},{33.75,-22.5},{51,-22.5}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{7.5,-12},{15.75,12}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-57,-43.5},{57,-43.5}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-60,-59.25},{60,-48}}, textString="Command Mapping", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-257,121},{257,150}}, textString="Command Adapter", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-257,113},{257,113}}, color={215,220,226}, thickness=0.25)
    }));
end CommandAdapter;