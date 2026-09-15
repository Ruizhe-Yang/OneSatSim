within NISSA_12UCubeSat.Foundation.Interfaces;
model IntegerSignalBridgeArray "整数因果输出数组到可扩展信息总线的无状态恒等桥"
  parameter Integer n(min=1)=1 "桥接标量数量";
  Modelica.Blocks.Interfaces.IntegerInput u[n]
    annotation(Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.IntegerOutput y[n]
    annotation(Placement(transformation(extent={{90,-10},{110,10}})));
equation
  y=u;
  annotation(
    Icon(graphics={Rectangle(extent={{-100,55},{100,-55}},lineColor={180,100,20},fillColor={252,244,230},fillPattern=FillPattern.Solid),Line(points={{-72,0},{72,0}},color={180,100,20},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-42,35},{42,-35}},textString="= [%n]")}),
    Documentation(info="<html><h4>功能定位</h4><p>多个整数因果输出到可扩展信息总线之间的数组化无状态恒等适配器。</p><h4>实现边界</h4><p>u为IntegerInput数组、y为IntegerOutput数组，逐元素实现y=u；n只确定数组维数，不改变信号。模型不包含任何动态或通信行为。</p><h4>连接方向与使用</h4><p>用于因果整数数组向可扩展总线字段发布；模型不转换状态码、不改变索引，也不包含协议打包行为。</p></html>"));
end IntegerSignalBridgeArray;
