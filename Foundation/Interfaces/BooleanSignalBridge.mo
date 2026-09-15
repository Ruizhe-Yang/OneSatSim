within OneSatSim.Foundation.Interfaces;
model BooleanSignalBridge "布尔因果输出到可扩展信息总线的无状态恒等桥"
  Modelica.Blocks.Interfaces.BooleanInput u
    annotation(Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
    annotation(Placement(transformation(extent={{90,-10},{110,10}})));
equation
  y=u;
  annotation(
    Icon(graphics={Rectangle(extent={{-100,55},{100,-55}},lineColor={135,45,145},fillColor={247,235,249},fillPattern=FillPattern.Solid),Line(points={{-72,0},{72,0}},color={135,45,145},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-30,35},{30,-35}},textString="=")}),
    Documentation(info="<html><h4>功能定位</h4><p>组件因果布尔输出到可扩展信息总线之间的无状态恒等适配器。</p><h4>实现边界</h4><p>u为BooleanInput、y为BooleanOutput，仅实现y=u；不包含参数、动态状态、采样、滤波、限幅、延迟或通信行为。</p><h4>连接方向与使用</h4><p>左侧u接收因果源，右侧y发布到可扩展总线字段。它只解决接口方向兼容，不表示命令确认、锁存或通信；总线字段进入因果逻辑时应使用BooleanSignalReader。</p></html>"));
end BooleanSignalBridge;
