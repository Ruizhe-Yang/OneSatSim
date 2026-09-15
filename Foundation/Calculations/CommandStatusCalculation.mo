within NISSA_12UCubeSat.Foundation.Calculations;
model CommandStatusCalculation "布尔指令状态码计算"
  Modelica.Blocks.Interfaces.BooleanInput command annotation(Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.IntegerOutput status annotation(Placement(transformation(extent={{80,-10},{100,10}})));
equation
  status=if command then 1 else 0;
  annotation(Icon(graphics={Rectangle(extent={{-100,65},{100,-65}},lineColor={0,95,170},fillColor={231,243,252},fillPattern=FillPattern.Solid),Line(points={{-70,0},{65,0}},color={0,95,170},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-90,42},{90,-42}},textString="BOOL -> STATUS")}),Documentation(info="<html><h4>功能定位</h4><p>把布尔设备指令转换为统一0/1状态码，供白箱组件发布设备工作状态。</p><h4>输入与物理含义</h4><p>command为已经完成接口读取的布尔使能或动作命令。</p><h4>输出与物理含义</h4><p>status为整数状态，false对应0，true对应1。</p><h4>主要计算关系</h4><p>使用单一条件表达式完成布尔到整数的无损语义映射。</p><h4>状态、事件与假设</h4><p>纯代数、无状态、无事件记忆；不处理故障码、超时、确认或协议编码。</p><h4>调用与结果使用</h4><p>由低速遥测基带等需要简单状态反馈的Component调用。该量适合设备状态字段，不应解释为动作完成确认。</p></html>"));
end CommandStatusCalculation;
