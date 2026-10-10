within OneSatSim.Foundation.Interfaces;
model MissionSelectionPublisher "已锁存任务对象索引的无状态发布适配器"
  ActiveMissionSelectionInput selection  "计算/接口量 selection" annotation(Placement(transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.IntegerOutput targetIndex  "目标Index" annotation(Placement(transformation(extent={{90,35},{110,55}}), iconTransformation(extent={{90,35},{110,55}})));
  Modelica.Blocks.Interfaces.IntegerOutput groundStationIndex  "地面站点Index" annotation(Placement(transformation(extent={{90,-55},{110,-35}}), iconTransformation(extent={{90,-55},{110,-35}})));
equation
  targetIndex = selection.targetIndex;
  groundStationIndex = selection.groundStationIndex;
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
    Documentation(info="<html><h2>已锁存任务对象索引的无状态发布适配器</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.MissionSelectionPublisher</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>已锁存任务对象索引的无状态发布适配器</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.N_systems.DataHandlingSystem\">OneSatSim.Systems.N_systems.DataHandlingSystem</a> 的 <code>activeSelectionPublisher</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>selection</code></td><td>ActiveMissionSelectionInput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 selection</td></tr><tr><td><code>targetIndex</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>目标Index</td></tr><tr><td><code>groundStationIndex</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>地面站点Index</td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] targetIndex = selection.targetIndex;\n[equation] groundStationIndex = selection.groundStationIndex;</pre></html>"));
end MissionSelectionPublisher;