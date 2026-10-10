within OneSatSim.Foundation.Calculations;
model PowerDistributionStatusCalculation "PDB通道状态派生"
  Modelica.Blocks.Interfaces.RealInput pdCurrent[24](each unit="A")  "pd电流 [A]" annotation(Placement(visible=true, transformation(origin={-185,16}, extent={{-7,-7},{7,7}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput equipmentStatus[6]  "计算/接口量 equipmentStatus" annotation(Placement(visible=true, transformation(origin={-89,-80}, extent={{-18.545455,-18.545455},{18.545455,18.545455}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-18.545455,-18.545455},{18.545455,18.545455}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput pdState[24]  "pd状态" annotation(Placement(visible=true, transformation(origin={89,0}, extent={{-17.803636,-17.803636},{17.803636,17.803636}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-17.803636,-17.803636},{17.803636,17.803636}}, rotation=0)));
equation
  pdState={
    if noEvent(abs(pdCurrent[1]) > 1e-5) then 170 else 0,
    if equipmentStatus[1] > 0 then 170 else 0,
    if equipmentStatus[2] > 0 then 170 else 0,
    if equipmentStatus[3] > 0 then 170 else 0,
    if equipmentStatus[4] > 0 then 170 else 0,
    0,0,
    if noEvent(abs(pdCurrent[8]) > 1e-5) then 170 else 0,
    0,0,0,
    if noEvent(abs(pdCurrent[12]) > 1e-5) then 170 else 0,
    if noEvent(abs(pdCurrent[13]) > 1e-5) then 170 else 0,
    if noEvent(abs(pdCurrent[14]) > 1e-5) then 170 else 0,
    if noEvent(abs(pdCurrent[15]) > 1e-5) then 170 else 0,
    if noEvent(abs(pdCurrent[16]) > 1e-5) then 170 else 0,
    if equipmentStatus[5] > 0 then 170 else 0,
    0,
    if equipmentStatus[6] > 0 then 170 else 0,
    if noEvent(abs(pdCurrent[20]) > 1e-5) then 170 else 0,
    if noEvent(abs(pdCurrent[21]) > 1e-5) then 170 else 0,
    if noEvent(abs(pdCurrent[22]) > 1e-5) then 170 else 0,
    0,0};
  annotation(Documentation(info="<html><h2>PDB通道状态派生</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Calculations.PowerDistributionStatusCalculation</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>PDB通道状态派生</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.PowerConditioningUnit\">OneSatSim.Components.PowerConditioningUnit</a> 的 <code>distributionStatusCalculation</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>pdCurrent[24]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>A</td><td>pd电流 [A]</td></tr><tr><td><code>equipmentStatus[6]</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 equipmentStatus</td></tr><tr><td><code>pdState[24]</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>pd状态</td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] pdState={ if noEvent(abs(pdCurrent[1]) &gt; 1e-5) then 170 else 0, if equipmentStatus[1] &gt; 0 then 170 else 0, if equipmentStatus[2] &gt; 0 then 170 else 0, if equipmentStatus[3] &gt; 0 then 170 else 0, if equipmentStatus[4] &gt; 0 then 170 else 0, 0,0, if noEvent(abs(pdCurrent[8]) &gt; 1e-5) then 170 else 0, 0,0,0, if noEvent(abs(pdCurrent[12]) &gt; 1e-5) then 170 else 0, if noEvent(abs(pdCurrent[13]) &gt; 1e-5) then 170 else 0, if noEvent(abs(pdCurrent[14]) &gt; 1e-5) then 170 else 0, if noEvent(abs(pdCurrent[15]) &gt; 1e-5) then 170 else 0, if noEvent(abs(pdCurrent[16]) &gt; 1e-5) then 170 else 0, if equipmentStatus[5] &gt; …（完整表达式见源码）</pre></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={245,158,11},lineColor={245,158,11},lineThickness=0,radius=0),
      Line(points={{-48,0},{-14,-34},{48,42}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{-45,-52},{45,-52}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={245,158,11},lineColor={245,158,11},lineThickness=0,radius=0),
      Line(points={{-48,0},{-14,-34},{48,42}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{-45,-52},{45,-52}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }));
end PowerDistributionStatusCalculation;