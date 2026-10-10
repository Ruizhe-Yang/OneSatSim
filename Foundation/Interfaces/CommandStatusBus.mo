within OneSatSim.Foundation.Interfaces;
connector CommandStatusBus "Mission command lifecycle and execution feedback"
  CommandTypeSignal currentCommand "电流指令" ;
  CommandExecutionStatusSignal executionStatus "执行状态" ;
  RejectReasonSignal rejectReason "计算/接口量 rejectReason" ;
  MissionModeSignal missionMode "任务模式" ;
  ControlModeSignal controlMode "控制模式" ;
  IntegerSignal commandId "指令Id" ;
  IntegerSignal transitionCounter "计算/接口量 transitionCounter" ;
  BooleanSignal accepted "计算/接口量 accepted" ;
  BooleanSignal rejected "计算/接口量 rejected" ;
  BooleanSignal executing "计算/接口量 executing" ;
  BooleanSignal completed "计算/接口量 completed" ;
  BooleanSignal failed "计算/接口量 failed" ;
  BooleanSignal aborted "计算/接口量 aborted" ;
  BooleanSignal timeout "计算/接口量 timeout" ;
  BooleanSignal safePreemption "安全模式Preemption" ;
  RealSignal executionTime(unit="s") "execution时间 [s]" ;
  BooleanSignal imagingOpportunity "成像几何机会" ;
  BooleanSignal downlinkOpportunity "地面站机会" ;
  BooleanSignal imagingAllowed "成像Allowed" ;
  BooleanSignal downlinkAllowed "下传Allowed" ;
  BooleanSignal safeModeRequired "安全模式模式Required" ;
  BooleanSignal imagingCaptureStarted "当前/最近一次成像任务曾进入Capture";
  BooleanSignal imagingImageComplete "当前/最近一次成像任务形成完整图像";
  RealSignal imagingValidImageBytes(unit="1") "当前/最近一次成像有效字节数";
  RejectReasonSignal imagingFailureReason "当前/最近一次成像持久化终止原因";
  RealSignal imagingAcceptedImageBytes(unit="1") "成像AcceptedImageBytes [1]；Recorder-accepted bytes for current or latest image request";
  IntegerSignal imagingAcceptedRequestId "成像Accepted请求Id" ;
  MissionModeSignal terminalFailurePhase "计算/接口量 terminalFailurePhase" ;
  ImagingPhaseSignal terminalImagingPhase "terminal成像Phase" ;
  IntegerSignal terminalFailureRequestId "terminalFailure请求Id" ;
  IntegerSignal terminalFailureTargetIndex "terminalFailure目标Index" ;
  IntegerSignal completedImagingCount "完整成像计数" ;
  IntegerSignal completedDownlinkCount "下传完成计数" ;
  IntegerSignal lastCompletedTargetIndex "lastCompleted目标Index" ;
  IntegerSignal lastTerminalRequestId "最近终止请求ID" ;
  RejectReasonSignal lastTerminalReason "计算/接口量 lastTerminalReason" ;
  annotation(Documentation(info="<html><h2>指令Status总线</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.CommandStatusBus</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>指令Status总线。原源码功能描述：Mission command lifecycle and execution feedback</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>currentCommand</code></td><td>CommandTypeSignal</td><td>public</td><td>按声明/类型合同</td><td>电流指令</td></tr><tr><td><code>executionStatus</code></td><td>CommandExecutionStatusSignal</td><td>public</td><td>按声明/类型合同</td><td>执行状态</td></tr><tr><td><code>rejectReason</code></td><td>RejectReasonSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 rejectReason</td></tr><tr><td><code>missionMode</code></td><td>MissionModeSignal</td><td>public</td><td>按声明/类型合同</td><td>任务模式</td></tr><tr><td><code>controlMode</code></td><td>ControlModeSignal</td><td>public</td><td>按声明/类型合同</td><td>控制模式</td></tr><tr><td><code>commandId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>指令Id</td></tr><tr><td><code>transitionCounter</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 transitionCounter</td></tr><tr><td><code>accepted</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 accepted</td></tr><tr><td><code>rejected</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 rejected</td></tr><tr><td><code>executing</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 executing</td></tr><tr><td><code>completed</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 completed</td></tr><tr><td><code>failed</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 failed</td></tr><tr><td><code>aborted</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 aborted</td></tr><tr><td><code>timeout</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 timeout</td></tr><tr><td><code>safePreemption</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>安全模式Preemption</td></tr><tr><td><code>executionTime</code></td><td>RealSignal</td><td>public</td><td>s</td><td>execution时间 [s]</td></tr><tr><td><code>imagingOpportunity</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>成像几何机会</td></tr><tr><td><code>downlinkOpportunity</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>地面站机会</td></tr><tr><td><code>imagingAllowed</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>成像Allowed</td></tr><tr><td><code>downlinkAllowed</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>下传Allowed</td></tr><tr><td><code>safeModeRequired</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>安全模式模式Required</td></tr><tr><td><code>imagingCaptureStarted</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>当前/最近一次成像任务曾进入Capture</td></tr><tr><td><code>imagingImageComplete</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>当前/最近一次成像任务形成完整图像</td></tr><tr><td><code>imagingValidImageBytes</code></td><td>RealSignal</td><td>public</td><td>1</td><td>当前/最近一次成像有效字节数</td></tr><tr><td><code>imagingFailureReason</code></td><td>RejectReasonSignal</td><td>public</td><td>按声明/类型合同</td><td>当前/最近一次成像持久化终止原因</td></tr><tr><td><code>imagingAcceptedImageBytes</code></td><td>RealSignal</td><td>public</td><td>1</td><td>成像AcceptedImageBytes [1]；Recorder-accepted bytes for current or latest image request</td></tr><tr><td><code>imagingAcceptedRequestId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>成像Accepted请求Id</td></tr><tr><td><code>terminalFailurePhase</code></td><td>MissionModeSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 terminalFailurePhase</td></tr><tr><td><code>terminalImagingPhase</code></td><td>ImagingPhaseSignal</td><td>public</td><td>按声明/类型合同</td><td>terminal成像Phase</td></tr><tr><td><code>terminalFailureRequestId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>terminalFailure请求Id</td></tr><tr><td><code>terminalFailureTargetIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>terminalFailure目标Index</td></tr><tr><td><code>completedImagingCount</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>完整成像计数</td></tr><tr><td><code>completedDownlinkCount</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>下传完成计数</td></tr><tr><td><code>lastCompletedTargetIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>lastCompleted目标Index</td></tr><tr><td><code>lastTerminalRequestId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>最近终止请求ID</td></tr><tr><td><code>lastTerminalReason</code></td><td>RejectReasonSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 lastTerminalReason</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,145,234},lineColor={0,145,234},lineThickness=0,radius=0),
      Line(points={{-48,0},{-14,-34},{48,42}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{-45,-52},{45,-52}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,145,234},lineColor={0,145,234},lineThickness=0,radius=0),
      Line(points={{-48,0},{-14,-34},{48,42}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{-45,-52},{45,-52}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }));
end CommandStatusBus;