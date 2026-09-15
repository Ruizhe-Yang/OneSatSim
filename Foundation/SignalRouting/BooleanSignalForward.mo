within OneSatSim.Foundation.SignalRouting;
model BooleanSignalForward "Boolean信号显式转发"
  Modelica.Blocks.Interfaces.BooleanInput u annotation(Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput y annotation(Placement(transformation(extent={{80,-10},{100,10}})));
equation
  y=u;
  annotation(
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}),graphics={
      Rectangle(extent={{-80,45},{80,-45}},lineColor={175,35,135},fillColor={250,232,246},fillPattern=FillPattern.Solid),
      Line(points={{-64,0},{55,0}},color={175,35,135},thickness=2,arrow={Arrow.None,Arrow.Filled}),
      Text(extent={{-35,35},{35,-35}},textString="B",textColor={145,20,110})}),
    Documentation(info="<html><p><b>输入：</b>任意Boolean工程信号。</p><p><b>输出：</b>与输入严格相等的Boolean信号。</p><p><b>边界：</b>无状态、无边沿检测、无延迟、无采样。</p><h4>适用边界</h4><p>u和y均为Modelica.Blocks因果端口，用于白箱内部布尔控制链的方向保持。它不产生逻辑、边沿或状态；共享BooleanSignal进入因果逻辑时必须使用BooleanSignalReader。</p></html>"));
end BooleanSignalForward;
