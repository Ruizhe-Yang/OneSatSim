within OneSatSim.Foundation.Interfaces;
model OpportunityIntegerReader "机会总线整数信号到因果计算端口的无状态恒等读取器"
  IntegerSignal u 
     "输入信号" annotation(Placement(visible=true, transformation(origin={-89,0}, extent={{-28.8,-28.8},{28.8,28.8}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-28.8,-28.8},{28.8,28.8}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput y 
     "输出信号" annotation(Placement(visible=true, transformation(origin={89,0}, extent={{-14.4,-14.4},{14.4,14.4}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-14.4,-14.4},{14.4,14.4}}, rotation=0)));
equation
  y=u;
  annotation(Documentation(info="<html><h2>机会总线整数信号到因果计算端口的无状态恒等读取器</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.OpportunityIntegerReader</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>机会总线整数信号到因果计算端口的无状态恒等读取器</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.MissionControlUnit\">OneSatSim.Components.MissionControlUnit</a> 的 <code>targetPreparationIndexReader</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>u</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>输入信号</td></tr><tr><td><code>y</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>输出信号</td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] y=u;</pre></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={255,109,0},lineColor={255,109,0},lineThickness=0,radius=0),
      Line(points={{-55,-44},{-20,-44},{-20,-4},{16,-4},{16,36},{55,36}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Ellipse(extent={{-62,-51},{-48,-37}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,startAngle=0,endAngle=360)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={255,109,0},lineColor={255,109,0},lineThickness=0,radius=0),
      Line(points={{-55,-44},{-20,-44},{-20,-4},{16,-4},{16,36},{55,36}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Ellipse(extent={{-62,-51},{-48,-37}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,startAngle=0,endAngle=360)
    }));
end OpportunityIntegerReader;