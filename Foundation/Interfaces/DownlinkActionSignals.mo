within OneSatSim.Foundation.Interfaces;
connector DownlinkActionSignals "Downlink action state and event identifiers"
  DownlinkPhaseSignal phase "计算/接口量 phase" ;
  BooleanSignal communicationPowerCommand "communication功率指令" ;
  BooleanSignal transmitCommand "transmit指令" ;
  BooleanSignal busy "计算/接口量 busy" ;
  BooleanSignal active "激活" ;
  BooleanSignal completed "计算/接口量 completed" ;
  BooleanSignal failed "计算/接口量 failed" ;
  BooleanSignal aborted "计算/接口量 aborted" ;
  BooleanSignal timeout "计算/接口量 timeout" ;
  IntegerSignal startedEventId "计算/接口量 startedEventId" ;
  IntegerSignal completedEventId "计算/接口量 completedEventId" ;
  IntegerSignal failedEventId "计算/接口量 failedEventId" ;
  IntegerSignal abortedEventId "计算/接口量 abortedEventId" ;
  IntegerSignal timeoutEventId "计算/接口量 timeoutEventId" ;
  annotation(Documentation(info="<html><h2>下传Action信号组</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.DownlinkActionSignals</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>下传Action信号组。原源码功能描述：Downlink action state and event identifiers</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>phase</code></td><td>DownlinkPhaseSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 phase</td></tr><tr><td><code>communicationPowerCommand</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>communication功率指令</td></tr><tr><td><code>transmitCommand</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>transmit指令</td></tr><tr><td><code>busy</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 busy</td></tr><tr><td><code>active</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>激活</td></tr><tr><td><code>completed</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 completed</td></tr><tr><td><code>failed</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 failed</td></tr><tr><td><code>aborted</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 aborted</td></tr><tr><td><code>timeout</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 timeout</td></tr><tr><td><code>startedEventId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 startedEventId</td></tr><tr><td><code>completedEventId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 completedEventId</td></tr><tr><td><code>failedEventId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 failedEventId</td></tr><tr><td><code>abortedEventId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 abortedEventId</td></tr><tr><td><code>timeoutEventId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 timeoutEventId</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,188,212},lineColor={0,188,212},lineThickness=0,radius=0),
      Polygon(points={{-10,53},{10,53},{10,-5},{35,-5},{0,-43},{-35,-5},{-10,-5},{-10,53}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4),
      Rectangle(extent={{-50,-58},{50,-48}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,188,212},lineColor={0,188,212},lineThickness=0,radius=0),
      Polygon(points={{-10,53},{10,53},{10,-5},{35,-5},{0,-43},{-35,-5},{-10,-5},{-10,53}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4),
      Rectangle(extent={{-50,-58},{50,-48}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0)
    }));
end DownlinkActionSignals;