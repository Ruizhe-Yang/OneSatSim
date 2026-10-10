within OneSatSim.Foundation.Interfaces;
connector SourcePowerPort "太阳阵/电池/PCDU之间的原始双线电源端口"
  Modelica.Electrical.Analog.Interfaces.Pin p "原始电源正端";
  Modelica.Electrical.Analog.Interfaces.Pin n "原始电源负端";
  annotation(Documentation(info="<html><h2>太阳阵/电池/PCDU之间的原始双线电源端口</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.SourcePowerPort</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>太阳阵/电池/PCDU之间的原始双线电源端口</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>p</code></td><td>Modelica.Electrical.Analog.Interfaces.Pin</td><td>public</td><td>按声明/类型合同</td><td>原始电源正端</td></tr><tr><td><code>n</code></td><td>Modelica.Electrical.Analog.Interfaces.Pin</td><td>public</td><td>按声明/类型合同</td><td>原始电源负端</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={232,93,4},lineColor={232,93,4},lineThickness=0,radius=0),
      Rectangle(extent={{-49,-30},{39,30}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,radius=0),
      Rectangle(extent={{39,-12},{54,12}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Line(points={{-30,0},{-8,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{3,0},{25,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{14,-11},{14,11}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={232,93,4},lineColor={232,93,4},lineThickness=0,radius=0),
      Rectangle(extent={{-49,-30},{39,30}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,radius=0),
      Rectangle(extent={{39,-12},{54,12}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Line(points={{-30,0},{-8,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{3,0},{25,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{14,-11},{14,11}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }));
end SourcePowerPort;