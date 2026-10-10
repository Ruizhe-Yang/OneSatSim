within OneSatSim.Scenarios.DesignConfigRecords;
record BatteryComponentConfig "battery硬件设计配置"
  parameter Integer SeriesCellCount
    "串联电芯数；Excel工程单位1";
  parameter Integer ParallelCellCount
    "并联支路数；Excel工程单位1";
  parameter Modelica.Units.SI.ElectricCharge CellCapacity_Ah
    "单并支路电芯容量；Excel工程单位Ah";
  parameter Modelica.Units.SI.Voltage CellOCVMax
    "单体最高开路电压；Excel工程单位V";
  parameter Modelica.Units.SI.Voltage CellOCVMin
    "单体最低开路电压；Excel工程单位V";
  parameter Modelica.Units.SI.Resistance CellInternalResistance
    "单体内阻；Excel工程单位Ω";
  parameter Real CellSOCMin
    "电芯模型SOC下界；Excel工程单位1";
  parameter Real CellSOCMax
    "电芯模型SOC上界；Excel工程单位1";
  parameter Real EOLCapacityFactor
    "寿命末期容量系数；Excel工程单位1";
  parameter Boolean UseEOLCapacity
    "启用EOL容量；Excel工程单位Boolean";
  parameter Modelica.Units.SI.Resistance ContactResistance
    "电池主路径接触电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.Resistance HeaterResistance
    "电池加热器电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.HeatCapacity CellHeatCapacity
    "电芯等效热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.HeatCapacity EnclosureHeatCapacity
    "电池壳体等效热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.ThermalConductance InternalThermalConductance
    "电芯-壳体导热；Excel工程单位W/K";
  parameter Modelica.Units.SI.ThermalConductance MountThermalConductance
    "电池安装导热；Excel工程单位W/K";
  parameter Modelica.Units.SI.Mass Mass
    "质量；Excel工程单位kg";
  parameter Modelica.Units.SI.Length RCM_X
    "质心偏置X；Excel工程单位m";
  parameter Modelica.Units.SI.Length RCM_Y
    "质心偏置Y；Excel工程单位m";
  parameter Modelica.Units.SI.Length RCM_Z
    "质心偏置Z；Excel工程单位m";
  parameter Modelica.Units.SI.Inertia Inertia_XX
    "局部惯量 Ixx；Excel工程单位kg·m²";
  parameter Modelica.Units.SI.Inertia Inertia_YY
    "局部惯量 Iyy；Excel工程单位kg·m²";
  parameter Modelica.Units.SI.Inertia Inertia_ZZ
    "局部惯量 Izz；Excel工程单位kg·m²";
  annotation(Documentation(info="<html><h2>battery硬件设计配置</h2><p><b>类路径：</b><code>OneSatSim.Scenarios.DesignConfigRecords.BatteryComponentConfig</code>　<b>类型：</b>record</p><h3>用途与定位</h3><p>battery硬件设计配置</p><h3>配置与调用</h3><p>由使用者声明或传入本类型；记录与常量保存静态配置，不单独代表一套物理状态。修改设计输入后应通过项目既有离线配置入口生成生效快照。</p><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>SeriesCellCount</code></td><td>Integer</td><td>串联电芯数；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>ParallelCellCount</code></td><td>Integer</td><td>并联支路数；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>CellCapacity_Ah</code></td><td>Modelica.Units.SI.ElectricCharge</td><td>单并支路电芯容量；Excel工程单位Ah</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>CellOCVMax</code></td><td>Modelica.Units.SI.Voltage</td><td>单体最高开路电压；Excel工程单位V</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>CellOCVMin</code></td><td>Modelica.Units.SI.Voltage</td><td>单体最低开路电压；Excel工程单位V</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>CellInternalResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>单体内阻；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>CellSOCMin</code></td><td>Real</td><td>电芯模型SOC下界；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>CellSOCMax</code></td><td>Real</td><td>电芯模型SOC上界；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>EOLCapacityFactor</code></td><td>Real</td><td>寿命末期容量系数；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>UseEOLCapacity</code></td><td>Boolean</td><td>启用EOL容量；Excel工程单位Boolean</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>ContactResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>电池主路径接触电阻；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>HeaterResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>电池加热器电阻；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>CellHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>电芯等效热容；Excel工程单位J/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>EnclosureHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>电池壳体等效热容；Excel工程单位J/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>InternalThermalConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>电芯-壳体导热；Excel工程单位W/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>MountThermalConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>电池安装导热；Excel工程单位W/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel工程单位kg</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={77,126,172}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-37.2,-7.2},{28.8,33}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Rectangle(extent={{-31.8,0},{-21,13.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{-28.2,13.8},{-24.6,15.6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-28.8,9.6},{-24,9.6}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-26.4,7.2},{-26.4,12}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{-16.8,0},{-6,13.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{-13.2,13.8},{-9.6,15.6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-13.8,9.6},{-9,9.6}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-11.4,7.2},{-11.4,12}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{-1.8,0},{9,13.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{1.8,13.8},{5.4,15.6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{1.2,9.6},{6,9.6}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{3.6,7.2},{3.6,12}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{13.2,0},{24,13.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{16.8,13.8},{20.4,15.6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{16.2,9.6},{21,9.6}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{18.6,7.2},{18.6,12}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-31.8,-1.8},{24,-1.8}}, color={77,126,172}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{-31.8,17.4},{-21,31.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{-28.2,31.2},{-24.6,33}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-28.8,27},{-24,27}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-26.4,24.6},{-26.4,29.4}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{-16.8,17.4},{-6,31.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{-13.2,31.2},{-9.6,33}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-13.8,27},{-9,27}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-11.4,24.6},{-11.4,29.4}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{-1.8,17.4},{9,31.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{1.8,31.2},{5.4,33}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{1.2,27},{6,27}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{3.6,24.6},{3.6,29.4}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{13.2,17.4},{24,31.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{16.8,31.2},{20.4,33}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{16.2,27},{21,27}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{18.6,24.6},{18.6,29.4}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-31.8,15.6},{24,15.6}}, color={77,126,172}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-40.2,23.4},{-46.2,23.4},{-46.2,0.6},{-40.2,0.6}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{30.6,23.4},{37.8,23.4}}, color={77,126,172}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{30.6,1.2},{37.8,1.2}}, color={77,126,172}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{33.6,27.6},{37.8,27.6}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{35.4,25.8},{35.4,29.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-30.6,-13.2},{-24.6,-13.2},{-22.2,-9.6},{-17.4,-16.2},{-12.6,-9.6},{-7.8,-16.2},{-3,-9.6},{1.8,-13.2},{9.6,-13.2}}, color={196,94,56}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Battery Pack 4S2P Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={77,126,172}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-37.2,-7.2},{28.8,33}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Rectangle(extent={{-31.8,0},{-21,13.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{-28.2,13.8},{-24.6,15.6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-28.8,9.6},{-24,9.6}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-26.4,7.2},{-26.4,12}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{-16.8,0},{-6,13.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{-13.2,13.8},{-9.6,15.6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-13.8,9.6},{-9,9.6}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-11.4,7.2},{-11.4,12}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{-1.8,0},{9,13.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{1.8,13.8},{5.4,15.6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{1.2,9.6},{6,9.6}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{3.6,7.2},{3.6,12}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{13.2,0},{24,13.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{16.8,13.8},{20.4,15.6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{16.2,9.6},{21,9.6}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{18.6,7.2},{18.6,12}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-31.8,-1.8},{24,-1.8}}, color={77,126,172}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{-31.8,17.4},{-21,31.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{-28.2,31.2},{-24.6,33}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-28.8,27},{-24,27}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-26.4,24.6},{-26.4,29.4}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{-16.8,17.4},{-6,31.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{-13.2,31.2},{-9.6,33}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-13.8,27},{-9,27}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-11.4,24.6},{-11.4,29.4}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{-1.8,17.4},{9,31.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{1.8,31.2},{5.4,33}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{1.2,27},{6,27}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{3.6,24.6},{3.6,29.4}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{13.2,17.4},{24,31.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{16.8,31.2},{20.4,33}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{16.2,27},{21,27}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{18.6,24.6},{18.6,29.4}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-31.8,15.6},{24,15.6}}, color={77,126,172}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-40.2,23.4},{-46.2,23.4},{-46.2,0.6},{-40.2,0.6}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{30.6,23.4},{37.8,23.4}}, color={77,126,172}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{30.6,1.2},{37.8,1.2}}, color={77,126,172}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{33.6,27.6},{37.8,27.6}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{35.4,25.8},{35.4,29.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-30.6,-13.2},{-24.6,-13.2},{-22.2,-9.6},{-17.4,-16.2},{-12.6,-9.6},{-7.8,-16.2},{-3,-9.6},{1.8,-13.2},{9.6,-13.2}}, color={196,94,56}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Battery Pack 4S2P Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));
end BatteryComponentConfig;