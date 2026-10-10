within OneSatSim.Foundation.Calculations;
model WheelSpeedServoCalculation "Typed low-order wheel speed-to-torque servo"
  parameter Real k(unit="N.m.s/rad") "配置项 k [N.m.s/rad]；Physical speed servo gain";
  Modelica.Blocks.Interfaces.RealInput u(unit="rad/s") 
     "输入信号 [rad/s]" annotation(Placement(visible=true, transformation(origin={-185,0}, extent={{-7,-7},{7,7}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-5.76,-5.76},{5.76,5.76}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput y(unit="N.m") 
     "输出信号 [N.m]" annotation(Placement(visible=true, transformation(origin={185,0}, extent={{-7,-7},{7,7}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-5.76,-5.76},{5.76,5.76}}, rotation=0)));
equation
  y=k*u;
  annotation(Documentation(info="<html><h2>飞轮转速伺服计算</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Calculations.WheelSpeedServoCalculation</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>飞轮转速伺服计算。原源码功能描述：Typed low-order wheel speed-to-torque servo</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.ReactionWheelSUnit\">OneSatSim.Components.ReactionWheelSUnit</a> 的 <code>compensator</code>；<a href=\"modelica://OneSatSim.Components.ReactionWheelXUnit\">OneSatSim.Components.ReactionWheelXUnit</a> 的 <code>speedGain</code>；<a href=\"modelica://OneSatSim.Components.ReactionWheelYUnit\">OneSatSim.Components.ReactionWheelYUnit</a> 的 <code>servoGain</code>；<a href=\"modelica://OneSatSim.Components.ReactionWheelZUnit\">OneSatSim.Components.ReactionWheelZUnit</a> 的 <code>proportional</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>u</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>rad/s</td><td>输入信号 [rad/s]</td></tr><tr><td><code>y</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>N.m</td><td>输出信号 [N.m]</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>k</code></td><td>Real</td><td>配置项 k [N.m.s/rad]；Physical speed servo gain</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] y=k*u;</pre></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={124,58,237},lineColor={124,58,237},lineThickness=0,radius=0),
      Line(points={{-53,40},{-10,40},{15,0},{53,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{-53,-40},{-10,-40},{15,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Polygon(points={{40,-12},{56,0},{40,12},{40,-12}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={124,58,237},lineColor={124,58,237},lineThickness=0,radius=0),
      Line(points={{-53,40},{-10,40},{15,0},{53,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{-53,-40},{-10,-40},{15,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Polygon(points={{40,-12},{56,0},{40,12},{40,-12}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4)
    }));
end WheelSpeedServoCalculation;