within OneSatSim.Foundation.Interfaces;
connector ImagingPhaseInput = input OneSatSim.Foundation.Types.ImagingPhase
  "成像任务阶段因果输入" annotation(Documentation(info="<html><h2>成像任务阶段因果输入</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.ImagingPhaseInput</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>成像任务阶段因果输入</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>继承与复用</h3><p>本类的继承/别名声明如下。继承得到的端口、参数、状态和算法仍由被引用类定义，不重复增加一套行为。</p><pre>input OneSatSim.Foundation.Types.ImagingPhase</pre></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={236,64,122},lineColor={236,64,122},lineThickness=0,radius=0),
      Rectangle(extent={{-41.25,-27},{41.25,25.5}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,radius=0),
      Ellipse(extent={{-17.25,-18},{17.25,16.5}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Rectangle(extent={{-21,25.5},{12,36}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Polygon(points={{-18,-78},{5,-68},{-18,-58},{-18,-78}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={236,64,122},lineColor={236,64,122},lineThickness=0,radius=0),
      Rectangle(extent={{-41.25,-27},{41.25,25.5}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,radius=0),
      Ellipse(extent={{-17.25,-18},{17.25,16.5}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Rectangle(extent={{-21,25.5},{12,36}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Polygon(points={{-18,-78},{5,-68},{-18,-58},{-18,-78}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4)
    }));