within NISSA_12UCubeSat.Foundation.SignalRouting;
model RealSignalForward "Real信号显式转发"
  Modelica.Blocks.Interfaces.RealInput u annotation(Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(extent={{80,-10},{100,10}})));
equation
  y=u;
  annotation(
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}),graphics={
      Rectangle(extent={{-80,45},{80,-45}},lineColor={0,95,170},fillColor={231,243,252},fillPattern=FillPattern.Solid),
      Line(points={{-64,0},{55,0}},color={0,95,170},thickness=2,arrow={Arrow.None,Arrow.Filled}),
      Text(extent={{-35,35},{35,-35}},textString="R",textColor={0,75,145})}),
    Documentation(info="<html><p><b>输入：</b>任意Real工程信号。</p><p><b>输出：</b>与输入严格相等的Real信号。</p><p><b>边界：</b>无状态、无单位换算、无限幅、无滤波、无事件逻辑。</p><h4>适用边界</h4><p>u和y均为Modelica.Blocks因果端口，用于白箱内部已明确方向的实数信号级联。它不是共享总线读取器；InformationPort、EnvironmentPort等无因果字段进入因果计算时必须使用RealSignalReader。</p></html>"));
end RealSignalForward;
