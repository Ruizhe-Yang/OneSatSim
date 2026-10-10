within OneSatSim.Foundation.Calculations;
model XBandTransmissionCalculation "X波段发射任务门控计算"
  parameter Real payloadDataRate(unit="1/s")=6.25e6 "载荷缓存读取率，数值单位byte/s";
  parameter Modelica.Units.SI.Voltage minimumOperationalVoltage=6
    "平均值功放模型可用供电域下限，不代表硬件欠压规格";
  Modelica.Blocks.Interfaces.BooleanInput communicationPowerCommand  "communication功率指令" annotation(Placement(visible=true, transformation(origin={-270,130}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,85}, extent={{-5,-5},{5,5}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInput transmitCommand  "transmit指令" annotation(Placement(visible=true, transformation(origin={-270,104}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,60}, extent={{-5,-5},{5,5}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInput dataAvailable  "数据Available" annotation(Placement(visible=true, transformation(origin={-270,52}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,35}, extent={{-5,-5},{5,5}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput activeGroundStationIndex
    "当前任务锁存的地面站；零表示无下传站" annotation(Placement(visible=true, transformation(origin={-270,-26}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,10}, extent={{-5,-5},{5,5}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInput groundLinkAttitudeReady
    "当前接触、指向、跟踪率和驻留均合格" annotation(Placement(visible=true, transformation(origin={-270,-52}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-15}, extent={{-5,-5},{5,5}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput busVoltage(unit="V")
    "12 V母线的合法电压测量" annotation(Placement(visible=true, transformation(origin={-270,-104}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-40}, extent={{-5,-5},{5,5}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput powerAmplifierCurrent(unit="A")
    "串联功放电流传感器正向读数" annotation(Placement(visible=true, transformation(origin={-270,-130}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-65}, extent={{-5,-5},{5,5}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput storedBytes(unit="1")
    "记录器当前可读库存，数值单位byte" annotation(Placement(visible=true, transformation(origin={-270,26}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-90}, extent={{-5,-5},{5,5}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput supplyEnabled  "供给启用" annotation(Placement(visible=true, transformation(origin={270,32}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput payloadReadRate(unit="1/s")  "payloadRead速率 [1/s]" annotation(Placement(visible=true, transformation(origin={270,0}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput transmitterStatus  "X波段发射状态" annotation(Placement(visible=true, transformation(origin={270,-32}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-6,-6},{6,6}}, rotation=0)));
protected
  Boolean actualPowerAvailable "命令已上电且功放支路真实取电";
equation
  supplyEnabled=communicationPowerCommand;
  actualPowerAvailable=communicationPowerCommand and busVoltage >= minimumOperationalVoltage and 
    noEvent(powerAmplifierCurrent > 0);
  payloadReadRate=if transmitCommand and actualPowerAvailable and 
    activeGroundStationIndex > 0 and groundLinkAttitudeReady and 
    dataAvailable and noEvent(storedBytes > 0) then payloadDataRate else 0;
  transmitterStatus=if actualPowerAvailable then 1 else 0;
  annotation(Documentation(info="<html><h2>X波段发射任务门控计算</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Calculations.XBandTransmissionCalculation</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>X波段发射任务门控计算</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.XBandTransmitterUnit\">OneSatSim.Components.XBandTransmitterUnit</a> 的 <code>transmissionLogic</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>communicationPowerCommand</code></td><td>Modelica.Blocks.Interfaces.BooleanInput</td><td>public</td><td>按声明/类型合同</td><td>communication功率指令</td></tr><tr><td><code>transmitCommand</code></td><td>Modelica.Blocks.Interfaces.BooleanInput</td><td>public</td><td>按声明/类型合同</td><td>transmit指令</td></tr><tr><td><code>dataAvailable</code></td><td>Modelica.Blocks.Interfaces.BooleanInput</td><td>public</td><td>按声明/类型合同</td><td>数据Available</td></tr><tr><td><code>activeGroundStationIndex</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>当前任务锁存的地面站；零表示无下传站</td></tr><tr><td><code>groundLinkAttitudeReady</code></td><td>Modelica.Blocks.Interfaces.BooleanInput</td><td>public</td><td>按声明/类型合同</td><td>当前接触、指向、跟踪率和驻留均合格</td></tr><tr><td><code>busVoltage</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>V</td><td>12 V母线的合法电压测量</td></tr><tr><td><code>powerAmplifierCurrent</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>A</td><td>串联功放电流传感器正向读数</td></tr><tr><td><code>storedBytes</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>1</td><td>记录器当前可读库存，数值单位byte</td></tr><tr><td><code>supplyEnabled</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>供给启用</td></tr><tr><td><code>payloadReadRate</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>1/s</td><td>payloadRead速率 [1/s]</td></tr><tr><td><code>transmitterStatus</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>X波段发射状态</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>payloadDataRate</code></td><td>Real</td><td>载荷缓存读取率，数值单位byte/s</td><td><code>=6.25e6</code></td></tr><tr><td><code>minimumOperationalVoltage</code></td><td>Modelica.Units.SI.Voltage</td><td>平均值功放模型可用供电域下限，不代表硬件欠压规格</td><td><code>=6</code></td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] supplyEnabled=communicationPowerCommand;\n[equation] actualPowerAvailable=communicationPowerCommand and busVoltage &gt;= minimumOperationalVoltage and noEvent(powerAmplifierCurrent &gt; 0);\n[equation] payloadReadRate=if transmitCommand and actualPowerAvailable and activeGroundStationIndex &gt; 0 and groundLinkAttitudeReady and dataAvailable and noEvent(storedBytes &gt; 0) then payloadDataRate else 0;\n[equation] transmitterStatus=if actualPowerAvailable then 1 else 0;</pre><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>actualPowerAvailable</code></td><td>Boolean</td><td>protected</td><td>按声明/类型合同</td><td>命令已上电且功放支路真实取电</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Communication", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-57.32,-13.44},{-13.4,22.56}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Rectangle(extent={{-51.56,-6.96},{-19.88,15.36}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Polygon(points={{-43.64,-2.64},{-43.64,12.48},{-29.24,4.56},{-43.64,-2.64}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{-53.72,4.56},{-43.64,4.56}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-29.24,4.56},{-14.12,4.56}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-12.68,4.56},{8.92,4.56},{8.92,27.6}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Polygon(points={{-0.44,34.8},{8.92,21.84},{18.28,34.8},{-0.44,34.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Ellipse(extent={{-1.88,11.04},{19.72,32.64}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.65, startAngle=-35, endAngle=35),
      Ellipse(extent={{-8.36,4.56},{26.2,39.12}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.65, startAngle=-35, endAngle=35),
      Ellipse(extent={{-14.84,-1.92},{32.68,45.6}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.65, startAngle=-35, endAngle=35),
      Line(points={{-1.88,-16.32},{30.52,-16.32}}, color={73,112,158}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Text(extent={{-52.28,26.16},{-35.72,41.28}}, textString="X", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Rectangle(extent={{43,-31},{72,28}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{47,15},{68,15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,0},{68,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,-15},{68,-15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-57,-51},{37,-34}}, textString="bytes / s", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Downlink Data Gate", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-344,-174},{314,234}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-78.32,-85.36},{78.32,83.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-66.88,56.32},{66.88,56.32}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-73.92,60.72},{-56.32,78.32}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-53.68,62.48},{66.88,75.68}}, textString="Communication", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-50.4416,-11.8272},{-11.792,19.8528}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Rectangle(extent={{-45.3728,-6.1248},{-17.4944,13.5168}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Polygon(points={{-38.4032,-2.3232},{-38.4032,10.9824},{-25.7312,4.0128},{-38.4032,-2.3232}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{-47.2736,4.0128},{-38.4032,4.0128}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-25.7312,4.0128},{-12.4256,4.0128}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-11.1584,4.0128},{7.8496,4.0128},{7.8496,24.288}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Polygon(points={{-0.3872,30.624},{7.8496,19.2192},{16.0864,30.624},{-0.3872,30.624}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Ellipse(extent={{-1.6544,9.7152},{17.3536,28.7232}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.65, startAngle=-35, endAngle=35),
      Ellipse(extent={{-7.3568,4.0128},{23.056,34.4256}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.65, startAngle=-35, endAngle=35),
      Ellipse(extent={{-13.0592,-1.6896},{28.7584,40.128}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.65, startAngle=-35, endAngle=35),
      Line(points={{-1.6544,-14.3616},{26.8576,-14.3616}}, color={73,112,158}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Text(extent={{-46.0064,23.0208},{-31.4336,36.3264}}, textString="X", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Rectangle(extent={{37.84,-27.28},{63.36,24.64}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{41.36,13.2},{59.84,13.2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{41.36,0},{59.84,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{41.36,-13.2},{59.84,-13.2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-50.16,-44.88},{32.56,-29.92}}, textString="bytes / s", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-66.88,-51.04},{66.88,-51.04}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-70.4,-69.52},{70.4,-56.32}}, textString="Downlink Data Gate", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-318,146},{-223,164}}, textString="COMMAND", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-318,68},{-223,86}}, textString="DATA", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-318,-10},{-223,8}}, textString="GROUND LINK", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-318,-88},{-223,-70}}, textString="POWER", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-332,189},{302,218}}, textString="X Band Transmission", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-332,181},{302,181}}, color={215,220,226}, thickness=0.25)
    }));
end XBandTransmissionCalculation;