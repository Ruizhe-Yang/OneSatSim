within NISSA_12UCubeSat.Foundation.Interfaces;
model IntegerSignalBridge "整数因果输出到可扩展信息总线的无状态恒等桥"
  Modelica.Blocks.Interfaces.IntegerInput u
    annotation(Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.IntegerOutput y
    annotation(Placement(transformation(extent={{90,-10},{110,10}})));
equation
  y=u;
  annotation(
    Icon(graphics={Rectangle(extent={{-100,55},{100,-55}},lineColor={180,100,20},fillColor={252,244,230},fillPattern=FillPattern.Solid),Line(points={{-72,0},{72,0}},color={180,100,20},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-30,35},{30,-35}},textString="=")}),
    Documentation(info="<html><h4>功能定位</h4><p>组件因果整数输出到可扩展信息总线之间的无状态恒等适配器。</p><h4>实现边界</h4><p>u为IntegerInput、y为IntegerOutput，仅实现y=u；不包含参数、动态状态、采样、滤波、限幅、延迟或通信行为。</p><h4>连接方向与使用</h4><p>左侧u接收因果状态码，右侧y发布到可扩展总线字段。桥接不解释状态码、不量化也不保持；总线字段进入因果计算时应使用IntegerSignalReader。</p></html>"));
end IntegerSignalBridge;
