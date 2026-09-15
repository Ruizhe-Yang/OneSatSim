within OneSatSim.Foundation.Calculations;
model SunSensorCalculation "太阳敏感器视线角计算"
  Modelica.Blocks.Interfaces.RealInput sunVectorBody[3] annotation(Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput alpha(unit="rad") annotation(Placement(transformation(extent={{80,25},{100,45}})));
  Modelica.Blocks.Interfaces.RealOutput beta(unit="rad") annotation(Placement(transformation(extent={{80,-45},{100,-25}})));
equation
  alpha=atan2(sunVectorBody[2],sunVectorBody[1]);
  beta=atan2(sunVectorBody[3],sqrt(sunVectorBody[1]^2+sunVectorBody[2]^2));
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={210,125,0},fillColor={252,242,215},fillPattern=FillPattern.Solid),Ellipse(extent={{-30,30},{30,-30}},fillColor={245,185,35},fillPattern=FillPattern.Solid),Line(points={{-70,0},{65,0}},color={150,90,0},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-90,-62},{90,-38}},textString="SUN alpha / beta")}),Documentation(info="<html><h4>功能定位</h4><p>把机体系太阳单位向量转换为太阳敏感器水平角alpha和俯仰角beta。</p><h4>输入与物理含义</h4><p>sunVectorBody[3]为环境提供的机体系太阳方向。</p><h4>输出与物理含义</h4><p>alpha、beta单位rad，分别表达两个正交视线角。</p><h4>主要计算关系</h4><p>使用atan2计算水平角与基于向量分量的俯仰角，并在退化方向保持数值稳定。</p><h4>状态、事件与假设</h4><p>纯代数、无状态；不模拟视场遮挡、象限电流、噪声、饱和和标定误差。日影有效性由环境另行给出。</p><h4>调用与结果使用</h4><p>由SunSensorUnit调用。生产遥测通常查看转换后的deg角；调试坐标方向时查看rad输出与原始向量。</p></html>"));
end SunSensorCalculation;
