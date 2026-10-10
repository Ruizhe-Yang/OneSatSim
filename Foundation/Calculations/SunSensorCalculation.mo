within OneSatSim.Foundation.Calculations;
model SunSensorCalculation "太阳敏感器视线角计算"
  Modelica.Blocks.Interfaces.RealInput sunVectorBody[3]  "太阳方向在本体系中的单位向量" annotation(Placement(visible=true, transformation(origin={-89,0}, extent={{-17.28,-17.28},{17.28,17.28}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-17.28,-17.28},{17.28,17.28}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput alpha(unit="rad")  "太阳敏感器视线投影角 alpha [rad]" annotation(Placement(visible=true, transformation(origin={185,16}, extent={{-7,-7},{7,7}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput beta(unit="rad")  "太阳敏感器视线投影角 beta [rad]" annotation(Placement(visible=true, transformation(origin={185,-16}, extent={{-7,-7},{7,7}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-6,-6},{6,6}}, rotation=0)));
equation
  alpha=atan2(sunVectorBody[2],sunVectorBody[1]);
  beta=atan2(sunVectorBody[3],sqrt(sunVectorBody[1]^2+sunVectorBody[2]^2));
  annotation(Documentation(info="<html><h2>太阳敏感器视线角计算</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Calculations.SunSensorCalculation</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>太阳敏感器视线角计算</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.SunSensorUnit\">OneSatSim.Components.SunSensorUnit</a> 的 <code>angleCalculation</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>sunVectorBody[3]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>按声明/类型合同</td><td>太阳方向在本体系中的单位向量</td></tr><tr><td><code>alpha</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>rad</td><td>太阳敏感器视线投影角 alpha [rad]</td></tr><tr><td><code>beta</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>rad</td><td>太阳敏感器视线投影角 beta [rad]</td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] alpha=atan2(sunVectorBody[2],sunVectorBody[1]);\n[equation] beta=atan2(sunVectorBody[3],sqrt(sunVectorBody[1]^2+sunVectorBody[2]^2));</pre></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={245,158,11},lineColor={245,158,11},lineThickness=0,radius=0),
      Ellipse(extent={{-33,-33},{33,33}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Line(points={{-56,0},{56,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{0,-56},{0,56}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={245,158,11},lineColor={245,158,11},lineThickness=0,radius=0),
      Ellipse(extent={{-33,-33},{33,33}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Line(points={{-56,0},{56,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{0,-56},{0,56}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }));
end SunSensorCalculation;