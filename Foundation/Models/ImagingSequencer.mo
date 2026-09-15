within NISSA_12UCubeSat.Foundation.Models;
model ImagingSequencer "请求驱动的成像动作时序器"
  NISSA_12UCubeSat.Foundation.Interfaces.MissionFeedbackBus feedback annotation(Placement(transformation(extent={{-112,45},{-92,65}})));
  NISSA_12UCubeSat.Foundation.Interfaces.ActiveGeometrySignals activeGeometry annotation(Placement(transformation(extent={{-112,10},{-92,30}})));
  NISSA_12UCubeSat.Foundation.Interfaces.SafetySignals safety annotation(Placement(transformation(extent={{-112,-25},{-92,-5}})));
  Modelica.Blocks.Interfaces.IntegerInput actionRequestId annotation(Placement(transformation(extent={{-112,-60},{-92,-40}})));
  Modelica.Blocks.Interfaces.IntegerOutput startedEventId;
  Modelica.Blocks.Interfaces.IntegerOutput completedEventId;
  Modelica.Blocks.Interfaces.IntegerOutput failedEventId;
  Modelica.Blocks.Interfaces.IntegerOutput abortedEventId;
  Modelica.Blocks.Interfaces.IntegerOutput timeoutEventId;
  NISSA_12UCubeSat.Foundation.Interfaces.ImagingActionSignals action annotation(Placement(transformation(extent={{92,-10},{112,10}})));
  parameter Real powerOnTime(unit="s")=2;
  parameter Real initializationTime(unit="s")=5;
  parameter Real attitudeWaitTimeout(unit="s")=90;
  parameter Real captureDuration(unit="s")=10;
  parameter Real completeImageBytes(unit="1")=100e6 "完整单景存储量，数值单位byte";
  final parameter Real imageWriteRate(unit="1/s")=completeImageBytes/captureDuration;
  parameter Real storeDuration(unit="s")=1;
  parameter Real powerOffTime(unit="s")=2;
  parameter Real cameraWakeAngle(unit="rad")=15*Modelica.Constants.pi/180;
  parameter Real eventSettleDelay(unit="s")=1e-4;
protected
  discrete NISSA_12UCubeSat.Foundation.Types.ImagingPhase phase(start=NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Idle,fixed=true);
  discrete Real phaseEntry(start=0,fixed=true);
  discrete Real phaseDeadline(start=1e100,fixed=true);
  discrete Real preparationDeadline(start=1e100,fixed=true);
  discrete Real resetDeadline(start=1e100,fixed=true);
  discrete Integer activeRequest(start=0,fixed=true);
  discrete Integer startedId(start=0,fixed=true);
  discrete Integer completedId(start=0,fixed=true);
  discrete Integer failedId(start=0,fixed=true);
  discrete Integer abortedId(start=0,fixed=true);
  discrete Integer timeoutId(start=0,fixed=true);
  discrete Boolean abortedLatch(start=false,fixed=true);
  discrete Boolean timeoutLatch(start=false,fixed=true);
  discrete Boolean captureStartedLatch(start=false,fixed=true);
  discrete Boolean imageCompleteLatch(start=false,fixed=true);
  discrete Real validImageBytesLatch(unit="1",start=0,fixed=true);
  discrete NISSA_12UCubeSat.Foundation.Types.RejectReason failureReasonLatch(
    start=NISSA_12UCubeSat.Foundation.Types.RejectReason.None,fixed=true);
  Modelica.Blocks.Interfaces.IntegerOutput startedEventIdPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.IntegerOutput completedEventIdPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.IntegerOutput failedEventIdPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.IntegerOutput abortedEventIdPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.IntegerOutput timeoutEventIdPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  NISSA_12UCubeSat.Foundation.Interfaces.IntegerSignalBridge actionIntegerBridge[5] annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Boolean qualifiedAttitude;
  Boolean imagingValid;
  Boolean captureReady;
  Boolean withinCameraWakeAngle;
equation
  qualifiedAttitude=feedback.imagingAttitudeReady;
  imagingValid=activeGeometry.activeTargetVisible and activeGeometry.offNadirValid and
    activeGeometry.cameraFOVValid and activeGeometry.targetIlluminationValid;
  // Camera ready and storage-full are device responses to commands produced by
  // this sequencer.  Read their preceding stable event values so the command
  // and its feedback are not solved in the same discrete iteration.
  captureReady=qualifiedAttitude and pre(feedback.cameraReady) and
    not pre(feedback.storageFull) and imagingValid;
  withinCameraWakeAngle=feedback.attitudeError <= cameraWakeAngle;
  action.phase=phase;
  action.payloadPowerCommand=phase == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.PowerOn or
    phase == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Initialize or
    phase == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.WaitAttitude or
    phase == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Capture or
    phase == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.StoreData or
    phase == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.PowerOff;
  action.captureCommand=phase == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Capture;
  action.busy=action.payloadPowerCommand;
  action.active=phase == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Capture or
    phase == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.StoreData or
    phase == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.PowerOff;
  action.completed=phase == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Complete;
  action.failed=phase == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Failed;
  action.aborted=abortedLatch;
  action.timeout=timeoutLatch;
  action.captureStarted=captureStartedLatch;
  action.imageComplete=imageCompleteLatch;
  action.validImageBytes=if phase == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Capture then
    min(completeImageBytes,imageWriteRate*max(0,time-phaseEntry)) else validImageBytesLatch;
  action.failureReason=failureReasonLatch;
  startedEventIdPublisher=startedId;
  completedEventIdPublisher=completedId;
  failedEventIdPublisher=failedId;
  abortedEventIdPublisher=abortedId;
  timeoutEventIdPublisher=timeoutId;
  startedEventId=startedId;
  completedEventId=completedId;
  failedEventId=failedId;
  abortedEventId=abortedId;
  timeoutEventId=timeoutId;
algorithm
  when {initial(),change(actionRequestId),change(withinCameraWakeAngle),
      change(qualifiedAttitude),change(feedback.storageFull),
      change(activeGeometry.activeTargetVisible),change(activeGeometry.offNadirValid),
      change(activeGeometry.cameraFOVValid),change(activeGeometry.targetIlluminationValid),
      edge(safety.safeModeRequired),time >= phaseDeadline,time >= preparationDeadline,time >= resetDeadline} then
    if initial() then
      phase:=NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Idle;
      phaseEntry:=time;
      phaseDeadline:=1e100;
      preparationDeadline:=1e100;
      resetDeadline:=1e100;
      activeRequest:=0;
      startedId:=0;
      completedId:=0;
      failedId:=0;
      abortedId:=0;
      timeoutId:=0;
      abortedLatch:=false;
      timeoutLatch:=false;
      captureStartedLatch:=false;
      imageCompleteLatch:=false;
      validImageBytesLatch:=0;
      failureReasonLatch:=NISSA_12UCubeSat.Foundation.Types.RejectReason.None;
    elseif change(actionRequestId) and actionRequestId > 0 then
      activeRequest:=actionRequestId;
      phase:=if withinCameraWakeAngle then NISSA_12UCubeSat.Foundation.Types.ImagingPhase.PowerOn else NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Idle;
      phaseEntry:=time;
      phaseDeadline:=if withinCameraWakeAngle then time+powerOnTime else 1e100;
      preparationDeadline:=time+attitudeWaitTimeout;
      resetDeadline:=1e100;
      abortedLatch:=false;
      timeoutLatch:=false;
      captureStartedLatch:=false;
      imageCompleteLatch:=false;
      validImageBytesLatch:=0;
      failureReasonLatch:=NISSA_12UCubeSat.Foundation.Types.RejectReason.None;
    elseif change(actionRequestId) and actionRequestId == 0 then
      phase:=NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Idle;
      phaseEntry:=time;
      phaseDeadline:=1e100;
      preparationDeadline:=1e100;
      resetDeadline:=1e100;
      activeRequest:=0;
      abortedLatch:=false;
      timeoutLatch:=false;
      captureStartedLatch:=false;
      imageCompleteLatch:=false;
      validImageBytesLatch:=0;
      failureReasonLatch:=NISSA_12UCubeSat.Foundation.Types.RejectReason.None;
    elseif safety.safeModeRequired and activeRequest > 0 and
        not (pre(phase) == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Idle or
             pre(phase) == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Complete or
             pre(phase) == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Failed) then
      phase:=NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Failed;
      phaseEntry:=time;
      phaseDeadline:=1e100;
      preparationDeadline:=1e100;
      resetDeadline:=time+eventSettleDelay;
      abortedLatch:=true;
      timeoutLatch:=false;
      validImageBytesLatch:=if pre(phase) == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Capture then
        min(completeImageBytes,imageWriteRate*max(0,time-pre(phaseEntry))) else pre(validImageBytesLatch);
      abortedId:=activeRequest;
      failureReasonLatch:=NISSA_12UCubeSat.Foundation.Types.RejectReason.SafetyPreempted;
    elseif time >= pre(resetDeadline) then
      phase:=NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Idle;
      phaseEntry:=time;
      phaseDeadline:=1e100;
      preparationDeadline:=1e100;
      resetDeadline:=1e100;
      activeRequest:=0;
      abortedLatch:=false;
      timeoutLatch:=false;
    elseif activeRequest > 0 and pre(phase) == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Idle and withinCameraWakeAngle then
      phase:=NISSA_12UCubeSat.Foundation.Types.ImagingPhase.PowerOn;
      phaseEntry:=time;
      phaseDeadline:=time+powerOnTime;
    elseif activeRequest > 0 and time >= pre(preparationDeadline) and
        not (pre(phase) == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Complete or pre(phase) == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Failed) then
      phase:=NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Failed;
      phaseEntry:=time;
      phaseDeadline:=1e100;
      preparationDeadline:=1e100;
      resetDeadline:=time+eventSettleDelay;
      timeoutLatch:=true;
      validImageBytesLatch:=if pre(phase) == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Capture then
        min(completeImageBytes,imageWriteRate*max(0,time-pre(phaseEntry))) else pre(validImageBytesLatch);
      timeoutId:=activeRequest;
      failureReasonLatch:=NISSA_12UCubeSat.Foundation.Types.RejectReason.Timeout;
    elseif pre(phase) == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.WaitAttitude and captureReady then
      phase:=NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Capture;
      phaseEntry:=time;
      phaseDeadline:=time+captureDuration;
      preparationDeadline:=1e100;
      startedId:=activeRequest;
      captureStartedLatch:=true;
      validImageBytesLatch:=0;
    elseif pre(phase) == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Capture and (not imagingValid or not qualifiedAttitude) then
      phase:=NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Failed;
      phaseEntry:=time;
      phaseDeadline:=1e100;
      preparationDeadline:=1e100;
      resetDeadline:=time+eventSettleDelay;
      failedId:=activeRequest;
      validImageBytesLatch:=min(completeImageBytes,imageWriteRate*max(0,time-pre(phaseEntry)));
      failureReasonLatch:=if not qualifiedAttitude then NISSA_12UCubeSat.Foundation.Types.RejectReason.AttitudeUnavailable else
        if not activeGeometry.activeTargetVisible then NISSA_12UCubeSat.Foundation.Types.RejectReason.TargetVisibilityLost else
        if not activeGeometry.offNadirValid then NISSA_12UCubeSat.Foundation.Types.RejectReason.OffNadirLimit else
        if not activeGeometry.cameraFOVValid then NISSA_12UCubeSat.Foundation.Types.RejectReason.CameraFOVLimit else
        NISSA_12UCubeSat.Foundation.Types.RejectReason.TargetNotIlluminated;
    elseif pre(feedback.storageFull) and (pre(phase) == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Initialize or
        pre(phase) == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.WaitAttitude or
        pre(phase) == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Capture) then
      phase:=NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Failed;
      phaseEntry:=time;
      phaseDeadline:=1e100;
      preparationDeadline:=1e100;
      resetDeadline:=time+eventSettleDelay;
      failedId:=activeRequest;
      validImageBytesLatch:=if pre(phase) == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Capture then
        min(completeImageBytes,imageWriteRate*max(0,time-pre(phaseEntry))) else pre(validImageBytesLatch);
      failureReasonLatch:=NISSA_12UCubeSat.Foundation.Types.RejectReason.StorageFull;
    elseif time >= pre(phaseDeadline) then
      phaseEntry:=time;
      if pre(phase) == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.PowerOn then
        phase:=NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Initialize;
        phaseDeadline:=time+initializationTime;
      elseif pre(phase) == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Initialize and captureReady then
        phase:=NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Capture;
        phaseDeadline:=time+captureDuration;
        preparationDeadline:=1e100;
        startedId:=activeRequest;
        captureStartedLatch:=true;
        validImageBytesLatch:=0;
      elseif pre(phase) == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Initialize then
        phase:=NISSA_12UCubeSat.Foundation.Types.ImagingPhase.WaitAttitude;
        phaseDeadline:=pre(preparationDeadline);
      elseif pre(phase) == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.WaitAttitude then
        phase:=NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Failed;
        phaseDeadline:=1e100;
        preparationDeadline:=1e100;
        resetDeadline:=time+eventSettleDelay;
        timeoutLatch:=true;
        timeoutId:=activeRequest;
        failureReasonLatch:=NISSA_12UCubeSat.Foundation.Types.RejectReason.Timeout;
      elseif pre(phase) == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Capture then
        phase:=NISSA_12UCubeSat.Foundation.Types.ImagingPhase.StoreData;
        phaseDeadline:=time+storeDuration;
        validImageBytesLatch:=completeImageBytes;
      elseif pre(phase) == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.StoreData then
        phase:=NISSA_12UCubeSat.Foundation.Types.ImagingPhase.PowerOff;
        phaseDeadline:=time+powerOffTime;
      elseif pre(phase) == NISSA_12UCubeSat.Foundation.Types.ImagingPhase.PowerOff then
        phase:=NISSA_12UCubeSat.Foundation.Types.ImagingPhase.Complete;
        phaseDeadline:=1e100;
        preparationDeadline:=1e100;
        resetDeadline:=time+eventSettleDelay;
        completedId:=activeRequest;
        imageCompleteLatch:=true;
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
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={55,75,110},fillColor={237,241,247},fillPattern=FillPattern.Solid),Ellipse(extent={{-50,36},{10,-24}},fillColor={55,70,95},fillPattern=FillPattern.Solid),Line(points={{18,6},{72,6}},color={55,75,110},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-94,-64},{94,-42}},textString="IMAGING SEQ")}),Documentation(info="<html><h4>功能定位</h4><p>把一次已接受成像请求展开为相机上电、初始化、姿态等待、曝光、存储和关机阶段。</p><h4>输入与接口关系</h4><p>actionRequestId触发动作；activeGeometry提供锁存目标几何；feedback提供相机、姿态和存储反馈；safety可禁止或中止。</p><h4>内部职责与实现</h4><p>离散状态机按各阶段时间、cameraWakeAngle和姿态等待超时推进，并用存储增量确认完整单景写入；结果通过一次性事件ID交付。</p><h4>输出</h4><p>ImagingActionSignals驱动相机电源和实际捕获命令；started/completed/failed/aborted/timeout事件回送状态机。</p><h4>连续/离散状态</h4><p>含阶段、计时、基准存储量、请求ID和结果事件等离散状态；无连续物理状态。</p><h4>使用与观察</h4><p>查看阶段、capture命令、目标索引、存储增量和结果事件。成像请求、捕获开始和完整成像完成是三个不同统计量。</p><h4>建模边界</h4><p>不计算光学图像质量和姿态控制本身；姿态/几何资格及相机物理响应来自外部模型。</p></html>"));
end ImagingSequencer;
