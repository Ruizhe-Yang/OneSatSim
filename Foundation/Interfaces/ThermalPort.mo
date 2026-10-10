within OneSatSim.Foundation.Interfaces;
connector ThermalPort "设备壳体热端口"
  extends Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a annotation(IconMap(primitivesVisible=false),DiagramMap(primitivesVisible=false));

  annotation(Documentation(info="<html><h2>设备壳体热端口</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.ThermalPort</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>设备壳体热端口</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>继承与复用</h3><p>本类的继承/别名声明如下。继承得到的端口、参数、状态和算法仍由被引用类定义，不重复增加一套行为。</p><pre>Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a annotation(IconMap(primitivesVisible=false),DiagramMap(primitivesVisible=false))</pre></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={229,57,53},lineColor={229,57,53},lineThickness=0,radius=0),
      Line(points={{-33,-53},{-42,-27},{-24,0},{-42,27},{-33,53}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{0,-53},{-9,-27},{9,0},{-9,27},{0,53}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{33,-53},{24,-27},{42,0},{24,27},{33,53}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={229,57,53},lineColor={229,57,53},lineThickness=0,radius=0),
      Line(points={{-33,-53},{-42,-27},{-24,0},{-42,27},{-33,53}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{0,-53},{-9,-27},{9,0},{-9,27},{0,53}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{33,-53},{24,-27},{42,0},{24,27},{33,53}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }));
end ThermalPort;