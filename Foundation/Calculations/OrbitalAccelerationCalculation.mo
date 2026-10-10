within OneSatSim.Foundation.Calculations;
model OrbitalAccelerationCalculation "轨道中心引力加速度计算"
  parameter Real gravitationalParameter(unit="m3/s2")=3.986004418e14 "gravitational参数 [m3/s2]" ;
  Modelica.Blocks.Interfaces.RealInput position[3](each unit="m")  "卫星相对地心的GCRS位置 [m]" annotation(Placement(visible=true, transformation(origin={-185,0}, extent={{-7,-7},{7,7}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-5.76,-5.76},{5.76,5.76}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput acceleration[3](each unit="m/s2")  "计算/接口量 acceleration [m/s2]" annotation(Placement(visible=true, transformation(origin={185,0}, extent={{-7,-7},{7,7}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-5.76,-5.76},{5.76,5.76}}, rotation=0)));
protected
  Real radiusSquared(unit="m2")  "计算/接口量 radiusSquared [m2]" annotation(HideResult=true);
equation
  radiusSquared=position*position;
  acceleration=-position*gravitationalParameter/radiusSquared^1.5;
  annotation(Documentation(info="<html><h2>轨道中心引力加速度计算</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Calculations.OrbitalAccelerationCalculation</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>轨道中心引力加速度计算</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.MEMSIMUUnit\">OneSatSim.Components.MEMSIMUUnit</a> 的 <code>accelerationCalculation</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>position[3]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>m</td><td>卫星相对地心的GCRS位置 [m]</td></tr><tr><td><code>acceleration[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>m/s2</td><td>计算/接口量 acceleration [m/s2]</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>gravitationalParameter</code></td><td>Real</td><td>gravitational参数 [m3/s2]</td><td><code>=3.986004418e14</code></td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] radiusSquared=position*position;\n[equation] acceleration=-position*gravitationalParameter/radiusSquared^1.5;</pre><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>radiusSquared</code></td><td>Real</td><td>protected</td><td>m2</td><td>计算/接口量 radiusSquared [m2]</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,166,81},lineColor={0,166,81},lineThickness=0,radius=0),
      Ellipse(extent={{-58,-30},{58,30}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Ellipse(extent={{27,12},{49,34}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,startAngle=0,endAngle=360),
      Line(points={{-8,-50},{-8,50}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,166,81},lineColor={0,166,81},lineThickness=0,radius=0),
      Ellipse(extent={{-58,-30},{58,30}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Ellipse(extent={{27,12},{49,34}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,startAngle=0,endAngle=360),
      Line(points={{-8,-50},{-8,50}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }));
end OrbitalAccelerationCalculation;