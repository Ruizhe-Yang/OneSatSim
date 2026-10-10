within OneSatSim.Foundation.Models;
model AverageDCDCConverterCore "连续低阶非理想直流变换核心"
  parameter Modelica.Units.SI.Voltage nominalOutputVoltage=5 "nominal输出电压 [V]" ;
  parameter Real efficiency(min=0.5,max=1)=0.90 "效率" ;
  parameter Modelica.Units.SI.Current outputCurrentLimit=3 "输出电流限制 [A]" ;
  parameter Modelica.Units.SI.Power outputPowerLimit=15 "输出功率限制 [W]" ;
  parameter Modelica.Units.SI.Voltage minimumInputVoltage=8 "minimum输入电压 [V]" ;
  parameter Modelica.Units.SI.Resistance outputResistance=0.03 "输出Resistance [Ohm]" ;
  parameter Modelica.Units.SI.Resistance overloadDroop=0.5 "配置项 overloadDroop [Ohm]" ;
  Modelica.Electrical.Analog.Interfaces.PositivePin p1 
     "计算/接口量 p1" annotation(Placement(visible=true, transformation(origin={-190,65}, extent={{-8,-8},{8,8}}, rotation=0), iconVisible=true, iconTransformation(origin={-80,95}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n1 
     "计算/接口量 n1" annotation(Placement(visible=true, transformation(origin={-190,-65}, extent={{-8,-8},{8,8}}, rotation=0), iconVisible=true, iconTransformation(origin={-26.666667,95}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Electrical.Analog.Interfaces.PositivePin p2 
     "计算/接口量 p2" annotation(Placement(visible=true, transformation(origin={190,65}, extent={{-8,-8},{8,8}}, rotation=0), iconVisible=true, iconTransformation(origin={26.666667,95}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n2 
     "计算/接口量 n2" annotation(Placement(visible=true, transformation(origin={190,-65}, extent={{-8,-8},{8,8}}, rotation=0), iconVisible=true, iconTransformation(origin={80,95}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort 
     "热流接口" annotation(Placement(visible=true, transformation(origin={0,-180}, extent={{-8,-8},{8,8}}, rotation=0), iconVisible=true, iconTransformation(origin={0,-97}, extent={{-5.76,-5.76},{5.76,5.76}}, rotation=0)));
  Modelica.Units.SI.Voltage inputVoltage "输入电压 [V]" ;
  Modelica.Units.SI.Voltage outputVoltage "输出电压 [V]" ;
  Modelica.Units.SI.Current outputCurrent "输出电流 [A]" ;
  final parameter Modelica.Units.SI.Current effectiveCurrentLimit=
    min(outputCurrentLimit,outputPowerLimit/max(nominalOutputVoltage,0.1)) "effective电流限制 [A]" ;
  Modelica.Units.SI.Current overloadCurrent "overload电流 [A]" ;
  Modelica.Units.SI.Power outputPower "输出功率 [W]" ;
  Modelica.Units.SI.Power inputPower "输入功率 [W]" ;
  Modelica.Units.SI.Power lossPower "loss功率 [W]" ;
  Real inputAvailability "输入可用性" ;
  Modelica.Units.SI.Voltage positiveInputVoltage "positive输入电压 [V]" ;
  Real overloadDelta(unit="A",start=0) "计算/接口量 overloadDelta [A]" ;
equation
  inputVoltage=p1.v-n1.v;
  outputVoltage=p2.v-n2.v;
  p1.i+n1.i=0;
  p2.i+n2.i=0;
  outputCurrent=-p2.i;
  positiveInputVoltage=0.5*(inputVoltage+sqrt(inputVoltage^2+1e-6));
  inputAvailability=noEvent(max(0,min(1,positiveInputVoltage/minimumInputVoltage)))
    "Regulated above minimumInputVoltage, continuous linear dropout below it";
  overloadDelta=outputCurrent-effectiveCurrentLimit;
  overloadCurrent=0.5*(overloadDelta+sqrt(overloadDelta^2+1e-8));
  outputVoltage=nominalOutputVoltage*inputAvailability-
    outputResistance*outputCurrent-overloadDroop*overloadCurrent;
  outputPower=outputVoltage*outputCurrent;
  p1.i=if inputVoltage >= minimumInputVoltage then 
    outputPower/(efficiency*inputVoltage) else 0;
  inputPower=inputVoltage*p1.i;
  lossPower=inputPower-outputPower;
  heatPort.Q_flow=-lossPower;
  assert(noEvent(inputVoltage >= minimumInputVoltage or outputPower <= 1e-4),
    "Average DC/DC converter is outside its supported input-voltage domain.");
  assert(noEvent(outputPower >= -1e-6 and lossPower >= -1e-6),
    "Average DC/DC converter cannot source power regeneratively or create energy.");
  annotation(Documentation(info="<html><h2>连续低阶非理想直流变换核心</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Models.AverageDCDCConverterCore</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>连续低阶非理想直流变换核心</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.PowerConditioningUnit\">OneSatSim.Components.PowerConditioningUnit</a> 的 <code>converter5</code>；<a href=\"modelica://OneSatSim.Components.PowerConditioningUnit\">OneSatSim.Components.PowerConditioningUnit</a> 的 <code>converter3V3</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>p1</code></td><td>Modelica.Electrical.Analog.Interfaces.PositivePin</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 p1</td></tr><tr><td><code>n1</code></td><td>Modelica.Electrical.Analog.Interfaces.NegativePin</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 n1</td></tr><tr><td><code>p2</code></td><td>Modelica.Electrical.Analog.Interfaces.PositivePin</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 p2</td></tr><tr><td><code>n2</code></td><td>Modelica.Electrical.Analog.Interfaces.NegativePin</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 n2</td></tr><tr><td><code>heatPort</code></td><td>Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a</td><td>public</td><td>按声明/类型合同</td><td>热流接口</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>nominalOutputVoltage</code></td><td>Modelica.Units.SI.Voltage</td><td>nominal输出电压 [V]</td><td><code>=5</code></td></tr><tr><td><code>efficiency</code></td><td>Real</td><td>效率</td><td><code>=0.90</code></td></tr><tr><td><code>outputCurrentLimit</code></td><td>Modelica.Units.SI.Current</td><td>输出电流限制 [A]</td><td><code>=3</code></td></tr><tr><td><code>outputPowerLimit</code></td><td>Modelica.Units.SI.Power</td><td>输出功率限制 [W]</td><td><code>=15</code></td></tr><tr><td><code>minimumInputVoltage</code></td><td>Modelica.Units.SI.Voltage</td><td>minimum输入电压 [V]</td><td><code>=8</code></td></tr><tr><td><code>outputResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>输出Resistance [Ohm]</td><td><code>=0.03</code></td></tr><tr><td><code>overloadDroop</code></td><td>Modelica.Units.SI.Resistance</td><td>配置项 overloadDroop [Ohm]</td><td><code>=0.5</code></td></tr><tr><td><code>effectiveCurrentLimit</code></td><td>Modelica.Units.SI.Current</td><td>effective电流限制 [A]</td><td><code>= min(outputCurrentLimit,outputPowerLimit/max(nominalOutputVoltage,0.1))</code></td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] inputVoltage=p1.v-n1.v;\n[equation] outputVoltage=p2.v-n2.v;\n[equation] p1.i+n1.i=0;\n[equation] p2.i+n2.i=0;\n[equation] outputCurrent=-p2.i;\n[equation] positiveInputVoltage=0.5*(inputVoltage+sqrt(inputVoltage^2+1e-6));\n[equation] inputAvailability=noEvent(max(0,min(1,positiveInputVoltage/minimumInputVoltage))) &quot;Regulated above minimumInputVoltage, continuous linear dropout below it&quot;;\n[equation] overloadDelta=outputCurrent-effectiveCurrentLimit;\n[equation] overloadCurrent=0.5*(overloadDelta+sqrt(overloadDelta^2+1e-8));\n[equation] outputVoltage=nominalOutputVoltage*inputAvailability- outputResistance*outputCurrent-overloadDroop*overloadCurrent;</pre><p>本类另有7段语句；阅读完整源码可查看其余边界与逻辑。</p><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>inputVoltage</code></td><td>Modelica.Units.SI.Voltage</td><td>public</td><td>V</td><td>输入电压 [V]</td></tr><tr><td><code>outputVoltage</code></td><td>Modelica.Units.SI.Voltage</td><td>public</td><td>V</td><td>输出电压 [V]</td></tr><tr><td><code>outputCurrent</code></td><td>Modelica.Units.SI.Current</td><td>public</td><td>A</td><td>输出电流 [A]</td></tr><tr><td><code>overloadCurrent</code></td><td>Modelica.Units.SI.Current</td><td>public</td><td>A</td><td>overload电流 [A]</td></tr><tr><td><code>outputPower</code></td><td>Modelica.Units.SI.Power</td><td>public</td><td>W</td><td>输出功率 [W]</td></tr><tr><td><code>inputPower</code></td><td>Modelica.Units.SI.Power</td><td>public</td><td>W</td><td>输入功率 [W]</td></tr><tr><td><code>lossPower</code></td><td>Modelica.Units.SI.Power</td><td>public</td><td>W</td><td>loss功率 [W]</td></tr><tr><td><code>inputAvailability</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>输入可用性</td></tr><tr><td><code>positiveInputVoltage</code></td><td>Modelica.Units.SI.Voltage</td><td>public</td><td>V</td><td>positive输入电压 [V]</td></tr><tr><td><code>overloadDelta</code></td><td>Real</td><td>public</td><td>A</td><td>计算/接口量 overloadDelta [A]</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={77,126,172}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-47,-30},{39,34}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Line(points={{-42,-24},{33,27}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-36,20},{-13,20}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{-36,13},{-13,13}}, color={77,126,172}, thickness=0.5, pattern=LinePattern.Dash),
      Line(points={{4,-9},{28,-9}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{4,-16},{28,-16}}, color={77,126,172}, thickness=0.5, pattern=LinePattern.Dash),
      Line(points={{-72,20},{-47,20}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-72,-20},{-47,-20}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{39,20},{71,20}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{39,-20},{71,-20}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-13,-34},{-13,-44},{0,-39},{13,-48},{26,-40}}, color={196,94,56}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Average DC/DC", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-236,-226},{236,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-64.08,-69.84},{64.08,68.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-54.72,46.08},{54.72,46.08}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-60.48,49.68},{-46.08,64.08}}, lineColor={0,0,0}, fillColor={77,126,172}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-43.92,51.12},{54.72,61.92}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-33.84,-21.6},{28.08,24.48}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Line(points={{-30.24,-17.28},{23.76,19.44}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-25.92,14.4},{-9.36,14.4}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{-25.92,9.36},{-9.36,9.36}}, color={77,126,172}, thickness=0.5, pattern=LinePattern.Dash),
      Line(points={{2.88,-6.48},{20.16,-6.48}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{2.88,-11.52},{20.16,-11.52}}, color={77,126,172}, thickness=0.5, pattern=LinePattern.Dash),
      Line(points={{-51.84,14.4},{-33.84,14.4}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-51.84,-14.4},{-33.84,-14.4}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{28.08,14.4},{51.12,14.4}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{28.08,-14.4},{51.12,-14.4}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-9.36,-24.48},{-9.36,-31.68},{0,-28.08},{9.36,-34.56},{18.72,-28.8}}, color={196,94,56}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-54.72,-41.76},{54.72,-41.76}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-57.6,-56.88},{57.6,-46.08}}, textString="Average DC/DC", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-224,110},{224,139}}, textString="Average DC / DC Conversion", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-224,102},{224,102}}, color={215,220,226}, thickness=0.25)
    }));
end AverageDCDCConverterCore;