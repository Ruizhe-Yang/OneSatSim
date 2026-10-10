within OneSatSim.Foundation.Calculations;
model StarTrackerCalculation "星敏任务门控与测量计算"
  parameter Modelica.Units.SI.Resistance activeResistance=51.9 "激活Resistance [Ohm]" ;
  OneSatSim.Foundation.Interfaces.ControlModeInput desiredControlMode  "desired控制模式" annotation(Placement(visible=true, transformation(origin={-225,45}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-12,-12},{12,12}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput quaternion[4]  "四元数" annotation(Placement(visible=true, transformation(origin={-225,-13}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput bodyRate[3](each unit="rad/s")  "机体系陀螺角速率 [rad/s]" annotation(Placement(visible=true, transformation(origin={-225,-45}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput active  "激活" annotation(Placement(visible=true, transformation(origin={225,77}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput loadConductance(unit="S")  "负载Conductance [S]" annotation(Placement(visible=true, transformation(origin={225,45}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,40}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput measuredQuaternion[4]  "measured四元数" annotation(Placement(visible=true, transformation(origin={225,-45}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput measuredBodyRate[3](each unit="rad/s")  "measured本体速率 [rad/s]" annotation(Placement(visible=true, transformation(origin={225,-77}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-40}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput status  "计算/接口量 status" annotation(Placement(visible=true, transformation(origin={225,13}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-6,-6},{6,6}}, rotation=0)));
equation
  active=desiredControlMode == OneSatSim.Foundation.Types.ControlMode.TargetPointing or 
    desiredControlMode == OneSatSim.Foundation.Types.ControlMode.GroundPointing;
  loadConductance=if active then 1/activeResistance else 0;
  measuredQuaternion=if active then quaternion else {0,0,0,0};
  measuredBodyRate=if active then bodyRate else {0,0,0};
  status=if active then 1 else 0;
  annotation(Documentation(info="<html><h2>星敏任务门控与测量计算</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Calculations.StarTrackerCalculation</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>星敏任务门控与测量计算</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.StarTrackerZUnit\">OneSatSim.Components.StarTrackerZUnit</a> 的 <code>trackerCalculation</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>desiredControlMode</code></td><td>OneSatSim.Foundation.Interfaces.ControlModeInput</td><td>public</td><td>按声明/类型合同</td><td>desired控制模式</td></tr><tr><td><code>quaternion[4]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>按声明/类型合同</td><td>四元数</td></tr><tr><td><code>bodyRate[3]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>rad/s</td><td>机体系陀螺角速率 [rad/s]</td></tr><tr><td><code>active</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>激活</td></tr><tr><td><code>loadConductance</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>S</td><td>负载Conductance [S]</td></tr><tr><td><code>measuredQuaternion[4]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>measured四元数</td></tr><tr><td><code>measuredBodyRate[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>rad/s</td><td>measured本体速率 [rad/s]</td></tr><tr><td><code>status</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 status</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>activeResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>激活Resistance [Ohm]</td><td><code>=51.9</code></td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] active=desiredControlMode == OneSatSim.Foundation.Types.ControlMode.TargetPointing or desiredControlMode == OneSatSim.Foundation.Types.ControlMode.GroundPointing;\n[equation] loadConductance=if active then 1/activeResistance else 0;\n[equation] measuredQuaternion=if active then quaternion else {0,0,0,0};\n[equation] measuredBodyRate=if active then bodyRate else {0,0,0};\n[equation] status=if active then 1 else 0;</pre></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Attitude sensing", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-51.56,-12},{-24.2,19.68}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Polygon(points={{-24.2,19.68},{-4.04,28.32},{-4.04,-18.48},{-24.2,-12},{-24.2,19.68}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Ellipse(extent={{-13.4,-18.48},{5.32,28.32}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.75, startAngle=0, endAngle=360),
      Ellipse(extent={{-9.08,-12},{1,21.84}}, lineColor={0,0,0}, fillColor={223,237,247}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{-6.2,-4.08},{-1.88,14.64}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Rectangle(extent={{-47.96,-16.32},{-28.52,-12.72}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, radius=0),
      Line(points={{5.32,25.44},{25.48,40.56}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Line(points={{5.32,-14.88},{32.68,-25.68}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Polygon(points={{22.6,31.2},{23.68,27.96},{26.92,26.88},{23.68,25.8},{22.6,22.56},{21.52,25.8},{18.28,26.88},{21.52,27.96},{22.6,31.2}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Polygon(points={{27.64,0.96},{28.54,-1.74},{31.24,-2.64},{28.54,-3.54},{27.64,-6.24},{26.74,-3.54},{24.04,-2.64},{26.74,-1.74},{27.64,0.96}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Polygon(points={{15.4,13.92},{16.12,11.76},{18.28,11.04},{16.12,10.32},{15.4,8.16},{14.68,10.32},{12.52,11.04},{14.68,11.76},{15.4,13.92}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Polygon(points={{-31.4,40.56},{-30.68,38.4},{-28.52,37.68},{-30.68,36.96},{-31.4,34.8},{-32.12,36.96},{-34.28,37.68},{-32.12,38.4},{-31.4,40.56}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Line(points={{-45.8,-1.92},{-29.24,-1.92}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-45.8,6},{-29.24,6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Text(extent={{-65.24,19.68},{-50.84,34.8}}, textString="Y", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Rectangle(extent={{43,-31},{72,28}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{47,15},{68,15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,0},{68,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,-15},{68,-15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-57,-51},{37,-34}}, textString="q / rate", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Star Measurement", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-269,-121},{269,165}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-66.75,-72.75},{66.75,71.25}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-57,48},{57,48}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-63,51.75},{-48,66.75}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-45.75,53.25},{57,64.5}}, textString="Attitude sensing", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-38.67,-9},{-18.15,14.76}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Polygon(points={{-18.15,14.76},{-3.03,21.24},{-3.03,-13.86},{-18.15,-9},{-18.15,14.76}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Ellipse(extent={{-10.05,-13.86},{3.99,21.24}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.75, startAngle=0, endAngle=360),
      Ellipse(extent={{-6.81,-9},{0.75,16.38}}, lineColor={0,0,0}, fillColor={223,237,247}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{-4.65,-3.06},{-1.41,10.98}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Rectangle(extent={{-35.97,-12.24},{-21.39,-9.54}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, radius=0),
      Line(points={{3.99,19.08},{19.11,30.42}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Line(points={{3.99,-11.16},{24.51,-19.26}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Polygon(points={{16.95,23.4},{17.76,20.97},{20.19,20.16},{17.76,19.35},{16.95,16.92},{16.14,19.35},{13.71,20.16},{16.14,20.97},{16.95,23.4}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Polygon(points={{20.73,0.72},{21.405,-1.305},{23.43,-1.98},{21.405,-2.655},{20.73,-4.68},{20.055,-2.655},{18.03,-1.98},{20.055,-1.305},{20.73,0.72}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Polygon(points={{11.55,10.44},{12.09,8.82},{13.71,8.28},{12.09,7.74},{11.55,6.12},{11.01,7.74},{9.39,8.28},{11.01,8.82},{11.55,10.44}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Polygon(points={{-23.55,30.42},{-23.01,28.8},{-21.39,28.26},{-23.01,27.72},{-23.55,26.1},{-24.09,27.72},{-25.71,28.26},{-24.09,28.8},{-23.55,30.42}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Line(points={{-34.35,-1.44},{-21.93,-1.44}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-34.35,4.5},{-21.93,4.5}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Text(extent={{-48.93,14.76},{-38.13,26.1}}, textString="Y", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Rectangle(extent={{32.25,-23.25},{54,21}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{35.25,11.25},{51,11.25}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{35.25,0},{51,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{35.25,-11.25},{51,-11.25}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-42.75,-38.25},{27.75,-25.5}}, textString="q / rate", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-57,-43.5},{57,-43.5}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-60,-59.25},{60,-48}}, textString="Star Measurement", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-257,120},{257,149}}, textString="Star Tracker", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-257,112},{257,112}}, color={215,220,226}, thickness=0.25)
    }));
end StarTrackerCalculation;