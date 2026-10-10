within OneSatSim.Foundation.Interfaces;
connector MissionStateSignals "Authoritative mission state and action requests"
  MissionModeSignal missionMode "任务模式" ;
  ControlModeSignal controlMode "控制模式" ;
  CommandTypeSignal currentCommand "电流指令" ;
  IntegerSignal activeRequestId "当前锁存请求ID" ;
  IntegerSignal activeTargetIndex "锁存目标ID" ;
  IntegerSignal activeGroundStationIndex "当前任务锁存的地面站；零表示无下传站" ;
  CommandExecutionStatusSignal executionStatus "执行状态" ;
  IntegerSignal transitionCounter "计算/接口量 transitionCounter" ;
  RealSignal stateElapsed(unit="s") "状态Elapsed [s]" ;
  RealSignal executionTime(unit="s") "execution时间 [s]" ;
  BooleanSignal commandExecuting "指令Executing" ;
  BooleanSignal commandCompleted "指令Completed" ;
  BooleanSignal commandFailed "指令Failed" ;
  BooleanSignal commandAborted "指令Aborted" ;
  BooleanSignal commandTimeout "指令Timeout" ;
  IntegerSignal imagingActionRequestId "成像Action请求Id" ;
  IntegerSignal downlinkActionRequestId "下传Action请求Id" ;
  IntegerSignal safeModeActionRequestId "安全模式模式Action请求Id" ;
  CommandTypeSignal safeModeActionCommand "安全模式模式Action指令" ;
  RejectReasonSignal lastRejectReason "最近一次规划/队列拒绝原因";
  RejectReasonSignal terminalFailureReason "计算/接口量 terminalFailureReason；Reason latched by the actual terminal branch";
  MissionModeSignal terminalFailurePhase "计算/接口量 terminalFailurePhase；Mission phase immediately before failure";
  ImagingPhaseSignal terminalImagingPhase "terminal成像Phase；Imaging action phase when its failure event was accepted";
  CommandTypeSignal terminalFailureCommand "terminalFailure指令" ;
  IntegerSignal terminalFailureRequestId "terminalFailure请求Id" ;
  IntegerSignal terminalFailureTargetIndex "terminalFailure目标Index" ;
  IntegerSignal completedImagingCount "完整成像计数；Distinct imaging requests completed by the sequencer";
  IntegerSignal completedDownlinkCount "下传完成计数；Distinct downlink requests completed by the sequencer";
  IntegerSignal lastCompletedTargetIndex "lastCompleted目标Index；Target slot of the most recent completed image";
  IntegerSignal lastTerminalRequestId "最近终止请求ID；Most recent terminal imaging or downlink request";
  RejectReasonSignal lastTerminalReason "计算/接口量 lastTerminalReason；Reason for most recent terminal request; None on success";
  annotation(Documentation(info="<html><h2>Mission状态信号组</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.MissionStateSignals</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>Mission状态信号组。原源码功能描述：Authoritative mission state and action requests</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>missionMode</code></td><td>MissionModeSignal</td><td>public</td><td>按声明/类型合同</td><td>任务模式</td></tr><tr><td><code>controlMode</code></td><td>ControlModeSignal</td><td>public</td><td>按声明/类型合同</td><td>控制模式</td></tr><tr><td><code>currentCommand</code></td><td>CommandTypeSignal</td><td>public</td><td>按声明/类型合同</td><td>电流指令</td></tr><tr><td><code>activeRequestId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>当前锁存请求ID</td></tr><tr><td><code>activeTargetIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>锁存目标ID</td></tr><tr><td><code>activeGroundStationIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>当前任务锁存的地面站；零表示无下传站</td></tr><tr><td><code>executionStatus</code></td><td>CommandExecutionStatusSignal</td><td>public</td><td>按声明/类型合同</td><td>执行状态</td></tr><tr><td><code>transitionCounter</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 transitionCounter</td></tr><tr><td><code>stateElapsed</code></td><td>RealSignal</td><td>public</td><td>s</td><td>状态Elapsed [s]</td></tr><tr><td><code>executionTime</code></td><td>RealSignal</td><td>public</td><td>s</td><td>execution时间 [s]</td></tr><tr><td><code>commandExecuting</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>指令Executing</td></tr><tr><td><code>commandCompleted</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>指令Completed</td></tr><tr><td><code>commandFailed</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>指令Failed</td></tr><tr><td><code>commandAborted</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>指令Aborted</td></tr><tr><td><code>commandTimeout</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>指令Timeout</td></tr><tr><td><code>imagingActionRequestId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>成像Action请求Id</td></tr><tr><td><code>downlinkActionRequestId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>下传Action请求Id</td></tr><tr><td><code>safeModeActionRequestId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>安全模式模式Action请求Id</td></tr><tr><td><code>safeModeActionCommand</code></td><td>CommandTypeSignal</td><td>public</td><td>按声明/类型合同</td><td>安全模式模式Action指令</td></tr><tr><td><code>lastRejectReason</code></td><td>RejectReasonSignal</td><td>public</td><td>按声明/类型合同</td><td>最近一次规划/队列拒绝原因</td></tr><tr><td><code>terminalFailureReason</code></td><td>RejectReasonSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 terminalFailureReason；Reason latched by the actual terminal branch</td></tr><tr><td><code>terminalFailurePhase</code></td><td>MissionModeSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 terminalFailurePhase；Mission phase immediately before failure</td></tr><tr><td><code>terminalImagingPhase</code></td><td>ImagingPhaseSignal</td><td>public</td><td>按声明/类型合同</td><td>terminal成像Phase；Imaging action phase when its failure event was accepted</td></tr><tr><td><code>terminalFailureCommand</code></td><td>CommandTypeSignal</td><td>public</td><td>按声明/类型合同</td><td>terminalFailure指令</td></tr><tr><td><code>terminalFailureRequestId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>terminalFailure请求Id</td></tr><tr><td><code>terminalFailureTargetIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>terminalFailure目标Index</td></tr><tr><td><code>completedImagingCount</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>完整成像计数；Distinct imaging requests completed by the sequencer</td></tr><tr><td><code>completedDownlinkCount</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>下传完成计数；Distinct downlink requests completed by the sequencer</td></tr><tr><td><code>lastCompletedTargetIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>lastCompleted目标Index；Target slot of the most recent completed image</td></tr><tr><td><code>lastTerminalRequestId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>最近终止请求ID；Most recent terminal imaging or downlink request</td></tr><tr><td><code>lastTerminalReason</code></td><td>RejectReasonSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 lastTerminalReason；Reason for most recent terminal request; None on success</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={103,58,183},lineColor={103,58,183},lineThickness=0,radius=0),
      Line(points={{-54,-40},{-18,-40},{-18,0},{18,0},{18,40},{54,40}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={103,58,183},lineColor={103,58,183},lineThickness=0,radius=0),
      Line(points={{-54,-40},{-18,-40},{-18,0},{18,0},{18,40},{54,40}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }));
end MissionStateSignals;