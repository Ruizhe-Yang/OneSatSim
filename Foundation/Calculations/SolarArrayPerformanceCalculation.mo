within OneSatSim.Foundation.Calculations;
model SolarArrayPerformanceCalculation "Shared body-mounted solar electrical and thermal balance"
  parameter Modelica.Units.SI.Area activeArea "激活Area [m2]" ;
  parameter Real cellEfficiency(min=0,max=1) "cell效率" ;
  parameter Real solarLifeFactor(min=0,max=1) "配置项 solarLifeFactor" ;
  parameter Real etaMPPT(min=0,max=1) "配置项 etaMPPT；Rated net delivery efficiency, including harness";
  parameter Modelica.Units.SI.Resistance harnessResistance "太阳阵线束/阻断路径电阻；Excel单位Ω，当前设计基线 [Ohm]" ;
  parameter Modelica.Units.SI.Conductance parasiticConductance
    "配置项 parasiticConductance [S]；Physical bus shunt in this panel; zero if absent";
  parameter Real solarAbsorptivity(min=0,max=1) "配置项 solarAbsorptivity" ;
  parameter Real infraredAbsorptivity(min=0,max=1) "配置项 infraredAbsorptivity" ;
  parameter Real panelNormalBody[3] "panelNormal本体" ;
  parameter Modelica.Units.SI.Voltage nominalSubArrayVoltage
    "nominalSubArray电压 [V]；Legacy protocol proxy, not an independently measured subarray voltage";
  parameter Modelica.Units.SI.Voltage nominalMpptVoltage
    "nominalMppt电压 [V]；Legacy protocol proxy, not a measured MPPT operating voltage";
  Modelica.Blocks.Interfaces.RealInput sunVectorBody[3]  "太阳方向在本体系中的单位向量" annotation(Placement(visible=true, transformation(origin={-270,117}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput solarFlux(unit="W/m2")  "太阳辐照通量 [W/m2]" annotation(Placement(visible=true, transformation(origin={-270,39}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,57.142857}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput earthVectorBody[3]  "地心方向在本体系中的单位向量" annotation(Placement(visible=true, transformation(origin={-270,91}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,34.285714}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput albedoFlux(unit="W/m2")  "地球反照通量 [W/m2]" annotation(Placement(visible=true, transformation(origin={-270,13}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,11.428571}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput earthInfraredFlux(unit="W/m2")  "地球红外通量 [W/m2]" annotation(Placement(visible=true, transformation(origin={-270,-13}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-11.428571}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput curtailment  "计算/接口量 curtailment" annotation(Placement(visible=true, transformation(origin={-270,-117}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-34.285714}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput measuredTerminalVoltage(unit="V")  "measuredTerminal电压 [V]" annotation(Placement(visible=true, transformation(origin={-270,-65}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-57.142857}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput measuredTerminalCurrent(unit="A")  "measuredTerminal电流 [A]" annotation(Placement(visible=true, transformation(origin={-270,-91}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput sourceCurrentCommand(unit="A")  "源电流指令 [A]" annotation(Placement(visible=true, transformation(origin={270,117}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput incidenceCos  "计算/接口量 incidenceCos" annotation(Placement(visible=true, transformation(origin={270,13}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,57.142857}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput availablePower(unit="W")  "available功率 [W]" annotation(Placement(visible=true, transformation(origin={270,91}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,34.285714}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput deliveredPower(unit="W")  "delivered功率 [W]" annotation(Placement(visible=true, transformation(origin={270,65}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,11.428571}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput absorbedHeat(unit="W")  "absorbed热流 [W]" annotation(Placement(visible=true, transformation(origin={270,-13}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-11.428571}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput subArrayVoltage(unit="V")  "subArray电压 [V]" annotation(Placement(visible=true, transformation(origin={270,-65}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-34.285714}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput mpptOperatingVoltage(unit="V")  "mpptOperating电压 [V]" annotation(Placement(visible=true, transformation(origin={270,-91}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-57.142857}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput mpptTelemetryCurrent(unit="A")  "mppt遥测电流 [A]" annotation(Placement(visible=true, transformation(origin={270,-117}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Units.SI.Power cellElectricalPower "cellElectrical功率 [W]；Available cell power after curtailment";
  Modelica.Units.SI.Power directSolarAbsorbedPower "directSolarAbsorbed功率 [W]" ;
  Modelica.Units.SI.Power albedoAbsorbedPower "albedoAbsorbed功率 [W]" ;
  Modelica.Units.SI.Power infraredAbsorbedPower "infraredAbsorbed功率 [W]" ;
  Modelica.Units.SI.Power grossTerminalPower "grossTerminal功率 [W]；Source current times physical bus voltage, before local shunt";
  Modelica.Units.SI.Power harnessLossPower "harnessLoss功率 [W]；Dissipated by the actual series harness resistor";
  Modelica.Units.SI.Power parasiticPower "parasitic功率 [W]；Dissipated by the actual parallel shunt resistor";
  Modelica.Units.SI.Power conversionLossPower "conversionLoss功率 [W]；Unconverted cell electrical power, excluding harness";
  Boolean voltageDomainSupported "电压DomainSupported；Current source enabled only for physical bus voltage at least 10 V";
protected
  Modelica.Units.SI.Current ratedNetCurrent "ratedNet电流 [A]" ;
  Modelica.Units.SI.Current energyLimitedCurrent "能量Limited电流 [A]" ;
  Real earthIncidenceCos "计算/接口量 earthIncidenceCos" ;
equation
  incidenceCos=noEvent(max(0,min(1,panelNormalBody*sunVectorBody)));
  earthIncidenceCos=noEvent(max(0,min(1,panelNormalBody*earthVectorBody)));
  availablePower=solarLifeFactor*activeArea*cellEfficiency*solarFlux*incidenceCos;
  cellElectricalPower=availablePower*noEvent(max(0,min(1,curtailment)));
  voltageDomainSupported=measuredTerminalVoltage >= 10;
  ratedNetCurrent=if voltageDomainSupported then etaMPPT*cellElectricalPower/measuredTerminalVoltage else 0;
  energyLimitedCurrent=if voltageDomainSupported then 
    2*cellElectricalPower/(measuredTerminalVoltage+
      sqrt(measuredTerminalVoltage^2+4*harnessResistance*cellElectricalPower)) else 0;
  sourceCurrentCommand=min(ratedNetCurrent,energyLimitedCurrent);
  grossTerminalPower=measuredTerminalVoltage*measuredTerminalCurrent;
  harnessLossPower=harnessResistance*sourceCurrentCommand^2;
  parasiticPower=parasiticConductance*measuredTerminalVoltage^2;
  deliveredPower=grossTerminalPower-parasiticPower;
  directSolarAbsorbedPower=solarAbsorptivity*activeArea*solarFlux*incidenceCos;
  albedoAbsorbedPower=solarAbsorptivity*activeArea*albedoFlux*earthIncidenceCos;
  infraredAbsorbedPower=infraredAbsorptivity*activeArea*earthInfraredFlux*earthIncidenceCos;
  conversionLossPower=cellElectricalPower-grossTerminalPower-harnessLossPower;
  absorbedHeat=directSolarAbsorbedPower-cellElectricalPower+
    albedoAbsorbedPower+infraredAbsorbedPower+conversionLossPower;
  subArrayVoltage=if solarFlux > 1 and incidenceCos > 1e-6 then 
    nominalSubArrayVoltage*(0.90+0.10*incidenceCos) else 0;
  mpptOperatingVoltage=if solarFlux > 1 and incidenceCos > 1e-6 then 
    nominalMpptVoltage*(1+0.002*tanh(incidenceCos)) else 0;
  mpptTelemetryCurrent=if mpptOperatingVoltage > 0.1 then 
    max(0,grossTerminalPower)/mpptOperatingVoltage else 0;
initial equation
  assert(activeArea > 0 and harnessResistance >= 0 and parasiticConductance >= 0,
    "Solar panel area/resistance/conductance must be physically valid.");
  assert(cellEfficiency*solarLifeFactor <= solarAbsorptivity+1e-12,
    "Photovoltaic electrical conversion cannot exceed direct solar absorption.");
  annotation(Documentation(info="<html><h2>体装太阳阵电热性能计算</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Calculations.SolarArrayPerformanceCalculation</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>体装太阳阵电热性能计算。原源码功能描述：Shared body-mounted solar electrical and thermal balance</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.BodyMountedSolarArrayMinusXUnit\">OneSatSim.Components.BodyMountedSolarArrayMinusXUnit</a> 的 <code>solarCalculation</code>；<a href=\"modelica://OneSatSim.Components.BodyMountedSolarArrayPlusXUnit\">OneSatSim.Components.BodyMountedSolarArrayPlusXUnit</a> 的 <code>solarCalculation</code>；<a href=\"modelica://OneSatSim.Components.BodyMountedSolarArrayPlusYUnit\">OneSatSim.Components.BodyMountedSolarArrayPlusYUnit</a> 的 <code>solarCalculation</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>sunVectorBody[3]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>按声明/类型合同</td><td>太阳方向在本体系中的单位向量</td></tr><tr><td><code>solarFlux</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>W/m2</td><td>太阳辐照通量 [W/m2]</td></tr><tr><td><code>earthVectorBody[3]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>按声明/类型合同</td><td>地心方向在本体系中的单位向量</td></tr><tr><td><code>albedoFlux</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>W/m2</td><td>地球反照通量 [W/m2]</td></tr><tr><td><code>earthInfraredFlux</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>W/m2</td><td>地球红外通量 [W/m2]</td></tr><tr><td><code>curtailment</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 curtailment</td></tr><tr><td><code>measuredTerminalVoltage</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>V</td><td>measuredTerminal电压 [V]</td></tr><tr><td><code>measuredTerminalCurrent</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>A</td><td>measuredTerminal电流 [A]</td></tr><tr><td><code>sourceCurrentCommand</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>A</td><td>源电流指令 [A]</td></tr><tr><td><code>incidenceCos</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 incidenceCos</td></tr><tr><td><code>availablePower</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>W</td><td>available功率 [W]</td></tr><tr><td><code>deliveredPower</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>W</td><td>delivered功率 [W]</td></tr><tr><td><code>absorbedHeat</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>W</td><td>absorbed热流 [W]</td></tr><tr><td><code>subArrayVoltage</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>V</td><td>subArray电压 [V]</td></tr><tr><td><code>mpptOperatingVoltage</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>V</td><td>mpptOperating电压 [V]</td></tr><tr><td><code>mpptTelemetryCurrent</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>A</td><td>mppt遥测电流 [A]</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>activeArea</code></td><td>Modelica.Units.SI.Area</td><td>激活Area [m2]</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>cellEfficiency</code></td><td>Real</td><td>cell效率</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>solarLifeFactor</code></td><td>Real</td><td>配置项 solarLifeFactor</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>etaMPPT</code></td><td>Real</td><td>配置项 etaMPPT；Rated net delivery efficiency, including harness</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>harnessResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>太阳阵线束/阻断路径电阻；Excel单位Ω，当前设计基线 [Ohm]</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>parasiticConductance</code></td><td>Modelica.Units.SI.Conductance</td><td>配置项 parasiticConductance [S]；Physical bus shunt in this panel; zero if absent</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>solarAbsorptivity</code></td><td>Real</td><td>配置项 solarAbsorptivity</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>infraredAbsorptivity</code></td><td>Real</td><td>配置项 infraredAbsorptivity</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>panelNormalBody[3]</code></td><td>Real</td><td>panelNormal本体</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>nominalSubArrayVoltage</code></td><td>Modelica.Units.SI.Voltage</td><td>nominalSubArray电压 [V]；Legacy protocol proxy, not an independently measured subarray voltage</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>nominalMpptVoltage</code></td><td>Modelica.Units.SI.Voltage</td><td>nominalMppt电压 [V]；Legacy protocol proxy, not a measured MPPT operating voltage</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] incidenceCos=noEvent(max(0,min(1,panelNormalBody*sunVectorBody)));\n[equation] earthIncidenceCos=noEvent(max(0,min(1,panelNormalBody*earthVectorBody)));\n[equation] availablePower=solarLifeFactor*activeArea*cellEfficiency*solarFlux*incidenceCos;\n[equation] cellElectricalPower=availablePower*noEvent(max(0,min(1,curtailment)));\n[equation] voltageDomainSupported=measuredTerminalVoltage &gt;= 10;\n[equation] ratedNetCurrent=if voltageDomainSupported then etaMPPT*cellElectricalPower/measuredTerminalVoltage else 0;\n[equation] energyLimitedCurrent=if voltageDomainSupported then 2*cellElectricalPower/(measuredTerminalVoltage+ sqrt(measuredTerminalVoltage^2+4*harnessResistance*cellElectricalPower)) else 0;\n[equation] sourceCurrentCommand=min(ratedNetCurrent,energyLimitedCurrent);\n[equation] grossTerminalPower=measuredTerminalVoltage*measuredTerminalCurrent;\n[equation] harnessLossPower=harnessResistance*sourceCurrentCommand^2;</pre><p>本类另有12段语句；阅读完整源码可查看其余边界与逻辑。</p><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>cellElectricalPower</code></td><td>Modelica.Units.SI.Power</td><td>public</td><td>W</td><td>cellElectrical功率 [W]；Available cell power after curtailment</td></tr><tr><td><code>directSolarAbsorbedPower</code></td><td>Modelica.Units.SI.Power</td><td>public</td><td>W</td><td>directSolarAbsorbed功率 [W]</td></tr><tr><td><code>albedoAbsorbedPower</code></td><td>Modelica.Units.SI.Power</td><td>public</td><td>W</td><td>albedoAbsorbed功率 [W]</td></tr><tr><td><code>infraredAbsorbedPower</code></td><td>Modelica.Units.SI.Power</td><td>public</td><td>W</td><td>infraredAbsorbed功率 [W]</td></tr><tr><td><code>grossTerminalPower</code></td><td>Modelica.Units.SI.Power</td><td>public</td><td>W</td><td>grossTerminal功率 [W]；Source current times physical bus voltage, before local shunt</td></tr><tr><td><code>harnessLossPower</code></td><td>Modelica.Units.SI.Power</td><td>public</td><td>W</td><td>harnessLoss功率 [W]；Dissipated by the actual series harness resistor</td></tr><tr><td><code>parasiticPower</code></td><td>Modelica.Units.SI.Power</td><td>public</td><td>W</td><td>parasitic功率 [W]；Dissipated by the actual parallel shunt resistor</td></tr><tr><td><code>conversionLossPower</code></td><td>Modelica.Units.SI.Power</td><td>public</td><td>W</td><td>conversionLoss功率 [W]；Unconverted cell electrical power, excluding harness</td></tr><tr><td><code>voltageDomainSupported</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>电压DomainSupported；Current source enabled only for physical bus voltage at least 10 V</td></tr><tr><td><code>ratedNetCurrent</code></td><td>Modelica.Units.SI.Current</td><td>protected</td><td>A</td><td>ratedNet电流 [A]</td></tr><tr><td><code>energyLimitedCurrent</code></td><td>Modelica.Units.SI.Current</td><td>protected</td><td>A</td><td>能量Limited电流 [A]</td></tr><tr><td><code>earthIncidenceCos</code></td><td>Real</td><td>protected</td><td>按声明/类型合同</td><td>计算/接口量 earthIncidenceCos</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={77,126,172}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Power calculation", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-50.12,-22.8},{-4.76,37.68}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Rectangle(extent={{-47.24,-19.92},{-38.42,-12}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-45.8,-18.48},{-39.86,-13.44}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-47.24,-10.56},{-38.42,-2.64}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-45.8,-9.12},{-39.86,-4.08}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-47.24,-1.2},{-38.42,6.72}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-45.8,0.24},{-39.86,5.28}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-47.24,8.16},{-38.42,16.08}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-45.8,9.6},{-39.86,14.64}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-47.24,17.52},{-38.42,25.44}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-45.8,18.96},{-39.86,24}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-47.24,26.88},{-38.42,34.8}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-45.8,28.32},{-39.86,33.36}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-36.98,-19.92},{-28.16,-12}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-35.54,-18.48},{-29.6,-13.44}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-36.98,-10.56},{-28.16,-2.64}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-35.54,-9.12},{-29.6,-4.08}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-36.98,-1.2},{-28.16,6.72}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-35.54,0.24},{-29.6,5.28}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-36.98,8.16},{-28.16,16.08}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-35.54,9.6},{-29.6,14.64}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-36.98,17.52},{-28.16,25.44}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-35.54,18.96},{-29.6,24}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-36.98,26.88},{-28.16,34.8}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-35.54,28.32},{-29.6,33.36}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-26.72,-19.92},{-17.9,-12}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-25.28,-18.48},{-19.34,-13.44}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-26.72,-10.56},{-17.9,-2.64}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-25.28,-9.12},{-19.34,-4.08}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-26.72,-1.2},{-17.9,6.72}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-25.28,0.24},{-19.34,5.28}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-26.72,8.16},{-17.9,16.08}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-25.28,9.6},{-19.34,14.64}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-26.72,17.52},{-17.9,25.44}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-25.28,18.96},{-19.34,24}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-26.72,26.88},{-17.9,34.8}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-25.28,28.32},{-19.34,33.36}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-16.46,-19.92},{-7.64,-12}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-15.02,-18.48},{-9.08,-13.44}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-16.46,-10.56},{-7.64,-2.64}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-15.02,-9.12},{-9.08,-4.08}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-16.46,-1.2},{-7.64,6.72}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-15.02,0.24},{-9.08,5.28}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-16.46,8.16},{-7.64,16.08}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-15.02,9.6},{-9.08,14.64}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-16.46,17.52},{-7.64,25.44}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-15.02,18.96},{-9.08,24}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-16.46,26.88},{-7.64,34.8}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-15.02,28.32},{-9.08,33.36}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Ellipse(extent={{16.12,26.88},{26.2,36.96}}, lineColor={0,0,0}, fillColor={255,246,210}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Line(points={{28.36,31.92},{31.96,31.92}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{26.251169,37.011169},{28.796753,39.556753}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{21.16,39.12},{21.16,42.72}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{16.068831,37.011169},{13.523247,39.556753}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{13.96,31.92},{10.36,31.92}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{16.068831,26.828831},{13.523247,24.283247}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{21.16,24.72},{21.16,21.12}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{26.251169,26.828831},{28.796753,24.283247}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{13.96,24.72},{-4.76,12.48}}, color={212,109,62}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{18.28,18.96},{-3.32,5.28}}, color={212,109,62}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-27.8,-24.24},{-27.8,-28.56},{5.32,-28.56},{5.32,-11.28}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid),
      Polygon(points={{1,-11.28},{9.64,-11.28},{5.32,-4.08},{1,-11.28}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6),
      Line(points={{1,-4.08},{9.64,-4.08}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{5.32,-4.08},{5.32,3.12},{26.92,3.12}}, color={77,126,172}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Text(extent={{8.92,-23.52},{31.24,-9.84}}, textString="+X", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Rectangle(extent={{43,-31},{72,28}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{47,15},{68,15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,0},{68,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,-15},{68,-15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-57,-51},{37,-34}}, textString="sun -> power", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Solar Array Balance", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-344,-161},{343,221}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-78.32,-85.36},{78.32,83.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-66.88,56.32},{66.88,56.32}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-73.92,60.72},{-56.32,78.32}}, lineColor={0,0,0}, fillColor={77,126,172}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-53.68,62.48},{66.88,75.68}}, textString="Power calculation", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-44.1056,-20.064},{-4.1888,33.1584}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Rectangle(extent={{-41.5712,-17.5296},{-33.8096,-10.56}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-40.304,-16.2624},{-35.0768,-11.8272}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-41.5712,-9.2928},{-33.8096,-2.3232}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-40.304,-8.0256},{-35.0768,-3.5904}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-41.5712,-1.056},{-33.8096,5.9136}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-40.304,0.2112},{-35.0768,4.6464}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-41.5712,7.1808},{-33.8096,14.1504}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-40.304,8.448},{-35.0768,12.8832}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-41.5712,15.4176},{-33.8096,22.3872}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-40.304,16.6848},{-35.0768,21.12}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-41.5712,23.6544},{-33.8096,30.624}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-40.304,24.9216},{-35.0768,29.3568}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-32.5424,-17.5296},{-24.7808,-10.56}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-31.2752,-16.2624},{-26.048,-11.8272}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-32.5424,-9.2928},{-24.7808,-2.3232}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-31.2752,-8.0256},{-26.048,-3.5904}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-32.5424,-1.056},{-24.7808,5.9136}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-31.2752,0.2112},{-26.048,4.6464}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-32.5424,7.1808},{-24.7808,14.1504}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-31.2752,8.448},{-26.048,12.8832}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-32.5424,15.4176},{-24.7808,22.3872}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-31.2752,16.6848},{-26.048,21.12}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-32.5424,23.6544},{-24.7808,30.624}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-31.2752,24.9216},{-26.048,29.3568}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-23.5136,-17.5296},{-15.752,-10.56}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-22.2464,-16.2624},{-17.0192,-11.8272}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-23.5136,-9.2928},{-15.752,-2.3232}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-22.2464,-8.0256},{-17.0192,-3.5904}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-23.5136,-1.056},{-15.752,5.9136}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-22.2464,0.2112},{-17.0192,4.6464}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-23.5136,7.1808},{-15.752,14.1504}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-22.2464,8.448},{-17.0192,12.8832}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-23.5136,15.4176},{-15.752,22.3872}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-22.2464,16.6848},{-17.0192,21.12}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-23.5136,23.6544},{-15.752,30.624}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-22.2464,24.9216},{-17.0192,29.3568}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-14.4848,-17.5296},{-6.7232,-10.56}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-13.2176,-16.2624},{-7.9904,-11.8272}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-14.4848,-9.2928},{-6.7232,-2.3232}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-13.2176,-8.0256},{-7.9904,-3.5904}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-14.4848,-1.056},{-6.7232,5.9136}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-13.2176,0.2112},{-7.9904,4.6464}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-14.4848,7.1808},{-6.7232,14.1504}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-13.2176,8.448},{-7.9904,12.8832}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-14.4848,15.4176},{-6.7232,22.3872}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-13.2176,16.6848},{-7.9904,21.12}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-14.4848,23.6544},{-6.7232,30.624}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-13.2176,24.9216},{-7.9904,29.3568}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Ellipse(extent={{14.1856,23.6544},{23.056,32.5248}}, lineColor={0,0,0}, fillColor={255,246,210}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Line(points={{24.9568,28.0896},{28.1248,28.0896}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{23.101,32.5698},{25.3411,34.8099}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{18.6208,34.4256},{18.6208,37.5936}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{14.1406,32.5698},{11.9005,34.8099}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{12.2848,28.0896},{9.1168,28.0896}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{14.1406,23.6094},{11.9005,21.3693}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{18.6208,21.7536},{18.6208,18.5856}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{23.101,23.6094},{25.3411,21.3693}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{12.2848,21.7536},{-4.1888,10.9824}}, color={212,109,62}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{16.0864,16.6848},{-2.9216,4.6464}}, color={212,109,62}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-24.464,-21.3312},{-24.464,-25.1328},{4.6816,-25.1328},{4.6816,-9.9264}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid),
      Polygon(points={{0.88,-9.9264},{8.4832,-9.9264},{4.6816,-3.5904},{0.88,-9.9264}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6),
      Line(points={{0.88,-3.5904},{8.4832,-3.5904}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{4.6816,-3.5904},{4.6816,2.7456},{23.6896,2.7456}}, color={77,126,172}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Text(extent={{7.8496,-20.6976},{27.4912,-8.6592}}, textString="+X", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Rectangle(extent={{37.84,-27.28},{63.36,24.64}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{41.36,13.2},{59.84,13.2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{41.36,0},{59.84,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{41.36,-13.2},{59.84,-13.2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-50.16,-44.88},{32.56,-29.92}}, textString="sun -> power", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-66.88,-51.04},{66.88,-51.04}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-70.4,-69.52},{70.4,-56.32}}, textString="Solar Array Balance", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-318,133},{-223,151}}, textString="GEOMETRY", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-318,55},{-223,73}}, textString="RADIATION", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-318,-49},{-223,-31}}, textString="MPPT INPUT", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{222,133},{317,151}}, textString="DELIVERY", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{222,29},{317,47}}, textString="RADIATION", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{222,-49},{317,-31}}, textString="MPPT STATE", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-332,176},{331,205}}, textString="Solar Array Performance", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-332,168},{331,168}}, color={215,220,226}, thickness=0.25)
    }));
end SolarArrayPerformanceCalculation;