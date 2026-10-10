within OneSatSim.Foundation.Calculations;
model CommandStatusCalculation "布尔指令状态码计算"
  Modelica.Blocks.Interfaces.BooleanInput command  "指令" annotation(Placement(visible=true, transformation(origin={-89,0}, extent={{-17.28,-17.28},{17.28,17.28}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-17.28,-17.28},{17.28,17.28}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput status  "计算/接口量 status" annotation(Placement(visible=true, transformation(origin={89,0}, extent={{-17.28,-17.28},{17.28,17.28}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-17.28,-17.28},{17.28,17.28}}, rotation=0)));
equation
  status=if command then 1 else 0;
  annotation(Documentation(info="<html><h2>布尔指令状态码计算</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Calculations.CommandStatusCalculation</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>布尔指令状态码计算</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.LowRateTelemetryTransmitterUnit\">OneSatSim.Components.LowRateTelemetryTransmitterUnit</a> 的 <code>statusCalculation</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>command</code></td><td>Modelica.Blocks.Interfaces.BooleanInput</td><td>public</td><td>按声明/类型合同</td><td>指令</td></tr><tr><td><code>status</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 status</td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] status=if command then 1 else 0;</pre></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,145,234},lineColor={0,145,234},lineThickness=0,radius=0),
      Line(points={{-48,0},{-14,-34},{48,42}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{-45,-52},{45,-52}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,145,234},lineColor={0,145,234},lineThickness=0,radius=0),
      Line(points={{-48,0},{-14,-34},{48,42}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{-45,-52},{45,-52}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }));
end CommandStatusCalculation;