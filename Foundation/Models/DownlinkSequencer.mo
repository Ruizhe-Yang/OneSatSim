within NISSA_12UCubeSat.Foundation.Models;
model DownlinkSequencer "请求驱动的下行动作时序器"
  NISSA_12UCubeSat.Foundation.Interfaces.MissionFeedbackBus feedback annotation(Placement(transformation(extent={{-112,45},{-92,65}})));
  NISSA_12UCubeSat.Foundation.Interfaces.ActiveGeometrySignals activeGeometry annotation(Placement(transformation(extent={{-112,10},{-92,30}})));
  NISSA_12UCubeSat.Foundation.Interfaces.SafetySignals safety annotation(Placement(transformation(extent={{-112,-25},{-92,-5}})));
  Modelica.Blocks.Interfaces.IntegerInput actionRequestId annotation(Placement(transformation(extent={{-112,-60},{-92,-40}})));
  NISSA_12UCubeSat.Foundation.Interfaces.ActiveMissionSelectionInput activeMissionSelection;
  Modelica.Blocks.Interfaces.IntegerOutput startedEventId;
  Modelica.Blocks.Interfaces.IntegerOutput completedEventId;
  Modelica.Blocks.Interfaces.IntegerOutput failedEventId;
  Modelica.Blocks.Interfaces.IntegerOutput abortedEventId;
  Modelica.Blocks.Interfaces.IntegerOutput timeoutEventId;
  NISSA_12UCubeSat.Foundation.Interfaces.DownlinkActionSignals action annotation(Placement(transformation(extent={{92,-10},{112,10}})));
  parameter Real powerOnTime(unit="s")=2;
  parameter Real initializationTime(unit="s")=5;
  parameter Real pointingWaitTimeout(unit="s")=171;
  parameter Real linkAcquisitionTime(unit="s")=2;
  parameter Real shutdownTime(unit="s")=2;
  parameter Real eventSettleDelay(unit="s")=1e-4;
protected
  discrete NISSA_12UCubeSat.Foundation.Types.DownlinkPhase phase(start=NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Idle,fixed=true);
  discrete Real phaseDeadline(start=1e100,fixed=true);
  discrete Real resetDeadline(start=1e100,fixed=true);
  discrete Integer activeRequest(start=0,fixed=true);
  discrete Integer startedId(start=0,fixed=true);
  discrete Integer completedId(start=0,fixed=true);
  discrete Integer abortedId(start=0,fixed=true);
  discrete Integer timeoutId(start=0,fixed=true);
  discrete Boolean abortedLatch(start=false,fixed=true);
  discrete Boolean timeoutLatch(start=false,fixed=true);
  Modelica.Blocks.Interfaces.IntegerOutput startedEventIdPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.IntegerOutput completedEventIdPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.IntegerOutput failedEventIdPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.IntegerOutput abortedEventIdPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.IntegerOutput timeoutEventIdPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  NISSA_12UCubeSat.Foundation.Interfaces.IntegerSignalBridge actionIntegerBridge[5] annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Boolean linkReady;
  Boolean transmitReady;
equation
  // Transmitter-ready is the equipment response to this sequencer's own power
  // command.  Use its preceding stable event value to avoid a same-event
  // power-command/readiness loop; dataAvailable remains a live external event.
  linkReady=pre(activeRequest) > 0 and activeGeometry.activeGroundContact and
    activeMissionSelection.groundStationIndex > 0 and feedback.groundLinkAttitudeReady and
    pre(feedback.transmitterReady) and feedback.dataAvailable;
  transmitReady=linkReady;
  action.phase=phase;
  action.communicationPowerCommand=phase == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.PowerOn or
    phase == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Initialize or
    phase == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.WaitGroundPointing or
    phase == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.EstablishLink or
    phase == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Transmit or
    phase == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Shutdown;
  action.transmitCommand=phase == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Transmit;
  action.busy=action.communicationPowerCommand;
  action.active=phase == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Transmit or phase == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Shutdown;
  action.completed=phase == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Complete;
  action.failed=phase == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Failed;
  action.aborted=abortedLatch;
  action.timeout=timeoutLatch;
  startedEventIdPublisher=startedId;
  completedEventIdPublisher=completedId;
  // Downlink terminal failures are classified explicitly as abort or timeout;
  // the generic failure channel therefore remains inactive.
  failedEventIdPublisher=0;
  abortedEventIdPublisher=abortedId;
  timeoutEventIdPublisher=timeoutId;
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
      phase:=NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.PowerOn;
      phaseDeadline:=time+powerOnTime;
      resetDeadline:=1e100;
      abortedLatch:=false;
      timeoutLatch:=false;
    elseif safety.safeModeRequired and activeRequest > 0 and
        not (pre(phase) == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Idle or
             pre(phase) == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Complete or
             pre(phase) == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Failed) then
      phase:=NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Failed;
      phaseDeadline:=1e100;
      resetDeadline:=time+eventSettleDelay;
      abortedLatch:=true;
      timeoutLatch:=false;
      abortedId:=activeRequest;
    elseif pre(activeRequest) > 0 and activeMissionSelection.groundStationIndex <= 0 and
        not (pre(phase) == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Idle or
             pre(phase) == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Complete or
             pre(phase) == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Failed) then
      phase:=NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Failed;
      phaseDeadline:=1e100;
      resetDeadline:=time+eventSettleDelay;
      abortedLatch:=true;
      timeoutLatch:=false;
      abortedId:=pre(activeRequest);
    elseif time >= pre(resetDeadline) then
      phase:=NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Idle;
      phaseDeadline:=1e100;
      resetDeadline:=1e100;
      activeRequest:=0;
      abortedLatch:=false;
      timeoutLatch:=false;
    elseif pre(phase) == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.WaitGroundPointing and linkReady and
        time+linkAcquisitionTime <= pre(phaseDeadline) then
      phase:=NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.EstablishLink;
      phaseDeadline:=time+linkAcquisitionTime;
      startedId:=activeRequest;
    elseif pre(phase) == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Transmit and not transmitReady then
      phase:=NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Shutdown;
      phaseDeadline:=time+shutdownTime;
    elseif pre(phase) == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.EstablishLink and not linkReady then
      phase:=NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Shutdown;
      phaseDeadline:=time+shutdownTime;
    elseif time >= pre(phaseDeadline) then
      if pre(phase) == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.PowerOn then
        phase:=NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Initialize;
        phaseDeadline:=time+initializationTime;
      elseif pre(phase) == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Initialize and linkReady then
        phase:=NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.EstablishLink;
        phaseDeadline:=time+linkAcquisitionTime;
        startedId:=activeRequest;
      elseif pre(phase) == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Initialize then
        phase:=NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.WaitGroundPointing;
        phaseDeadline:=time+pointingWaitTimeout;
      elseif pre(phase) == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.WaitGroundPointing then
        phase:=NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Failed;
        phaseDeadline:=1e100;
        resetDeadline:=time+eventSettleDelay;
        timeoutLatch:=true;
        timeoutId:=activeRequest;
      elseif pre(phase) == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.EstablishLink and transmitReady then
        phase:=NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Transmit;
        phaseDeadline:=1e100;
      elseif pre(phase) == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.EstablishLink then
        phase:=NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Shutdown;
        phaseDeadline:=time+shutdownTime;
      elseif pre(phase) == NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Shutdown then
        phase:=NISSA_12UCubeSat.Foundation.Types.DownlinkPhase.Complete;
        phaseDeadline:=1e100;
        resetDeadline:=time+eventSettleDelay;
        completedId:=activeRequest;
      else
        phaseDeadline:=1e100;
      end if;
    end if;
  end when;
equation
  connect(startedEventIdPublisher,actionIntegerBridge[1].u);
  connect(actionIntegerBridge[1].y,action.startedEventId);
  connect(completedEventIdPublisher,actionIntegerBridge[2].u);
  connect(actionIntegerBridge[2].y,action.completedEventId);
  connect(failedEventIdPublisher,actionIntegerBridge[3].u);
  connect(actionIntegerBridge[3].y,action.failedEventId);
  connect(abortedEventIdPublisher,actionIntegerBridge[4].u);
  connect(actionIntegerBridge[4].y,action.abortedEventId);
  connect(timeoutEventIdPublisher,actionIntegerBridge[5].u);
  connect(actionIntegerBridge[5].y,action.timeoutEventId);
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={15,85,150},fillColor={225,239,250},fillPattern=FillPattern.Solid),Polygon(points={{-62,34},{20,34},{55,0},{20,-34},{-62,-34},{-62,34}},fillColor={95,160,205},fillPattern=FillPattern.Solid),Line(points={{55,20},{82,42}},color={15,85,150}),Line(points={{55,-20},{82,-42}},color={15,85,150}),Text(extent={{-94,-64},{94,-42}},textString="DOWNLINK SEQ")}),Documentation(info="<html><h4>功能定位</h4><p>把一次已接受下传请求展开为通信上电、初始化、指向等待、链路获取、真实发射和关机阶段。</p><h4>输入与接口关系</h4><p>actionRequestId触发新动作；activeMissionSelection给出锁存地面站；feedback和activeGeometry提供数据可用、通信专用姿态资格及接触完成条件；safety或上级取消活动地面站可中止动作。</p><h4>内部职责与实现</h4><p>离散状态机依据powerOnTime、initializationTime、pointingWaitTimeout、linkAcquisitionTime和shutdownTime推进，形成started/completed/failed/aborted/timeout事件。活动地面站被任务状态机清零时，当前下传在离散边界中止，不修改已存数据。</p><h4>输出</h4><p>DownlinkActionSignals驱动通信上电与发射命令，五类事件ID回送MissionStateMachine。</p><h4>连续/离散状态</h4><p>含当前阶段、开始时间、请求ID和结果事件等离散状态；eventSettleDelay用于单次事件交付，不是周期采样。</p><h4>使用与观察</h4><p>查看阶段、真实发射门控、活动站索引和结果事件。请求数不等于真实发射数，必须由transmit动作判定。</p><h4>建模边界</h4><p>不计算射频链路预算、协议重传和地面解调；接触与姿态资格由外部物理反馈提供。任务中止后的续传由后续独立窗口重新发起。</p></html>"));
end DownlinkSequencer;
