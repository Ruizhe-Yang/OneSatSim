within OneSatSim.Scenarios.DesignConfigRecords;
record PcduComponentConfig "pcdu硬件设计配置"
  parameter Real RegulatorEfficiency12
    "12V主变换效率；Excel工程单位1";
  parameter Modelica.Units.SI.Voltage MinimumInputVoltage12
    "12V变换最低输入电压；Excel工程单位V";
  parameter Modelica.Units.SI.Current MaximumInputCurrent12
    "12V主变换最大输入电流；Excel工程单位A";
  parameter Modelica.Units.SI.Current MaximumOutputCurrent12
    "12V主变换最大输出电流；Excel工程单位A";
  parameter Modelica.Units.SI.Power MaximumOutputPower12
    "12V主变换最大输出功率；Excel工程单位W";
  parameter Modelica.Units.SI.Resistance OutputResistance12
    "12V输出等效内阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.Resistance OverloadDroop12
    "12V过载压降系数；Excel工程单位Ω";
  parameter Real Efficiency5V
    "5V变换效率；Excel工程单位1";
  parameter Modelica.Units.SI.Current CurrentLimit5V
    "5V电流上限；Excel工程单位A";
  parameter Modelica.Units.SI.Voltage NominalVoltage5V
    "5V名义输出电压；Excel工程单位V";
  parameter Modelica.Units.SI.Power PowerLimit5V
    "5V输出功率上限；Excel工程单位W";
  parameter Modelica.Units.SI.Voltage MinimumInputVoltage5V
    "5V变换最低输入电压；Excel工程单位V";
  parameter Modelica.Units.SI.Resistance OutputResistance5V
    "5V输出等效内阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.Resistance OverloadDroop5V
    "5V过载压降系数；Excel工程单位Ω";
  parameter Real Efficiency3V3
    "3.3V变换效率；Excel工程单位1";
  parameter Modelica.Units.SI.Current CurrentLimit3V3
    "3.3V电流上限；Excel工程单位A";
  parameter Modelica.Units.SI.Voltage NominalVoltage3V3
    "3.3V名义输出电压；Excel工程单位V";
  parameter Modelica.Units.SI.Power PowerLimit3V3
    "3.3V输出功率上限；Excel工程单位W";
  parameter Modelica.Units.SI.Voltage MinimumInputVoltage3V3
    "3.3V变换最低输入电压；Excel工程单位V";
  parameter Modelica.Units.SI.Resistance OutputResistance3V3
    "3.3V输出等效内阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.Resistance OverloadDroop3V3
    "3.3V过载压降系数；Excel工程单位Ω";
  parameter Modelica.Units.SI.Resistance HousekeepingResistance12
    "PCDU自耗等效电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.HeatCapacity BoardHeatCapacity
    "PCDU板等效热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.ThermalConductance MountConductance
    "PCDU安装导热；Excel工程单位W/K";
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
  annotation(Documentation(info="<html><h2>pcdu硬件设计配置</h2><p><b>类路径：</b><code>OneSatSim.Scenarios.DesignConfigRecords.PcduComponentConfig</code>　<b>类型：</b>record</p><h3>用途与定位</h3><p>pcdu硬件设计配置</p><h3>配置与调用</h3><p>由使用者声明或传入本类型；记录与常量保存静态配置，不单独代表一套物理状态。修改设计输入后应通过项目既有离线配置入口生成生效快照。</p><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>RegulatorEfficiency12</code></td><td>Real</td><td>12V主变换效率；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>MinimumInputVoltage12</code></td><td>Modelica.Units.SI.Voltage</td><td>12V变换最低输入电压；Excel工程单位V</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>MaximumInputCurrent12</code></td><td>Modelica.Units.SI.Current</td><td>12V主变换最大输入电流；Excel工程单位A</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>MaximumOutputCurrent12</code></td><td>Modelica.Units.SI.Current</td><td>12V主变换最大输出电流；Excel工程单位A</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>MaximumOutputPower12</code></td><td>Modelica.Units.SI.Power</td><td>12V主变换最大输出功率；Excel工程单位W</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>OutputResistance12</code></td><td>Modelica.Units.SI.Resistance</td><td>12V输出等效内阻；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>OverloadDroop12</code></td><td>Modelica.Units.SI.Resistance</td><td>12V过载压降系数；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Efficiency5V</code></td><td>Real</td><td>5V变换效率；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>CurrentLimit5V</code></td><td>Modelica.Units.SI.Current</td><td>5V电流上限；Excel工程单位A</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>NominalVoltage5V</code></td><td>Modelica.Units.SI.Voltage</td><td>5V名义输出电压；Excel工程单位V</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>PowerLimit5V</code></td><td>Modelica.Units.SI.Power</td><td>5V输出功率上限；Excel工程单位W</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>MinimumInputVoltage5V</code></td><td>Modelica.Units.SI.Voltage</td><td>5V变换最低输入电压；Excel工程单位V</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>OutputResistance5V</code></td><td>Modelica.Units.SI.Resistance</td><td>5V输出等效内阻；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>OverloadDroop5V</code></td><td>Modelica.Units.SI.Resistance</td><td>5V过载压降系数；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Efficiency3V3</code></td><td>Real</td><td>3.3V变换效率；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>CurrentLimit3V3</code></td><td>Modelica.Units.SI.Current</td><td>3.3V电流上限；Excel工程单位A</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>NominalVoltage3V3</code></td><td>Modelica.Units.SI.Voltage</td><td>3.3V名义输出电压；Excel工程单位V</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>PowerLimit3V3</code></td><td>Modelica.Units.SI.Power</td><td>3.3V输出功率上限；Excel工程单位W</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>MinimumInputVoltage3V3</code></td><td>Modelica.Units.SI.Voltage</td><td>3.3V变换最低输入电压；Excel工程单位V</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>OutputResistance3V3</code></td><td>Modelica.Units.SI.Resistance</td><td>3.3V输出等效内阻；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>OverloadDroop3V3</code></td><td>Modelica.Units.SI.Resistance</td><td>3.3V过载压降系数；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>HousekeepingResistance12</code></td><td>Modelica.Units.SI.Resistance</td><td>PCDU自耗等效电阻；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>BoardHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>PCDU板等效热容；Excel工程单位J/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>MountConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>PCDU安装导热；Excel工程单位W/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel工程单位kg</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={77,126,172}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-39.51,4.5},{-11.13,25.62}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Line(points={{-37.86,6.48},{-13.11,23.31}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-35.88,21},{-28.29,21}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{-35.88,18.69},{-28.29,18.69}}, color={77,126,172}, thickness=0.5, pattern=LinePattern.Dash),
      Line(points={{-22.68,11.43},{-14.76,11.43}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{-22.68,9.12},{-14.76,9.12}}, color={77,126,172}, thickness=0.5, pattern=LinePattern.Dash),
      Line(points={{-47.76,21},{-39.51,21}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-47.76,7.8},{-39.51,7.8}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-11.13,21},{-0.57,21}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-11.13,7.8},{-0.57,7.8}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-28.29,3.18},{-28.29,-0.12},{-24,1.53},{-19.71,-1.44},{-15.42,1.2}}, color={196,94,56}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{0,14.4},{10.2,14.4},{10.2,32.4},{34.8,32.4}}, color={77,126,172}, thickness=0.9, pattern=LinePattern.Solid),
      Line(points={{10.2,14.4},{34.8,14.4}}, color={77,126,172}, thickness=0.9, pattern=LinePattern.Solid),
      Line(points={{10.2,14.4},{10.2,-3.6},{34.8,-3.6}}, color={77,126,172}, thickness=0.9, pattern=LinePattern.Solid),
      Rectangle(extent={{15.6,29.4},{23.4,35.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Ellipse(extent={{28.2,30.6},{31.8,34.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Line(points={{31.8,32.4},{39,32.4}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid),
      Rectangle(extent={{15.6,11.4},{23.4,17.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Ellipse(extent={{28.2,12.6},{31.8,16.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Line(points={{31.8,14.4},{39,14.4}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid),
      Rectangle(extent={{15.6,-6.6},{23.4,-0.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Ellipse(extent={{28.2,-5.4},{31.8,-1.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Line(points={{31.8,-3.6},{39,-3.6}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid),
      Text(extent={{16.2,35.4},{40.8,45}}, textString="12 V", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Text(extent={{16.2,17.4},{40.8,27}}, textString="5 V", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Text(extent={{16.2,-17.4},{40.8,-7.2}}, textString="3.3 V", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="PCDU Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={77,126,172}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-39.51,4.5},{-11.13,25.62}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Line(points={{-37.86,6.48},{-13.11,23.31}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-35.88,21},{-28.29,21}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{-35.88,18.69},{-28.29,18.69}}, color={77,126,172}, thickness=0.5, pattern=LinePattern.Dash),
      Line(points={{-22.68,11.43},{-14.76,11.43}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{-22.68,9.12},{-14.76,9.12}}, color={77,126,172}, thickness=0.5, pattern=LinePattern.Dash),
      Line(points={{-47.76,21},{-39.51,21}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-47.76,7.8},{-39.51,7.8}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-11.13,21},{-0.57,21}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-11.13,7.8},{-0.57,7.8}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-28.29,3.18},{-28.29,-0.12},{-24,1.53},{-19.71,-1.44},{-15.42,1.2}}, color={196,94,56}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{0,14.4},{10.2,14.4},{10.2,32.4},{34.8,32.4}}, color={77,126,172}, thickness=0.9, pattern=LinePattern.Solid),
      Line(points={{10.2,14.4},{34.8,14.4}}, color={77,126,172}, thickness=0.9, pattern=LinePattern.Solid),
      Line(points={{10.2,14.4},{10.2,-3.6},{34.8,-3.6}}, color={77,126,172}, thickness=0.9, pattern=LinePattern.Solid),
      Rectangle(extent={{15.6,29.4},{23.4,35.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Ellipse(extent={{28.2,30.6},{31.8,34.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Line(points={{31.8,32.4},{39,32.4}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid),
      Rectangle(extent={{15.6,11.4},{23.4,17.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Ellipse(extent={{28.2,12.6},{31.8,16.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Line(points={{31.8,14.4},{39,14.4}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid),
      Rectangle(extent={{15.6,-6.6},{23.4,-0.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Ellipse(extent={{28.2,-5.4},{31.8,-1.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Line(points={{31.8,-3.6},{39,-3.6}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid),
      Text(extent={{16.2,35.4},{40.8,45}}, textString="12 V", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Text(extent={{16.2,17.4},{40.8,27}}, textString="5 V", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Text(extent={{16.2,-17.4},{40.8,-7.2}}, textString="3.3 V", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="PCDU Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));
end PcduComponentConfig;