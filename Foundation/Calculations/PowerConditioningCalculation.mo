within OneSatSim.Foundation.Calculations;
model PowerConditioningCalculation "12 V平均值调节与太阳限功率计算"
  parameter Real regulatorEfficiency(min=0.8,max=1)=0.94 "12 V平均值变换效率" ;
  parameter Modelica.Units.SI.Voltage minimumInputVoltage=10.2 "minimum输入电压 [V]" ;
  parameter Modelica.Units.SI.Current maximumInputCurrent=12 "maximum输入电流 [A]" ;
  parameter Modelica.Units.SI.Current maximumOutputCurrent=8 "maximum输出电流 [A]" ;
  parameter Modelica.Units.SI.Power maximumOutputPower=96 "maximum输出功率 [W]" ;
  parameter Modelica.Units.SI.Resistance outputResistance12=0.035 "系统级 12 V load regulation/droop [Ohm]" ;
  parameter Modelica.Units.SI.Resistance overloadDroop12=0.65 "配置项 overloadDroop12 [Ohm]" ;
  parameter Real solarNetDeliveryEfficiency[3](each min=0,each max=1)
    "solarNetDelivery效率；Same rated net-delivery targets used by the three array physical branches";
  Modelica.Blocks.Interfaces.RealInput batterySOC  "BMS荷电状态" annotation(Placement(visible=true, transformation(origin={-270,182}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-5.688889,-5.688889},{5.688889,5.688889}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInput batteryChargeAllowed  "BMS允许充电" annotation(Placement(visible=true, transformation(origin={-270,156}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,62.222222}, extent={{-5.688889,-5.688889},{5.688889,5.688889}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput batteryHeaterCurrent[2](each unit="A")
    "电池Heater电流 [A]；Actual current sensors in the two direct raw-bus heater branches" 
    annotation(Placement(visible=true, transformation(origin={-270,130}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,26.666667}, extent={{-5.688889,-5.688889},{5.688889,5.688889}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput availableSolarPower[3](each unit="W")  "availableSolar功率 [W]" annotation(Placement(visible=true, transformation(origin={-270,78}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,8.888889}, extent={{-5.688889,-5.688889},{5.688889,5.688889}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput sourceVoltageAverage(unit="V")  "实际原始电源端电压的30 s慢变平均 [V]" annotation(Placement(visible=true, transformation(origin={-270,26}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-8.888889}, extent={{-5.688889,-5.688889},{5.688889,5.688889}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput loadCurrentAverage(unit="A")  "负载电流Average [A]" annotation(Placement(visible=true, transformation(origin={-270,-78}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-26.666667}, extent={{-5.688889,-5.688889},{5.688889,5.688889}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput sourceVoltage(unit="V")  "原始电源路径电压 [V]" annotation(Placement(visible=true, transformation(origin={-270,0}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-44.444444}, extent={{-5.688889,-5.688889},{5.688889,5.688889}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput busVoltage12(unit="V")  "总线电压12 [V]" annotation(Placement(visible=true, transformation(origin={-270,-104}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-62.222222}, extent={{-5.688889,-5.688889},{5.688889,5.688889}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput loadBusCurrent(unit="A")  "负载总线电流 [A]" annotation(Placement(visible=true, transformation(origin={-270,-130}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-5.688889,-5.688889},{5.688889,5.688889}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput threeRailVoltage[3](each unit="V")
    "threeRail电压 [V]；Measured 12, 5 and 3.3 V output-rail voltages" 
    annotation(Placement(transformation(origin={-270,-156}, extent={{-6,-6},{6,6}}, rotation=0),iconTransformation(origin={-70,-100},extent={{-6,-6},{6,6}})));
  Modelica.Blocks.Interfaces.RealInput threeRailCurrent[3](each unit="A")
    "threeRail电流 [A]；Measured 12 V trunk and 5/3.3 V final output currents" 
    annotation(Placement(transformation(origin={-270,-182}, extent={{-6,-6},{6,6}}, rotation=0),iconTransformation(origin={0,-100},extent={{-6,-6},{6,6}})));
  Modelica.Blocks.Interfaces.RealInput converterInputCurrent[2](each unit="A")
    "converter输入电流 [A]；Measured 12 V input currents of 5 V and 3.3 V converters" 
    annotation(Placement(transformation(origin={-270,-26}, extent={{-6,-6},{6,6}}, rotation=0),iconTransformation(origin={70,-100},extent={{-6,-6},{6,6}})));
  Modelica.Blocks.Interfaces.RealOutput batteryOCVEstimate(unit="V")
    "仅供诊断的SOC开路电压估算，不参与稳压反馈" annotation(Placement(visible=true, transformation(origin={270,-104}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-5.688889,-5.688889},{5.688889,5.688889}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput loadCurrentMeasurement(unit="A")  "负载电流测量 [A]" annotation(Placement(visible=true, transformation(origin={270,-130}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,62.222222}, extent={{-5.688889,-5.688889},{5.688889,5.688889}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput regulatedVoltageCommand(unit="V")  "regulated电压指令 [V]" annotation(Placement(visible=true, transformation(origin={270,130}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,44.444444}, extent={{-5.688889,-5.688889},{5.688889,5.688889}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput sourceCurrentCommand(unit="A")  "源电流指令 [A]" annotation(Placement(visible=true, transformation(origin={270,104}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,26.666667}, extent={{-5.688889,-5.688889},{5.688889,5.688889}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput regulatorLossPower(unit="W")  "regulatorLoss功率 [W]" annotation(Placement(visible=true, transformation(origin={270,-26}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,8.888889}, extent={{-5.688889,-5.688889},{5.688889,5.688889}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput solarCurtailmentCommand  "solarCurtailment指令" annotation(Placement(visible=true, transformation(origin={270,78}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-8.888889}, extent={{-5.688889,-5.688889},{5.688889,5.688889}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput regulatedOutputPower(unit="W")  "regulated输出功率 [W]" annotation(Placement(visible=true, transformation(origin={270,26}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-62.222222}, extent={{-5.688889,-5.688889},{5.688889,5.688889}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput weightedAvailableSolarPower(unit="W")  "weightedAvailableSolar功率 [W]" annotation(Placement(visible=true, transformation(origin={270,-52}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-5.688889,-5.688889},{5.688889,5.688889}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput threeRailOutputPower(unit="W")
    "threeRail输出功率 [W]；Signed measured final-load power; 12 V converter inputs are subtracted before adding 5/3.3 V outputs" 
    annotation(Placement(transformation(origin={270,0}, extent={{-6,-6},{6,6}}, rotation=0),iconTransformation(origin={100,-95},extent={{-6,-6},{6,6}})));
protected
  Real positiveLoadCurrent(unit="A") "positive负载电流 [A]" ;
  Real rawInputPower(unit="W") "raw输入功率 [W]" ;
  Real rawConversionLoss(unit="W") "计算/接口量 rawConversionLoss [W]" ;
  Real directBatteryHeaterPower(unit="W") "direct电池Heater功率 [W]" ;
  Real solarCurtailmentDemandPower(unit="W") "solarCurtailment需求功率 [W]" ;
  Real solarCurtailmentRatio "计算/接口量 solarCurtailmentRatio" ;
  Real limitedSolarCurtailmentRatio "计算/接口量 limitedSolarCurtailmentRatio" ;
  Real powerCurrentLimit(unit="A") "功率电流限制 [A]" ;
  Real inputCurrentLimitAtOutput(unit="A") "输入电流限制At输出 [A]" ;
  Real currentAndPowerLimit(unit="A") "电流And功率限制 [A]" ;
  Real capabilityCurrentLimit(unit="A") "capability电流限制 [A]" ;
  Real overloadCurrent(unit="A") "overload电流 [A]" ;
  Real sourceAvailability "源可用性" ;
equation
  batteryOCVEstimate=noEvent(4*(3.2+min(1,max(0,batterySOC))));
  loadCurrentMeasurement=positiveLoadCurrent;
  positiveLoadCurrent=0.5*(loadBusCurrent+sqrt(loadBusCurrent^2+1e-8));
  rawInputPower=sourceVoltage*sourceCurrentCommand;
  regulatedOutputPower=busVoltage12*positiveLoadCurrent;
  threeRailOutputPower=threeRailVoltage[1]*
    (threeRailCurrent[1]-converterInputCurrent[1]-converterInputCurrent[2])+
    threeRailVoltage[2]*threeRailCurrent[2]+
    threeRailVoltage[3]*threeRailCurrent[3];
  rawConversionLoss=rawInputPower-regulatedOutputPower;
  directBatteryHeaterPower=sourceVoltage*
    (max(0,batteryHeaterCurrent[1])+max(0,batteryHeaterCurrent[2]));
  weightedAvailableSolarPower=sum(
    solarNetDeliveryEfficiency[i]*availableSolarPower[i] for i in 1:3);
  solarCurtailmentDemandPower=regulatedOutputPower/regulatorEfficiency+directBatteryHeaterPower;
  solarCurtailmentRatio=solarCurtailmentDemandPower/max(1,weightedAvailableSolarPower);
  limitedSolarCurtailmentRatio=noEvent(min(1,solarCurtailmentRatio));
  solarCurtailmentCommand=if batteryChargeAllowed then 1 else limitedSolarCurtailmentRatio;
  powerCurrentLimit=maximumOutputPower/sqrt(12.10^2+0.01);
  inputCurrentLimitAtOutput=maximumInputCurrent*regulatorEfficiency*sqrt(sourceVoltageAverage^2+0.01)/sqrt(12.10^2+0.01);
  currentAndPowerLimit=0.5*(maximumOutputCurrent+powerCurrentLimit-sqrt((maximumOutputCurrent-powerCurrentLimit)^2+1e-6));
  capabilityCurrentLimit=0.5*(currentAndPowerLimit+inputCurrentLimitAtOutput-sqrt((currentAndPowerLimit-inputCurrentLimitAtOutput)^2+1e-6));
  overloadCurrent=0.5*((loadCurrentAverage-capabilityCurrentLimit)+sqrt((loadCurrentAverage-capabilityCurrentLimit)^2+1e-8));
  sourceAvailability=0.5+0.5*tanh((sourceVoltageAverage-(minimumInputVoltage+0.25))/0.10);
  regulatedVoltageCommand=sourceAvailability*(12.10+0.015*tanh((sourceVoltageAverage-12.05)/0.10)-outputResistance12*loadCurrentAverage-overloadDroop12*overloadCurrent);
  sourceCurrentCommand=if sourceVoltage >= minimumInputVoltage then 
    regulatedOutputPower/(regulatorEfficiency*sourceVoltage) else 0;
  regulatorLossPower=rawConversionLoss;
  assert(noEvent(sourceVoltage >= minimumInputVoltage or regulatedOutputPower <= 1e-4),
    "12 V averaged regulator outside supported input-voltage domain.");
  assert(noEvent(regulatedOutputPower >= -1e-6 and regulatorLossPower >= -1e-6),
    "12 V averaged regulator power is outside non-regenerative model domain.");
  annotation(Documentation(info="<html><h2>12 V平均值调节与太阳限功率计算</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Calculations.PowerConditioningCalculation</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>12 V平均值调节与太阳限功率计算</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.PowerConditioningUnit\">OneSatSim.Components.PowerConditioningUnit</a> 的 <code>powerCalculation</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>batterySOC</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>按声明/类型合同</td><td>BMS荷电状态</td></tr><tr><td><code>batteryChargeAllowed</code></td><td>Modelica.Blocks.Interfaces.BooleanInput</td><td>public</td><td>按声明/类型合同</td><td>BMS允许充电</td></tr><tr><td><code>batteryHeaterCurrent[2]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>A</td><td>电池Heater电流 [A]；Actual current sensors in the two direct raw-bus heater branches</td></tr><tr><td><code>availableSolarPower[3]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>W</td><td>availableSolar功率 [W]</td></tr><tr><td><code>sourceVoltageAverage</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>V</td><td>实际原始电源端电压的30 s慢变平均 [V]</td></tr><tr><td><code>loadCurrentAverage</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>A</td><td>负载电流Average [A]</td></tr><tr><td><code>sourceVoltage</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>V</td><td>原始电源路径电压 [V]</td></tr><tr><td><code>busVoltage12</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>V</td><td>总线电压12 [V]</td></tr><tr><td><code>loadBusCurrent</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>A</td><td>负载总线电流 [A]</td></tr><tr><td><code>threeRailVoltage[3]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>V</td><td>threeRail电压 [V]；Measured 12, 5 and 3.3 V output-rail voltages</td></tr><tr><td><code>threeRailCurrent[3]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>A</td><td>threeRail电流 [A]；Measured 12 V trunk and 5/3.3 V final output currents</td></tr><tr><td><code>converterInputCurrent[2]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>A</td><td>converter输入电流 [A]；Measured 12 V input currents of 5 V and 3.3 V converters</td></tr><tr><td><code>batteryOCVEstimate</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>V</td><td>仅供诊断的SOC开路电压估算，不参与稳压反馈</td></tr><tr><td><code>loadCurrentMeasurement</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>A</td><td>负载电流测量 [A]</td></tr><tr><td><code>regulatedVoltageCommand</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>V</td><td>regulated电压指令 [V]</td></tr><tr><td><code>sourceCurrentCommand</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>A</td><td>源电流指令 [A]</td></tr><tr><td><code>regulatorLossPower</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>W</td><td>regulatorLoss功率 [W]</td></tr><tr><td><code>solarCurtailmentCommand</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>solarCurtailment指令</td></tr><tr><td><code>regulatedOutputPower</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>W</td><td>regulated输出功率 [W]</td></tr><tr><td><code>weightedAvailableSolarPower</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>W</td><td>weightedAvailableSolar功率 [W]</td></tr><tr><td><code>threeRailOutputPower</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>W</td><td>threeRail输出功率 [W]；Signed measured final-load power; 12 V converter inputs are subtracted before adding 5/3.3 V outputs</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>regulatorEfficiency</code></td><td>Real</td><td>12 V平均值变换效率</td><td><code>=0.94</code></td></tr><tr><td><code>minimumInputVoltage</code></td><td>Modelica.Units.SI.Voltage</td><td>minimum输入电压 [V]</td><td><code>=10.2</code></td></tr><tr><td><code>maximumInputCurrent</code></td><td>Modelica.Units.SI.Current</td><td>maximum输入电流 [A]</td><td><code>=12</code></td></tr><tr><td><code>maximumOutputCurrent</code></td><td>Modelica.Units.SI.Current</td><td>maximum输出电流 [A]</td><td><code>=8</code></td></tr><tr><td><code>maximumOutputPower</code></td><td>Modelica.Units.SI.Power</td><td>maximum输出功率 [W]</td><td><code>=96</code></td></tr><tr><td><code>outputResistance12</code></td><td>Modelica.Units.SI.Resistance</td><td>系统级 12 V load regulation/droop [Ohm]</td><td><code>=0.035</code></td></tr><tr><td><code>overloadDroop12</code></td><td>Modelica.Units.SI.Resistance</td><td>配置项 overloadDroop12 [Ohm]</td><td><code>=0.65</code></td></tr><tr><td><code>solarNetDeliveryEfficiency[3]</code></td><td>Real</td><td>solarNetDelivery效率；Same rated net-delivery targets used by the three array physical branches</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] batteryOCVEstimate=noEvent(4*(3.2+min(1,max(0,batterySOC))));\n[equation] loadCurrentMeasurement=positiveLoadCurrent;\n[equation] positiveLoadCurrent=0.5*(loadBusCurrent+sqrt(loadBusCurrent^2+1e-8));\n[equation] rawInputPower=sourceVoltage*sourceCurrentCommand;\n[equation] regulatedOutputPower=busVoltage12*positiveLoadCurrent;\n[equation] threeRailOutputPower=threeRailVoltage[1]* (threeRailCurrent[1]-converterInputCurrent[1]-converterInputCurrent[2])+ threeRailVoltage[2]*threeRailCurrent[2]+ threeRailVoltage[3]*threeRailCurrent[3];\n[equation] rawConversionLoss=rawInputPower-regulatedOutputPower;\n[equation] directBatteryHeaterPower=sourceVoltage* (max(0,batteryHeaterCurrent[1])+max(0,batteryHeaterCurrent[2]));\n[equation] weightedAvailableSolarPower=sum( solarNetDeliveryEfficiency[i]*availableSolarPower[i] for i in 1:3);\n[equation] solarCurtailmentDemandPower=regulatedOutputPower/regulatorEfficiency+directBatteryHeaterPower;</pre><p>本类另有14段语句；阅读完整源码可查看其余边界与逻辑。</p><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>positiveLoadCurrent</code></td><td>Real</td><td>protected</td><td>A</td><td>positive负载电流 [A]</td></tr><tr><td><code>rawInputPower</code></td><td>Real</td><td>protected</td><td>W</td><td>raw输入功率 [W]</td></tr><tr><td><code>rawConversionLoss</code></td><td>Real</td><td>protected</td><td>W</td><td>计算/接口量 rawConversionLoss [W]</td></tr><tr><td><code>directBatteryHeaterPower</code></td><td>Real</td><td>protected</td><td>W</td><td>direct电池Heater功率 [W]</td></tr><tr><td><code>solarCurtailmentDemandPower</code></td><td>Real</td><td>protected</td><td>W</td><td>solarCurtailment需求功率 [W]</td></tr><tr><td><code>solarCurtailmentRatio</code></td><td>Real</td><td>protected</td><td>按声明/类型合同</td><td>计算/接口量 solarCurtailmentRatio</td></tr><tr><td><code>limitedSolarCurtailmentRatio</code></td><td>Real</td><td>protected</td><td>按声明/类型合同</td><td>计算/接口量 limitedSolarCurtailmentRatio</td></tr><tr><td><code>powerCurrentLimit</code></td><td>Real</td><td>protected</td><td>A</td><td>功率电流限制 [A]</td></tr><tr><td><code>inputCurrentLimitAtOutput</code></td><td>Real</td><td>protected</td><td>A</td><td>输入电流限制At输出 [A]</td></tr><tr><td><code>currentAndPowerLimit</code></td><td>Real</td><td>protected</td><td>A</td><td>电流And功率限制 [A]</td></tr><tr><td><code>capabilityCurrentLimit</code></td><td>Real</td><td>protected</td><td>A</td><td>capability电流限制 [A]</td></tr><tr><td><code>overloadCurrent</code></td><td>Real</td><td>protected</td><td>A</td><td>overload电流 [A]</td></tr><tr><td><code>sourceAvailability</code></td><td>Real</td><td>protected</td><td>按声明/类型合同</td><td>源可用性</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={77,126,172}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Power calculation", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-50.84,-15.6},{11.08,30.48}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Line(points={{-47.24,-11.28},{6.76,25.44}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-42.92,20.4},{-26.36,20.4}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{-42.92,15.36},{-26.36,15.36}}, color={77,126,172}, thickness=0.5, pattern=LinePattern.Dash),
      Line(points={{-14.12,-0.48},{3.16,-0.48}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{-14.12,-5.52},{3.16,-5.52}}, color={77,126,172}, thickness=0.5, pattern=LinePattern.Dash),
      Line(points={{-68.84,20.4},{-50.84,20.4}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-68.84,-8.4},{-50.84,-8.4}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{11.08,20.4},{34.12,20.4}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{11.08,-8.4},{34.12,-8.4}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-26.36,-18.48},{-26.36,-25.68},{-17,-22.08},{-7.64,-28.56},{1.72,-22.8}}, color={196,94,56}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{43,-31},{72,28}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{47,15},{68,15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,0},{68,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,-15},{68,-15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-57,-51},{37,-34}}, textString="Pin - Pout", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Regulator Balance", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-344,-226},{348.8,286}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-78.32,-85.36},{78.32,83.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-66.88,56.32},{66.88,56.32}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-73.92,60.72},{-56.32,78.32}}, lineColor={0,0,0}, fillColor={77,126,172}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-53.68,62.48},{66.88,75.68}}, textString="Power calculation", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-44.7392,-13.728},{9.7504,26.8224}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Line(points={{-41.5712,-9.9264},{5.9488,22.3872}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-37.7696,17.952},{-23.1968,17.952}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{-37.7696,13.5168},{-23.1968,13.5168}}, color={77,126,172}, thickness=0.5, pattern=LinePattern.Dash),
      Line(points={{-12.4256,-0.4224},{2.7808,-0.4224}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{-12.4256,-4.8576},{2.7808,-4.8576}}, color={77,126,172}, thickness=0.5, pattern=LinePattern.Dash),
      Line(points={{-60.5792,17.952},{-44.7392,17.952}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-60.5792,-7.392},{-44.7392,-7.392}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{9.7504,17.952},{30.0256,17.952}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{9.7504,-7.392},{30.0256,-7.392}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-23.1968,-16.2624},{-23.1968,-22.5984},{-14.96,-19.4304},{-6.7232,-25.1328},{1.5136,-20.064}}, color={196,94,56}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{37.84,-27.28},{63.36,24.64}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{41.36,13.2},{59.84,13.2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{41.36,0},{59.84,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{41.36,-13.2},{59.84,-13.2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-50.16,-44.88},{32.56,-29.92}}, textString="Pin - Pout", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-66.88,-51.04},{66.88,-51.04}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-70.4,-69.52},{70.4,-56.32}}, textString="Regulator Balance", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-318,198},{-223,216}}, textString="BATTERY", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-318,94},{-223,112}}, textString="SOLAR", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-318,42},{-223,60}}, textString="INPUT RAIL", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-318,-62},{-223,-44}}, textString="LOAD RAILS", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{222,146},{317,164}}, textString="REGULATION", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{222,42},{322.8,60}}, textString="POWER / LOSS", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{222,-88},{317,-70}}, textString="ESTIMATES", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-332,241},{336.8,270}}, textString="Power Conditioning", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-332,233},{336.8,233}}, color={215,220,226}, thickness=0.25)
    }));
end PowerConditioningCalculation;