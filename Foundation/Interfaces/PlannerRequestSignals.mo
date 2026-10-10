within OneSatSim.Foundation.Interfaces;
connector PlannerRequestSignals "Latched planner request"
  BooleanSignal requestValid "请求Valid" ;
  CommandTypeSignal requestedCommand "requested指令" ;
  IntegerSignal requestedTargetIndex "requested目标Index" ;
  IntegerSignal requestedGroundStationIndex "requested地面站点Index" ;
  IntegerSignal requestWindowId "请求WindowId" ;
  IntegerSignal requestId "当前/最近请求ID" ;
  RejectReasonSignal planningRejectReason "计算/接口量 planningRejectReason" ;
  RealSignal requestedOpportunityTimeRemaining(unit="s") "requestedOpportunity时间Remaining [s]" ;
  annotation(Documentation(info="<html><h2>Planner请求信号组</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.PlannerRequestSignals</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>Planner请求信号组。原源码功能描述：Latched planner request</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>requestValid</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>请求Valid</td></tr><tr><td><code>requestedCommand</code></td><td>CommandTypeSignal</td><td>public</td><td>按声明/类型合同</td><td>requested指令</td></tr><tr><td><code>requestedTargetIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>requested目标Index</td></tr><tr><td><code>requestedGroundStationIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>requested地面站点Index</td></tr><tr><td><code>requestWindowId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>请求WindowId</td></tr><tr><td><code>requestId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>当前/最近请求ID</td></tr><tr><td><code>planningRejectReason</code></td><td>RejectReasonSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 planningRejectReason</td></tr><tr><td><code>requestedOpportunityTimeRemaining</code></td><td>RealSignal</td><td>public</td><td>s</td><td>requestedOpportunity时间Remaining [s]</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={255,109,0},lineColor={255,109,0},lineThickness=0,radius=0),
      Rectangle(extent={{-52,31},{-38,45}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Rectangle(extent={{-52,-7},{-38,7}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Rectangle(extent={{-52,-45},{-38,-31}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Line(points={{-21,38},{52,38}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{-21,0},{52,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{-21,-38},{52,-38}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={255,109,0},lineColor={255,109,0},lineThickness=0,radius=0),
      Rectangle(extent={{-52,31},{-38,45}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Rectangle(extent={{-52,-7},{-38,7}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Rectangle(extent={{-52,-45},{-38,-31}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Line(points={{-21,38},{52,38}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{-21,0},{52,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{-21,-38},{52,-38}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }));
end PlannerRequestSignals;