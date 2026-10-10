within OneSatSim.Foundation.Models;
model ImagingSequencer "请求驱动的成像动作时序器"
  OneSatSim.Foundation.Interfaces.MissionFeedbackBus feedback  "反馈" annotation(Placement(visible=true, transformation(origin={-225,77}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.PayloadDataPort payloadReceipt
    "计算/接口量 payloadReceipt；Recorder accepted-write receipt for the active image request" 
    annotation(Placement(visible=true, transformation(origin={-225,45}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,40}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.ActiveGeometrySignals activeGeometry  "激活几何" annotation(Placement(visible=true, transformation(origin={-225,13}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.SafetySignals safety  "计算/接口量 safety" annotation(Placement(visible=true, transformation(origin={-225,-19}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-40}, extent={{-12,-12},{12,12}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput actionRequestId  "action请求Id" annotation(Placement(visible=true, transformation(origin={-225,-77}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput startedEventId  "计算/接口量 startedEventId" annotation(Placement(visible=true, transformation(origin={225,78}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput completedEventId  "计算/接口量 completedEventId" annotation(Placement(visible=true, transformation(origin={225,52}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,48}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput failedEventId  "计算/接口量 failedEventId" annotation(Placement(visible=true, transformation(origin={225,26}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,16}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput abortedEventId  "计算/接口量 abortedEventId" annotation(Placement(visible=true, transformation(origin={225,0}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-16}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput timeoutEventId  "计算/接口量 timeoutEventId" annotation(Placement(visible=true, transformation(origin={225,-26}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-48}, extent={{-6,-6},{6,6}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.ImagingActionSignals action  "计算/接口量 action" annotation(Placement(visible=true, transformation(origin={225,-78}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-12,-12},{12,12}}, rotation=0)));
  parameter OneSatSim.Foundation.Types.ImagingCapabilities imagingCapabilities
    "成像Capabilities；Shared Earth-camera capability and sequence timing";
  final parameter Real powerOnTime(unit="s")=imagingCapabilities.powerOnTime_s "功率On时间 [s]" ;
  final parameter Real initializationTime(unit="s")=imagingCapabilities.initializationTime_s "initialization时间 [s]" ;
  parameter Real attitudeWaitTimeout(unit="s")=90 "姿态WaitTimeout [s]" ;
  final parameter Real captureDuration(unit="s")=imagingCapabilities.captureDuration_s "配置项 captureDuration [s]" ;
  final parameter Real completeImageBytes(unit="1")=imagingCapabilities.storedImageBytes "配置项 completeImageBytes [1]" ;
  final parameter Real imageWriteRate(unit="1/s")=imagingCapabilities.nominalWriteRate_Bps "imageWrite速率 [1/s]" ;
  final parameter Real storeDuration(unit="s")=imagingCapabilities.storeTime_s "配置项 storeDuration [s]" ;
  final parameter Real powerOffTime(unit="s")=imagingCapabilities.powerOffTime_s "功率Off时间 [s]" ;
  parameter Real cameraWakeAngle(unit="rad")=15*Modelica.Constants.pi/180 "配置项 cameraWakeAngle [rad]" ;
  parameter Real eventSettleDelay(unit="s")=1e-4 "配置项 eventSettleDelay [s]" ;
  Real acceptedImageBytes(unit="1",start=0,fixed=true)
    "计算/接口量 acceptedImageBytes [1]；Accepted bytes of this request only; reset when a new request begins";
  final parameter Real completeByteTolerance(unit="1")=
    max(100,1e-5*completeImageBytes) "配置项 completeByteTolerance [1]" ;
protected
  discrete OneSatSim.Foundation.Types.ImagingPhase phase(start=OneSatSim.Foundation.Types.ImagingPhase.Idle,fixed=true) "计算/接口量 phase" ;
  discrete Real phaseEntry(start=0,fixed=true) "计算/接口量 phaseEntry" ;
  discrete Real phaseDeadline(start=1e100,fixed=true) "计算/接口量 phaseDeadline" ;
  discrete Real preparationDeadline(start=1e100,fixed=true) "计算/接口量 preparationDeadline" ;
  discrete Real resetDeadline(start=1e100,fixed=true) "计算/接口量 resetDeadline" ;
  discrete Integer activeRequest(start=0,fixed=true) "激活请求" ;
  discrete Integer startedId(start=0,fixed=true) "计算/接口量 startedId" ;
  discrete Integer completedId(start=0,fixed=true) "计算/接口量 completedId" ;
  discrete Integer failedId(start=0,fixed=true) "计算/接口量 failedId" ;
  discrete Integer abortedId(start=0,fixed=true) "计算/接口量 abortedId" ;
  discrete Integer timeoutId(start=0,fixed=true) "计算/接口量 timeoutId" ;
  discrete Boolean abortedLatch(start=false,fixed=true) "计算/接口量 abortedLatch" ;
  discrete Boolean timeoutLatch(start=false,fixed=true) "计算/接口量 timeoutLatch" ;
  discrete Boolean captureStartedLatch(start=false,fixed=true) "计算/接口量 captureStartedLatch" ;
  discrete Boolean imageCompleteLatch(start=false,fixed=true) "计算/接口量 imageCompleteLatch" ;
  discrete Real validImageBytesLatch(unit="1",start=0,fixed=true) "计算/接口量 validImageBytesLatch [1]" ;
  discrete OneSatSim.Foundation.Types.RejectReason failureReasonLatch(
    start=OneSatSim.Foundation.Types.RejectReason.None,fixed=true) "计算/接口量 failureReasonLatch" ;
  discrete OneSatSim.Foundation.Types.ImagingPhase failurePhaseLatch(
    start=OneSatSim.Foundation.Types.ImagingPhase.Idle,fixed=true) "计算/接口量 failurePhaseLatch" ;
  Boolean qualifiedAttitude "qualified姿态" ;
  Boolean imagingValid "成像Valid" ;
  Boolean captureReady "capture就绪" ;
  Boolean withinCameraWakeAngle "计算/接口量 withinCameraWakeAngle" ;
equation
  der(acceptedImageBytes)=if phase == OneSatSim.Foundation.Types.ImagingPhase.Capture and 
    payloadReceipt.acceptedImagingRequestId == activeRequest then 
    max(0,payloadReceipt.acceptedEarthCameraWriteRate) else 0;
  when change(actionRequestId) and actionRequestId > 0 then
    reinit(acceptedImageBytes,0);
  end when;
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
  action.payloadPowerCommand=phase == OneSatSim.Foundation.Types.ImagingPhase.PowerOn or 
    phase == OneSatSim.Foundation.Types.ImagingPhase.Initialize or 
    phase == OneSatSim.Foundation.Types.ImagingPhase.WaitAttitude or 
    phase == OneSatSim.Foundation.Types.ImagingPhase.Capture or 
    phase == OneSatSim.Foundation.Types.ImagingPhase.StoreData or 
    phase == OneSatSim.Foundation.Types.ImagingPhase.PowerOff;
  action.captureCommand=phase == OneSatSim.Foundation.Types.ImagingPhase.Capture;
  action.busy=action.payloadPowerCommand;
  action.active=phase == OneSatSim.Foundation.Types.ImagingPhase.Capture or 
    phase == OneSatSim.Foundation.Types.ImagingPhase.StoreData or 
    phase == OneSatSim.Foundation.Types.ImagingPhase.PowerOff;
  action.completed=phase == OneSatSim.Foundation.Types.ImagingPhase.Complete;
  action.failed=phase == OneSatSim.Foundation.Types.ImagingPhase.Failed;
  action.aborted=abortedLatch;
  action.timeout=timeoutLatch;
  action.captureStarted=captureStartedLatch;
  action.imageComplete=imageCompleteLatch;
  action.validImageBytes=if phase == OneSatSim.Foundation.Types.ImagingPhase.Capture then 
    acceptedImageBytes else validImageBytesLatch;
  action.acceptedImageBytes=acceptedImageBytes;
  action.acceptedRequestId=activeRequest;
  action.failureReason=failureReasonLatch;
  action.failurePhase=failurePhaseLatch;
  action.startedEventId=startedId;
  action.completedEventId=completedId;
  action.failedEventId=failedId;
  action.abortedEventId=abortedId;
  action.timeoutEventId=timeoutId;
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
      phase:=OneSatSim.Foundation.Types.ImagingPhase.Idle;
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
      failureReasonLatch:=OneSatSim.Foundation.Types.RejectReason.None;
      failurePhaseLatch:=OneSatSim.Foundation.Types.ImagingPhase.Idle;
    elseif change(actionRequestId) and actionRequestId > 0 then
      activeRequest:=actionRequestId;
      phase:=if withinCameraWakeAngle then OneSatSim.Foundation.Types.ImagingPhase.PowerOn else OneSatSim.Foundation.Types.ImagingPhase.Idle;
      phaseEntry:=time;
      phaseDeadline:=if withinCameraWakeAngle then time+powerOnTime else 1e100;
      preparationDeadline:=time+attitudeWaitTimeout;
      resetDeadline:=1e100;
      abortedLatch:=false;
      timeoutLatch:=false;
      captureStartedLatch:=false;
      imageCompleteLatch:=false;
      validImageBytesLatch:=0;
      failureReasonLatch:=OneSatSim.Foundation.Types.RejectReason.None;
      failurePhaseLatch:=OneSatSim.Foundation.Types.ImagingPhase.Idle;
    elseif change(actionRequestId) and actionRequestId == 0 then
      phase:=OneSatSim.Foundation.Types.ImagingPhase.Idle;
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
      failureReasonLatch:=OneSatSim.Foundation.Types.RejectReason.None;
      failurePhaseLatch:=OneSatSim.Foundation.Types.ImagingPhase.Idle;
    elseif safety.safeModeRequired and activeRequest > 0 and 
        not (pre(phase) == OneSatSim.Foundation.Types.ImagingPhase.Idle or 
             pre(phase) == OneSatSim.Foundation.Types.ImagingPhase.Complete or 
             pre(phase) == OneSatSim.Foundation.Types.ImagingPhase.Failed) then
      phase:=OneSatSim.Foundation.Types.ImagingPhase.Failed;
      phaseEntry:=time;
      phaseDeadline:=1e100;
      preparationDeadline:=1e100;
      resetDeadline:=time+eventSettleDelay;
      abortedLatch:=true;
      timeoutLatch:=false;
      validImageBytesLatch:=if pre(phase) == OneSatSim.Foundation.Types.ImagingPhase.Capture then 
        acceptedImageBytes else pre(validImageBytesLatch);
      abortedId:=activeRequest;
      failureReasonLatch:=OneSatSim.Foundation.Types.RejectReason.SafetyPreempted;
      failurePhaseLatch:=pre(phase);
    elseif time >= pre(resetDeadline) then
      phase:=OneSatSim.Foundation.Types.ImagingPhase.Idle;
      phaseEntry:=time;
      phaseDeadline:=1e100;
      preparationDeadline:=1e100;
      resetDeadline:=1e100;
      activeRequest:=0;
      abortedLatch:=false;
      timeoutLatch:=false;
    elseif activeRequest > 0 and pre(phase) == OneSatSim.Foundation.Types.ImagingPhase.Idle and withinCameraWakeAngle then
      phase:=OneSatSim.Foundation.Types.ImagingPhase.PowerOn;
      phaseEntry:=time;
      phaseDeadline:=time+powerOnTime;
    elseif activeRequest > 0 and time >= pre(preparationDeadline) and 
        not (pre(phase) == OneSatSim.Foundation.Types.ImagingPhase.Complete or pre(phase) == OneSatSim.Foundation.Types.ImagingPhase.Failed) then
      phase:=OneSatSim.Foundation.Types.ImagingPhase.Failed;
      phaseEntry:=time;
      phaseDeadline:=1e100;
      preparationDeadline:=1e100;
      resetDeadline:=time+eventSettleDelay;
      timeoutLatch:=true;
      validImageBytesLatch:=if pre(phase) == OneSatSim.Foundation.Types.ImagingPhase.Capture then 
        acceptedImageBytes else pre(validImageBytesLatch);
      timeoutId:=activeRequest;
      failureReasonLatch:=OneSatSim.Foundation.Types.RejectReason.Timeout;
      failurePhaseLatch:=pre(phase);
    elseif pre(phase) == OneSatSim.Foundation.Types.ImagingPhase.WaitAttitude and captureReady then
      phase:=OneSatSim.Foundation.Types.ImagingPhase.Capture;
      phaseEntry:=time;
      phaseDeadline:=time+captureDuration;
      preparationDeadline:=1e100;
      startedId:=activeRequest;
      captureStartedLatch:=true;
      validImageBytesLatch:=0;
    elseif pre(phase) == OneSatSim.Foundation.Types.ImagingPhase.Capture and 
        (not imagingValid or not qualifiedAttitude or not pre(feedback.cameraReady)) then
      phase:=OneSatSim.Foundation.Types.ImagingPhase.Failed;
      phaseEntry:=time;
      phaseDeadline:=1e100;
      preparationDeadline:=1e100;
      resetDeadline:=time+eventSettleDelay;
      failedId:=activeRequest;
      validImageBytesLatch:=acceptedImageBytes;
      failureReasonLatch:=if not pre(feedback.cameraReady) then OneSatSim.Foundation.Types.RejectReason.CameraUnavailable else 
        if not qualifiedAttitude then OneSatSim.Foundation.Types.RejectReason.AttitudeUnavailable else 
        if not activeGeometry.activeTargetVisible then OneSatSim.Foundation.Types.RejectReason.TargetVisibilityLost else 
        if not activeGeometry.offNadirValid then OneSatSim.Foundation.Types.RejectReason.OffNadirLimit else 
        if not activeGeometry.cameraFOVValid then OneSatSim.Foundation.Types.RejectReason.CameraFOVLimit else 
        OneSatSim.Foundation.Types.RejectReason.TargetNotIlluminated;
      failurePhaseLatch:=pre(phase);
    elseif pre(feedback.storageFull) and (pre(phase) == OneSatSim.Foundation.Types.ImagingPhase.Initialize or 
        pre(phase) == OneSatSim.Foundation.Types.ImagingPhase.WaitAttitude or 
        pre(phase) == OneSatSim.Foundation.Types.ImagingPhase.Capture) then
      phase:=OneSatSim.Foundation.Types.ImagingPhase.Failed;
      phaseEntry:=time;
      phaseDeadline:=1e100;
      preparationDeadline:=1e100;
      resetDeadline:=time+eventSettleDelay;
      failedId:=activeRequest;
      validImageBytesLatch:=if pre(phase) == OneSatSim.Foundation.Types.ImagingPhase.Capture then 
        acceptedImageBytes else pre(validImageBytesLatch);
      failureReasonLatch:=OneSatSim.Foundation.Types.RejectReason.StorageFull;
      failurePhaseLatch:=pre(phase);
    elseif time >= pre(phaseDeadline) then
      phaseEntry:=time;
      if pre(phase) == OneSatSim.Foundation.Types.ImagingPhase.PowerOn then
        phase:=OneSatSim.Foundation.Types.ImagingPhase.Initialize;
        phaseDeadline:=time+initializationTime;
      elseif pre(phase) == OneSatSim.Foundation.Types.ImagingPhase.Initialize and captureReady then
        phase:=OneSatSim.Foundation.Types.ImagingPhase.Capture;
        phaseDeadline:=time+captureDuration;
        preparationDeadline:=1e100;
        startedId:=activeRequest;
        captureStartedLatch:=true;
        validImageBytesLatch:=0;
      elseif pre(phase) == OneSatSim.Foundation.Types.ImagingPhase.Initialize then
        phase:=OneSatSim.Foundation.Types.ImagingPhase.WaitAttitude;
        phaseDeadline:=pre(preparationDeadline);
      elseif pre(phase) == OneSatSim.Foundation.Types.ImagingPhase.WaitAttitude then
        phase:=OneSatSim.Foundation.Types.ImagingPhase.Failed;
        phaseDeadline:=1e100;
        preparationDeadline:=1e100;
        resetDeadline:=time+eventSettleDelay;
        timeoutLatch:=true;
        timeoutId:=activeRequest;
        failureReasonLatch:=OneSatSim.Foundation.Types.RejectReason.Timeout;
        failurePhaseLatch:=pre(phase);
      elseif pre(phase) == OneSatSim.Foundation.Types.ImagingPhase.Capture then
        validImageBytesLatch:=acceptedImageBytes;
        if acceptedImageBytes >= completeImageBytes-completeByteTolerance then
          phase:=OneSatSim.Foundation.Types.ImagingPhase.StoreData;
          phaseDeadline:=time+storeDuration;
        else
          phase:=OneSatSim.Foundation.Types.ImagingPhase.Failed;
          phaseDeadline:=1e100;
          resetDeadline:=time+eventSettleDelay;
          failedId:=activeRequest;
          failureReasonLatch:=if feedback.storageFull then 
            OneSatSim.Foundation.Types.RejectReason.StorageFull else 
            OneSatSim.Foundation.Types.RejectReason.DataWriteIncomplete;
          failurePhaseLatch:=pre(phase);
        end if;
      elseif pre(phase) == OneSatSim.Foundation.Types.ImagingPhase.StoreData then
        phase:=OneSatSim.Foundation.Types.ImagingPhase.PowerOff;
        phaseDeadline:=time+powerOffTime;
      elseif pre(phase) == OneSatSim.Foundation.Types.ImagingPhase.PowerOff then
        phase:=if acceptedImageBytes >= completeImageBytes-completeByteTolerance then 
          OneSatSim.Foundation.Types.ImagingPhase.Complete else 
          OneSatSim.Foundation.Types.ImagingPhase.Failed;
        phaseDeadline:=1e100;
        preparationDeadline:=1e100;
        resetDeadline:=time+eventSettleDelay;
        completedId:=if acceptedImageBytes >= completeImageBytes-completeByteTolerance then activeRequest else pre(completedId);
        failedId:=if acceptedImageBytes >= completeImageBytes-completeByteTolerance then pre(failedId) else activeRequest;
        imageCompleteLatch:=acceptedImageBytes >= completeImageBytes-completeByteTolerance;
        failureReasonLatch:=if acceptedImageBytes >= completeImageBytes-completeByteTolerance then 
          OneSatSim.Foundation.Types.RejectReason.None else 
          OneSatSim.Foundation.Types.RejectReason.DataWriteIncomplete;
        failurePhaseLatch:=if acceptedImageBytes >= completeImageBytes-completeByteTolerance then 
          OneSatSim.Foundation.Types.ImagingPhase.Idle else pre(phase);
      else
        phaseDeadline:=1e100;
      end if;
    end if;
  end when;
equation
  annotation(Documentation(info="<html><h2>请求驱动的成像动作时序器</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Models.ImagingSequencer</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>请求驱动的成像动作时序器</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.MissionControlUnit\">OneSatSim.Components.MissionControlUnit</a> 的 <code>imagingSequencer</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>feedback</code></td><td>OneSatSim.Foundation.Interfaces.MissionFeedbackBus</td><td>public</td><td>按声明/类型合同</td><td>反馈</td></tr><tr><td><code>payloadReceipt</code></td><td>OneSatSim.Foundation.Interfaces.PayloadDataPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 payloadReceipt；Recorder accepted-write receipt for the active image request</td></tr><tr><td><code>activeGeometry</code></td><td>OneSatSim.Foundation.Interfaces.ActiveGeometrySignals</td><td>public</td><td>按声明/类型合同</td><td>激活几何</td></tr><tr><td><code>safety</code></td><td>OneSatSim.Foundation.Interfaces.SafetySignals</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 safety</td></tr><tr><td><code>actionRequestId</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>action请求Id</td></tr><tr><td><code>startedEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 startedEventId</td></tr><tr><td><code>completedEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 completedEventId</td></tr><tr><td><code>failedEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 failedEventId</td></tr><tr><td><code>abortedEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 abortedEventId</td></tr><tr><td><code>timeoutEventId</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 timeoutEventId</td></tr><tr><td><code>action</code></td><td>OneSatSim.Foundation.Interfaces.ImagingActionSignals</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 action</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>imagingCapabilities</code></td><td>OneSatSim.Foundation.Types.ImagingCapabilities</td><td>成像Capabilities；Shared Earth-camera capability and sequence timing</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>powerOnTime</code></td><td>Real</td><td>功率On时间 [s]</td><td><code>=imagingCapabilities.powerOnTime_s</code></td></tr><tr><td><code>initializationTime</code></td><td>Real</td><td>initialization时间 [s]</td><td><code>=imagingCapabilities.initializationTime_s</code></td></tr><tr><td><code>attitudeWaitTimeout</code></td><td>Real</td><td>姿态WaitTimeout [s]</td><td><code>=90</code></td></tr><tr><td><code>captureDuration</code></td><td>Real</td><td>配置项 captureDuration [s]</td><td><code>=imagingCapabilities.captureDuration_s</code></td></tr><tr><td><code>completeImageBytes</code></td><td>Real</td><td>配置项 completeImageBytes [1]</td><td><code>=imagingCapabilities.storedImageBytes</code></td></tr><tr><td><code>imageWriteRate</code></td><td>Real</td><td>imageWrite速率 [1/s]</td><td><code>=imagingCapabilities.nominalWriteRate_Bps</code></td></tr><tr><td><code>storeDuration</code></td><td>Real</td><td>配置项 storeDuration [s]</td><td><code>=imagingCapabilities.storeTime_s</code></td></tr><tr><td><code>powerOffTime</code></td><td>Real</td><td>功率Off时间 [s]</td><td><code>=imagingCapabilities.powerOffTime_s</code></td></tr><tr><td><code>cameraWakeAngle</code></td><td>Real</td><td>配置项 cameraWakeAngle [rad]</td><td><code>=15*Modelica.Constants.pi/180</code></td></tr><tr><td><code>eventSettleDelay</code></td><td>Real</td><td>配置项 eventSettleDelay [s]</td><td><code>=1e-4</code></td></tr><tr><td><code>completeByteTolerance</code></td><td>Real</td><td>配置项 completeByteTolerance [1]</td><td><code>= max(100,1e-5*completeImageBytes)</code></td></tr></table><h3>状态与初始化</h3><p>本类源码中显式出现的导数对象或离散声明：<code>acceptedImageBytes, phase, phaseEntry, phaseDeadline, preparationDeadline, resetDeadline, activeRequest, startedId, completedId, failedId, abortedId, timeoutId, abortedLatch, timeoutLatch, captureStartedLatch, imageCompleteLatch, validImageBytesLatch, failureReasonLatch, failurePhaseLatch</code>。初始化取当前声明的 start/fixed、initial 方程/算法及继承设置。此处是源码级说明，不等同于编译后连续状态统计。</p><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] der(acceptedImageBytes)=if phase == OneSatSim.Foundation.Types.ImagingPhase.Capture and payloadReceipt.acceptedImagingRequestId == activeRequest then max(0,payloadReceipt.acceptedEarthCameraWriteRate) else 0;\n[equation] when change(actionRequestId) and actionRequestId &gt; 0 then reinit(acceptedImageBytes,0);\n[equation] end when;\n[equation] qualifiedAttitude=feedback.imagingAttitudeReady;\n[equation] imagingValid=activeGeometry.activeTargetVisible and activeGeometry.offNadirValid and activeGeometry.cameraFOVValid and activeGeometry.targetIlluminationValid;\n[equation] captureReady=qualifiedAttitude and pre(feedback.cameraReady) and not pre(feedback.storageFull) and imagingValid;\n[equation] withinCameraWakeAngle=feedback.attitudeError &lt;= cameraWakeAngle;\n[equation] action.phase=phase;\n[equation] action.payloadPowerCommand=phase == OneSatSim.Foundation.Types.ImagingPhase.PowerOn or phase == OneSatSim.Foundation.Types.ImagingPhase.Initialize or phase == OneSatSim.Foundation.Types.ImagingPhase.WaitAttitude or phase == OneSatSim.Foundation.Types.ImagingPhase.Capture or phase == OneSatSim.Foundation.Types.ImagingPhase.StoreData or phase == OneSatSim.Foundation.Types.ImagingPhase.PowerOff;\n[equation] action.captureCommand=phase == OneSatSim.Foundation.Types.ImagingPhase.Capture;</pre><p>本类另有168段语句；阅读完整源码可查看其余边界与逻辑。</p><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>acceptedImageBytes</code></td><td>Real</td><td>public</td><td>1</td><td>计算/接口量 acceptedImageBytes [1]；Accepted bytes of this request only; reset when a new request begins</td></tr><tr><td><code>phase</code></td><td>OneSatSim.Foundation.Types.ImagingPhase</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 phase</td></tr><tr><td><code>phaseEntry</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 phaseEntry</td></tr><tr><td><code>phaseDeadline</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 phaseDeadline</td></tr><tr><td><code>preparationDeadline</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 preparationDeadline</td></tr><tr><td><code>resetDeadline</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 resetDeadline</td></tr><tr><td><code>activeRequest</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>激活请求</td></tr><tr><td><code>startedId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 startedId</td></tr><tr><td><code>completedId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 completedId</td></tr><tr><td><code>failedId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 failedId</td></tr><tr><td><code>abortedId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 abortedId</td></tr><tr><td><code>timeoutId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 timeoutId</td></tr><tr><td><code>abortedLatch</code></td><td>Boolean</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 abortedLatch</td></tr><tr><td><code>timeoutLatch</code></td><td>Boolean</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 timeoutLatch</td></tr><tr><td><code>captureStartedLatch</code></td><td>Boolean</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 captureStartedLatch</td></tr><tr><td><code>imageCompleteLatch</code></td><td>Boolean</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 imageCompleteLatch</td></tr><tr><td><code>validImageBytesLatch</code></td><td>Real</td><td>discrete</td><td>1</td><td>计算/接口量 validImageBytesLatch [1]</td></tr><tr><td><code>failureReasonLatch</code></td><td>OneSatSim.Foundation.Types.RejectReason</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 failureReasonLatch</td></tr><tr><td><code>failurePhaseLatch</code></td><td>OneSatSim.Foundation.Types.ImagingPhase</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 failurePhaseLatch</td></tr><tr><td><code>qualifiedAttitude</code></td><td>Boolean</td><td>protected</td><td>按声明/类型合同</td><td>qualified姿态</td></tr><tr><td><code>imagingValid</code></td><td>Boolean</td><td>protected</td><td>按声明/类型合同</td><td>成像Valid</td></tr><tr><td><code>captureReady</code></td><td>Boolean</td><td>protected</td><td>按声明/类型合同</td><td>capture就绪</td></tr><tr><td><code>withinCameraWakeAngle</code></td><td>Boolean</td><td>protected</td><td>按声明/类型合同</td><td>计算/接口量 withinCameraWakeAngle</td></tr></table></html>"),
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
      Rectangle(extent={{-7.7,26.5},{9.1,41.9}}, lineColor={0,0,0}, fillColor={236,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Ellipse(extent={{-2.1,31.4},{3.5,37}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.4, startAngle=0, endAngle=360),
      Rectangle(extent={{25.9,26.5},{42.7,41.9}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{25.9,-7.8},{42.7,7.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{-8.4,-7.8},{8.4,7.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{-42,-7.8},{-25.2,7.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Line(points={{-33.6,-9.2},{-33.6,-16.2},{0,-16.2},{0,-9.2}}, color={113,122,132}, thickness=0.55, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-62,-26},{65,-26}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{-50,-39},{-20,-28}}, lineColor={128,97,151}, fillColor={235,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{-15,-39},{8,-28}}, lineColor={128,97,151}, fillColor={235,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{14,-39},{33,-28}}, lineColor={128,97,151}, fillColor={235,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Ellipse(extent={{46,-50},{61,-35}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Imaging Sequence", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
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
      Rectangle(extent={{-5.775,19.875},{6.825,31.425}}, lineColor={0,0,0}, fillColor={236,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Ellipse(extent={{-1.575,23.55},{2.625,27.75}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.4, startAngle=0, endAngle=360),
      Rectangle(extent={{19.425,19.875},{32.025,31.425}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{19.425,-5.85},{32.025,5.7}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{-6.3,-5.85},{6.3,5.7}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Rectangle(extent={{-31.5,-5.85},{-18.9,5.7}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=3),
      Line(points={{-25.2,-6.9},{-25.2,-12.15},{0,-12.15},{0,-6.9}}, color={113,122,132}, thickness=0.55, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-46.5,-19.5},{48.75,-19.5}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{-37.5,-29.25},{-15,-21}}, lineColor={128,97,151}, fillColor={235,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{-11.25,-29.25},{6,-21}}, lineColor={128,97,151}, fillColor={235,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{10.5,-29.25},{24.75,-21}}, lineColor={128,97,151}, fillColor={235,229,243}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Ellipse(extent={{34.5,-37.5},{45.75,-26.25}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Line(points={{-57,-43.5},{57,-43.5}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-60,-59.25},{60,-48}}, textString="Imaging Sequence", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-257,121},{257,150}}, textString="Imaging Sequencer", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-257,113},{257,113}}, color={215,220,226}, thickness=0.25)
    }));
end ImagingSequencer;