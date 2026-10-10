within OneSatSim.Foundation.Calculations;
model StarQuaternionCalculation "沿用原旋转序列的星敏四元数计算"
  Modelica.Blocks.Interfaces.RealInput angles[3](each unit="rad")  "计算/接口量 angles [rad]" annotation(Placement(transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealOutput quaternion[4](each unit="1")  "四元数 [1]" annotation(Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
equation
  quaternion = Modelica.Mechanics.MultiBody.Frames.Quaternions.from_T(
    Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.axesRotations(
      {1,2,3}, angles));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={124,58,237},lineColor={124,58,237},lineThickness=0,radius=0),
      Ellipse(extent={{-33,-33},{33,33}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Line(points={{-56,0},{56,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{0,-56},{0,56}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={124,58,237},lineColor={124,58,237},lineThickness=0,radius=0),
      Ellipse(extent={{-33,-33},{33,33}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Line(points={{-56,0},{56,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{0,-56},{0,56}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Documentation(info="<html><h2>沿用原旋转序列的星敏四元数计算</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Calculations.StarQuaternionCalculation</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>沿用原旋转序列的星敏四元数计算</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.StarTrackerYUnit\">OneSatSim.Components.StarTrackerYUnit</a> 的 <code>quaternionCalculation</code>；<a href=\"modelica://OneSatSim.Components.StarTrackerZUnit\">OneSatSim.Components.StarTrackerZUnit</a> 的 <code>quaternionCalculation</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>angles[3]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>rad</td><td>计算/接口量 angles [rad]</td></tr><tr><td><code>quaternion[4]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>1</td><td>四元数 [1]</td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] quaternion = Modelica.Mechanics.MultiBody.Frames.Quaternions.from_T( Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.axesRotations( {1,2,3}, angles));</pre></html>"));
end StarQuaternionCalculation;