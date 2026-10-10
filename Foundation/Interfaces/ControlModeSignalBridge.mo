within OneSatSim.Foundation.Interfaces;
model ControlModeSignalBridge "控制模式因果输出到可扩展信息总线的无状态恒等桥"
  OneSatSim.Foundation.Interfaces.ControlModeInput u 
     "输入信号" annotation(Placement(visible=true, transformation(origin={-89,0}, extent={{-23.04,-23.04},{23.04,23.04}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-23.04,-23.04},{23.04,23.04}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.ControlModeOutput y 
     "输出信号" annotation(Placement(visible=true, transformation(origin={89,0}, extent={{-23.04,-23.04},{23.04,23.04}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-23.04,-23.04},{23.04,23.04}}, rotation=0)));
equation
  y=u;
  annotation(Documentation(info="<html><h2>控制模式因果输出到可扩展信息总线的无状态恒等桥</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.ControlModeSignalBridge</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>控制模式因果输出到可扩展信息总线的无状态恒等桥</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Foundation.Models.EquivalentAOCSCore\">OneSatSim.Foundation.Models.EquivalentAOCSCore</a> 的 <code>informationControlModeBridge</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>u</code></td><td>OneSatSim.Foundation.Interfaces.ControlModeInput</td><td>public</td><td>按声明/类型合同</td><td>输入信号</td></tr><tr><td><code>y</code></td><td>OneSatSim.Foundation.Interfaces.ControlModeOutput</td><td>public</td><td>按声明/类型合同</td><td>输出信号</td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] y=u;</pre></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,102,255},lineColor={0,102,255},lineThickness=0,radius=0),
      Line(points={{-54,-40},{-18,-40},{-18,0},{18,0},{18,40},{54,40}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,102,255},lineColor={0,102,255},lineThickness=0,radius=0),
      Line(points={{-54,-40},{-18,-40},{-18,0},{18,0},{18,40},{54,40}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }));
end ControlModeSignalBridge;