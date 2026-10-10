within OneSatSim.Foundation.Interfaces;
model MissionSelectionReader "环境总线到窄任务选择输入的无状态适配器"
  IntegerSignal targetIndex  "目标Index" annotation(Placement(transformation(extent={{-110,35},{-90,55}}), iconTransformation(extent={{-110,35},{-90,55}})));
  IntegerSignal groundStationIndex  "地面站点Index" annotation(Placement(transformation(extent={{-110,-55},{-90,-35}}), iconTransformation(extent={{-110,-55},{-90,-35}})));
  ActiveMissionSelectionOutput selection  "计算/接口量 selection" annotation(Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
equation
  selection.targetIndex = targetIndex;
  selection.groundStationIndex = groundStationIndex;
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={255,109,0},lineColor={255,109,0},lineThickness=0,radius=0),
      Polygon(points={{0,47},{39,0},{0,-47},{-39,0},{0,47}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4),
      Line(points={{-58,0},{-39,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{39,0},{58,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={255,109,0},lineColor={255,109,0},lineThickness=0,radius=0),
      Polygon(points={{0,47},{39,0},{0,-47},{-39,0},{0,47}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4),
      Line(points={{-58,0},{-39,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{39,0},{58,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Documentation(info="<html><h2>环境总线到窄任务选择输入的无状态适配器</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.MissionSelectionReader</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>环境总线到窄任务选择输入的无状态适配器</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Simulation.OrbitalEnvironment\">OneSatSim.Simulation.OrbitalEnvironment</a> 的 <code>activeSelectionReader</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>targetIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>目标Index</td></tr><tr><td><code>groundStationIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>地面站点Index</td></tr><tr><td><code>selection</code></td><td>ActiveMissionSelectionOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 selection</td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] selection.targetIndex = targetIndex;\n[equation] selection.groundStationIndex = groundStationIndex;</pre></html>"));
end MissionSelectionReader;