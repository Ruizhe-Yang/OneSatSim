within OneSatSim.Foundation.Interfaces;
connector SafeModeActionSignals "Safe-entry and recovery action events"
  BooleanSignal safeEntryComplete "安全模式EntryComplete" ;
  BooleanSignal recoveryReady "recovery就绪" ;
  BooleanSignal recoveryComplete "计算/接口量 recoveryComplete" ;
  IntegerSignal safeEntryCompleteEventId "安全模式EntryCompleteEventId" ;
  IntegerSignal recoveryCompleteEventId "计算/接口量 recoveryCompleteEventId" ;
  annotation(Documentation(info="<html><h2>安全模式模式Action信号组</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.SafeModeActionSignals</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>安全模式模式Action信号组。原源码功能描述：Safe-entry and recovery action events</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>safeEntryComplete</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>安全模式EntryComplete</td></tr><tr><td><code>recoveryReady</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>recovery就绪</td></tr><tr><td><code>recoveryComplete</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 recoveryComplete</td></tr><tr><td><code>safeEntryCompleteEventId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>安全模式EntryCompleteEventId</td></tr><tr><td><code>recoveryCompleteEventId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 recoveryCompleteEventId</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={198,40,40},lineColor={198,40,40},lineThickness=0,radius=0),
      Polygon(points={{0,56},{46,35},{35,-26},{0,-56},{-35,-26},{-46,35},{0,56}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4),
      Line(points={{-22,0},{-4,-18},{25,20}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={198,40,40},lineColor={198,40,40},lineThickness=0,radius=0),
      Polygon(points={{0,56},{46,35},{35,-26},{0,-56},{-35,-26},{-46,35},{0,56}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4),
      Line(points={{-22,0},{-4,-18},{25,20}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }));
end SafeModeActionSignals;