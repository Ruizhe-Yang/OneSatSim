within OneSatSim.Foundation.Models;
model MissionStateMachine "单向动作握手的事件驱动任务状态机"
  OneSatSim.Foundation.Interfaces.ArbiterDecisionSignals decision annotation(Placement(transformation(extent={{-112,60},{-92,80}})));
  Modelica.Blocks.Interfaces.IntegerInput imagingStartedEventId;
  Modelica.Blocks.Interfaces.IntegerInput imagingCompletedEventId;
  Modelica.Blocks.Interfaces.IntegerInput imagingFailedEventId;
  Modelica.Blocks.Interfaces.IntegerInput imagingAbortedEventId;
  Modelica.Blocks.Interfaces.IntegerInput imagingTimeoutEventId;
  Modelica.Blocks.Interfaces.IntegerInput downlinkStartedEventId;
  Modelica.Blocks.Interfaces.IntegerInput downlinkCompletedEventId;
  Modelica.Blocks.Interfaces.IntegerInput downlinkFailedEventId;
  Modelica.Blocks.Interfaces.IntegerInput downlinkAbortedEventId;
  Modelica.Blocks.Interfaces.IntegerInput downlinkTimeoutEventId;
  Modelica.Blocks.Interfaces.IntegerInput safeEntryCompleteEventId;
  Modelica.Blocks.Interfaces.IntegerInput recoveryCompleteEventId;
  Modelica.Blocks.Interfaces.IntegerInput geometryEventId;
  Modelica.Blocks.Interfaces.BooleanInput targetPreparationReady;
  Modelica.Blocks.Interfaces.BooleanInput targetEarlyOpportunity;
  Modelica.Blocks.Interfaces.IntegerInput targetPreparationIndex;
  Modelica.Blocks.Interfaces.IntegerOutput imagingActionRequestIdOut;
  Modelica.Blocks.Interfaces.IntegerOutput downlinkActionRequestIdOut;
  Modelica.Blocks.Interfaces.IntegerOutput safeModeActionRequestIdOut;
  OneSatSim.Foundation.Interfaces.CommandTypeOutput safeModeActionCommandOut;
  OneSatSim.Foundation.Interfaces.MissionStateSignals state annotation(Placement(transformation(extent={{92,25},{112,45}})));
  OneSatSim.Foundation.Interfaces.ActiveMissionSelectionOutput selection annotation(Placement(transformation(extent={{92,-45},{112,-25}})));
  parameter Real bootDuration(unit="s")=10;
  parameter Boolean operationalSnapshotStart=true;
  parameter Real imagingPreparationTimeout(unit="s")=90;
  parameter Real downlinkPreparationTimeout(unit="s")=180;
  parameter Real targetPreSlewDuration(unit="s")=96;
  parameter Real requiredImagingOpportunityTime(unit="s")=126;
  parameter Real requiredDownlinkOpportunityTime(unit="s")=30;
  parameter Real eventSettleDelay(unit="s")=1e-4;
protected
  discrete OneSatSim.Foundation.Types.MissionMode mode(
    start=if operationalSnapshotStart then OneSatSim.Foundation.Types.MissionMode.Idle else OneSatSim.Foundation.Types.MissionMode.Boot,fixed=true);
  discrete OneSatSim.Foundation.Types.CommandType command(start=OneSatSim.Foundation.Types.CommandType.None,fixed=true);
  discrete OneSatSim.Foundation.Types.CommandExecutionStatus resultStatus(
    start=OneSatSim.Foundation.Types.CommandExecutionStatus.Idle,fixed=true);
  discrete Real entryTime(start=0,fixed=true);
  discrete Real commandStartTime(start=0,fixed=true);
  discrete Integer transitions(start=0,fixed=true);
  discrete Real eventDeadline(start=1e100,fixed=true);
  discrete Real timeoutDeadline(start=if operationalSnapshotStart then 1e100 else bootDuration,fixed=true);
  discrete Real preSlewDeadline(start=1e100,fixed=true);
  discrete Boolean preSlewElapsed(start=false,fixed=true);
  discrete Integer pendingEvent(start=0,fixed=true);
  discrete OneSatSim.Foundation.Types.CommandType pendingCommand(start=OneSatSim.Foundation.Types.CommandType.None,fixed=true);
  discrete Integer pendingId(start=0,fixed=true);
  discrete Integer pendingTarget(start=0,fixed=true);
  discrete Integer pendingStation(start=0,fixed=true);
  discrete Boolean pendingAccepted(start=false,fixed=true);
  discrete OneSatSim.Foundation.Types.RejectReason pendingRejectReason(
    start=OneSatSim.Foundation.Types.RejectReason.None,fixed=true);
  discrete Real pendingOpportunityTimeRemaining(start=0,fixed=true);
  discrete Boolean queuedDecisionValid(start=false,fixed=true);
  discrete OneSatSim.Foundation.Types.CommandType queuedCommand(start=OneSatSim.Foundation.Types.CommandType.None,fixed=true);
  discrete Integer queuedId(start=0,fixed=true);
  discrete Integer queuedTarget(start=0,fixed=true);
  discrete Integer queuedStation(start=0,fixed=true);
  discrete Integer queuedWindow(start=0,fixed=true);
  discrete Real queuedOpportunityTimeRemaining(start=0,fixed=true);
  discrete Real queuedCaptureTime(start=0,fixed=true);
  discrete OneSatSim.Foundation.Types.RejectReason lastRejectReasonLatch(
    start=OneSatSim.Foundation.Types.RejectReason.None,fixed=true);
  discrete Boolean timeoutLatch(start=false,fixed=true);
  discrete Integer activeId(start=0,fixed=true);
  discrete Integer activeTarget(start=0,fixed=true);
  discrete Integer activeStation(start=0,fixed=true);
  discrete Integer imagingRequestId(start=0,fixed=true);
  discrete Integer downlinkRequestId(start=0,fixed=true);
  discrete Integer safeRequestId(start=0,fixed=true);
  discrete OneSatSim.Foundation.Types.CommandType safeRequestCommand(start=OneSatSim.Foundation.Types.CommandType.None,fixed=true);
  Modelica.Blocks.Interfaces.IntegerOutput activeRequestIdPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.IntegerOutput activeTargetIndexPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.IntegerOutput activeGroundStationIndexPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.IntegerOutput imagingActionRequestIdPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.IntegerOutput downlinkActionRequestIdPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.IntegerOutput safeModeActionRequestIdPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  OneSatSim.Foundation.Interfaces.IntegerSignalBridge stateIntegerBridge[6] annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
equation
  state.missionMode=mode;
  state.currentCommand=command;
  state.transitionCounter=transitions;
  state.stateElapsed=time-entryTime;
  state.executionTime=max(0,time-commandStartTime);
  activeRequestIdPublisher=activeId;
  activeTargetIndexPublisher=activeTarget;
  activeGroundStationIndexPublisher=activeStation;
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
  imagingActionRequestIdPublisher=imagingRequestId;
  downlinkActionRequestIdPublisher=downlinkRequestId;
  safeModeActionRequestIdPublisher=safeRequestId;
  state.safeModeActionCommand=safeRequestCommand;
  state.lastRejectReason=lastRejectReasonLatch;
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
      time >= preSlewDeadline,time >= timeoutDeadline} then
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
      pendingOpportunityTimeRemaining:=0;
      queuedDecisionValid:=false;
      queuedCommand:=OneSatSim.Foundation.Types.CommandType.None;
      queuedId:=0;
      queuedTarget:=0;
      queuedStation:=0;
      queuedWindow:=0;
      queuedOpportunityTimeRemaining:=0;
      queuedCaptureTime:=time;
      lastRejectReasonLatch:=OneSatSim.Foundation.Types.RejectReason.None;
      timeoutLatch:=false;
      activeId:=0;
      activeTarget:=0;
      activeStation:=0;
      imagingRequestId:=0;
      downlinkRequestId:=0;
      safeRequestId:=0;
      safeRequestCommand:=OneSatSim.Foundation.Types.CommandType.None;
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
        eventDeadline:=time+eventSettleDelay;
      elseif change(imagingAbortedEventId) then
        pendingEvent:=5;
        pendingId:=imagingAbortedEventId;
        eventDeadline:=time+eventSettleDelay;
      elseif change(imagingTimeoutEventId) then
        pendingEvent:=6;
        pendingId:=imagingTimeoutEventId;
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
              lastRejectReasonLatch:=OneSatSim.Foundation.Types.RejectReason.Busy;
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
              resultStatus:=OneSatSim.Foundation.Types.CommandExecutionStatus.Rejected;
              lastRejectReasonLatch:=if pre(queuedOpportunityTimeRemaining)-(time-pre(queuedCaptureTime)) > 0 then
                OneSatSim.Foundation.Types.RejectReason.InsufficientOpportunityTime else
                OneSatSim.Foundation.Types.RejectReason.StaleOpportunity;
            end if;
            queuedDecisionValid:=false;
          end if;
        elseif pre(pendingEvent) >= 8 and pre(pendingEvent) <= 11 and pre(pendingId) == pre(activeId) then
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
              resultStatus:=OneSatSim.Foundation.Types.CommandExecutionStatus.Rejected;
              lastRejectReasonLatch:=if pre(queuedOpportunityTimeRemaining)-(time-pre(queuedCaptureTime)) > 0 then
                OneSatSim.Foundation.Types.RejectReason.InsufficientOpportunityTime else
                OneSatSim.Foundation.Types.RejectReason.StaleOpportunity;
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
        elseif pre(mode) == OneSatSim.Foundation.Types.MissionMode.ImagingPreparation or pre(mode) == OneSatSim.Foundation.Types.MissionMode.DownlinkPreparation then
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
  connect(activeRequestIdPublisher,stateIntegerBridge[1].u);
  connect(stateIntegerBridge[1].y,state.activeRequestId);
  connect(activeTargetIndexPublisher,stateIntegerBridge[2].u);
  connect(stateIntegerBridge[2].y,state.activeTargetIndex);
  connect(activeGroundStationIndexPublisher,stateIntegerBridge[3].u);
  connect(stateIntegerBridge[3].y,state.activeGroundStationIndex);
  connect(imagingActionRequestIdPublisher,stateIntegerBridge[4].u);
  connect(stateIntegerBridge[4].y,state.imagingActionRequestId);
  connect(downlinkActionRequestIdPublisher,stateIntegerBridge[5].u);
  connect(stateIntegerBridge[5].y,state.downlinkActionRequestId);
  connect(safeModeActionRequestIdPublisher,stateIntegerBridge[6].u);
  connect(stateIntegerBridge[6].y,state.safeModeActionRequestId);
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={85,65,140},fillColor={240,234,248},fillPattern=FillPattern.Solid),Ellipse(extent={{-75,38},{-25,-12}},fillColor={170,145,205},fillPattern=FillPattern.Solid),Ellipse(extent={{25,38},{75,-12}},fillColor={170,145,205},fillPattern=FillPattern.Solid),Line(points={{-25,13},{25,13}},color={85,65,140},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-94,-64},{94,-42}},textString="MISSION FSM")}),Documentation(info="<html><h4>功能定位</h4><p>维护整星任务阶段、活动请求与对象选择，并用Sequencer结果事件完成成像、下传及安全动作握手。</p><h4>输入与接口关系</h4><p>decision接收仲裁结果；Mailbox输入提供动作开始/完成/失败/中止/超时、几何事件及预指向条件。</p><h4>内部职责与实现</h4><p>状态机锁存请求ID、任务类型、目标/站索引和当前阶段，提前机会进入预指向，正式资格后发出动作请求；只有匹配请求ID的结果事件才能推进或结束任务。单槽队列保存机会剩余时间与入队时刻，出队时按实际等待时间复核；已有队列不被普通新任务覆盖。满足剩余窗口要求的成像机会可中止可恢复的下传，使有截止期的拍摄优先。</p><h4>输出</h4><p>MissionStateSignals、ActiveMissionSelection及三类actionRequestId输出供Adapter、环境核心和Sequencer使用。</p><h4>连续/离散状态</h4><p>核心为离散状态与事件计数；operationalSnapshotStart控制初始化快照。无连续物理状态。</p><h4>使用与观察</h4><p>任务回归应分别查看候选机会、仲裁接受、实际执行、完成/拒绝原因和事件ID一致性；请求计数不能代替实际动作计数。</p><h4>建模边界</h4><p>不计算物理完成条件，也不包含相机、通信或姿控方程；这些由反馈和Sequencer负责。被中止的下传数据仍保留在存储器中，后续窗口可以继续下传。</p></html>"));
end MissionStateMachine;
