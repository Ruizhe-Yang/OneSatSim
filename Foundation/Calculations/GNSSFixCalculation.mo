within OneSatSim.Foundation.Calculations;
model GNSSFixCalculation "GNSS定位状态计算"
  Modelica.Blocks.Interfaces.BooleanInput eclipse  "计算/接口量 eclipse" annotation(Placement(visible=true, transformation(origin={-89,0}, extent={{-17.803636,-17.803636},{17.803636,17.803636}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-17.803636,-17.803636},{17.803636,17.803636}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput fixStatus  "计算/接口量 fixStatus" annotation(Placement(visible=true, transformation(origin={89,0}, extent={{-17.803636,-17.803636},{17.803636,17.803636}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-17.803636,-17.803636},{17.803636,17.803636}}, rotation=0)));
equation
  fixStatus=if eclipse then 2 else 3;
  annotation(Documentation(info="<html><h2>GNSS定位状态计算</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Calculations.GNSSFixCalculation</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>GNSS定位状态计算</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.GPSReceiverUnit\">OneSatSim.Components.GPSReceiverUnit</a> 的 <code>fixCalculation</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>eclipse</code></td><td>Modelica.Blocks.Interfaces.BooleanInput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 eclipse</td></tr><tr><td><code>fixStatus</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 fixStatus</td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] fixStatus=if eclipse then 2 else 3;</pre></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,166,81},lineColor={0,166,81},lineThickness=0,radius=0),
      Ellipse(extent={{-33,-33},{33,33}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Line(points={{-56,0},{56,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{0,-56},{0,56}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,166,81},lineColor={0,166,81},lineThickness=0,radius=0),
      Ellipse(extent={{-33,-33},{33,33}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Line(points={{-56,0},{56,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{0,-56},{0,56}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }));
end GNSSFixCalculation;