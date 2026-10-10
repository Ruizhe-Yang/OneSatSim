within OneSatSim.Foundation.Calculations;
model ReactionWheelPowerCalculation "反作用飞轮平均值机电热功率计算"
  parameter Real etaMotor(min=0.1,max=1)=1
    "电动工况平均效率；缺少器件数据时取1作为透明功率闭合基线";
  parameter Modelica.Units.SI.Voltage minimumBusVoltage=6
    "平均电机模型的最低已支持母线电压，不代表器件欠压规格";
  Modelica.Blocks.Interfaces.RealInput motorTorque(unit="N.m") 
     "电机Torque [N.m]" annotation(Placement(visible=true, transformation(origin={-225,45}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput angularVelocity(unit="rad/s") 
     "计算/接口量 angularVelocity [rad/s]" annotation(Placement(visible=true, transformation(origin={-225,13}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput busVoltage(unit="V") 
     "12/5/3.3V轨实测 [V]" annotation(Placement(visible=true, transformation(origin={-225,-45}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput mechanicalPower(unit="W") 
     "机械功率 [W]" annotation(Placement(visible=true, transformation(origin={225,61}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput dynamicElectricalPower(unit="W") 
     "dynamicElectrical功率 [W]" annotation(Placement(visible=true, transformation(origin={225,29}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,26.666667}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput dynamicCurrentCommand(unit="A") 
     "dynamic电流指令 [A]" annotation(Placement(visible=true, transformation(origin={225,-29}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-26.666667}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput dynamicLossHeat(unit="W") 
     "dynamicLoss热流 [W]" annotation(Placement(visible=true, transformation(origin={225,-61}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-6,-6},{6,6}}, rotation=0)));
equation
  mechanicalPower=motorTorque*angularVelocity;
  dynamicElectricalPower=noEvent(if mechanicalPower > 0 then mechanicalPower/etaMotor else 0);
  dynamicCurrentCommand=if busVoltage >= minimumBusVoltage then 
    dynamicElectricalPower/busVoltage else 0;
  dynamicLossHeat=dynamicElectricalPower-mechanicalPower;
  assert(noEvent(busVoltage >= minimumBusVoltage or dynamicElectricalPower <= 1e-9),
    "Reaction wheel positive shaft power requested outside supported bus-voltage domain",
    level=AssertionLevel.error);
  annotation(Documentation(info="<html><h2>反作用飞轮平均值机电热功率计算</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Calculations.ReactionWheelPowerCalculation</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>反作用飞轮平均值机电热功率计算</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.ReactionWheelSUnit\">OneSatSim.Components.ReactionWheelSUnit</a> 的 <code>powerCalculation</code>；<a href=\"modelica://OneSatSim.Components.ReactionWheelXUnit\">OneSatSim.Components.ReactionWheelXUnit</a> 的 <code>powerCalculation</code>；<a href=\"modelica://OneSatSim.Components.ReactionWheelYUnit\">OneSatSim.Components.ReactionWheelYUnit</a> 的 <code>powerCalculation</code>；<a href=\"modelica://OneSatSim.Components.ReactionWheelZUnit\">OneSatSim.Components.ReactionWheelZUnit</a> 的 <code>powerCalculation</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>motorTorque</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>N.m</td><td>电机Torque [N.m]</td></tr><tr><td><code>angularVelocity</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>rad/s</td><td>计算/接口量 angularVelocity [rad/s]</td></tr><tr><td><code>busVoltage</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>V</td><td>12/5/3.3V轨实测 [V]</td></tr><tr><td><code>mechanicalPower</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>W</td><td>机械功率 [W]</td></tr><tr><td><code>dynamicElectricalPower</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>W</td><td>dynamicElectrical功率 [W]</td></tr><tr><td><code>dynamicCurrentCommand</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>A</td><td>dynamic电流指令 [A]</td></tr><tr><td><code>dynamicLossHeat</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>W</td><td>dynamicLoss热流 [W]</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>etaMotor</code></td><td>Real</td><td>电动工况平均效率；缺少器件数据时取1作为透明功率闭合基线</td><td><code>=1</code></td></tr><tr><td><code>minimumBusVoltage</code></td><td>Modelica.Units.SI.Voltage</td><td>平均电机模型的最低已支持母线电压，不代表器件欠压规格</td><td><code>=6</code></td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] mechanicalPower=motorTorque*angularVelocity;\n[equation] dynamicElectricalPower=noEvent(if mechanicalPower &gt; 0 then mechanicalPower/etaMotor else 0);\n[equation] dynamicCurrentCommand=if busVoltage &gt;= minimumBusVoltage then dynamicElectricalPower/busVoltage else 0;\n[equation] dynamicLossHeat=dynamicElectricalPower-mechanicalPower;\n[equation] assert(noEvent(busVoltage &gt;= minimumBusVoltage or dynamicElectricalPower &lt;= 1e-9), &quot;Reaction wheel positive shaft power requested outside supported bus-voltage domain&quot;, level=AssertionLevel.error);</pre></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={77,126,172}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Power calculation", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-56.6,-20.64},{14.68,-14.88}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Rectangle(extent={{-43.64,-15.6},{-36.44,-7.68}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Rectangle(extent={{1.72,-15.6},{8.92,-7.68}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Ellipse(extent={{-51.56,-10.56},{14.68,31.2}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, startAngle=0, endAngle=360),
      Ellipse(extent={{-45.8,-6.96},{8.92,26.88}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-36.44,-1.2},{-0.44,22.56}}, lineColor={0,0,0}, fillColor={234,240,244}, fillPattern=FillPattern.Solid, lineThickness=0.55, startAngle=0, endAngle=360),
      Ellipse(extent={{-25.64,3.84},{-11.24,16.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-21.32,6.72},{-15.56,13.92}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-10.52,10.32},{6.04,10.32}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-12.839714,13.883818},{-1.130026,20.502338}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-18.44,15.36},{-18.44,24.72}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-24.040286,13.883818},{-35.749974,20.502338}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-26.36,10.32},{-42.92,10.32}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-24.040286,6.756182},{-35.749974,0.137662}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-18.44,5.28},{-18.44,-4.08}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-12.839714,6.756182},{-1.130026,0.137662}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-40.04,36.24},{-26.36,41.28},{-8.36,39.84},{3.88,34.8}}, color={76,128,143}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Ellipse(extent={{-53,-19.2},{-50.12,-16.32}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-52.28,-17.76},{-50.84,-17.76}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{8.2,-19.2},{11.08,-16.32}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{8.92,-17.76},{10.36,-17.76}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{21.88,-9.12},{35.56,-9.12}}, color={76,128,143}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{21.88,-9.12},{14.7664,-0.3648}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{21.88,-9.12},{21.88,4.56}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Text(extent={{16.84,20.4},{34.84,35.52}}, textString="X", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Rectangle(extent={{43,-31},{72,28}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{47,15},{68,15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,0},{68,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,-15},{68,-15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-57,-51},{37,-34}}, textString="P = torque * w", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Wheel Power and Heat", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-269,-108.5},{269,152.5}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-66.75,-72.75},{66.75,71.25}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-57,48},{57,48}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-63,51.75},{-48,66.75}}, lineColor={0,0,0}, fillColor={77,126,172}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-45.75,53.25},{57,64.5}}, textString="Power calculation", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-42.45,-15.48},{11.01,-11.16}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Rectangle(extent={{-32.73,-11.7},{-27.33,-5.76}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Rectangle(extent={{1.29,-11.7},{6.69,-5.76}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Ellipse(extent={{-38.67,-7.92},{11.01,23.4}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, startAngle=0, endAngle=360),
      Ellipse(extent={{-34.35,-5.22},{6.69,20.16}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-27.33,-0.9},{-0.33,16.92}}, lineColor={0,0,0}, fillColor={234,240,244}, fillPattern=FillPattern.Solid, lineThickness=0.55, startAngle=0, endAngle=360),
      Ellipse(extent={{-19.23,2.88},{-8.43,12.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-15.99,5.04},{-11.67,10.44}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-7.89,7.74},{4.53,7.74}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-9.6298,10.4129},{-0.8475,15.3768}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-13.83,11.52},{-13.83,18.54}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-18.0302,10.4129},{-26.8125,15.3768}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-19.77,7.74},{-32.19,7.74}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-18.0302,5.0671},{-26.8125,0.1032}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-13.83,3.96},{-13.83,-3.06}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-9.6298,5.0671},{-0.8475,0.1032}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-30.03,27.18},{-19.77,30.96},{-6.27,29.88},{2.91,26.1}}, color={76,128,143}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Ellipse(extent={{-39.75,-14.4},{-37.59,-12.24}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-39.21,-13.32},{-38.13,-13.32}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{6.15,-14.4},{8.31,-12.24}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{6.69,-13.32},{7.77,-13.32}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{16.41,-6.84},{26.67,-6.84}}, color={76,128,143}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{16.41,-6.84},{11.0748,-0.2736}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{16.41,-6.84},{16.41,3.42}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Text(extent={{12.63,15.3},{26.13,26.64}}, textString="X", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Rectangle(extent={{32.25,-23.25},{54,21}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{35.25,11.25},{51,11.25}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{35.25,0},{51,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{35.25,-11.25},{51,-11.25}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-42.75,-38.25},{27.75,-25.5}}, textString="P = torque * w", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-57,-43.5},{57,-43.5}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-60,-59.25},{60,-48}}, textString="Wheel Power and Heat", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-257,107.5},{257,136.5}}, textString="Reaction Wheel Power", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-257,99.5},{257,99.5}}, color={215,220,226}, thickness=0.25)
    }));
end ReactionWheelPowerCalculation;