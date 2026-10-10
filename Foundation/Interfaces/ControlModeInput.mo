within OneSatSim.Foundation.Interfaces;
connector ControlModeInput = input OneSatSim.Foundation.Types.ControlMode
  "控制模式因果输入" annotation(Documentation(info="<html><h2>控制模式因果输入</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.ControlModeInput</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>控制模式因果输入</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>继承与复用</h3><p>本类的继承/别名声明如下。继承得到的端口、参数、状态和算法仍由被引用类定义，不重复增加一套行为。</p><pre>input OneSatSim.Foundation.Types.ControlMode</pre></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,102,255},lineColor={0,102,255},lineThickness=0,radius=0),
      Line(points={{-40.5,-30},{-13.5,-30},{-13.5,0},{13.5,0},{13.5,30},{40.5,30}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Polygon(points={{-18,-78},{5,-68},{-18,-58},{-18,-78}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,102,255},lineColor={0,102,255},lineThickness=0,radius=0),
      Line(points={{-40.5,-30},{-13.5,-30},{-13.5,0},{13.5,0},{13.5,30},{40.5,30}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Polygon(points={{-18,-78},{5,-68},{-18,-58},{-18,-78}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4)
    }));