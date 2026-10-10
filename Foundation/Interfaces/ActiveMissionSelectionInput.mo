within OneSatSim.Foundation.Interfaces;
connector ActiveMissionSelectionInput "Narrow causal input for active target and station selection"
  input Integer targetIndex "目标Index" ;
  input Integer groundStationIndex "地面站点Index" ;
  annotation(Documentation(info="<html><h2>激活MissionSelection输入</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.ActiveMissionSelectionInput</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>激活MissionSelection输入。原源码功能描述：Narrow causal input for active target and station selection</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>targetIndex</code></td><td>Integer</td><td>input</td><td>按声明/类型合同</td><td>目标Index</td></tr><tr><td><code>groundStationIndex</code></td><td>Integer</td><td>input</td><td>按声明/类型合同</td><td>地面站点Index</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={255,109,0},lineColor={255,109,0},lineThickness=0,radius=0),
      Polygon(points={{0,35.25},{29.25,0},{0,-35.25},{-29.25,0},{0,35.25}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4),
      Line(points={{-43.5,0},{-29.25,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{29.25,0},{43.5,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Polygon(points={{-18,-78},{5,-68},{-18,-58},{-18,-78}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={255,109,0},lineColor={255,109,0},lineThickness=0,radius=0),
      Polygon(points={{0,35.25},{29.25,0},{0,-35.25},{-29.25,0},{0,35.25}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4),
      Line(points={{-43.5,0},{-29.25,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{29.25,0},{43.5,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Polygon(points={{-18,-78},{5,-68},{-18,-58},{-18,-78}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4)
    }));
end ActiveMissionSelectionInput;