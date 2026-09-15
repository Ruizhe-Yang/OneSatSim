within OneSatSim.Foundation.Interfaces;
model BooleanSignalBridgeArray "布尔因果输出数组到可扩展信息总线的无状态恒等桥"
  parameter Integer n(min=1)=1 "桥接标量数量";
  Modelica.Blocks.Interfaces.BooleanInput u[n]
    annotation(Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput y[n]
    annotation(Placement(transformation(extent={{90,-10},{110,10}})));
equation
  y=u;
  annotation(
    Icon(graphics={Rectangle(extent={{-100,55},{100,-55}},lineColor={135,45,145},fillColor={247,235,249},fillPattern=FillPattern.Solid),Line(points={{-72,0},{72,0}},color={135,45,145},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-42,35},{42,-35}},textString="= [%n]")}),
    Documentation(info="<html><h4>功能定位</h4><p>多个布尔因果输出到可扩展信息总线之间的数组化无状态恒等适配器。</p><h4>实现边界</h4><p>u为BooleanInput数组、y为BooleanOutput数组，逐元素实现y=u；n只确定数组维数，不改变信号。模型不包含任何动态或通信行为。</p><h4>连接方向与使用</h4><p>用于因果布尔数组向可扩展总线字段发布；模型不产生边沿、事件或锁存，索引语义由调用者接口定义。</p></html>"));
end BooleanSignalBridgeArray;
