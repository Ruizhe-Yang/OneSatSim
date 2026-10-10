within OneSatSim.Foundation.Calculations;
model MagnetometerCalculation "三轴轨道磁场低阶计算"
  parameter Real fieldXAmplitude(unit="T")=25e-6 "X轴磁场基准幅值 [T]" ;
  parameter Real fieldYAmplitude(unit="T")=18e-6 "Y轴磁场基准幅值 [T]" ;
  parameter Real fieldZAmplitude(unit="T")=34e-6 "Z轴磁场基准幅值 [T]" ;
  parameter Modelica.Units.SI.Radius earthRadius=6378137 "地球参考半径" ;
  parameter Modelica.Units.SI.Time magneticFieldPeriod=5624.1 "轨道磁场近似周期 [s]" ;
  Modelica.Blocks.Interfaces.RealInput instantaneousAltitude(unit="m")  "瞬时ECI位置模长减参考地球半径 [m]" annotation(Placement(visible=true, transformation(origin={-185,0}, extent={{-7,-7},{7,7}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-5.76,-5.76},{5.76,5.76}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput magneticField[3](each unit="T")  "计算/接口量 magneticField [T]" annotation(Placement(visible=true, transformation(origin={185,0}, extent={{-7,-7},{7,7}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-5.76,-5.76},{5.76,5.76}}, rotation=0)));
equation
  magneticField[1]=fieldXAmplitude*(earthRadius/(earthRadius+instantaneousAltitude))^3*cos(2*Modelica.Constants.pi*time/magneticFieldPeriod);
  magneticField[2]=fieldYAmplitude*(earthRadius/(earthRadius+instantaneousAltitude))^3*sin(2*Modelica.Constants.pi*time/magneticFieldPeriod);
  magneticField[3]=fieldZAmplitude*(earthRadius/(earthRadius+instantaneousAltitude))^3;
  annotation(Documentation(info="<html><h2>三轴轨道磁场低阶计算</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Calculations.MagnetometerCalculation</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>三轴轨道磁场低阶计算</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.MagnetometerUnit\">OneSatSim.Components.MagnetometerUnit</a> 的 <code>fieldCalculation</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>instantaneousAltitude</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>m</td><td>瞬时ECI位置模长减参考地球半径 [m]</td></tr><tr><td><code>magneticField[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>T</td><td>计算/接口量 magneticField [T]</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>fieldXAmplitude</code></td><td>Real</td><td>X轴磁场基准幅值 [T]</td><td><code>=25e-6</code></td></tr><tr><td><code>fieldYAmplitude</code></td><td>Real</td><td>Y轴磁场基准幅值 [T]</td><td><code>=18e-6</code></td></tr><tr><td><code>fieldZAmplitude</code></td><td>Real</td><td>Z轴磁场基准幅值 [T]</td><td><code>=34e-6</code></td></tr><tr><td><code>earthRadius</code></td><td>Modelica.Units.SI.Radius</td><td>地球参考半径</td><td><code>=6378137</code></td></tr><tr><td><code>magneticFieldPeriod</code></td><td>Modelica.Units.SI.Time</td><td>轨道磁场近似周期 [s]</td><td><code>=5624.1</code></td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] magneticField[1]=fieldXAmplitude*(earthRadius/(earthRadius+instantaneousAltitude))^3*cos(2*Modelica.Constants.pi*time/magneticFieldPeriod);\n[equation] magneticField[2]=fieldYAmplitude*(earthRadius/(earthRadius+instantaneousAltitude))^3*sin(2*Modelica.Constants.pi*time/magneticFieldPeriod);\n[equation] magneticField[3]=fieldZAmplitude*(earthRadius/(earthRadius+instantaneousAltitude))^3;</pre></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Field calculation", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-35,-10.56},{-1.16,21.12}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=0),
      Rectangle(extent={{-29.24,-4.8},{-6.92,15.36}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, radius=0),
      Line(points={{-18.44,4.56},{8.92,4.56}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-18.44,4.56},{-32.6672,22.0704}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-18.44,4.56},{-18.44,31.92}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-63.08,-20.64},{-42.92,-17.04},{-4.76,-17.04},{25.48,-20.64}}, color={76,128,143}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{-63.08,31.2},{-42.92,34.8},{-4.76,34.8},{25.48,31.2}}, color={76,128,143}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Ellipse(extent={{-33.2,-8.76},{-31.04,-6.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-32.66,-7.68},{-31.58,-7.68}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-5.12,-8.76},{-2.96,-6.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-4.58,-7.68},{-3.5,-7.68}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-33.2,17.16},{-31.04,19.32}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-32.66,18.24},{-31.58,18.24}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-5.12,17.16},{-2.96,19.32}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-4.58,18.24},{-3.5,18.24}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{43,-31},{72,28}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{47,15},{68,15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,0},{68,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,-15},{68,-15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-57,-51},{37,-34}}, textString="B(r,t)", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Orbital Magnetic Field", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-230,-89.8},{230,133.8}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-51.62,-56.26},{51.62,55.1}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-44.08,37.12},{44.08,37.12}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-48.72,40.02},{-37.12,51.62}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-35.38,41.18},{44.08,49.88}}, textString="Field calculation", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-20.3,-6.1248},{-0.6728,12.2496}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=0),
      Rectangle(extent={{-16.9592,-2.784},{-4.0136,8.9088}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, radius=0),
      Line(points={{-10.6952,2.6448},{5.1736,2.6448}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-10.6952,2.6448},{-18.947,12.8008}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-10.6952,2.6448},{-10.6952,18.5136}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-36.5864,-11.9712},{-24.8936,-9.8832},{-2.7608,-9.8832},{14.7784,-11.9712}}, color={76,128,143}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{-36.5864,18.096},{-24.8936,20.184},{-2.7608,20.184},{14.7784,18.096}}, color={76,128,143}, thickness=0.6, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Ellipse(extent={{-19.256,-5.0808},{-18.0032,-3.828}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-18.9428,-4.4544},{-18.3164,-4.4544}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-2.9696,-5.0808},{-1.7168,-3.828}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-2.6564,-4.4544},{-2.03,-4.4544}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-19.256,9.9528},{-18.0032,11.2056}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-18.9428,10.5792},{-18.3164,10.5792}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-2.9696,9.9528},{-1.7168,11.2056}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-2.6564,10.5792},{-2.03,10.5792}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{24.94,-17.98},{41.76,16.24}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{27.26,8.7},{39.44,8.7}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{27.26,0},{39.44,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{27.26,-8.7},{39.44,-8.7}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-33.06,-29.58},{21.46,-19.72}}, textString="B(r,t)", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-44.08,-33.64},{44.08,-33.64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-46.4,-45.82},{46.4,-37.12}}, textString="Orbital Magnetic Field", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-218,88.8},{218,117.8}}, textString="Magnetometer", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-218,80.8},{218,80.8}}, color={215,220,226}, thickness=0.25)
    }));
end MagnetometerCalculation;