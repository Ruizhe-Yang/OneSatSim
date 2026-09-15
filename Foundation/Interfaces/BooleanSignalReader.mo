within NISSA_12UCubeSat.Foundation.Interfaces;
model BooleanSignalReader "可扩展总线布尔信号到因果计算端口的无状态恒等读取器"
  Modelica.Blocks.Interfaces.BooleanInput u
    annotation(Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput y
    annotation(Placement(transformation(extent={{90,-10},{110,10}})));
equation
  y=u;
  annotation(
    Icon(graphics={Rectangle(extent={{-100,55},{100,-55}},lineColor={135,45,145},fillColor={247,235,249},fillPattern=FillPattern.Solid),Line(points={{-72,0},{72,0}},color={135,45,145},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-45,35},{45,-35}},textString="READ")}),
    Documentation(info="<html><h4>功能定位</h4><p>把可扩展信息总线中的布尔信号交付给具有明确输入方向的逻辑端口。</p><h4>接口与边界</h4><p>u为因果BooleanInput，y为因果BooleanOutput。模型仅实现y=u，不包含参数、状态、采样、延迟或事件逻辑，也不代表新的设备或指令处理过程。</p><h4>使用方法</h4><p>在图形白箱中将可扩展总线字段连接到u，再将y连接到Calculation或Modelica标准库模块的BooleanInput。</p></html>"));
end BooleanSignalReader;
