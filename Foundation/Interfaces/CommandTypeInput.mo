within OneSatSim.Foundation.Interfaces;
connector CommandTypeInput = input OneSatSim.Foundation.Types.CommandType "Causal mission command type input" annotation(Documentation(info="<html><h2>指令Type输入</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.CommandTypeInput</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>指令Type输入。原源码功能描述：Causal mission command type input</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>继承与复用</h3><p>本类的继承/别名声明如下。继承得到的端口、参数、状态和算法仍由被引用类定义，不重复增加一套行为。</p><pre>input OneSatSim.Foundation.Types.CommandType</pre></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={117,0,255},lineColor={117,0,255},lineThickness=0,radius=0),
      Polygon(points={{-40.5,-9},{9,-9},{9,-27.75},{42,0},{9,27.75},{9,9},{-40.5,9},{-40.5,-9}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4),
      Polygon(points={{-18,-78},{5,-68},{-18,-58},{-18,-78}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={117,0,255},lineColor={117,0,255},lineThickness=0,radius=0),
      Polygon(points={{-40.5,-9},{9,-9},{9,-27.75},{42,0},{9,27.75},{9,9},{-40.5,9},{-40.5,-9}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4),
      Polygon(points={{-18,-78},{5,-68},{-18,-58},{-18,-78}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4)
    }));