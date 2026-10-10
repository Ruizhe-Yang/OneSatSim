within OneSatSim.Foundation.Interfaces;
connector PowerPort "三电压轨电源接口"
  Modelica.Electrical.Analog.Interfaces.Pin p12 "计算/接口量 p12" ;
  Modelica.Electrical.Analog.Interfaces.Pin n12 "计算/接口量 n12" ;
  Modelica.Electrical.Analog.Interfaces.Pin p5 "计算/接口量 p5" ;
  Modelica.Electrical.Analog.Interfaces.Pin n5 "计算/接口量 n5" ;
  Modelica.Electrical.Analog.Interfaces.Pin p33 "计算/接口量 p33" ;
  Modelica.Electrical.Analog.Interfaces.Pin n33 "计算/接口量 n33" ;

  annotation(Documentation(info = "<html><h2>三电压轨电源接口</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.PowerPort</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>三电压轨电源接口</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>p12</code></td><td>Modelica.Electrical.Analog.Interfaces.Pin</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 p12</td></tr><tr><td><code>n12</code></td><td>Modelica.Electrical.Analog.Interfaces.Pin</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 n12</td></tr><tr><td><code>p5</code></td><td>Modelica.Electrical.Analog.Interfaces.Pin</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 p5</td></tr><tr><td><code>n5</code></td><td>Modelica.Electrical.Analog.Interfaces.Pin</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 n5</td></tr><tr><td><code>p33</code></td><td>Modelica.Electrical.Analog.Interfaces.Pin</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 p33</td></tr><tr><td><code>n33</code></td><td>Modelica.Electrical.Analog.Interfaces.Pin</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 n33</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={245,158,11},lineColor={245,158,11},lineThickness=0,radius=0),
      Polygon(points={{10,60},{-38,0},{-8,0},{-20,-60},{40,12},{10,12},{10,60}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={245,158,11},lineColor={245,158,11},lineThickness=0,radius=0),
      Polygon(points={{10,60},{-38,0},{-8,0},{-20,-60},{40,12},{10,12},{10,60}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4)
    }));
end PowerPort;