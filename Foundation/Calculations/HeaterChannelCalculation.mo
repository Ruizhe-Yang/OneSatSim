within OneSatSim.Foundation.Calculations;
model HeaterChannelCalculation "单路加热器指令与平均电导计算"
  parameter Integer activeState=170 "加热有效状态字";
  parameter Modelica.Units.SI.Resistance heaterResistance=144 "等效加热电阻";
  Modelica.Blocks.Interfaces.IntegerInput controlState  "控制状态" annotation(Placement(visible=true, transformation(origin={-89,0}, extent={{-15.709091,-15.709091},{15.709091,15.709091}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-15.709091,-15.709091},{15.709091,15.709091}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput command  "指令" annotation(Placement(visible=true, transformation(origin={89,80}, extent={{-16.363636,-16.363636},{16.363636,16.363636}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-16.363636,-16.363636},{16.363636,16.363636}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput conductance(unit="S")  "计算/接口量 conductance [S]" annotation(Placement(visible=true, transformation(origin={185,-16}, extent={{-7,-7},{7,7}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-6,-6},{6,6}}, rotation=0)));
equation
  command=controlState == activeState;
  conductance=if command then 1/heaterResistance else 0;
  annotation(Documentation(info="<html><h2>单路加热器指令与平均电导计算</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Calculations.HeaterChannelCalculation</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>单路加热器指令与平均电导计算</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.BatteryUnit\">OneSatSim.Components.BatteryUnit</a> 的 <code>batteryHeaterCalculation</code>；<a href=\"modelica://OneSatSim.Components.HeaterRadiatorUnit\">OneSatSim.Components.HeaterRadiatorUnit</a> 的 <code>heaterCalculation</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>controlState</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>控制状态</td></tr><tr><td><code>command</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>指令</td></tr><tr><td><code>conductance</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>S</td><td>计算/接口量 conductance [S]</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>activeState</code></td><td>Integer</td><td>加热有效状态字</td><td><code>=170</code></td></tr><tr><td><code>heaterResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>等效加热电阻</td><td><code>=144</code></td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] command=controlState == activeState;\n[equation] conductance=if command then 1/heaterResistance else 0;</pre></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={229,57,53},lineColor={229,57,53},lineThickness=0,radius=0),
      Line(points={{-33,-53},{-42,-27},{-24,0},{-42,27},{-33,53}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{0,-53},{-9,-27},{9,0},{-9,27},{0,53}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{33,-53},{24,-27},{42,0},{24,27},{33,53}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={229,57,53},lineColor={229,57,53},lineThickness=0,radius=0),
      Line(points={{-33,-53},{-42,-27},{-24,0},{-42,27},{-33,53}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{0,-53},{-9,-27},{9,0},{-9,27},{0,53}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{33,-53},{24,-27},{42,0},{24,27},{33,53}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }));
end HeaterChannelCalculation;