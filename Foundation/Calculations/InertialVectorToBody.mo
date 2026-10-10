within OneSatSim.Foundation.Calculations;
model InertialVectorToBody "惯性系至本体系无状态矢量变换"
  parameter String vectorUnit="1" "配置项 vectorUnit" ;
  Modelica.Mechanics.MultiBody.Interfaces.Frame_a frame_a  "参考系a" annotation(Placement(transformation(extent={{-110,-90},{-90,-70}}), iconTransformation(extent={{-110,-90},{-90,-70}})));
  Modelica.Blocks.Interfaces.RealInput vectorIn[3](each unit=vectorUnit)  "计算/接口量 vectorIn" annotation(Placement(transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealOutput vectorOut[3](each unit=vectorUnit)  "计算/接口量 vectorOut" annotation(Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
equation
  frame_a.f = zeros(3);
  frame_a.t = zeros(3);
  vectorOut = Modelica.Mechanics.MultiBody.Frames.resolve2(frame_a.R, vectorIn);
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={124,58,237},lineColor={124,58,237},lineThickness=0,radius=0),
      Ellipse(extent={{-58,-30},{58,30}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Ellipse(extent={{27,12},{49,34}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,startAngle=0,endAngle=360),
      Line(points={{-8,-50},{-8,50}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={124,58,237},lineColor={124,58,237},lineThickness=0,radius=0),
      Ellipse(extent={{-58,-30},{58,30}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Ellipse(extent={{27,12},{49,34}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,startAngle=0,endAngle=360),
      Line(points={{-8,-50},{-8,50}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Documentation(info="<html><h2>惯性系至本体系无状态矢量变换</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Calculations.InertialVectorToBody</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>惯性系至本体系无状态矢量变换</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.MagnetometerUnit\">OneSatSim.Components.MagnetometerUnit</a> 的 <code>magneticFrameTransform</code>；<a href=\"modelica://OneSatSim.Components.SunSensorUnit\">OneSatSim.Components.SunSensorUnit</a> 的 <code>sunFrameTransform</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>frame_a</code></td><td>Modelica.Mechanics.MultiBody.Interfaces.Frame_a</td><td>public</td><td>按声明/类型合同</td><td>参考系a</td></tr><tr><td><code>vectorIn[3]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 vectorIn</td></tr><tr><td><code>vectorOut[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 vectorOut</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>vectorUnit</code></td><td>String</td><td>配置项 vectorUnit</td><td><code>=&quot;1&quot;</code></td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] frame_a.f = zeros(3);\n[equation] frame_a.t = zeros(3);\n[equation] vectorOut = Modelica.Mechanics.MultiBody.Frames.resolve2(frame_a.R, vectorIn);</pre></html>"));
end InertialVectorToBody;