within OneSatSim.Foundation.Interfaces;
connector DownlinkPhaseSignal=OneSatSim.Foundation.Types.DownlinkPhase
  "无因果数传阶段标量" annotation(Documentation(info="<html><h2>无因果数传阶段标量</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.DownlinkPhaseSignal</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>无因果数传阶段标量</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>继承与复用</h3><p>本类的继承/别名声明如下。继承得到的端口、参数、状态和算法仍由被引用类定义，不重复增加一套行为。</p><pre>OneSatSim.Foundation.Types.DownlinkPhase</pre></html>"),
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