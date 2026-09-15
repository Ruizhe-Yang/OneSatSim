within OneSatSim.Foundation.Interfaces;
model IntegerSignalReader "可扩展总线整数信号到因果计算端口的无状态恒等读取器"
  Modelica.Blocks.Interfaces.IntegerInput u
    annotation(Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.IntegerOutput y
    annotation(Placement(transformation(extent={{90,-10},{110,10}})));
equation
  y=u;
  annotation(
    Icon(graphics={Rectangle(extent={{-100,55},{100,-55}},lineColor={180,100,20},fillColor={252,244,230},fillPattern=FillPattern.Solid),Line(points={{-72,0},{72,0}},color={180,100,20},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-45,35},{45,-35}},textString="READ")}),
    Documentation(info="<html><h4>功能定位</h4><p>把可扩展信息总线中的整数信号交付给具有明确输入方向的计算端口。</p><h4>接口与边界</h4><p>u为因果IntegerInput，y为因果IntegerOutput。模型仅实现y=u，不包含参数、状态、采样、延迟或事件逻辑，也不解释状态码的业务含义。</p><h4>使用方法</h4><p>在图形白箱中将可扩展总线字段连接到u，再将y连接到Calculation或Modelica标准库模块的IntegerInput。</p></html>"));
end IntegerSignalReader;
