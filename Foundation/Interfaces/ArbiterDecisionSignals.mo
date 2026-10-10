within OneSatSim.Foundation.Interfaces;
connector ArbiterDecisionSignals "Discrete command-arbitration decision"
  IntegerSignal decisionId "计算/接口量 decisionId" ;
  BooleanSignal accepted "计算/接口量 accepted" ;
  BooleanSignal rejected "计算/接口量 rejected" ;
  CommandTypeSignal acceptedCommand "接受命令类别" ;
  IntegerSignal acceptedCommandId "接受命令ID" ;
  IntegerSignal acceptedTargetIndex "accepted目标Index" ;
  IntegerSignal acceptedGroundStationIndex "accepted地面站点Index" ;
  RealSignal acceptedOpportunityTimeRemaining(unit="s") "acceptedOpportunity时间Remaining [s]" ;
  RejectReasonSignal rejectReason "计算/接口量 rejectReason" ;
  BooleanSignal requestPending "请求Pending" ;
  annotation(Documentation(info="<html><h2>ArbiterDecision信号组</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.ArbiterDecisionSignals</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>ArbiterDecision信号组。原源码功能描述：Discrete command-arbitration decision</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>decisionId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 decisionId</td></tr><tr><td><code>accepted</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 accepted</td></tr><tr><td><code>rejected</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 rejected</td></tr><tr><td><code>acceptedCommand</code></td><td>CommandTypeSignal</td><td>public</td><td>按声明/类型合同</td><td>接受命令类别</td></tr><tr><td><code>acceptedCommandId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>接受命令ID</td></tr><tr><td><code>acceptedTargetIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>accepted目标Index</td></tr><tr><td><code>acceptedGroundStationIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>accepted地面站点Index</td></tr><tr><td><code>acceptedOpportunityTimeRemaining</code></td><td>RealSignal</td><td>public</td><td>s</td><td>acceptedOpportunity时间Remaining [s]</td></tr><tr><td><code>rejectReason</code></td><td>RejectReasonSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 rejectReason</td></tr><tr><td><code>requestPending</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>请求Pending</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={170,0,255},lineColor={170,0,255},lineThickness=0,radius=0),
      Line(points={{-53,40},{-10,40},{15,0},{53,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{-53,-40},{-10,-40},{15,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Polygon(points={{40,-12},{56,0},{40,12},{40,-12}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={170,0,255},lineColor={170,0,255},lineThickness=0,radius=0),
      Line(points={{-53,40},{-10,40},{15,0},{53,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{-53,-40},{-10,-40},{15,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Polygon(points={{40,-12},{56,0},{40,12},{40,-12}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4)
    }));
end ArbiterDecisionSignals;