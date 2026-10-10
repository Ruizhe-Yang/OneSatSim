within OneSatSim.Foundation.Models;
model MissionActionResultMailbox "任务动作结果事件邮箱"
  Modelica.Blocks.Interfaces.IntegerInput imagingStartedIn  "成像StartedIn" annotation(Placement(visible=true, transformation(origin={-270,195}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-4.654545,-4.654545},{4.654545,4.654545}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput imagingCompletedIn  "成像CompletedIn" annotation(Placement(visible=true, transformation(origin={-270,169}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,65.454545}, extent={{-4.654545,-4.654545},{4.654545,4.654545}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput imagingFailedIn  "成像FailedIn" annotation(Placement(visible=true, transformation(origin={-270,143}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,50.909091}, extent={{-4.654545,-4.654545},{4.654545,4.654545}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput imagingAbortedIn  "成像AbortedIn" annotation(Placement(visible=true, transformation(origin={-270,117}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,36.363636}, extent={{-4.654545,-4.654545},{4.654545,4.654545}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput imagingTimeoutIn  "成像TimeoutIn" annotation(Placement(visible=true, transformation(origin={-270,91}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,21.818182}, extent={{-4.654545,-4.654545},{4.654545,4.654545}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.RejectReasonSignal imagingFailureReasonIn
    "成像FailureReasonIn；Reason captured with failed/aborted/timeout event ID" 
    annotation(Placement(visible=true, transformation(origin={-270,65}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-6.826666,-6.826666},{6.826666,6.826666}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.ImagingPhaseSignal imagingFailurePhaseIn
    "成像FailurePhaseIn；Action phase captured with terminal event ID" 
    annotation(Placement(visible=true, transformation(origin={-270,39}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,69.333333}, extent={{-6.826666,-6.826666},{6.826666,6.826666}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput downlinkStartedIn  "下传StartedIn" annotation(Placement(visible=true, transformation(origin={-270,-13}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,7.272727}, extent={{-4.654545,-4.654545},{4.654545,4.654545}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput downlinkCompletedIn  "下传CompletedIn" annotation(Placement(visible=true, transformation(origin={-270,-39}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-7.272727}, extent={{-4.654545,-4.654545},{4.654545,4.654545}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput downlinkFailedIn  "下传FailedIn" annotation(Placement(visible=true, transformation(origin={-270,-65}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-21.818182}, extent={{-4.654545,-4.654545},{4.654545,4.654545}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput downlinkAbortedIn  "下传AbortedIn" annotation(Placement(visible=true, transformation(origin={-270,-91}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-36.363636}, extent={{-4.654545,-4.654545},{4.654545,4.654545}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput downlinkTimeoutIn  "下传TimeoutIn" annotation(Placement(visible=true, transformation(origin={-270,-117}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-50.909091}, extent={{-4.654545,-4.654545},{4.654545,4.654545}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput safeEntryCompleteIn  "安全模式EntryCompleteIn" annotation(Placement(visible=true, transformation(origin={-270,-169}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-65.454545}, extent={{-4.654545,-4.654545},{4.654545,4.654545}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput recoveryCompleteIn  "计算/接口量 recoveryCompleteIn" annotation(Placement(visible=true, transformation(origin={-270,-195}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-4.654545,-4.654545},{4.654545,4.654545}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput imagingStartedOut  "成像StartedOut" annotation(Placement(visible=true, transformation(origin={270,195}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,58.666667}, extent={{-3.413333,-3.413333},{3.413333,3.413333}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput imagingCompletedOut  "成像CompletedOut" annotation(Placement(visible=true, transformation(origin={270,169}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,48}, extent={{-3.413333,-3.413333},{3.413333,3.413333}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput imagingFailedOut  "成像FailedOut" annotation(Placement(visible=true, transformation(origin={270,143}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,37.333333}, extent={{-3.413333,-3.413333},{3.413333,3.413333}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput imagingAbortedOut  "成像AbortedOut" annotation(Placement(visible=true, transformation(origin={270,117}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,26.666667}, extent={{-3.413333,-3.413333},{3.413333,3.413333}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput imagingTimeoutOut  "成像TimeoutOut" annotation(Placement(visible=true, transformation(origin={270,91}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,16}, extent={{-3.413333,-3.413333},{3.413333,3.413333}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.RejectReasonOutput imagingFailureReasonOut 
     "成像FailureReasonOut" annotation(Placement(visible=true, transformation(origin={270,65}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,5.333333}, extent={{-6.826666,-6.826666},{6.826666,6.826666}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.ImagingPhaseOutput imagingFailurePhaseOut 
     "成像FailurePhaseOut" annotation(Placement(visible=true, transformation(origin={270,39}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-5.333333}, extent={{-6.826666,-6.826666},{6.826666,6.826666}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput downlinkStartedOut  "下传StartedOut" annotation(Placement(visible=true, transformation(origin={270,-13}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-16}, extent={{-3.413333,-3.413333},{3.413333,3.413333}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput downlinkCompletedOut  "下传CompletedOut" annotation(Placement(visible=true, transformation(origin={270,-39}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-26.666667}, extent={{-3.413333,-3.413333},{3.413333,3.413333}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput downlinkFailedOut  "下传FailedOut" annotation(Placement(visible=true, transformation(origin={270,-65}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-37.333333}, extent={{-3.413333,-3.413333},{3.413333,3.413333}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput downlinkAbortedOut  "下传AbortedOut" annotation(Placement(visible=true, transformation(origin={270,-91}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-48}, extent={{-3.413333,-3.413333},{3.413333,3.413333}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput downlinkTimeoutOut  "下传TimeoutOut" annotation(Placement(visible=true, transformation(origin={270,-117}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-58.666667}, extent={{-3.413333,-3.413333},{3.413333,3.413333}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput safeEntryCompleteOut  "安全模式EntryCompleteOut" annotation(Placement(visible=true, transformation(origin={270,-169}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-69.333333}, extent={{-3.413333,-3.413333},{3.413333,3.413333}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput recoveryCompleteOut  "计算/接口量 recoveryCompleteOut" annotation(Placement(visible=true, transformation(origin={270,-195}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-3.413333,-3.413333},{3.413333,3.413333}}, rotation=0)));
  parameter Real dispatchBoundary(unit="s")=1e-4
    "单次事件邮箱交付边界；不是周期采样或物理通信延迟";
protected
  discrete Integer pendingKind(start=0,fixed=true) "计算/接口量 pendingKind" ;
  discrete Integer pendingId(start=0,fixed=true) "计算/接口量 pendingId" ;
  discrete OneSatSim.Foundation.Types.RejectReason pendingImagingFailureReason(
    start=OneSatSim.Foundation.Types.RejectReason.None,fixed=true) "pending成像FailureReason" ;
  discrete OneSatSim.Foundation.Types.ImagingPhase pendingImagingFailurePhase(
    start=OneSatSim.Foundation.Types.ImagingPhase.Idle,fixed=true) "pending成像FailurePhase" ;
  discrete Real dispatchDeadline(start=1e100,fixed=true) "计算/接口量 dispatchDeadline" ;
  discrete Integer imagingStartedId(start=0,fixed=true) "成像StartedId" ;
  discrete Integer imagingCompletedId(start=0,fixed=true) "成像CompletedId" ;
  discrete Integer imagingFailedId(start=0,fixed=true) "成像FailedId" ;
  discrete Integer imagingAbortedId(start=0,fixed=true) "成像AbortedId" ;
  discrete Integer imagingTimeoutId(start=0,fixed=true) "成像TimeoutId" ;
  discrete OneSatSim.Foundation.Types.RejectReason imagingFailureReasonDelivered(
    start=OneSatSim.Foundation.Types.RejectReason.None,fixed=true) "成像FailureReasonDelivered" ;
  discrete OneSatSim.Foundation.Types.ImagingPhase imagingFailurePhaseDelivered(
    start=OneSatSim.Foundation.Types.ImagingPhase.Idle,fixed=true) "成像FailurePhaseDelivered" ;
  discrete Integer downlinkStartedId(start=0,fixed=true) "下传StartedId" ;
  discrete Integer downlinkCompletedId(start=0,fixed=true) "下传CompletedId" ;
  discrete Integer downlinkFailedId(start=0,fixed=true) "下传FailedId" ;
  discrete Integer downlinkAbortedId(start=0,fixed=true) "下传AbortedId" ;
  discrete Integer downlinkTimeoutId(start=0,fixed=true) "下传TimeoutId" ;
  discrete Integer safeEntryCompleteId(start=0,fixed=true) "安全模式EntryCompleteId" ;
  discrete Integer recoveryCompleteId(start=0,fixed=true) "计算/接口量 recoveryCompleteId" ;
equation
  imagingStartedOut=imagingStartedId;
  imagingCompletedOut=imagingCompletedId;
  imagingFailedOut=imagingFailedId;
  imagingAbortedOut=imagingAbortedId;
  imagingTimeoutOut=imagingTimeoutId;
  imagingFailureReasonOut=imagingFailureReasonDelivered;
  imagingFailurePhaseOut=imagingFailurePhaseDelivered;
  downlinkStartedOut=downlinkStartedId;
  downlinkCompletedOut=downlinkCompletedId;
  downlinkFailedOut=downlinkFailedId;
  downlinkAbortedOut=downlinkAbortedId;
  downlinkTimeoutOut=downlinkTimeoutId;
  safeEntryCompleteOut=safeEntryCompleteId;
  recoveryCompleteOut=recoveryCompleteId;
algorithm
  // Capture stage: only the mailbox snapshot and its one-shot deadline are
  // written here.  No delivered result is modified in this event equation.
  when {initial(),change(imagingStartedIn),change(imagingCompletedIn),
      change(imagingFailedIn),change(imagingAbortedIn),change(imagingTimeoutIn),
      change(downlinkStartedIn),change(downlinkCompletedIn),change(downlinkFailedIn),
      change(downlinkAbortedIn),change(downlinkTimeoutIn),change(safeEntryCompleteIn),
      change(recoveryCompleteIn)} then
    if initial() then
      pendingKind:=0;
      pendingId:=0;
      dispatchDeadline:=1e100;
      pendingImagingFailureReason:=OneSatSim.Foundation.Types.RejectReason.None;
      pendingImagingFailurePhase:=OneSatSim.Foundation.Types.ImagingPhase.Idle;
    elseif change(imagingStartedIn) then
      pendingKind:=1; pendingId:=imagingStartedIn; dispatchDeadline:=time+dispatchBoundary;
    elseif change(imagingCompletedIn) then
      pendingKind:=2; pendingId:=imagingCompletedIn; dispatchDeadline:=time+dispatchBoundary;
    elseif change(imagingFailedIn) then
      pendingKind:=3; pendingId:=imagingFailedIn; dispatchDeadline:=time+dispatchBoundary;
      pendingImagingFailureReason:=imagingFailureReasonIn;
      pendingImagingFailurePhase:=imagingFailurePhaseIn;
    elseif change(imagingAbortedIn) then
      pendingKind:=4; pendingId:=imagingAbortedIn; dispatchDeadline:=time+dispatchBoundary;
      pendingImagingFailureReason:=imagingFailureReasonIn;
      pendingImagingFailurePhase:=imagingFailurePhaseIn;
    elseif change(imagingTimeoutIn) then
      pendingKind:=5; pendingId:=imagingTimeoutIn; dispatchDeadline:=time+dispatchBoundary;
      pendingImagingFailureReason:=imagingFailureReasonIn;
      pendingImagingFailurePhase:=imagingFailurePhaseIn;
    elseif change(downlinkStartedIn) then
      pendingKind:=6; pendingId:=downlinkStartedIn; dispatchDeadline:=time+dispatchBoundary;
    elseif change(downlinkCompletedIn) then
      pendingKind:=7; pendingId:=downlinkCompletedIn; dispatchDeadline:=time+dispatchBoundary;
    elseif change(downlinkFailedIn) then
      pendingKind:=8; pendingId:=downlinkFailedIn; dispatchDeadline:=time+dispatchBoundary;
    elseif change(downlinkAbortedIn) then
      pendingKind:=9; pendingId:=downlinkAbortedIn; dispatchDeadline:=time+dispatchBoundary;
    elseif change(downlinkTimeoutIn) then
      pendingKind:=10; pendingId:=downlinkTimeoutIn; dispatchDeadline:=time+dispatchBoundary;
    elseif change(safeEntryCompleteIn) then
      pendingKind:=11; pendingId:=safeEntryCompleteIn; dispatchDeadline:=time+dispatchBoundary;
    elseif change(recoveryCompleteIn) then
      pendingKind:=12; pendingId:=recoveryCompleteIn; dispatchDeadline:=time+dispatchBoundary;
    end if;
  end when;
algorithm
  // Delivery stage: the deadline is strictly later than the capture event and
  // only pre(...) snapshots are read.  This is the discrete causality cut.
  when {initial(),time >= pre(dispatchDeadline)} then
    if initial() then
      imagingStartedId:=0;
      imagingCompletedId:=0;
      imagingFailedId:=0;
      imagingAbortedId:=0;
      imagingTimeoutId:=0;
      imagingFailureReasonDelivered:=OneSatSim.Foundation.Types.RejectReason.None;
      imagingFailurePhaseDelivered:=OneSatSim.Foundation.Types.ImagingPhase.Idle;
      downlinkStartedId:=0;
      downlinkCompletedId:=0;
      downlinkFailedId:=0;
      downlinkAbortedId:=0;
      downlinkTimeoutId:=0;
      safeEntryCompleteId:=0;
      recoveryCompleteId:=0;
    else
      if pre(pendingKind) == 1 then imagingStartedId:=pre(pendingId);
      elseif pre(pendingKind) == 2 then imagingCompletedId:=pre(pendingId);
      elseif pre(pendingKind) == 3 then imagingFailedId:=pre(pendingId);
      elseif pre(pendingKind) == 4 then imagingAbortedId:=pre(pendingId);
      elseif pre(pendingKind) == 5 then imagingTimeoutId:=pre(pendingId);
      elseif pre(pendingKind) == 6 then downlinkStartedId:=pre(pendingId);
      elseif pre(pendingKind) == 7 then downlinkCompletedId:=pre(pendingId);
      elseif pre(pendingKind) == 8 then downlinkFailedId:=pre(pendingId);
      elseif pre(pendingKind) == 9 then downlinkAbortedId:=pre(pendingId);
      elseif pre(pendingKind) == 10 then downlinkTimeoutId:=pre(pendingId);
      elseif pre(pendingKind) == 11 then safeEntryCompleteId:=pre(pendingId);
      elseif pre(pendingKind) == 12 then recoveryCompleteId:=pre(pendingId);
      end if;
      if pre(pendingKind) >= 3 and pre(pendingKind) <= 5 then
        imagingFailureReasonDelivered:=pre(pendingImagingFailureReason);
        imagingFailurePhaseDelivered:=pre(pendingImagingFailurePhase);
      end if;
    end if;
  end when;
  annotation(Documentation(info="<html><h2>任务动作结果事件邮箱</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Models.MissionActionResultMailbox</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>任务动作结果事件邮箱</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.MissionControlUnit\">OneSatSim.Components.MissionControlUnit</a> 的 <code>resultMailbox</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>imagingStartedIn</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>成像StartedIn</td></tr><tr><td><code>imagingCompletedIn</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>成像CompletedIn</td></tr><tr><td><code>imagingFailedIn</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>成像FailedIn</td></tr><tr><td><code>imagingAbortedIn</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>成像AbortedIn</td></tr><tr><td><code>imagingTimeoutIn</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>成像TimeoutIn</td></tr><tr><td><code>imagingFailureReasonIn</code></td><td>OneSatSim.Foundation.Interfaces.RejectReasonSignal</td><td>public</td><td>按声明/类型合同</td><td>成像FailureReasonIn；Reason captured with failed/aborted/timeout event ID</td></tr><tr><td><code>imagingFailurePhaseIn</code></td><td>OneSatSim.Foundation.Interfaces.ImagingPhaseSignal</td><td>public</td><td>按声明/类型合同</td><td>成像FailurePhaseIn；Action phase captured with terminal event ID</td></tr><tr><td><code>downlinkStartedIn</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>下传StartedIn</td></tr><tr><td><code>downlinkCompletedIn</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>下传CompletedIn</td></tr><tr><td><code>downlinkFailedIn</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>下传FailedIn</td></tr><tr><td><code>downlinkAbortedIn</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>下传AbortedIn</td></tr><tr><td><code>downlinkTimeoutIn</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>下传TimeoutIn</td></tr><tr><td><code>safeEntryCompleteIn</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>安全模式EntryCompleteIn</td></tr><tr><td><code>recoveryCompleteIn</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 recoveryCompleteIn</td></tr><tr><td><code>imagingStartedOut</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>成像StartedOut</td></tr><tr><td><code>imagingCompletedOut</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>成像CompletedOut</td></tr><tr><td><code>imagingFailedOut</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>成像FailedOut</td></tr><tr><td><code>imagingAbortedOut</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>成像AbortedOut</td></tr><tr><td><code>imagingTimeoutOut</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>成像TimeoutOut</td></tr><tr><td><code>imagingFailureReasonOut</code></td><td>OneSatSim.Foundation.Interfaces.RejectReasonOutput</td><td>public</td><td>按声明/类型合同</td><td>成像FailureReasonOut</td></tr><tr><td><code>imagingFailurePhaseOut</code></td><td>OneSatSim.Foundation.Interfaces.ImagingPhaseOutput</td><td>public</td><td>按声明/类型合同</td><td>成像FailurePhaseOut</td></tr><tr><td><code>downlinkStartedOut</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>下传StartedOut</td></tr><tr><td><code>downlinkCompletedOut</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>下传CompletedOut</td></tr><tr><td><code>downlinkFailedOut</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>下传FailedOut</td></tr><tr><td><code>downlinkAbortedOut</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>下传AbortedOut</td></tr><tr><td><code>downlinkTimeoutOut</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>下传TimeoutOut</td></tr><tr><td><code>safeEntryCompleteOut</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>安全模式EntryCompleteOut</td></tr><tr><td><code>recoveryCompleteOut</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 recoveryCompleteOut</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>dispatchBoundary</code></td><td>Real</td><td>单次事件邮箱交付边界；不是周期采样或物理通信延迟</td><td><code>=1e-4</code></td></tr></table><h3>状态与初始化</h3><p>本类源码中显式出现的导数对象或离散声明：<code>pendingKind, pendingId, pendingImagingFailureReason, pendingImagingFailurePhase, dispatchDeadline, imagingStartedId, imagingCompletedId, imagingFailedId, imagingAbortedId, imagingTimeoutId, imagingFailureReasonDelivered, imagingFailurePhaseDelivered, downlinkStartedId, downlinkCompletedId, downlinkFailedId, downlinkAbortedId, downlinkTimeoutId, safeEntryCompleteId, recoveryCompleteId</code>。初始化取当前声明的 start/fixed、initial 方程/算法及继承设置。此处是源码级说明，不等同于编译后连续状态统计。</p><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] imagingStartedOut=imagingStartedId;\n[equation] imagingCompletedOut=imagingCompletedId;\n[equation] imagingFailedOut=imagingFailedId;\n[equation] imagingAbortedOut=imagingAbortedId;\n[equation] imagingTimeoutOut=imagingTimeoutId;\n[equation] imagingFailureReasonOut=imagingFailureReasonDelivered;\n[equation] imagingFailurePhaseOut=imagingFailurePhaseDelivered;\n[equation] downlinkStartedOut=downlinkStartedId;\n[equation] downlinkCompletedOut=downlinkCompletedId;\n[equation] downlinkFailedOut=downlinkFailedId;</pre><p>本类另有85段语句；阅读完整源码可查看其余边界与逻辑。</p><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>pendingKind</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 pendingKind</td></tr><tr><td><code>pendingId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 pendingId</td></tr><tr><td><code>pendingImagingFailureReason</code></td><td>OneSatSim.Foundation.Types.RejectReason</td><td>discrete</td><td>按声明/类型合同</td><td>pending成像FailureReason</td></tr><tr><td><code>pendingImagingFailurePhase</code></td><td>OneSatSim.Foundation.Types.ImagingPhase</td><td>discrete</td><td>按声明/类型合同</td><td>pending成像FailurePhase</td></tr><tr><td><code>dispatchDeadline</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 dispatchDeadline</td></tr><tr><td><code>imagingStartedId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>成像StartedId</td></tr><tr><td><code>imagingCompletedId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>成像CompletedId</td></tr><tr><td><code>imagingFailedId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>成像FailedId</td></tr><tr><td><code>imagingAbortedId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>成像AbortedId</td></tr><tr><td><code>imagingTimeoutId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>成像TimeoutId</td></tr><tr><td><code>imagingFailureReasonDelivered</code></td><td>OneSatSim.Foundation.Types.RejectReason</td><td>discrete</td><td>按声明/类型合同</td><td>成像FailureReasonDelivered</td></tr><tr><td><code>imagingFailurePhaseDelivered</code></td><td>OneSatSim.Foundation.Types.ImagingPhase</td><td>discrete</td><td>按声明/类型合同</td><td>成像FailurePhaseDelivered</td></tr><tr><td><code>downlinkStartedId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>下传StartedId</td></tr><tr><td><code>downlinkCompletedId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>下传CompletedId</td></tr><tr><td><code>downlinkFailedId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>下传FailedId</td></tr><tr><td><code>downlinkAbortedId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>下传AbortedId</td></tr><tr><td><code>downlinkTimeoutId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>下传TimeoutId</td></tr><tr><td><code>safeEntryCompleteId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>安全模式EntryCompleteId</td></tr><tr><td><code>recoveryCompleteId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 recoveryCompleteId</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-31,-26},{32,33}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Rectangle(extent={{-23,17},{24,22}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Rectangle(extent={{-21,-17},{22,9}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{-21,9},{0,-5},{22,9}}, color={0,0,0}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-21,-17},{-4,-2}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{22,-17},{4,-2}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-71,-8},{-38,-8}}, color={83,131,109}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{38,7},{69,7}}, color={83,131,109}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-10,-38},{-2,-46},{14,-30}}, color={83,131,109}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{-14,44},{-14,52},{4,52},{4,44},{22,44}}, color={113,122,132}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Action Result Mailbox", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-344,-239},{343,299}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-78.32,-85.36},{78.32,83.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-66.88,56.32},{66.88,56.32}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-73.92,60.72},{-56.32,78.32}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-53.68,62.48},{66.88,75.68}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-27.28,-22.88},{28.16,29.04}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Rectangle(extent={{-20.24,14.96},{21.12,19.36}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Rectangle(extent={{-18.48,-14.96},{19.36,7.92}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{-18.48,7.92},{0,-4.4},{19.36,7.92}}, color={0,0,0}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-18.48,-14.96},{-3.52,-1.76}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{19.36,-14.96},{3.52,-1.76}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-62.48,-7.04},{-33.44,-7.04}}, color={83,131,109}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{33.44,6.16},{60.72,6.16}}, color={83,131,109}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-8.8,-33.44},{-1.76,-40.48},{12.32,-26.4}}, color={83,131,109}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{-12.32,38.72},{-12.32,45.76},{3.52,45.76},{3.52,38.72},{19.36,38.72}}, color={113,122,132}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-66.88,-51.04},{66.88,-51.04}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-70.4,-69.52},{70.4,-56.32}}, textString="Action Result Mailbox", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-318,211},{-223,229}}, textString="IMAGING", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-318,3},{-223,21}}, textString="DOWNLINK", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-318,-153},{-223,-135}}, textString="SAFE MODE", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{222,211},{317,229}}, textString="IMAGING", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{222,3},{317,21}}, textString="DOWNLINK", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{222,-153},{317,-135}}, textString="SAFE MODE", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-332,254},{331,283}}, textString="Mission Action Result Mailbox", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-332,246},{331,246}}, color={215,220,226}, thickness=0.25)
    }));
end MissionActionResultMailbox;