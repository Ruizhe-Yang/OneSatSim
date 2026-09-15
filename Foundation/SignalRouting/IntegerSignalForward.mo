within OneSatSim.Foundation.SignalRouting;
model IntegerSignalForward "Integer信号显式转发"
  Modelica.Blocks.Interfaces.IntegerInput u annotation(Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.IntegerOutput y annotation(Placement(transformation(extent={{80,-10},{100,10}})));
equation
  y=u;
  annotation(
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}),graphics={
      Rectangle(extent={{-80,45},{80,-45}},lineColor={220,105,0},fillColor={253,241,225},fillPattern=FillPattern.Solid),
      Line(points={{-64,0},{55,0}},color={220,105,0},thickness=2,arrow={Arrow.None,Arrow.Filled}),
      Text(extent={{-35,35},{35,-35}},textString="I",textColor={185,80,0})}),
    Documentation(info="<html><p><b>输入：</b>任意Integer工程信号。</p><p><b>输出：</b>与输入严格相等的Integer信号。</p><p><b>边界：</b>无状态、无编码转换、无限幅、无事件逻辑。</p><h4>适用边界</h4><p>u和y均为Modelica.Blocks因果端口，用于白箱内部整数状态码的方向保持。它不解释或转换状态码；共享IntegerSignal进入因果计算时必须使用IntegerSignalReader。</p></html>"));
end IntegerSignalForward;
