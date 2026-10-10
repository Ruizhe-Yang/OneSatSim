within OneSatSim.Foundation.Calculations;
model EarthObservationCameraCalculation "对地观测相机任务状态计算"
  parameter Real imagingDataRate(unit="1/s")=10e6 "成像数据速率 [1/s]" ;
  parameter Modelica.Units.SI.Resistance focalHeaterResistance=36 "焦面加热器电阻；Excel单位Ω，当前设计基线 [Ohm]" ;
  parameter Modelica.Units.SI.Voltage minimumOperationalVoltage=6
    "平均值功放模型可用供电域下限，不代表硬件欠压规格 [V]；Average-model support boundary, not a flight hardware specification";
  Modelica.Blocks.Interfaces.BooleanInput payloadPowered  "计算/接口量 payloadPowered" annotation(Placement(visible=true, transformation(origin={-225,61}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInput captureCommand  "capture指令" annotation(Placement(visible=true, transformation(origin={-225,29}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,26.666667}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput supplyVoltage(unit="V")
    "供给电压 [V]；Measured local 12 V supply" 
    annotation(Placement(visible=true, transformation(origin={-225,-29}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-26.666667}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput focalHeaterState  "focalHeater状态" annotation(Placement(visible=true, transformation(origin={-225,-61}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput status  "计算/接口量 status" annotation(Placement(visible=true, transformation(origin={225,77}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput payloadWriteRate  "payloadWrite速率" annotation(Placement(visible=true, transformation(origin={225,45}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,40}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput captureActive 
     "capture激活" annotation(Placement(visible=true, transformation(origin={225,13}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput powerAvailable 
     "功率Available" annotation(Placement(visible=true, transformation(origin={225,-45}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-40}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput focalHeaterConductance(unit="S")  "计算/接口量 focalHeaterConductance [S]" annotation(Placement(visible=true, transformation(origin={225,-77}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-6,-6},{6,6}}, rotation=0)));
equation
  powerAvailable=noEvent(supplyVoltage >= minimumOperationalVoltage);
  status=if payloadPowered and powerAvailable then 1 else 0;
  captureActive=payloadPowered and powerAvailable and captureCommand;
  payloadWriteRate=if captureActive then imagingDataRate else 0;
  focalHeaterConductance=if focalHeaterState == 170 then 1/focalHeaterResistance else 0;
  annotation(Documentation(info="<html><h2>对地观测相机任务状态计算</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Calculations.EarthObservationCameraCalculation</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>对地观测相机任务状态计算</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.EarthObservationCameraUnit\">OneSatSim.Components.EarthObservationCameraUnit</a> 的 <code>cameraCalculation</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>payloadPowered</code></td><td>Modelica.Blocks.Interfaces.BooleanInput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 payloadPowered</td></tr><tr><td><code>captureCommand</code></td><td>Modelica.Blocks.Interfaces.BooleanInput</td><td>public</td><td>按声明/类型合同</td><td>capture指令</td></tr><tr><td><code>supplyVoltage</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>V</td><td>供给电压 [V]；Measured local 12 V supply</td></tr><tr><td><code>focalHeaterState</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>focalHeater状态</td></tr><tr><td><code>status</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 status</td></tr><tr><td><code>payloadWriteRate</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>payloadWrite速率</td></tr><tr><td><code>captureActive</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>capture激活</td></tr><tr><td><code>powerAvailable</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>功率Available</td></tr><tr><td><code>focalHeaterConductance</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>S</td><td>计算/接口量 focalHeaterConductance [S]</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>imagingDataRate</code></td><td>Real</td><td>成像数据速率 [1/s]</td><td><code>=10e6</code></td></tr><tr><td><code>focalHeaterResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>焦面加热器电阻；Excel单位Ω，当前设计基线 [Ohm]</td><td><code>=36</code></td></tr><tr><td><code>minimumOperationalVoltage</code></td><td>Modelica.Units.SI.Voltage</td><td>平均值功放模型可用供电域下限，不代表硬件欠压规格 [V]；Average-model support boundary, not a flight hardware specification</td><td><code>=6</code></td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] powerAvailable=noEvent(supplyVoltage &gt;= minimumOperationalVoltage);\n[equation] status=if payloadPowered and powerAvailable then 1 else 0;\n[equation] captureActive=payloadPowered and powerAvailable and captureCommand;\n[equation] payloadWriteRate=if captureActive then imagingDataRate else 0;\n[equation] focalHeaterConductance=if focalHeaterState == 170 then 1/focalHeaterResistance else 0;</pre></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={152,118,71}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Payload logic", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-53,-13.44},{-17,26.16}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Polygon(points={{-17,24},{1,31.92},{1,-19.2},{-17,-10.56},{-17,24}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Ellipse(extent={{-6.92,-19.2},{11.08,31.92}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.75, startAngle=0, endAngle=360),
      Ellipse(extent={{-3.32,-12},{7.48,24}}, lineColor={0,0,0}, fillColor={224,237,246}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{0.28,-4.08},{4.6,16.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-50.12,-17.76},{-11.24,-17.76}}, color={0,0,0}, thickness=0.75, pattern=LinePattern.Solid),
      Rectangle(extent={{-44.36,9.6},{-26.36,19.68}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Ellipse(extent={{-49.256,-9.696},{-46.664,-7.104}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-48.608,-8.4},{-47.312,-8.4}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-24.776,-9.696},{-22.184,-7.104}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-24.128,-8.4},{-22.832,-8.4}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{16.8688,-19.8912},{35.5312,-1.2288}}, lineColor={0,0,0}, fillColor={239,246,250}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{22.46752,-19.8912},{29.93248,-1.2288}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Ellipse(extent={{16.8688,-13.82592},{35.5312,-7.29408}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Line(points={{16.8688,-10.56},{35.5312,-10.56}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{26.2,-19.8912},{26.2,-1.2288}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{11.08,18.96},{31.96,-1.92}}, color={73,112,158}, thickness=0.55, pattern=LinePattern.Dash),
      Line(points={{11.08,-8.4},{20.44,-20.64}}, color={73,112,158}, thickness=0.55, pattern=LinePattern.Dash),
      Line(points={{-44.36,14.64},{-35,14.64}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Rectangle(extent={{43,-31},{72,28}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{47,15},{68,15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,0},{68,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,-15},{68,-15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-57,-51},{37,-34}}, textString="capture", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Camera Capture Logic", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-269,-121},{269,165}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-66.75,-72.75},{66.75,71.25}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-57,48},{57,48}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-63,51.75},{-48,66.75}}, lineColor={0,0,0}, fillColor={152,118,71}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-45.75,53.25},{57,64.5}}, textString="Payload logic", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-39.75,-10.08},{-12.75,19.62}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Polygon(points={{-12.75,18},{0.75,23.94},{0.75,-14.4},{-12.75,-7.92},{-12.75,18}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Ellipse(extent={{-5.19,-14.4},{8.31,23.94}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.75, startAngle=0, endAngle=360),
      Ellipse(extent={{-2.49,-9},{5.61,18}}, lineColor={0,0,0}, fillColor={224,237,246}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{0.21,-3.06},{3.45,12.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-37.59,-13.32},{-8.43,-13.32}}, color={0,0,0}, thickness=0.75, pattern=LinePattern.Solid),
      Rectangle(extent={{-33.27,7.2},{-19.77,14.76}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Ellipse(extent={{-36.942,-7.272},{-34.998,-5.328}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-36.456,-6.3},{-35.484,-6.3}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-18.582,-7.272},{-16.638,-5.328}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-18.096,-6.3},{-17.124,-6.3}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{12.6516,-14.9184},{26.6484,-0.9216}}, lineColor={0,0,0}, fillColor={239,246,250}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{16.8506,-14.9184},{22.4494,-0.9216}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Ellipse(extent={{12.6516,-10.3694},{26.6484,-5.4706}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Line(points={{12.6516,-7.92},{26.6484,-7.92}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{19.65,-14.9184},{19.65,-0.9216}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{8.31,14.22},{23.97,-1.44}}, color={73,112,158}, thickness=0.55, pattern=LinePattern.Dash),
      Line(points={{8.31,-6.3},{15.33,-15.48}}, color={73,112,158}, thickness=0.55, pattern=LinePattern.Dash),
      Line(points={{-33.27,10.98},{-26.25,10.98}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Rectangle(extent={{32.25,-23.25},{54,21}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{35.25,11.25},{51,11.25}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{35.25,0},{51,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{35.25,-11.25},{51,-11.25}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-42.75,-38.25},{27.75,-25.5}}, textString="capture", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-57,-43.5},{57,-43.5}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-60,-59.25},{60,-48}}, textString="Camera Capture Logic", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-257,120},{257,149}}, textString="Earth Observation Camera", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-257,112},{257,112}}, color={215,220,226}, thickness=0.25)
    }));
end EarthObservationCameraCalculation;