within OneSatSim.Foundation.Interfaces;
connector ImagingActionSignals "Imaging action state and event identifiers"
  ImagingPhaseSignal phase "计算/接口量 phase" ;
  BooleanSignal payloadPowerCommand "payload功率指令" ;
  BooleanSignal captureCommand "capture指令" ;
  BooleanSignal busy "计算/接口量 busy" ;
  BooleanSignal active "激活" ;
  BooleanSignal completed "计算/接口量 completed" ;
  BooleanSignal failed "计算/接口量 failed" ;
  BooleanSignal aborted "计算/接口量 aborted" ;
  BooleanSignal timeout "计算/接口量 timeout" ;
  BooleanSignal captureStarted "当前/最近一次成像任务已进入Capture";
  BooleanSignal imageComplete "当前/最近一次成像任务完成完整10 s图像";
  RealSignal validImageBytes(unit="1") "当前/最近一次任务形成的有效图像字节数";
  RealSignal acceptedImageBytes(unit="1") "计算/接口量 acceptedImageBytes [1]；Bytes actually accepted by the recorder for this image request";
  IntegerSignal acceptedRequestId "accepted请求Id；Request ID to which acceptedImageBytes belongs";
  RejectReasonSignal failureReason "计算/接口量 failureReason" ;
  ImagingPhaseSignal failurePhase "计算/接口量 failurePhase；Phase that triggered the most recent terminal failure";
  IntegerSignal startedEventId "计算/接口量 startedEventId" ;
  IntegerSignal completedEventId "计算/接口量 completedEventId" ;
  IntegerSignal failedEventId "计算/接口量 failedEventId" ;
  IntegerSignal abortedEventId "计算/接口量 abortedEventId" ;
  IntegerSignal timeoutEventId "计算/接口量 timeoutEventId" ;
  annotation(Documentation(info="<html><h2>成像Action信号组</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.ImagingActionSignals</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>成像Action信号组。原源码功能描述：Imaging action state and event identifiers</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>phase</code></td><td>ImagingPhaseSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 phase</td></tr><tr><td><code>payloadPowerCommand</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>payload功率指令</td></tr><tr><td><code>captureCommand</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>capture指令</td></tr><tr><td><code>busy</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 busy</td></tr><tr><td><code>active</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>激活</td></tr><tr><td><code>completed</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 completed</td></tr><tr><td><code>failed</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 failed</td></tr><tr><td><code>aborted</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 aborted</td></tr><tr><td><code>timeout</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 timeout</td></tr><tr><td><code>captureStarted</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>当前/最近一次成像任务已进入Capture</td></tr><tr><td><code>imageComplete</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>当前/最近一次成像任务完成完整10 s图像</td></tr><tr><td><code>validImageBytes</code></td><td>RealSignal</td><td>public</td><td>1</td><td>当前/最近一次任务形成的有效图像字节数</td></tr><tr><td><code>acceptedImageBytes</code></td><td>RealSignal</td><td>public</td><td>1</td><td>计算/接口量 acceptedImageBytes [1]；Bytes actually accepted by the recorder for this image request</td></tr><tr><td><code>acceptedRequestId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>accepted请求Id；Request ID to which acceptedImageBytes belongs</td></tr><tr><td><code>failureReason</code></td><td>RejectReasonSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 failureReason</td></tr><tr><td><code>failurePhase</code></td><td>ImagingPhaseSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 failurePhase；Phase that triggered the most recent terminal failure</td></tr><tr><td><code>startedEventId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 startedEventId</td></tr><tr><td><code>completedEventId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 completedEventId</td></tr><tr><td><code>failedEventId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 failedEventId</td></tr><tr><td><code>abortedEventId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 abortedEventId</td></tr><tr><td><code>timeoutEventId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 timeoutEventId</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={236,64,122},lineColor={236,64,122},lineThickness=0,radius=0),
      Rectangle(extent={{-55,-36},{55,34}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,radius=0),
      Ellipse(extent={{-23,-24},{23,22}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Rectangle(extent={{-28,34},{16,48}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={236,64,122},lineColor={236,64,122},lineThickness=0,radius=0),
      Rectangle(extent={{-55,-36},{55,34}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,radius=0),
      Ellipse(extent={{-23,-24},{23,22}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Rectangle(extent={{-28,34},{16,48}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0)
    }));
end ImagingActionSignals;