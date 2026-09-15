within OneSatSim.Foundation.Interfaces;
model RealSignalBridge "实数因果输出到可扩展信息总线的无状态恒等桥"
  Modelica.Blocks.Interfaces.RealInput u
    annotation(Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation(Placement(transformation(extent={{90,-10},{110,10}})));
equation
  y=u;
  annotation(
    Icon(graphics={Rectangle(extent={{-100,55},{100,-55}},lineColor={35,100,160},fillColor={235,245,252},fillPattern=FillPattern.Solid),Line(points={{-72,0},{72,0}},color={35,100,160},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-30,35},{30,-35}},textString="=")}),
    Documentation(info="<html><h4>功能定位</h4><p>组件因果实数输出到可扩展信息总线之间的无状态恒等适配器。</p><h4>实现边界</h4><p>u为RealInput、y为RealOutput，仅实现y=u；不包含参数、动态状态、采样、滤波、限幅、延迟或通信行为。</p><h4>连接方向与使用</h4><p>左侧u连接因果源，右侧y连接Information、Environment或Telemetry类可扩展总线字段。反向读取应使用RealSignalReader。该桥不应加入生产结果变量筛选。</p></html>"));
end RealSignalBridge;
