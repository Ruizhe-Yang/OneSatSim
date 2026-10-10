within OneSatSim.Foundation.Interfaces;
expandable connector InformationPort "统一星上信息接口"
  CommandBus command "指令" ;
  CommandStatusBus commandStatus "指令Status" ;
  DeviceStatusBus device "计算/接口量 device" ;
  PayloadDataPort payload "计算/接口量 payload" ;
  annotation(Documentation(info="<html><h2>统一星上信息接口</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.InformationPort</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>统一星上信息接口</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>command</code></td><td>CommandBus</td><td>public</td><td>按声明/类型合同</td><td>指令</td></tr><tr><td><code>commandStatus</code></td><td>CommandStatusBus</td><td>public</td><td>按声明/类型合同</td><td>指令Status</td></tr><tr><td><code>device</code></td><td>DeviceStatusBus</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 device</td></tr><tr><td><code>payload</code></td><td>PayloadDataPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 payload</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,102,255},lineColor={0,102,255},lineThickness=0,radius=0),
      Rectangle(extent={{-54,-12},{-30,12}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Rectangle(extent={{30,26},{54,50}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Rectangle(extent={{30,-50},{54,-26}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Line(points={{-30,0},{0,0},{0,38},{30,38}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{0,0},{0,-38},{30,-38}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,102,255},lineColor={0,102,255},lineThickness=0,radius=0),
      Rectangle(extent={{-54,-12},{-30,12}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Rectangle(extent={{30,26},{54,50}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Rectangle(extent={{30,-50},{54,-26}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Line(points={{-30,0},{0,0},{0,38},{30,38}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{0,0},{0,-38},{30,-38}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }));
end InformationPort;