within NISSA_12UCubeSat.Foundation.Calculations;
model ReactionWheelTelemetryCalculation "反作用飞轮角动量与饱和状态计算"
  parameter Modelica.Units.SI.Inertia rotorInertia=1e-4;
  parameter Modelica.Units.SI.AngularVelocity wheelSpeedLimit=628.3185307;
  Modelica.Blocks.Interfaces.RealInput angularVelocity(unit="rad/s") annotation(Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput momentum(unit="N.m.s") annotation(Placement(transformation(extent={{80,25},{100,45}})));
  Modelica.Blocks.Interfaces.BooleanOutput saturated annotation(Placement(transformation(extent={{80,-45},{100,-25}})));
equation
  momentum=rotorInertia*angularVelocity;
  saturated=abs(angularVelocity) >= 0.98*wheelSpeedLimit;
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={65,85,115},fillColor={235,241,249},fillPattern=FillPattern.Solid),Ellipse(extent={{-38,38},{38,-38}},lineColor={65,85,115},fillColor={155,175,205},fillPattern=FillPattern.Solid),Line(points={{-72,0},{62,0}},color={65,85,115},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-90,-62},{90,-38}},textString="H / SAT")}),Documentation(info="<html><h4>功能定位</h4><p>由单台反作用飞轮实际角速度计算角动量和饱和状态。</p><h4>输入与物理含义</h4><p>angularVelocity为转子速度，rotorInertia为转子惯量，wheelSpeedLimit为物理速度上限。</p><h4>输出与物理含义</h4><p>momentum为I乘角速度，保留符号；saturated在绝对速度达到限值时为true。</p><h4>主要计算关系</h4><p>采用线性刚体角动量关系和对称速度限值判定。</p><h4>状态、事件与假设</h4><p>纯代数、无状态；不计算轴承摩擦、转矩裕度和整轮组总角动量。</p><h4>调用与结果使用</h4><p>由四个独立ReactionWheel组件调用。用户查看momentum、saturated和父组件rpm/电流/温度；不要把命令速度当成实际速度。</p></html>"));
end ReactionWheelTelemetryCalculation;
