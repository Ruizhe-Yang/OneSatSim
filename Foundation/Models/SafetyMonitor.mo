within OneSatSim.Foundation.Models;
model SafetyMonitor "带回差的任务安全许可监视器"
  OneSatSim.Foundation.Interfaces.MissionFeedbackBus feedback  "反馈" annotation(Placement(visible=true, transformation(origin={-185,0}, extent={{-14,-14},{14,14}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.SafetySignals safety  "计算/接口量 safety" annotation(Placement(visible=true, transformation(origin={185,0}, extent={{-14,-14},{14,14}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  parameter Real SOC_safe_enter=0.30 "SOC安全模式enter" ;
  parameter Real SOC_safe_exit=0.40 "SOC安全模式exit" ;
  parameter Real SOC_critical=0.20 "配置项 SOC_critical" ;
  parameter Real V_safe_enter(unit="V")=10.8 "V安全模式enter [V]" ;
  parameter Real V_safe_exit(unit="V")=11.5 "V安全模式exit [V]" ;
  parameter Real imagingSOC=0.40 "成像SOC" ;
  parameter Real downlinkSOC=0.35 "下传SOC" ;
  parameter Real batteryTemperatureLow(unit="K")=263.15 "电池温度Low [K]" ;
  parameter Real batteryTemperatureHigh(unit="K")=318.15 "电池温度High [K]" ;
  parameter Real payloadTemperatureLow(unit="K")=273.15 "payload温度Low [K]" ;
  parameter Real payloadTemperatureHigh(unit="K")=313.15 "payload温度High [K]" ;
  parameter Real transmitterTemperatureHigh(unit="K")=338.15 "transmitter温度High [K]" ;
protected
  Boolean criticalUnsafe "计算/接口量 criticalUnsafe" ;
  Boolean recoveryConditions "计算/接口量 recoveryConditions" ;
  Boolean payloadTemperatureOperational "payload温度Operational" ;
  discrete Boolean unsafeLatched(start=false,fixed=true) "计算/接口量 unsafeLatched" ;
equation
  criticalUnsafe=feedback.batterySOC < SOC_safe_enter or feedback.busVoltage < V_safe_enter or feedback.batteryTemperature < batteryTemperatureLow or feedback.batteryTemperature > batteryTemperatureHigh or feedback.transmitterTemperature > transmitterTemperatureHigh;
  recoveryConditions=feedback.batterySOC > SOC_safe_exit and feedback.busVoltage > V_safe_exit and feedback.batteryTemperature > batteryTemperatureLow+2 and feedback.batteryTemperature < batteryTemperatureHigh-3 and feedback.payloadTemperature < payloadTemperatureHigh-3 and feedback.transmitterTemperature < transmitterTemperatureHigh-3;
  payloadTemperatureOperational=feedback.payloadTemperature >= payloadTemperatureLow and feedback.payloadTemperature <= payloadTemperatureHigh;
  safety.powerHealthy=feedback.batterySOC > downlinkSOC and feedback.busVoltage > 11.2;
  safety.thermalHealthy=feedback.batteryTemperature > batteryTemperatureLow and feedback.batteryTemperature < batteryTemperatureHigh and feedback.payloadTemperature < payloadTemperatureHigh and feedback.transmitterTemperature < transmitterTemperatureHigh;
  safety.attitudeHealthy=feedback.aocsAvailable;
  safety.storageHealthy=not feedback.storageFull;
  safety.spacecraftHealthy=safety.powerHealthy and safety.thermalHealthy and safety.attitudeHealthy;
  safety.imagingAllowed=feedback.batterySOC > imagingSOC and feedback.busVoltage > 11.4 and safety.thermalHealthy and payloadTemperatureOperational and safety.attitudeHealthy and not feedback.storageHigh and not unsafeLatched;
  safety.downlinkAllowed=feedback.batterySOC > downlinkSOC and feedback.busVoltage > 11.2 and safety.thermalHealthy and safety.attitudeHealthy and feedback.dataAvailable and not unsafeLatched;
  safety.safeModeRequired=unsafeLatched;
  safety.recoveryAllowed=not unsafeLatched and recoveryConditions;
  safety.safetyReason=if feedback.batterySOC <= SOC_critical then OneSatSim.Foundation.Types.RejectReason.LowSOC else 
    if feedback.batterySOC <= imagingSOC then OneSatSim.Foundation.Types.RejectReason.LowSOC else 
    if feedback.busVoltage <= 11.2 then OneSatSim.Foundation.Types.RejectReason.LowBusVoltage else 
    if not safety.thermalHealthy or not payloadTemperatureOperational then OneSatSim.Foundation.Types.RejectReason.ThermalLimit else 
    if feedback.storageHigh then OneSatSim.Foundation.Types.RejectReason.StorageFull else 
    if not feedback.dataAvailable then OneSatSim.Foundation.Types.RejectReason.NoData else 
    if not feedback.aocsAvailable then OneSatSim.Foundation.Types.RejectReason.AttitudeUnavailable else OneSatSim.Foundation.Types.RejectReason.None;
algorithm
  when initial() then
    unsafeLatched:=criticalUnsafe;
  elsewhen criticalUnsafe then
    unsafeLatched:=true;
  elsewhen recoveryConditions then
    unsafeLatched:=false;
  end when;
  annotation(Documentation(info="<html><h2>带回差的任务安全许可监视器</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Models.SafetyMonitor</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>带回差的任务安全许可监视器</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.MissionControlUnit\">OneSatSim.Components.MissionControlUnit</a> 的 <code>safety</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>feedback</code></td><td>OneSatSim.Foundation.Interfaces.MissionFeedbackBus</td><td>public</td><td>按声明/类型合同</td><td>反馈</td></tr><tr><td><code>safety</code></td><td>OneSatSim.Foundation.Interfaces.SafetySignals</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 safety</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>SOC_safe_enter</code></td><td>Real</td><td>SOC安全模式enter</td><td><code>=0.30</code></td></tr><tr><td><code>SOC_safe_exit</code></td><td>Real</td><td>SOC安全模式exit</td><td><code>=0.40</code></td></tr><tr><td><code>SOC_critical</code></td><td>Real</td><td>配置项 SOC_critical</td><td><code>=0.20</code></td></tr><tr><td><code>V_safe_enter</code></td><td>Real</td><td>V安全模式enter [V]</td><td><code>=10.8</code></td></tr><tr><td><code>V_safe_exit</code></td><td>Real</td><td>V安全模式exit [V]</td><td><code>=11.5</code></td></tr><tr><td><code>imagingSOC</code></td><td>Real</td><td>成像SOC</td><td><code>=0.40</code></td></tr><tr><td><code>downlinkSOC</code></td><td>Real</td><td>下传SOC</td><td><code>=0.35</code></td></tr><tr><td><code>batteryTemperatureLow</code></td><td>Real</td><td>电池温度Low [K]</td><td><code>=263.15</code></td></tr><tr><td><code>batteryTemperatureHigh</code></td><td>Real</td><td>电池温度High [K]</td><td><code>=318.15</code></td></tr><tr><td><code>payloadTemperatureLow</code></td><td>Real</td><td>payload温度Low [K]</td><td><code>=273.15</code></td></tr><tr><td><code>payloadTemperatureHigh</code></td><td>Real</td><td>payload温度High [K]</td><td><code>=313.15</code></td></tr><tr><td><code>transmitterTemperatureHigh</code></td><td>Real</td><td>transmitter温度High [K]</td><td><code>=338.15</code></td></tr></table><h3>状态与初始化</h3><p>本类源码中显式出现的导数对象或离散声明：<code>unsafeLatched</code>。初始化取当前声明的 start/fixed、initial 方程/算法及继承设置。此处是源码级说明，不等同于编译后连续状态统计。</p><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] criticalUnsafe=feedback.batterySOC &lt; SOC_safe_enter or feedback.busVoltage &lt; V_safe_enter or feedback.batteryTemperature &lt; batteryTemperatureLow or feedback.batteryTemperature &gt; batteryTemperatureHigh or feedback.transmitterTemperature &gt; transmitterTemperatureHigh;\n[equation] recoveryConditions=feedback.batterySOC &gt; SOC_safe_exit and feedback.busVoltage &gt; V_safe_exit and feedback.batteryTemperature &gt; batteryTemperatureLow+2 and feedback.batteryTemperature &lt; batteryTemperatureHigh-3 and feedback.payloadTemperature &lt; payloadTemperatureHigh-3 and feedback.transmitterTemperature &lt; transmitterTemperatureHigh-3;\n[equation] payloadTemperatureOperational=feedback.payloadTemperature &gt;= payloadTemperatureLow and feedback.payloadTemperature &lt;= payloadTemperatureHigh;\n[equation] safety.powerHealthy=feedback.batterySOC &gt; downlinkSOC and feedback.busVoltage &gt; 11.2;\n[equation] safety.thermalHealthy=feedback.batteryTemperature &gt; batteryTemperatureLow and feedback.batteryTemperature &lt; batteryTemperatureHigh and feedback.payloadTemperature &lt; payloadTemperatureHigh and feedback.transmitterTemperature &lt; transmitterTemperatureHigh;\n[equation] safety.attitudeHealthy=feedback.aocsAvailable;\n[equation] safety.storageHealthy=not feedback.storageFull;\n[equation] safety.spacecraftHealthy=safety.powerHealthy and safety.thermalHealthy and safety.attitudeHealthy;\n[equation] safety.imagingAllowed=feedback.batterySOC &gt; imagingSOC and feedback.busVoltage &gt; 11.4 and safety.thermalHealthy and payloadTemperatureOperational and safety.attitudeHealthy and not feedback.storageHigh and not unsafeLatched;\n[equation] safety.downlinkAllowed=feedback.batterySOC &gt; downlinkSOC and feedback.busVoltage &gt; 11.2 and safety.thermalHealthy and safety.attitudeHealthy and feedback.dataAvailable and not unsafeLatched;</pre><p>本类另有7段语句；阅读完整源码可查看其余边界与逻辑。</p><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>criticalUnsafe</code></td><td>Boolean</td><td>protected</td><td>按声明/类型合同</td><td>计算/接口量 criticalUnsafe</td></tr><tr><td><code>recoveryConditions</code></td><td>Boolean</td><td>protected</td><td>按声明/类型合同</td><td>计算/接口量 recoveryConditions</td></tr><tr><td><code>payloadTemperatureOperational</code></td><td>Boolean</td><td>protected</td><td>按声明/类型合同</td><td>payload温度Operational</td></tr><tr><td><code>unsafeLatched</code></td><td>Boolean</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 unsafeLatched</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={196,94,56}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-72,23},{-29,23},{0,1}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-72,-23},{-29,-23},{0,1}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Polygon(points={{0,23},{23,1},{0,-21},{-23,1},{0,23}}, lineColor={0,0,0}, fillColor={239,232,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{23,1},{38,1},{38,26},{65,26}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{38,1},{38,-27},{65,-27}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{58,34},{63,30},{71,40}}, color={83,131,109}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{60,-40},{70,-30}}, color={196,94,56}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{60,-30},{70,-40}}, color={196,94,56}, thickness=0.8, pattern=LinePattern.Solid),
      Polygon(points={{-19,47},{0,55},{19,47},{14,29},{0,20},{-14,29},{-19,47}}, lineColor={196,94,56}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{-8,39},{-1,32},{10,45}}, color={83,131,109}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Mission Safety Monitor", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-230,-89.8},{230,133.8}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-51.62,-56.26},{51.62,55.1}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-44.08,37.12},{44.08,37.12}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-48.72,40.02},{-37.12,51.62}}, lineColor={0,0,0}, fillColor={196,94,56}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-35.38,41.18},{44.08,49.88}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-41.76,13.34},{-16.82,13.34},{0,0.58}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-41.76,-13.34},{-16.82,-13.34},{0,0.58}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Polygon(points={{0,13.34},{13.34,0.58},{0,-12.18},{-13.34,0.58},{0,13.34}}, lineColor={0,0,0}, fillColor={239,232,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{13.34,0.58},{22.04,0.58},{22.04,15.08},{37.7,15.08}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{22.04,0.58},{22.04,-15.66},{37.7,-15.66}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{33.64,19.72},{36.54,17.4},{41.18,23.2}}, color={83,131,109}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{34.8,-23.2},{40.6,-17.4}}, color={196,94,56}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{34.8,-17.4},{40.6,-23.2}}, color={196,94,56}, thickness=0.8, pattern=LinePattern.Solid),
      Polygon(points={{-11.02,27.26},{0,31.9},{11.02,27.26},{8.12,16.82},{0,11.6},{-8.12,16.82},{-11.02,27.26}}, lineColor={196,94,56}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{-4.64,22.62},{-0.58,18.56},{5.8,26.1}}, color={83,131,109}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{-44.08,-33.64},{44.08,-33.64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-46.4,-45.82},{46.4,-37.12}}, textString="Mission Safety Monitor", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-218,88.8},{218,117.8}}, textString="Safety Monitor", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-218,80.8},{218,80.8}}, color={215,220,226}, thickness=0.25)
    }));
end SafetyMonitor;