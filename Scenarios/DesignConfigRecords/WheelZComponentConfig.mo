within OneSatSim.Scenarios.DesignConfigRecords;
record WheelZComponentConfig "wheelZ硬件设计配置"
  parameter Modelica.Units.SI.AngularVelocity SpeedLimit
    "飞轮最大转速；Excel工程单位rad/s";
  parameter Real MotorEfficiency
    "平均电机效率；Excel工程单位1";
  parameter Modelica.Units.SI.Resistance StandbyResistance
    "飞轮驱动电子学待机电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.Torque MaxTorque
    "飞轮最大轴力矩；Excel工程单位N·m";
  parameter Modelica.Units.SI.Inertia RotorInertia
    "飞轮转子惯量；Excel工程单位kg·m²";
  parameter Real BearingDamping(unit="N.m.s/rad")
    "轴承等效黏性阻尼；Excel工程单位N·m·s/rad";
  parameter Modelica.Units.SI.HeatCapacity HeatCapacity
    "飞轮等效热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.ThermalConductance MountConductance
    "飞轮安装导热；Excel工程单位W/K";
  parameter Real Axis_X
    "飞轮转轴方向X；Excel工程单位1";
  parameter Real Axis_Y
    "飞轮转轴方向Y；Excel工程单位1";
  parameter Real Axis_Z
    "飞轮转轴方向Z；Excel工程单位1";
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
  annotation(Documentation(info="<html><h2>wheelZ硬件设计配置</h2><p><b>类路径：</b><code>OneSatSim.Scenarios.DesignConfigRecords.WheelZComponentConfig</code>　<b>类型：</b>record</p><h3>用途与定位</h3><p>wheelZ硬件设计配置</p><h3>配置与调用</h3><p>由使用者声明或传入本类型；记录与常量保存静态配置，不单独代表一套物理状态。修改设计输入后应通过项目既有离线配置入口生成生效快照。</p><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>SpeedLimit</code></td><td>Modelica.Units.SI.AngularVelocity</td><td>飞轮最大转速；Excel工程单位rad/s</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>MotorEfficiency</code></td><td>Real</td><td>平均电机效率；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>StandbyResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>飞轮驱动电子学待机电阻；Excel工程单位Ω</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>MaxTorque</code></td><td>Modelica.Units.SI.Torque</td><td>飞轮最大轴力矩；Excel工程单位N·m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RotorInertia</code></td><td>Modelica.Units.SI.Inertia</td><td>飞轮转子惯量；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>BearingDamping</code></td><td>Real</td><td>轴承等效黏性阻尼；Excel工程单位N·m·s/rad</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>HeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>飞轮等效热容；Excel工程单位J/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>MountConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>飞轮安装导热；Excel工程单位W/K</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Axis_X</code></td><td>Real</td><td>飞轮转轴方向X；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Axis_Y</code></td><td>Real</td><td>飞轮转轴方向Y；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Axis_Z</code></td><td>Real</td><td>飞轮转轴方向Z；Excel工程单位1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel工程单位kg</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>RCM_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel工程单位m</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>Inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel工程单位kg·m²</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-36,-10.2},{23.4,-5.4}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Rectangle(extent={{-25.2,-6},{-19.2,0.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Rectangle(extent={{12.6,-6},{18.6,0.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Ellipse(extent={{-31.8,-1.8},{23.4,33}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, startAngle=0, endAngle=360),
      Ellipse(extent={{-27,1.2},{18.6,29.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-19.2,6},{10.8,25.8}}, lineColor={0,0,0}, fillColor={234,240,244}, fillPattern=FillPattern.Solid, lineThickness=0.55, startAngle=0, endAngle=360),
      Ellipse(extent={{-10.2,10.2},{1.8,21}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-6.6,12.6},{-1.8,18.6}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{2.4,15.6},{16.2,15.6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{0.466905,18.569848},{10.224979,24.085282}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-4.2,19.8},{-4.2,27.6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-8.866905,18.569848},{-18.624979,24.085282}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-10.8,15.6},{-24.6,15.6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-8.866905,12.630152},{-18.624979,7.114718}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-4.2,11.4},{-4.2,3.6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{0.466905,12.630152},{10.224979,7.114718}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-22.2,37.2},{-10.8,41.4},{4.2,40.2},{14.4,36}}, color={76,128,143}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Ellipse(extent={{-33,-9},{-30.6,-6.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-32.4,-7.8},{-31.2,-7.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{18,-9},{20.4,-6.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{18.6,-7.8},{19.8,-7.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{29.4,-0.6},{40.8,-0.6}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{29.4,-0.6},{23.472,6.696}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{29.4,-0.6},{29.4,10.8}}, color={76,128,143}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Text(extent={{25.2,24},{40.2,36.6}}, textString="Z", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Z Wheel Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Hardware record", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-36,-10.2},{23.4,-5.4}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Rectangle(extent={{-25.2,-6},{-19.2,0.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Rectangle(extent={{12.6,-6},{18.6,0.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Ellipse(extent={{-31.8,-1.8},{23.4,33}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, startAngle=0, endAngle=360),
      Ellipse(extent={{-27,1.2},{18.6,29.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-19.2,6},{10.8,25.8}}, lineColor={0,0,0}, fillColor={234,240,244}, fillPattern=FillPattern.Solid, lineThickness=0.55, startAngle=0, endAngle=360),
      Ellipse(extent={{-10.2,10.2},{1.8,21}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-6.6,12.6},{-1.8,18.6}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{2.4,15.6},{16.2,15.6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{0.466905,18.569848},{10.224979,24.085282}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-4.2,19.8},{-4.2,27.6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-8.866905,18.569848},{-18.624979,24.085282}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-10.8,15.6},{-24.6,15.6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-8.866905,12.630152},{-18.624979,7.114718}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-4.2,11.4},{-4.2,3.6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{0.466905,12.630152},{10.224979,7.114718}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-22.2,37.2},{-10.8,41.4},{4.2,40.2},{14.4,36}}, color={76,128,143}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Ellipse(extent={{-33,-9},{-30.6,-6.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-32.4,-7.8},{-31.2,-7.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{18,-9},{20.4,-6.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{18.6,-7.8},{19.8,-7.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{29.4,-0.6},{40.8,-0.6}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{29.4,-0.6},{23.472,6.696}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{29.4,-0.6},{29.4,10.8}}, color={76,128,143}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Text(extent={{25.2,24},{40.2,36.6}}, textString="Z", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Z Wheel Data", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));
end WheelZComponentConfig;