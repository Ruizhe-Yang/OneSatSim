within OneSatSim.Foundation.Interfaces;
connector CommandExecutionStatusSignal=OneSatSim.Foundation.Types.CommandExecutionStatus
  "无因果任务执行状态标量" annotation(Documentation(info="<html><h2>无因果任务执行状态标量</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.CommandExecutionStatusSignal</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>无因果任务执行状态标量</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>继承与复用</h3><p>本类的继承/别名声明如下。继承得到的端口、参数、状态和算法仍由被引用类定义，不重复增加一套行为。</p><pre>OneSatSim.Foundation.Types.CommandExecutionStatus</pre></html>"),
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