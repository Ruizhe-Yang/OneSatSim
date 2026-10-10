within OneSatSim.Foundation.Models;
model MissionStateMachine "单向动作握手的事件驱动任务状态机"
  OneSatSim.Foundation.Interfaces.ArbiterDecisionSignals decision  "计算/接口量 decision" annotation(Placement(visible=true, transformation(origin={-270,286}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-6.4,-6.4},{6.4,6.4}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput imagingStartedEventId  "成像StartedEventId" annotation(Placement(visible=true, transformation(origin={-270,234}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,70}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput imagingCompletedEventId  "成像完成对象ID" annotation(Placement(visible=true, transformation(origin={-270,208}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,60}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput imagingFailedEventId  "成像FailedEventId" annotation(Placement(visible=true, transformation(origin={-270,182}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,50}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput imagingAbortedEventId  "成像AbortedEventId" annotation(Placement(visible=true, transformation(origin={-270,156}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,40}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput imagingTimeoutEventId  "成像TimeoutEventId" annotation(Placement(visible=true, transformation(origin={-270,130}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,30}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput downlinkStartedEventId  "下传StartedEventId" annotation(Placement(visible=true, transformation(origin={-270,26}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,20}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput downlinkCompletedEventId  "数传完成对象ID" annotation(Placement(visible=true, transformation(origin={-270,0}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,10}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput downlinkFailedEventId  "下传FailedEventId" annotation(Placement(visible=true, transformation(origin={-270,-26}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput downlinkAbortedEventId  "下传AbortedEventId" annotation(Placement(visible=true, transformation(origin={-270,-52}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-10}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput downlinkTimeoutEventId  "下传TimeoutEventId" annotation(Placement(visible=true, transformation(origin={-270,-78}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-20}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput safeEntryCompleteEventId  "安全模式EntryCompleteEventId" annotation(Placement(visible=true, transformation(origin={-270,-130}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-30}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput recoveryCompleteEventId  "计算/接口量 recoveryCompleteEventId" annotation(Placement(visible=true, transformation(origin={-270,-156}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-40}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput geometryEventId  "几何EventId" annotation(Placement(visible=true, transformation(origin={-270,-208}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-50}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInput targetPreparationReady  "目标Preparation就绪" annotation(Placement(visible=true, transformation(origin={-270,-234}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-60}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInput targetEarlyOpportunity  "目标EarlyOpportunity" annotation(Placement(visible=true, transformation(origin={-270,-260}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-70}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput targetPreparationIndex  "目标PreparationIndex" annotation(Placement(visible=true, transformation(origin={-270,-286}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-3.2,-3.2},{3.2,3.2}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.RejectReasonInput imagingFailureReason
    "当前/最近一次成像持久化终止原因；Sequencer's actual failure reason, sampled at its terminal event" 
    annotation(Placement(visible=true, transformation(origin={-270,104}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.ImagingPhaseInput imagingFailurePhase
    "成像FailurePhase；Sequencer phase that triggered its terminal failure" 
    annotation(Placement(visible=true, transformation(origin={-270,78}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,57.142857}, extent={{-12,-12},{12,12}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput imagingActionRequestIdOut  "成像Action请求IdOut" annotation(Placement(visible=true, transformation(origin={270,78}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,34.285714}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput downlinkActionRequestIdOut  "下传Action请求IdOut" annotation(Placement(visible=true, transformation(origin={270,52}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,11.428571}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput safeModeActionRequestIdOut  "安全模式模式Action请求IdOut" annotation(Placement(visible=true, transformation(origin={270,26}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-11.428571}, extent={{-6,-6},{6,6}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.CommandTypeOutput safeModeActionCommandOut  "安全模式模式Action指令Out" annotation(Placement(visible=true, transformation(origin={270,0}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-34.285714}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.MissionStateSignals state  "状态值或模式码" annotation(Placement(visible=true, transformation(origin={270,-52}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-57.142857}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.ActiveMissionSelectionOutput selection  "计算/接口量 selection" annotation(Placement(visible=true, transformation(origin={270,-78}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-12,-12},{12,12}}, rotation=0)));
  parameter Real bootDuration(unit="s")=10 "配置项 bootDuration [s]" ;
  parameter OneSatSim.Foundation.Types.ImagingCapabilities imagingCapabilities
    "成像Capabilities；Shared Earth-camera and imaging opportunity capability";
  parameter Boolean operationalSnapshotStart=true "配置项 operationalSnapshotStart" ;
  parameter Real imagingPreparationTimeout(unit="s")=90 "成像PreparationTimeout [s]" ;
  parameter Real downlinkPreparationTimeout(unit="s")=180 "下传PreparationTimeout [s]" ;
  final parameter Real targetPreSlewDuration(unit="s")=imagingCapabilities.preSlewDuration_s "目标PreSlewDuration [s]" ;
  final parameter Real requiredImagingOpportunityTime(unit="s")=
    imagingCapabilities.requiredOpportunityTime_s "required成像Opportunity时间 [s]" ;
  parameter Real requiredDownlinkOpportunityTime(unit="s")=30 "上电、初始化、主视轴驻留、建链、最小有效发送和关机余量 [s]" ;
  parameter Real eventSettleDelay(unit="s")=1e-4 "配置项 eventSettleDelay [s]" ;
protected
  discrete OneSatSim.Foundation.Types.MissionMode mode(
    start=if operationalSnapshotStart then OneSatSim.Foundation.Types.MissionMode.Idle else OneSatSim.Foundation.Types.MissionMode.Boot,fixed=true) "模式" ;
  discrete OneSatSim.Foundation.Types.CommandType command(start=OneSatSim.Foundation.Types.CommandType.None,fixed=true) "指令" ;
  discrete OneSatSim.Foundation.Types.CommandExecutionStatus resultStatus(
    start=OneSatSim.Foundation.Types.CommandExecutionStatus.Idle,fixed=true) "计算/接口量 resultStatus" ;
  discrete Real entryTime(start=0,fixed=true) "entry时间" ;
  discrete Real commandStartTime(start=0,fixed=true) "指令Start时间" ;
  discrete Integer transitions(start=0,fixed=true) "计算/接口量 transitions" ;
  discrete Real eventDeadline(start=1e100,fixed=true) "计算/接口量 eventDeadline" ;
  discrete Real timeoutDeadline(start=if operationalSnapshotStart then 1e100 else bootDuration,fixed=true) "计算/接口量 timeoutDeadline" ;
  discrete Real preSlewDeadline(start=1e100,fixed=true) "计算/接口量 preSlewDeadline" ;
  discrete Boolean preSlewElapsed(start=false,fixed=true) "计算/接口量 preSlewElapsed" ;
  discrete Integer pendingEvent(start=0,fixed=true) "计算/接口量 pendingEvent" ;
  discrete OneSatSim.Foundation.Types.CommandType pendingCommand(start=OneSatSim.Foundation.Types.CommandType.None,fixed=true) "pending指令" ;
  discrete Integer pendingId(start=0,fixed=true) "计算/接口量 pendingId" ;
  discrete Integer pendingTarget(start=0,fixed=true) "pending目标" ;
  discrete Integer pendingStation(start=0,fixed=true) "pending站点" ;
  discrete Boolean pendingAccepted(start=false,fixed=true) "计算/接口量 pendingAccepted" ;
  discrete OneSatSim.Foundation.Types.RejectReason pendingRejectReason(
    start=OneSatSim.Foundation.Types.RejectReason.None,fixed=true) "计算/接口量 pendingRejectReason" ;
  discrete OneSatSim.Foundation.Types.RejectReason pendingImagingFailureReason(
    start=OneSatSim.Foundation.Types.RejectReason.None,fixed=true) "pending成像FailureReason" ;
  discrete OneSatSim.Foundation.Types.ImagingPhase pendingImagingFailurePhase(
    start=OneSatSim.Foundation.Types.ImagingPhase.Idle,fixed=true) "pending成像FailurePhase" ;
  discrete Real pendingOpportunityTimeRemaining(start=0,fixed=true) "pendingOpportunity时间Remaining" ;
  discrete Boolean queuedDecisionValid(start=false,fixed=true) "计算/接口量 queuedDecisionValid" ;
  discrete OneSatSim.Foundation.Types.CommandType queuedCommand(start=OneSatSim.Foundation.Types.CommandType.None,fixed=true) "queued指令" ;
  discrete Integer queuedId(start=0,fixed=true) "计算/接口量 queuedId" ;
  discrete Integer queuedTarget(start=0,fixed=true) "queued目标" ;
  discrete Integer queuedStation(start=0,fixed=true) "queued站点" ;
  discrete Integer queuedWindow(start=0,fixed=true) "计算/接口量 queuedWindow" ;
  discrete Real queuedOpportunityTimeRemaining(start=0,fixed=true) "queuedOpportunity时间Remaining" ;
  discrete Real queuedCaptureTime(start=0,fixed=true) "queuedCapture时间" ;
  discrete Real queuedTerminalDeadline(start=1e100,fixed=true) "计算/接口量 queuedTerminalDeadline" ;
  discrete Integer queuedTerminalId(start=0,fixed=true) "计算/接口量 queuedTerminalId" ;
  discrete Integer queuedTerminalTarget(start=0,fixed=true) "queuedTerminal目标" ;
  discrete OneSatSim.Foundation.Types.CommandType queuedTerminalCommand(
    start=OneSatSim.Foundation.Types.CommandType.None,fixed=true) "queuedTerminal指令" ;
  discrete OneSatSim.Foundation.Types.RejectReason queuedTerminalReason(
    start=OneSatSim.Foundation.Types.RejectReason.None,fixed=true) "计算/接口量 queuedTerminalReason" ;
  discrete OneSatSim.Foundation.Types.RejectReason lastRejectReasonLatch(
    start=OneSatSim.Foundation.Types.RejectReason.None,fixed=true) "计算/接口量 lastRejectReasonLatch" ;
  discrete OneSatSim.Foundation.Types.RejectReason terminalFailureReasonLatch(
    start=OneSatSim.Foundation.Types.RejectReason.None,fixed=true) "计算/接口量 terminalFailureReasonLatch" ;
  discrete OneSatSim.Foundation.Types.MissionMode terminalFailurePhaseLatch(
    start=OneSatSim.Foundation.Types.MissionMode.Idle,fixed=true) "计算/接口量 terminalFailurePhaseLatch" ;
  discrete OneSatSim.Foundation.Types.ImagingPhase terminalImagingPhaseLatch(
    start=OneSatSim.Foundation.Types.ImagingPhase.Idle,fixed=true) "terminal成像PhaseLatch" ;
  discrete OneSatSim.Foundation.Types.CommandType terminalFailureCommandLatch(
    start=OneSatSim.Foundation.Types.CommandType.None,fixed=true) "terminalFailure指令Latch" ;
  discrete Integer terminalFailureRequestIdLatch(start=0,fixed=true) "terminalFailure请求IdLatch" ;
  discrete Integer terminalFailureTargetIndexLatch(start=0,fixed=true) "terminalFailure目标IndexLatch" ;
  discrete Integer completedImagingCountLatch(start=0,fixed=true) "completed成像CountLatch" ;
  discrete Integer completedDownlinkCountLatch(start=0,fixed=true) "completed下传CountLatch" ;
  discrete Integer lastCountedImagingRequestId(start=0,fixed=true) "lastCounted成像请求Id" ;
  discrete Integer lastCountedDownlinkRequestId(start=0,fixed=true) "lastCounted下传请求Id" ;
  discrete Integer lastCompletedTargetIndexLatch(start=0,fixed=true) "lastCompleted目标IndexLatch" ;
  discrete Integer lastTerminalRequestIdLatch(start=0,fixed=true) "lastTerminal请求IdLatch" ;
  discrete OneSatSim.Foundation.Types.RejectReason lastTerminalReasonLatch(
    start=OneSatSim.Foundation.Types.RejectReason.None,fixed=true) "计算/接口量 lastTerminalReasonLatch" ;
  discrete Boolean timeoutLatch(start=false,fixed=true) "计算/接口量 timeoutLatch" ;
  discrete Integer activeId(start=0,fixed=true) "激活Id" ;
  discrete Integer activeTarget(start=0,fixed=true) "激活目标" ;
  discrete Integer activeStation(start=0,fixed=true) "激活站点" ;
  discrete Integer imagingRequestId(start=0,fixed=true) "成像请求Id" ;
  discrete Integer downlinkRequestId(start=0,fixed=true) "下传请求Id" ;
  discrete Integer safeRequestId(start=0,fixed=true) "安全模式请求Id" ;
  discrete OneSatSim.Foundation.Types.CommandType safeRequestCommand(start=OneSatSim.Foundation.Types.CommandType.None,fixed=true) "安全模式请求指令" ;
equation
  state.missionMode=mode;
  state.currentCommand=command;
  state.transitionCounter=transitions;
  state.stateElapsed=time-entryTime;
  state.executionTime=max(0,time-commandStartTime);
  state.activeRequestId=activeId;
  state.activeTargetIndex=activeTarget;
  state.activeGroundStationIndex=activeStation;
  state.controlMode=if mode == OneSatSim.Foundation.Types.MissionMode.Boot then OneSatSim.Foundation.Types.ControlMode.Initialization else 
    if mode == OneSatSim.Foundation.Types.MissionMode.TargetPreSlew or mode == OneSatSim.Foundation.Types.MissionMode.ImagingPreparation or mode == OneSatSim.Foundation.Types.MissionMode.Imaging then OneSatSim.Foundation.Types.ControlMode.TargetPointing else 
    if mode == OneSatSim.Foundation.Types.MissionMode.DownlinkPreparation or mode == OneSatSim.Foundation.Types.MissionMode.Downlink then OneSatSim.Foundation.Types.ControlMode.GroundPointing else 
    if mode == OneSatSim.Foundation.Types.MissionMode.SafeEntry or mode == OneSatSim.Foundation.Types.MissionMode.SafeHold then OneSatSim.Foundation.Types.ControlMode.SafeMode else OneSatSim.Foundation.Types.ControlMode.SunPointing;
  state.executionStatus=resultStatus;
  state.commandExecuting=mode <> OneSatSim.Foundation.Types.MissionMode.Idle and mode <> OneSatSim.Foundation.Types.MissionMode.Boot;
  state.commandCompleted=resultStatus == OneSatSim.Foundation.Types.CommandExecutionStatus.Completed;
  state.commandFailed=resultStatus == OneSatSim.Foundation.Types.CommandExecutionStatus.Failed;
  state.commandAborted=resultStatus == OneSatSim.Foundation.Types.CommandExecutionStatus.Aborted;
  state.commandTimeout=timeoutLatch;
  state.imagingActionRequestId=imagingRequestId;
  state.downlinkActionRequestId=downlinkRequestId;
  state.safeModeActionRequestId=safeRequestId;
  state.safeModeActionCommand=safeRequestCommand;
  state.lastRejectReason=lastRejectReasonLatch;
  state.terminalFailureReason=terminalFailureReasonLatch;
  state.terminalFailurePhase=terminalFailurePhaseLatch;
  state.terminalImagingPhase=terminalImagingPhaseLatch;
  state.terminalFailureCommand=terminalFailureCommandLatch;
  state.terminalFailureRequestId=terminalFailureRequestIdLatch;
  state.terminalFailureTargetIndex=terminalFailureTargetIndexLatch;
  state.completedImagingCount=completedImagingCountLatch;
  state.completedDownlinkCount=completedDownlinkCountLatch;
  state.lastCompletedTargetIndex=lastCompletedTargetIndexLatch;
  state.lastTerminalRequestId=lastTerminalRequestIdLatch;
  state.lastTerminalReason=lastTerminalReasonLatch;
  selection.targetIndex=activeTarget;
  selection.groundStationIndex=activeStation;
  imagingActionRequestIdOut=imagingRequestId;
  downlinkActionRequestIdOut=downlinkRequestId;
  safeModeActionRequestIdOut=safeRequestId;
  safeModeActionCommandOut=safeRequestCommand;
algorithm
  when {initial(),change(decision.decisionId),change(imagingStartedEventId),
      change(imagingCompletedEventId),change(imagingFailedEventId),
      change(imagingAbortedEventId),change(imagingTimeoutEventId),
      change(downlinkStartedEventId),change(downlinkCompletedEventId),
      change(downlinkFailedEventId),change(downlinkAbortedEventId),
      change(downlinkTimeoutEventId),change(safeEntryCompleteEventId),
      change(recoveryCompleteEventId),change(geometryEventId),time >= eventDeadline,
      time >= preSlewDeadline,time >= timeoutDeadline,
      time >= queuedTerminalDeadline} then
    if initial() then
      mode:=if operationalSnapshotStart then OneSatSim.Foundation.Types.MissionMode.Idle else OneSatSim.Foundation.Types.MissionMode.Boot;
      command:=OneSatSim.Foundation.Types.CommandType.None;
      resultStatus:=OneSatSim.Foundation.Types.CommandExecutionStatus.Idle;
      entryTime:=time;
      commandStartTime:=time;
      transitions:=0;
      eventDeadline:=1e100;
      timeoutDeadline:=if operationalSnapshotStart then 1e100 else time+bootDuration;
      preSlewDeadline:=1e100;
      preSlewElapsed:=false;
      pendingEvent:=0;
      pendingCommand:=OneSatSim.Foundation.Types.CommandType.None;
      pendingId:=0;
      pendingTarget:=0;
      pendingStation:=0;
      pendingAccepted:=false;
      pendingRejectReason:=OneSatSim.Foundation.Types.RejectReason.None;
      pendingImagingFailureReason:=OneSatSim.Foundation.Types.RejectReason.None;
      pendingImagingFailurePhase:=OneSatSim.Foundation.Types.ImagingPhase.Idle;
      pendingOpportunityTimeRemaining:=0;
      queuedDecisionValid:=false;
      queuedCommand:=OneSatSim.Foundation.Types.CommandType.None;
      queuedId:=0;
      queuedTarget:=0;
      queuedStation:=0;
      queuedWindow:=0;
      queuedOpportunityTimeRemaining:=0;
      queuedCaptureTime:=time;
      queuedTerminalDeadline:=1e100;
      queuedTerminalId:=0;
      queuedTerminalTarget:=0;
      queuedTerminalCommand:=OneSatSim.Foundation.Types.CommandType.None;
      queuedTerminalReason:=OneSatSim.Foundation.Types.RejectReason.None;
      lastRejectReasonLatch:=OneSatSim.Foundation.Types.RejectReason.None;
      terminalFailureReasonLatch:=OneSatSim.Foundation.Types.RejectReason.None;
      terminalFailurePhaseLatch:=OneSatSim.Foundation.Types.MissionMode.Idle;
      terminalImagingPhaseLatch:=OneSatSim.Foundation.Types.ImagingPhase.Idle;
      terminalFailureCommandLatch:=OneSatSim.Foundation.Types.CommandType.None;
      terminalFailureRequestIdLatch:=0;
      terminalFailureTargetIndexLatch:=0;
      completedImagingCountLatch:=0;
      completedDownlinkCountLatch:=0;
      lastCountedImagingRequestId:=0;
      lastCountedDownlinkRequestId:=0;
      lastCompletedTargetIndexLatch:=0;
      lastTerminalRequestIdLatch:=0;
      lastTerminalReasonLatch:=OneSatSim.Foundation.Types.RejectReason.None;
      timeoutLatch:=false;
      activeId:=0;
      activeTarget:=0;
      activeStation:=0;
      imagingRequestId:=0;
      downlinkRequestId:=0;
      safeRequestId:=0;
      safeRequestCommand:=OneSatSim.Foundation.Types.CommandType.None;
    elseif time >= pre(queuedTerminalDeadline) then
      // The active request terminal was already published at the prior event.
      // Publish the accepted queued request's stale-window terminal separately.
      queuedTerminalDeadline:=1e100;
      lastTerminalRequestIdLatch:=pre(queuedTerminalId);
      lastTerminalReasonLatch:=pre(queuedTerminalReason);
      lastRejectReasonLatch:=pre(queuedTerminalReason);
      terminalFailureReasonLatch:=pre(queuedTerminalReason);
      terminalFailurePhaseLatch:=OneSatSim.Foundation.Types.MissionMode.Idle;
      terminalImagingPhaseLatch:=OneSatSim.Foundation.Types.ImagingPhase.Idle;
      terminalFailureCommandLatch:=pre(queuedTerminalCommand);
      terminalFailureRequestIdLatch:=pre(queuedTerminalId);
      terminalFailureTargetIndexLatch:=pre(queuedTerminalTarget);
      resultStatus:=OneSatSim.Foundation.Types.CommandExecutionStatus.Rejected;
      queuedTerminalId:=0;
    elseif change(decision.decisionId) then
        pendingEvent:=1;
        pendingCommand:=decision.acceptedCommand;
        pendingId:=decision.acceptedCommandId;
        pendingTarget:=decision.acceptedTargetIndex;
        pendingStation:=decision.acceptedGroundStationIndex;
        pendingAccepted:=decision.accepted;
        pendingRejectReason:=decision.rejectReason;
        pendingOpportunityTimeRemaining:=decision.acceptedOpportunityTimeRemaining;
        eventDeadline:=time+eventSettleDelay;
      elseif change(imagingStartedEventId) then
        pendingEvent:=2;
        pendingId:=imagingStartedEventId;
        eventDeadline:=time+eventSettleDelay;
      elseif change(imagingCompletedEventId) then
        pendingEvent:=3;
        pendingId:=imagingCompletedEventId;
        eventDeadline:=time+eventSettleDelay;
      elseif change(imagingFailedEventId) then
        pendingEvent:=4;
        pendingId:=imagingFailedEventId;
        pendingImagingFailureReason:=imagingFailureReason;
        pendingImagingFailurePhase:=imagingFailurePhase;
        eventDeadline:=time+eventSettleDelay;
      elseif change(imagingAbortedEventId) then
        pendingEvent:=5;
        pendingId:=imagingAbortedEventId;
        pendingImagingFailureReason:=imagingFailureReason;
        pendingImagingFailurePhase:=imagingFailurePhase;
        eventDeadline:=time+eventSettleDelay;
      elseif change(imagingTimeoutEventId) then
        pendingEvent:=6;
        pendingId:=imagingTimeoutEventId;
        pendingImagingFailureReason:=imagingFailureReason;
        pendingImagingFailurePhase:=imagingFailurePhase;
        eventDeadline:=time+eventSettleDelay;
      elseif change(downlinkStartedEventId) then
        pendingEvent:=7;
        pendingId:=downlinkStartedEventId;
        eventDeadline:=time+eventSettleDelay;
      elseif change(downlinkCompletedEventId) then
        pendingEvent:=8;
        pendingId:=downlinkCompletedEventId;
        eventDeadline:=time+eventSettleDelay;
      elseif change(downlinkFailedEventId) then
        pendingEvent:=9;
        pendingId:=downlinkFailedEventId;
        eventDeadline:=time+eventSettleDelay;
      elseif change(downlinkAbortedEventId) then
        pendingEvent:=10;
        pendingId:=downlinkAbortedEventId;
        eventDeadline:=time+eventSettleDelay;
      elseif change(downlinkTimeoutEventId) then
        pendingEvent:=11;
        pendingId:=downlinkTimeoutEventId;
        eventDeadline:=time+eventSettleDelay;
      elseif change(safeEntryCompleteEventId) then
        pendingEvent:=12;
        pendingId:=safeEntryCompleteEventId;
        eventDeadline:=time+eventSettleDelay;
      elseif change(recoveryCompleteEventId) then
        pendingEvent:=13;
        pendingId:=recoveryCompleteEventId;
        eventDeadline:=time+eventSettleDelay;
      elseif change(geometryEventId) then
        pendingEvent:=14;
        pendingId:=geometryEventId;
        eventDeadline:=time+eventSettleDelay;
      elseif time >= pre(preSlewDeadline) then
        preSlewDeadline:=1e100;
        preSlewElapsed:=true;
        if pre(mode) == OneSatSim.Foundation.Types.MissionMode.TargetPreSlew and pre(targetPreparationReady) and 
            pre(targetPreparationIndex) == pre(activeTarget) then
          mode:=OneSatSim.Foundation.Types.MissionMode.ImagingPreparation;
          entryTime:=time;
          transitions:=pre(transitions)+1;
          timeoutDeadline:=time+imagingPreparationTimeout;
          imagingRequestId:=pre(activeId);
          preSlewElapsed:=false;
        elseif pre(mode) == OneSatSim.Foundation.Types.MissionMode.TargetPreSlew and not pre(targetEarlyOpportunity) then
          terminalFailureReasonLatch:=OneSatSim.Foundation.Types.RejectReason.PreSlewOpportunityLost;
          terminalFailurePhaseLatch:=pre(mode);
          terminalImagingPhaseLatch:=OneSatSim.Foundation.Types.ImagingPhase.Idle;
          terminalFailureCommandLatch:=OneSatSim.Foundation.Types.CommandType.Imaging;
          terminalFailureRequestIdLatch:=pre(activeId);
          terminalFailureTargetIndexLatch:=pre(activeTarget);
          lastTerminalRequestIdLatch:=pre(activeId);
          lastTerminalReasonLatch:=OneSatSim.Foundation.Types.RejectReason.PreSlewOpportunityLost;
          mode:=OneSatSim.Foundation.Types.MissionMode.Idle;
          command:=OneSatSim.Foundation.Types.CommandType.Imaging;
          resultStatus:=OneSatSim.Foundation.Types.CommandExecutionStatus.Failed;
          entryTime:=time;
          transitions:=pre(transitions)+1;
          activeId:=0;
          activeTarget:=0;
          imagingRequestId:=0;
          preSlewElapsed:=false;
        elseif pre(mode) == OneSatSim.Foundation.Types.MissionMode.TargetPreSlew then
          timeoutDeadline:=time+imagingPreparationTimeout;
        end if;
      elseif time >= pre(eventDeadline) then
        eventDeadline:=1e100;
        pendingEvent:=0;
        if pre(pendingEvent) == 1 then
          timeoutLatch:=false;
          if not pre(pendingAccepted) then
            resultStatus:=OneSatSim.Foundation.Types.CommandExecutionStatus.Rejected;
            lastRejectReasonLatch:=pre(pendingRejectReason);
          elseif pre(pendingCommand) == OneSatSim.Foundation.Types.CommandType.EnterSafeMode then
            mode:=OneSatSim.Foundation.Types.MissionMode.SafeEntry;
            command:=OneSatSim.Foundation.Types.CommandType.EnterSafeMode;
            resultStatus:=OneSatSim.Foundation.Types.CommandExecutionStatus.Executing;
            entryTime:=time;
            commandStartTime:=time;
            transitions:=pre(transitions)+1;
            timeoutDeadline:=time+5;
            preSlewDeadline:=1e100;
            preSlewElapsed:=false;
            activeId:=0;
            activeTarget:=0;
            activeStation:=0;
            safeRequestId:=pre(pendingId);
            safeRequestCommand:=OneSatSim.Foundation.Types.CommandType.EnterSafeMode;
          elseif pre(mode) == OneSatSim.Foundation.Types.MissionMode.SafeHold and pre(pendingCommand) == OneSatSim.Foundation.Types.CommandType.ExitSafeMode then
            mode:=OneSatSim.Foundation.Types.MissionMode.Recovery;
            command:=OneSatSim.Foundation.Types.CommandType.ExitSafeMode;
            resultStatus:=OneSatSim.Foundation.Types.CommandExecutionStatus.Executing;
            entryTime:=time;
            commandStartTime:=time;
            transitions:=pre(transitions)+1;
            timeoutDeadline:=time+30;
            safeRequestId:=pre(pendingId);
            safeRequestCommand:=OneSatSim.Foundation.Types.CommandType.ExitSafeMode;
          elseif pre(pendingAccepted) and 
              pre(pendingCommand) == OneSatSim.Foundation.Types.CommandType.Imaging and 
              (pre(mode) == OneSatSim.Foundation.Types.MissionMode.DownlinkPreparation or 
               pre(mode) == OneSatSim.Foundation.Types.MissionMode.Downlink) and 
              pre(pendingOpportunityTimeRemaining) >= requiredImagingOpportunityTime then
            // A time-limited imaging opportunity has priority over a restartable
            // downlink.  Clearing the active station asks the downlink sequencer
            // to stop at its discrete action boundary; stored data remains intact.
            // The old downlink request is terminal here. Its later sequencer
            // abort event carries the old ID and cannot terminate the new image.
            terminalFailureReasonLatch:=OneSatSim.Foundation.Types.RejectReason.SafetyPreempted;
            terminalFailurePhaseLatch:=pre(mode);
            terminalImagingPhaseLatch:=OneSatSim.Foundation.Types.ImagingPhase.Idle;
            terminalFailureCommandLatch:=OneSatSim.Foundation.Types.CommandType.Downlink;
            terminalFailureRequestIdLatch:=pre(activeId);
            terminalFailureTargetIndexLatch:=0;
            lastTerminalRequestIdLatch:=pre(activeId);
            lastTerminalReasonLatch:=OneSatSim.Foundation.Types.RejectReason.SafetyPreempted;
            mode:=OneSatSim.Foundation.Types.MissionMode.TargetPreSlew;
            command:=OneSatSim.Foundation.Types.CommandType.Imaging;
            resultStatus:=OneSatSim.Foundation.Types.CommandExecutionStatus.Executing;
            entryTime:=time;
            commandStartTime:=time;
            transitions:=pre(transitions)+1;
            timeoutDeadline:=1e100;
            preSlewDeadline:=time+targetPreSlewDuration;
            preSlewElapsed:=false;
            activeId:=pre(pendingId);
            activeTarget:=pre(pendingTarget);
            activeStation:=0;
            lastRejectReasonLatch:=OneSatSim.Foundation.Types.RejectReason.None;
          elseif pre(mode) == OneSatSim.Foundation.Types.MissionMode.Idle and pre(pendingCommand) == OneSatSim.Foundation.Types.CommandType.Imaging then
            mode:=OneSatSim.Foundation.Types.MissionMode.TargetPreSlew;
            command:=OneSatSim.Foundation.Types.CommandType.Imaging;
            resultStatus:=OneSatSim.Foundation.Types.CommandExecutionStatus.Executing;
            entryTime:=time;
            commandStartTime:=time;
            transitions:=pre(transitions)+1;
            timeoutDeadline:=1e100;
            preSlewDeadline:=time+targetPreSlewDuration;
            preSlewElapsed:=false;
            activeId:=pre(pendingId);
            activeTarget:=pre(pendingTarget);
            activeStation:=0;
            lastRejectReasonLatch:=OneSatSim.Foundation.Types.RejectReason.None;
          elseif pre(mode) == OneSatSim.Foundation.Types.MissionMode.Idle and pre(pendingCommand) == OneSatSim.Foundation.Types.CommandType.Downlink then
            mode:=OneSatSim.Foundation.Types.MissionMode.DownlinkPreparation;
            command:=OneSatSim.Foundation.Types.CommandType.Downlink;
            resultStatus:=OneSatSim.Foundation.Types.CommandExecutionStatus.Executing;
            entryTime:=time;
            commandStartTime:=time;
            transitions:=pre(transitions)+1;
            timeoutDeadline:=time+downlinkPreparationTimeout;
            activeId:=pre(pendingId);
            activeTarget:=0;
            activeStation:=pre(pendingStation);
            downlinkRequestId:=pre(pendingId);
            lastRejectReasonLatch:=OneSatSim.Foundation.Types.RejectReason.None;
          elseif pre(pendingAccepted) and 
              (pre(pendingCommand) == OneSatSim.Foundation.Types.CommandType.Imaging or 
               pre(pendingCommand) == OneSatSim.Foundation.Types.CommandType.Downlink) then
            if not pre(queuedDecisionValid) then
              queuedDecisionValid:=true;
              queuedCommand:=pre(pendingCommand);
              queuedId:=pre(pendingId);
              queuedTarget:=pre(pendingTarget);
              queuedStation:=pre(pendingStation);
              queuedWindow:=if pre(pendingCommand) == OneSatSim.Foundation.Types.CommandType.Imaging then 
                div(pre(pendingId)-1000000,1000) else div(pre(pendingId)-2000000,1000);
              queuedOpportunityTimeRemaining:=pre(pendingOpportunityTimeRemaining);
              queuedCaptureTime:=time;
            else
              // This request was accepted by the arbiter, so it must receive
              // a terminal ID even though the one-slot queue is occupied.
              lastRejectReasonLatch:=OneSatSim.Foundation.Types.RejectReason.Busy;
              lastTerminalRequestIdLatch:=pre(pendingId);
              lastTerminalReasonLatch:=OneSatSim.Foundation.Types.RejectReason.Busy;
              terminalFailureReasonLatch:=OneSatSim.Foundation.Types.RejectReason.Busy;
              terminalFailurePhaseLatch:=pre(mode);
              terminalImagingPhaseLatch:=OneSatSim.Foundation.Types.ImagingPhase.Idle;
              terminalFailureCommandLatch:=pre(pendingCommand);
              terminalFailureRequestIdLatch:=pre(pendingId);
              terminalFailureTargetIndexLatch:=pre(pendingTarget);
            end if;
          end if;
        elseif pre(pendingEvent) == 2 and pre(pendingId) == pre(activeId) and pre(mode) == OneSatSim.Foundation.Types.MissionMode.ImagingPreparation then
          mode:=OneSatSim.Foundation.Types.MissionMode.Imaging;
          entryTime:=time;
          transitions:=pre(transitions)+1;
          timeoutDeadline:=1e100;
        elseif pre(pendingEvent) == 7 and pre(pendingId) == pre(activeId) and pre(mode) == OneSatSim.Foundation.Types.MissionMode.DownlinkPreparation then
          mode:=OneSatSim.Foundation.Types.MissionMode.Downlink;
          entryTime:=time;
          transitions:=pre(transitions)+1;
          timeoutDeadline:=1e100;
        elseif pre(pendingEvent) >= 3 and pre(pendingEvent) <= 6 and pre(pendingId) == pre(activeId) then
          if pre(pendingEvent) == 3 and pre(activeId) > 0 and 
              pre(activeId) <> pre(lastCountedImagingRequestId) then
            completedImagingCountLatch:=pre(completedImagingCountLatch)+1;
            lastCountedImagingRequestId:=pre(activeId);
            lastCompletedTargetIndexLatch:=pre(activeTarget);
          end if;
          lastTerminalRequestIdLatch:=pre(activeId);
          lastTerminalReasonLatch:=if pre(pendingEvent) == 3 then 
            OneSatSim.Foundation.Types.RejectReason.None else 
            if pre(pendingEvent) == 5 then OneSatSim.Foundation.Types.RejectReason.SafetyPreempted else 
            if pre(pendingEvent) == 6 then OneSatSim.Foundation.Types.RejectReason.Timeout else 
            pre(pendingImagingFailureReason);
          if pre(pendingEvent) <> 3 then
            terminalFailureReasonLatch:=if pre(pendingEvent) == 5 then 
              OneSatSim.Foundation.Types.RejectReason.SafetyPreempted else 
              if pre(pendingEvent) == 6 then OneSatSim.Foundation.Types.RejectReason.Timeout else 
              pre(pendingImagingFailureReason);
            terminalFailurePhaseLatch:=pre(mode);
            terminalImagingPhaseLatch:=pre(pendingImagingFailurePhase);
            terminalFailureCommandLatch:=OneSatSim.Foundation.Types.CommandType.Imaging;
            terminalFailureRequestIdLatch:=pre(activeId);
            terminalFailureTargetIndexLatch:=pre(activeTarget);
          end if;
          mode:=OneSatSim.Foundation.Types.MissionMode.Idle;
          command:=OneSatSim.Foundation.Types.CommandType.None;
          resultStatus:=if pre(pendingEvent) == 3 then OneSatSim.Foundation.Types.CommandExecutionStatus.Completed else 
            if pre(pendingEvent) == 5 then OneSatSim.Foundation.Types.CommandExecutionStatus.Aborted else OneSatSim.Foundation.Types.CommandExecutionStatus.Failed;
          timeoutLatch:=pre(pendingEvent) == 6;
          entryTime:=time;
          transitions:=pre(transitions)+1;
          timeoutDeadline:=1e100;
          activeId:=0;
          activeTarget:=0;
          if pre(queuedDecisionValid) then
            if pre(queuedOpportunityTimeRemaining)-(time-pre(queuedCaptureTime)) >=
                (if pre(queuedCommand) == OneSatSim.Foundation.Types.CommandType.Imaging then 
                  requiredImagingOpportunityTime else requiredDownlinkOpportunityTime) then
              pendingEvent:=1;
              pendingCommand:=pre(queuedCommand);
              pendingId:=pre(queuedId);
              pendingTarget:=pre(queuedTarget);
              pendingStation:=pre(queuedStation);
              pendingAccepted:=true;
              pendingOpportunityTimeRemaining:=pre(queuedOpportunityTimeRemaining)-(time-pre(queuedCaptureTime));
              eventDeadline:=time+eventSettleDelay;
            else
              queuedTerminalId:=pre(queuedId);
              queuedTerminalTarget:=pre(queuedTarget);
              queuedTerminalCommand:=pre(queuedCommand);
              queuedTerminalReason:=if pre(queuedOpportunityTimeRemaining)-(time-pre(queuedCaptureTime)) > 0 then 
                OneSatSim.Foundation.Types.RejectReason.InsufficientOpportunityTime else 
                OneSatSim.Foundation.Types.RejectReason.StaleOpportunity;
              queuedTerminalDeadline:=time+eventSettleDelay;
            end if;
            queuedDecisionValid:=false;
          end if;
        elseif pre(pendingEvent) >= 8 and pre(pendingEvent) <= 11 and pre(pendingId) == pre(activeId) then
          if pre(pendingEvent) == 8 and pre(activeId) > 0 and 
              pre(activeId) <> pre(lastCountedDownlinkRequestId) then
            completedDownlinkCountLatch:=pre(completedDownlinkCountLatch)+1;
            lastCountedDownlinkRequestId:=pre(activeId);
          end if;
          lastTerminalRequestIdLatch:=pre(activeId);
          lastTerminalReasonLatch:=if pre(pendingEvent) == 8 then 
            OneSatSim.Foundation.Types.RejectReason.None else 
            if pre(pendingEvent) == 10 then OneSatSim.Foundation.Types.RejectReason.SafetyPreempted else 
            if pre(pendingEvent) == 11 then OneSatSim.Foundation.Types.RejectReason.Timeout else 
            OneSatSim.Foundation.Types.RejectReason.InvalidState;
          if pre(pendingEvent) <> 8 then
            terminalFailureReasonLatch:=if pre(pendingEvent) == 10 then 
              OneSatSim.Foundation.Types.RejectReason.SafetyPreempted else 
              if pre(pendingEvent) == 11 then OneSatSim.Foundation.Types.RejectReason.Timeout else 
              OneSatSim.Foundation.Types.RejectReason.InvalidState;
            terminalFailurePhaseLatch:=pre(mode);
            terminalImagingPhaseLatch:=OneSatSim.Foundation.Types.ImagingPhase.Idle;
            terminalFailureCommandLatch:=OneSatSim.Foundation.Types.CommandType.Downlink;
            terminalFailureRequestIdLatch:=pre(activeId);
            terminalFailureTargetIndexLatch:=0;
          end if;
          mode:=OneSatSim.Foundation.Types.MissionMode.Idle;
          command:=OneSatSim.Foundation.Types.CommandType.None;
          resultStatus:=if pre(pendingEvent) == 8 then OneSatSim.Foundation.Types.CommandExecutionStatus.Completed else 
            if pre(pendingEvent) == 10 then OneSatSim.Foundation.Types.CommandExecutionStatus.Aborted else OneSatSim.Foundation.Types.CommandExecutionStatus.Failed;
          timeoutLatch:=pre(pendingEvent) == 11;
          entryTime:=time;
          transitions:=pre(transitions)+1;
          timeoutDeadline:=1e100;
          activeId:=0;
          activeStation:=0;
          if pre(queuedDecisionValid) then
            if pre(queuedOpportunityTimeRemaining)-(time-pre(queuedCaptureTime)) >=
                (if pre(queuedCommand) == OneSatSim.Foundation.Types.CommandType.Imaging then 
                  requiredImagingOpportunityTime else requiredDownlinkOpportunityTime) then
              pendingEvent:=1;
              pendingCommand:=pre(queuedCommand);
              pendingId:=pre(queuedId);
              pendingTarget:=pre(queuedTarget);
              pendingStation:=pre(queuedStation);
              pendingAccepted:=true;
              pendingOpportunityTimeRemaining:=pre(queuedOpportunityTimeRemaining)-(time-pre(queuedCaptureTime));
              eventDeadline:=time+eventSettleDelay;
            else
              queuedTerminalId:=pre(queuedId);
              queuedTerminalTarget:=pre(queuedTarget);
              queuedTerminalCommand:=pre(queuedCommand);
              queuedTerminalReason:=if pre(queuedOpportunityTimeRemaining)-(time-pre(queuedCaptureTime)) > 0 then 
                OneSatSim.Foundation.Types.RejectReason.InsufficientOpportunityTime else 
                OneSatSim.Foundation.Types.RejectReason.StaleOpportunity;
              queuedTerminalDeadline:=time+eventSettleDelay;
            end if;
            queuedDecisionValid:=false;
          end if;
        elseif pre(pendingEvent) == 12 and pre(mode) == OneSatSim.Foundation.Types.MissionMode.SafeEntry then
          mode:=OneSatSim.Foundation.Types.MissionMode.SafeHold;
          entryTime:=time;
          transitions:=pre(transitions)+1;
          timeoutDeadline:=1e100;
        elseif pre(pendingEvent) == 13 and pre(mode) == OneSatSim.Foundation.Types.MissionMode.Recovery then
          mode:=OneSatSim.Foundation.Types.MissionMode.Idle;
          command:=OneSatSim.Foundation.Types.CommandType.None;
          resultStatus:=OneSatSim.Foundation.Types.CommandExecutionStatus.Completed;
          entryTime:=time;
          transitions:=pre(transitions)+1;
          timeoutDeadline:=1e100;
        elseif pre(pendingEvent) == 14 and pre(mode) == OneSatSim.Foundation.Types.MissionMode.TargetPreSlew and pre(preSlewElapsed) then
          if pre(targetPreparationReady) and pre(targetPreparationIndex) == pre(activeTarget) then
            mode:=OneSatSim.Foundation.Types.MissionMode.ImagingPreparation;
            entryTime:=time;
            transitions:=pre(transitions)+1;
            timeoutDeadline:=time+imagingPreparationTimeout;
            imagingRequestId:=pre(activeId);
            preSlewElapsed:=false;
          elseif not pre(targetEarlyOpportunity) then
            terminalFailureReasonLatch:=OneSatSim.Foundation.Types.RejectReason.PreSlewOpportunityLost;
            terminalFailurePhaseLatch:=pre(mode);
            terminalImagingPhaseLatch:=OneSatSim.Foundation.Types.ImagingPhase.Idle;
            terminalFailureCommandLatch:=OneSatSim.Foundation.Types.CommandType.Imaging;
            terminalFailureRequestIdLatch:=pre(activeId);
            terminalFailureTargetIndexLatch:=pre(activeTarget);
            lastTerminalRequestIdLatch:=pre(activeId);
            lastTerminalReasonLatch:=OneSatSim.Foundation.Types.RejectReason.PreSlewOpportunityLost;
            mode:=OneSatSim.Foundation.Types.MissionMode.Idle;
            command:=OneSatSim.Foundation.Types.CommandType.Imaging;
            resultStatus:=OneSatSim.Foundation.Types.CommandExecutionStatus.Failed;
            entryTime:=time;
            transitions:=pre(transitions)+1;
            activeId:=0;
            activeTarget:=0;
            imagingRequestId:=0;
            preSlewElapsed:=false;
          end if;
        end if;
      elseif time >= pre(timeoutDeadline) then
        timeoutDeadline:=1e100;
        if pre(mode) == OneSatSim.Foundation.Types.MissionMode.Boot then
          mode:=OneSatSim.Foundation.Types.MissionMode.Idle;
          command:=OneSatSim.Foundation.Types.CommandType.None;
          resultStatus:=OneSatSim.Foundation.Types.CommandExecutionStatus.Idle;
          entryTime:=time;
          transitions:=pre(transitions)+1;
        elseif pre(mode) == OneSatSim.Foundation.Types.MissionMode.TargetPreSlew or 
            pre(mode) == OneSatSim.Foundation.Types.MissionMode.ImagingPreparation or 
            pre(mode) == OneSatSim.Foundation.Types.MissionMode.DownlinkPreparation then
          terminalFailureReasonLatch:=OneSatSim.Foundation.Types.RejectReason.Timeout;
          terminalFailurePhaseLatch:=pre(mode);
          terminalImagingPhaseLatch:=OneSatSim.Foundation.Types.ImagingPhase.Idle;
          terminalFailureCommandLatch:=pre(command);
          terminalFailureRequestIdLatch:=pre(activeId);
          terminalFailureTargetIndexLatch:=pre(activeTarget);
          lastTerminalRequestIdLatch:=pre(activeId);
          lastTerminalReasonLatch:=OneSatSim.Foundation.Types.RejectReason.Timeout;
          mode:=OneSatSim.Foundation.Types.MissionMode.Idle;
          command:=OneSatSim.Foundation.Types.CommandType.None;
          resultStatus:=OneSatSim.Foundation.Types.CommandExecutionStatus.Failed;
          timeoutLatch:=true;
          entryTime:=time;
          transitions:=pre(transitions)+1;
          activeId:=0;
          activeTarget:=0;
          activeStation:=0;
          preSlewDeadline:=1e100;
          preSlewElapsed:=false;
        elseif pre(mode) == OneSatSim.Foundation.Types.MissionMode.SafeEntry then
          mode:=OneSatSim.Foundation.Types.MissionMode.SafeHold;
          entryTime:=time;
          transitions:=pre(transitions)+1;
        elseif pre(mode) == OneSatSim.Foundation.Types.MissionMode.Recovery then
          mode:=OneSatSim.Foundation.Types.MissionMode.Idle;
          command:=OneSatSim.Foundation.Types.CommandType.None;
          resultStatus:=OneSatSim.Foundation.Types.CommandExecutionStatus.Completed;
          entryTime:=time;
          transitions:=pre(transitions)+1;
        end if;
    end if;
  end when;
equation
  annotation(Documentation(info="<html><h2>单向动作握手的事件驱动任务状态机</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Models.MissionStateMachine</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>单向动作握手的事件驱动任务状态机</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.MissionControlUnit\">OneSatSim.Components.MissionControlUnit</a> 的 <code>stateMachine</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>decision</code></td><td>OneSatSim.Foundation.Interfaces.ArbiterDecisionSignals</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 decision</td></tr><tr><td><code>imagingStartedEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>成像StartedEventId</td></tr><tr><td><code>imagingCompletedEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>成像完成对象ID</td></tr><tr><td><code>imagingFailedEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>成像FailedEventId</td></tr><tr><td><code>imagingAbortedEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>成像AbortedEventId</td></tr><tr><td><code>imagingTimeoutEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>成像TimeoutEventId</td></tr><tr><td><code>downlinkStartedEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>下传StartedEventId</td></tr><tr><td><code>downlinkCompletedEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>数传完成对象ID</td></tr><tr><td><code>downlinkFailedEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>下传FailedEventId</td></tr><tr><td><code>downlinkAbortedEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>下传AbortedEventId</td></tr><tr><td><code>downlinkTimeoutEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>下传TimeoutEventId</td></tr><tr><td><code>safeEntryCompleteEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>安全模式EntryCompleteEventId</td></tr><tr><td><code>recoveryCompleteEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 recoveryCompleteEventId</td></tr><tr><td><code>geometryEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>几何EventId</td></tr><tr><td><code>targetPreparationReady</code></td><td>Modelica.Blocks.Interfaces.BooleanInput</td><td>public</td><td>按声明/类型合同</td><td>目标Preparation就绪</td></tr><tr><td><code>targetEarlyOpportunity</code></td><td>Modelica.Blocks.Interfaces.BooleanInput</td><td>public</td><td>按声明/类型合同</td><td>目标EarlyOpportunity</td></tr><tr><td><code>targetPreparationIndex</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>目标PreparationIndex</td></tr><tr><td><code>imagingFailureReason</code></td><td>OneSatSim.Foundation.Interfaces.RejectReasonInput</td><td>public</td><td>按声明/类型合同</td><td>当前/最近一次成像持久化终止原因；Sequencer&#x27;s actual failure reason, sampled at its terminal event</td></tr><tr><td><code>imagingFailurePhase</code></td><td>OneSatSim.Foundation.Interfaces.ImagingPhaseInput</td><td>public</td><td>按声明/类型合同</td><td>成像FailurePhase；Sequencer phase that triggered its terminal failure</td></tr><tr><td><code>imagingActionRequestIdOut</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>成像Action请求IdOut</td></tr><tr><td><code>downlinkActionRequestIdOut</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>下传Action请求IdOut</td></tr><tr><td><code>safeModeActionRequestIdOut</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>安全模式模式Action请求IdOut</td></tr><tr><td><code>safeModeActionCommandOut</code></td><td>OneSatSim.Foundation.Interfaces.CommandTypeOutput</td><td>public</td><td>按声明/类型合同</td><td>安全模式模式Action指令Out</td></tr><tr><td><code>state</code></td><td>OneSatSim.Foundation.Interfaces.MissionStateSignals</td><td>public</td><td>按声明/类型合同</td><td>状态值或模式码</td></tr><tr><td><code>selection</code></td><td>OneSatSim.Foundation.Interfaces.ActiveMissionSelectionOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 selection</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>bootDuration</code></td><td>Real</td><td>配置项 bootDuration [s]</td><td><code>=10</code></td></tr><tr><td><code>imagingCapabilities</code></td><td>OneSatSim.Foundation.Types.ImagingCapabilities</td><td>成像Capabilities；Shared Earth-camera and imaging opportunity capability</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>operationalSnapshotStart</code></td><td>Boolean</td><td>配置项 operationalSnapshotStart</td><td><code>=true</code></td></tr><tr><td><code>imagingPreparationTimeout</code></td><td>Real</td><td>成像PreparationTimeout [s]</td><td><code>=90</code></td></tr><tr><td><code>downlinkPreparationTimeout</code></td><td>Real</td><td>下传PreparationTimeout [s]</td><td><code>=180</code></td></tr><tr><td><code>targetPreSlewDuration</code></td><td>Real</td><td>目标PreSlewDuration [s]</td><td><code>=imagingCapabilities.preSlewDuration_s</code></td></tr><tr><td><code>requiredImagingOpportunityTime</code></td><td>Real</td><td>required成像Opportunity时间 [s]</td><td><code>= imagingCapabilities.requiredOpportunityTime_s</code></td></tr><tr><td><code>requiredDownlinkOpportunityTime</code></td><td>Real</td><td>上电、初始化、主视轴驻留、建链、最小有效发送和关机余量 [s]</td><td><code>=30</code></td></tr><tr><td><code>eventSettleDelay</code></td><td>Real</td><td>配置项 eventSettleDelay [s]</td><td><code>=1e-4</code></td></tr></table><h3>状态与初始化</h3><p>本类源码中显式出现的导数对象或离散声明：<code>mode, command, resultStatus, entryTime, commandStartTime, transitions, eventDeadline, timeoutDeadline, preSlewDeadline, preSlewElapsed, pendingEvent, pendingCommand, pendingId, pendingTarget, pendingStation, pendingAccepted, pendingRejectReason, pendingImagingFailureReason, pendingImagingFailurePhase, pendingOpportunityTimeRemaining, queuedDecisionValid, queuedCommand, queuedId, queuedTarget, queuedStation, queuedWindow, queuedOpportunityTimeRemaining, queuedCaptureTime, queuedTerminalDeadline, queuedTerminalId, queuedTerminalTarget, queuedTerminalCommand, queuedTerminalReason, lastRejectReasonLatch, terminalFailureReasonLatch, terminalFailurePhaseLatch, terminalImagingPhaseLatch, terminalFailureCommandLatch, terminalFailureRequestIdLatch, terminalFailureTargetIndexLatch, completedImagingCountLatch, completedDownlinkCountLatch, lastCountedImagingRequestId, lastCountedDownlinkRequestId, lastCompletedTargetIndexLatch, lastTerminalRequestIdLatch, lastTerminalReasonLatch, timeoutLatch, activeId, activeTarget, activeStation, imagingRequestId, downlinkRequestId, safeRequestId, safeRequestCommand</code>。初始化取当前声明的 start/fixed、initial 方程/算法及继承设置。此处是源码级说明，不等同于编译后连续状态统计。</p><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] state.missionMode=mode;\n[equation] state.currentCommand=command;\n[equation] state.transitionCounter=transitions;\n[equation] state.stateElapsed=time-entryTime;\n[equation] state.executionTime=max(0,time-commandStartTime);\n[equation] state.activeRequestId=activeId;\n[equation] state.activeTargetIndex=activeTarget;\n[equation] state.activeGroundStationIndex=activeStation;\n[equation] state.controlMode=if mode == OneSatSim.Foundation.Types.MissionMode.Boot then OneSatSim.Foundation.Types.ControlMode.Initialization else if mode == OneSatSim.Foundation.Types.MissionMode.TargetPreSlew or mode == OneSatSim.Foundation.Types.MissionMode.ImagingPreparation or mode == OneSatSim.Foundation.Types.MissionMode.Imaging then OneSatSim.Foundation.Types.ControlMode.TargetPointing else if mode == OneSatSim.Foundation.Types.MissionMode.DownlinkPreparation or mode == OneSatSim.Foundation.Types.MissionMode.Downlink then OneSatSim.Foundation.Types.ControlMode.GroundPointing else if mode == OneS …（完整表达式见源码）\n[equation] state.executionStatus=resultStatus;</pre><p>本类另有422段语句；阅读完整源码可查看其余边界与逻辑。</p><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>mode</code></td><td>OneSatSim.Foundation.Types.MissionMode</td><td>discrete</td><td>按声明/类型合同</td><td>模式</td></tr><tr><td><code>command</code></td><td>OneSatSim.Foundation.Types.CommandType</td><td>discrete</td><td>按声明/类型合同</td><td>指令</td></tr><tr><td><code>resultStatus</code></td><td>OneSatSim.Foundation.Types.CommandExecutionStatus</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 resultStatus</td></tr><tr><td><code>entryTime</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>entry时间</td></tr><tr><td><code>commandStartTime</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>指令Start时间</td></tr><tr><td><code>transitions</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 transitions</td></tr><tr><td><code>eventDeadline</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 eventDeadline</td></tr><tr><td><code>timeoutDeadline</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 timeoutDeadline</td></tr><tr><td><code>preSlewDeadline</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 preSlewDeadline</td></tr><tr><td><code>preSlewElapsed</code></td><td>Boolean</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 preSlewElapsed</td></tr><tr><td><code>pendingEvent</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 pendingEvent</td></tr><tr><td><code>pendingCommand</code></td><td>OneSatSim.Foundation.Types.CommandType</td><td>discrete</td><td>按声明/类型合同</td><td>pending指令</td></tr><tr><td><code>pendingId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 pendingId</td></tr><tr><td><code>pendingTarget</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>pending目标</td></tr><tr><td><code>pendingStation</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>pending站点</td></tr><tr><td><code>pendingAccepted</code></td><td>Boolean</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 pendingAccepted</td></tr><tr><td><code>pendingRejectReason</code></td><td>OneSatSim.Foundation.Types.RejectReason</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 pendingRejectReason</td></tr><tr><td><code>pendingImagingFailureReason</code></td><td>OneSatSim.Foundation.Types.RejectReason</td><td>discrete</td><td>按声明/类型合同</td><td>pending成像FailureReason</td></tr><tr><td><code>pendingImagingFailurePhase</code></td><td>OneSatSim.Foundation.Types.ImagingPhase</td><td>discrete</td><td>按声明/类型合同</td><td>pending成像FailurePhase</td></tr><tr><td><code>pendingOpportunityTimeRemaining</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>pendingOpportunity时间Remaining</td></tr><tr><td><code>queuedDecisionValid</code></td><td>Boolean</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 queuedDecisionValid</td></tr><tr><td><code>queuedCommand</code></td><td>OneSatSim.Foundation.Types.CommandType</td><td>discrete</td><td>按声明/类型合同</td><td>queued指令</td></tr><tr><td><code>queuedId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 queuedId</td></tr><tr><td><code>queuedTarget</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>queued目标</td></tr><tr><td><code>queuedStation</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>queued站点</td></tr><tr><td><code>queuedWindow</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 queuedWindow</td></tr><tr><td><code>queuedOpportunityTimeRemaining</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>queuedOpportunity时间Remaining</td></tr><tr><td><code>queuedCaptureTime</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>queuedCapture时间</td></tr><tr><td><code>queuedTerminalDeadline</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 queuedTerminalDeadline</td></tr><tr><td><code>queuedTerminalId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 queuedTerminalId</td></tr><tr><td><code>queuedTerminalTarget</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>queuedTerminal目标</td></tr><tr><td><code>queuedTerminalCommand</code></td><td>OneSatSim.Foundation.Types.CommandType</td><td>discrete</td><td>按声明/类型合同</td><td>queuedTerminal指令</td></tr><tr><td><code>queuedTerminalReason</code></td><td>OneSatSim.Foundation.Types.RejectReason</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 queuedTerminalReason</td></tr><tr><td><code>lastRejectReasonLatch</code></td><td>OneSatSim.Foundation.Types.RejectReason</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 lastRejectReasonLatch</td></tr><tr><td><code>terminalFailureReasonLatch</code></td><td>OneSatSim.Foundation.Types.RejectReason</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 terminalFailureReasonLatch</td></tr><tr><td><code>terminalFailurePhaseLatch</code></td><td>OneSatSim.Foundation.Types.MissionMode</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 terminalFailurePhaseLatch</td></tr><tr><td><code>terminalImagingPhaseLatch</code></td><td>OneSatSim.Foundation.Types.ImagingPhase</td><td>discrete</td><td>按声明/类型合同</td><td>terminal成像PhaseLatch</td></tr><tr><td><code>terminalFailureCommandLatch</code></td><td>OneSatSim.Foundation.Types.CommandType</td><td>discrete</td><td>按声明/类型合同</td><td>terminalFailure指令Latch</td></tr><tr><td><code>terminalFailureRequestIdLatch</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>terminalFailure请求IdLatch</td></tr><tr><td><code>terminalFailureTargetIndexLatch</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>terminalFailure目标IndexLatch</td></tr><tr><td><code>completedImagingCountLatch</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>completed成像CountLatch</td></tr><tr><td><code>completedDownlinkCountLatch</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>completed下传CountLatch</td></tr><tr><td><code>lastCountedImagingRequestId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>lastCounted成像请求Id</td></tr><tr><td><code>lastCountedDownlinkRequestId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>lastCounted下传请求Id</td></tr><tr><td><code>lastCompletedTargetIndexLatch</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>lastCompleted目标IndexLatch</td></tr><tr><td><code>lastTerminalRequestIdLatch</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>lastTerminal请求IdLatch</td></tr><tr><td><code>lastTerminalReasonLatch</code></td><td>OneSatSim.Foundation.Types.RejectReason</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 lastTerminalReasonLatch</td></tr><tr><td><code>timeoutLatch</code></td><td>Boolean</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 timeoutLatch</td></tr><tr><td><code>activeId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>激活Id</td></tr><tr><td><code>activeTarget</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>激活目标</td></tr><tr><td><code>activeStation</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>激活站点</td></tr><tr><td><code>imagingRequestId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>成像请求Id</td></tr><tr><td><code>downlinkRequestId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>下传请求Id</td></tr><tr><td><code>safeRequestId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>安全模式请求Id</td></tr><tr><td><code>safeRequestCommand</code></td><td>OneSatSim.Foundation.Types.CommandType</td><td>discrete</td><td>按声明/类型合同</td><td>安全模式请求指令</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-36,26},{-11,26}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{13,26},{37,26}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{49,14},{49,-11}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{37,-23},{12,-23}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-12,-23},{-36,-23}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{-60,15},{-36,37}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{-11,15},{13,37}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{37,15},{61,37}}, lineColor={0,0,0}, fillColor={236,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Ellipse(extent={{45,22},{53,30}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.4, startAngle=0, endAngle=360),
      Rectangle(extent={{37,-34},{61,-12}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{-12,-34},{12,-12}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{-60,-34},{-36,-12}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Line(points={{-48,-36},{-48,-46},{0,-46},{0,-36}}, color={113,122,132}, thickness=0.55, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Mission State Machine", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-344,-330},{314,390}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-78.32,-85.36},{78.32,83.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-66.88,56.32},{66.88,56.32}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-73.92,60.72},{-56.32,78.32}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-53.68,62.48},{66.88,75.68}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-31.68,22.88},{-9.68,22.88}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{11.44,22.88},{32.56,22.88}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{43.12,12.32},{43.12,-9.68}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{32.56,-20.24},{10.56,-20.24}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-10.56,-20.24},{-31.68,-20.24}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{-52.8,13.2},{-31.68,32.56}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{-9.68,13.2},{11.44,32.56}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{32.56,13.2},{53.68,32.56}}, lineColor={0,0,0}, fillColor={236,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Ellipse(extent={{39.6,19.36},{46.64,26.4}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.4, startAngle=0, endAngle=360),
      Rectangle(extent={{32.56,-29.92},{53.68,-10.56}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{-10.56,-29.92},{10.56,-10.56}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{-52.8,-29.92},{-31.68,-10.56}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Line(points={{-42.24,-31.68},{-42.24,-40.48},{0,-40.48},{0,-31.68}}, color={113,122,132}, thickness=0.55, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-66.88,-51.04},{66.88,-51.04}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-70.4,-69.52},{70.4,-56.32}}, textString="Mission State Machine", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-318,302},{-223,320}}, textString="DECISION", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-318,250},{-223,268}}, textString="IMAGING", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-318,42},{-223,60}}, textString="DOWNLINK", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-318,-114},{-223,-96}}, textString="RECOVERY", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-318,-192},{-223,-174}}, textString="GEOMETRY", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-332,345},{302,374}}, textString="Mission State Machine", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-332,337},{302,337}}, color={215,220,226}, thickness=0.25)
    }));
end MissionStateMachine;