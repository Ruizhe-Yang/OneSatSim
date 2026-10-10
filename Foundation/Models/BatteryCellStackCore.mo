within OneSatSim.Foundation.Models;
model BatteryCellStackCore "MSL-equivalent electrochemical cell stack with a public SOC connector"
  parameter Integer Ns(min=1)=1 "配置项 Ns；Series cells";
  parameter Integer Np(min=1)=1 "配置项 Np；Parallel cells";
  parameter Modelica.Electrical.Batteries.ParameterRecords.CellData cellData "任务级参数: 8.5 Ah per parallel cell" ;
  parameter Real initialSOC(min=0,max=1)=0.78 "场景初始SOC" ;
  parameter Real SOCtolerance=1e-9 "配置项 SOCtolerance" ;
  Modelica.Electrical.Analog.Interfaces.PositivePin p 
     "电气正端" annotation(Placement(visible=true, transformation(origin={-345,80}, extent={{-8,-8},{8,8}}, rotation=0), iconVisible=true, iconTransformation(origin={-80,95}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Electrical.Analog.Interfaces.NegativePin n 
     "电气负端" annotation(Placement(visible=true, transformation(origin={285,80}, extent={{-8,-8},{8,8}}, rotation=0), iconVisible=true, iconTransformation(origin={80,95}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort 
     "热流接口" annotation(Placement(visible=true, transformation(origin={285,-120}, extent={{-8,-8},{8,8}}, rotation=0), iconVisible=true, iconTransformation(origin={0,-97}, extent={{-5.76,-5.76},{5.76,5.76}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput SOC 
     "荷电状态" annotation(Placement(visible=true, transformation(origin={135,-245}, extent={{-8,-8},{8,8}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-5.76,-5.76},{5.76,5.76}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor 
     "电流传感器" annotation(Placement(visible=true, transformation(origin={-250,80}, extent={{-36,-36},{36,36}}, rotation=0)));
  Modelica.Blocks.Continuous.LimIntegrator limIntegrator(
    final k=1/(Np*cellData.Qnom),outMax=1-SOCtolerance,
    outMin=SOCtolerance,final initType=Modelica.Blocks.Types.Init.NoInit,
    y(start=initialSOC,fixed=true)) 
     "计算/接口量 limIntegrator" annotation(Placement(visible=true, transformation(origin={-250,-110}, extent={{-44,-44},{44,44}}, rotation=0)));
  Modelica.Blocks.Tables.CombiTable1Ds ocv_soc(
    final table=cellData.OCV_SOC_internal,
    final smoothness=cellData.smoothness,
    extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint) 
     "计算/接口量 ocv_soc" annotation(Placement(visible=true, transformation(origin={-70,-110}, extent={{-44,-44},{44,44}}, rotation=0)));
  Modelica.Blocks.Math.Gain gainV(final k=Ns*cellData.OCVmax) 
     "增益V" annotation(Placement(visible=true, transformation(origin={-80,245}, extent={{-36,-36},{36,36}}, rotation=270)));
  Modelica.Electrical.Analog.Sources.SignalVoltage ocv 
     "计算/接口量 ocv" annotation(Placement(visible=true, transformation(origin={-80,80}, extent={{-52,-52},{52,52}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Conductor selfDischarge(
    final G=Np*cellData.Idis/(Ns*cellData.OCVmax),T_ref=293.15,
    final useHeatPort=true) 
     "计算/接口量 selfDischarge" annotation(Placement(visible=true, transformation(origin={-225,245}, extent={{-30,-30},{30,30}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor r0(
    final R=Ns*cellData.Ri/Np,final T_ref=cellData.T_ref,
    final alpha=cellData.alpha,final useHeatPort=true) 
     "计算/接口量 r0" annotation(Placement(visible=true, transformation(origin={115,80}, extent={{-36,-36},{36,36}}, rotation=0)));
  BatteryCellLimits limits(cellData=cellData,SOCtolerance=SOCtolerance) 
     "电芯参数与荷电状态边界实例" annotation(Placement(visible=true, transformation(origin={-80,-245}, extent={{-32,-32},{32,32}}, rotation=0)));
equation
  connect(p,currentSensor.p) annotation(Line(points={{-345,80},{-286,80}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(currentSensor.n,ocv.p) annotation(Line(points={{-214,80},{-132,80}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(ocv.n,r0.p) annotation(Line(points={{-28,80},{79,80}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(r0.n,n) annotation(Line(points={{151,80},{285,80}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(p,selfDischarge.p) annotation(Line(points={{-345,80},{-385,80},{-385,245},{-255,245}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(ocv.n,selfDischarge.n) annotation(Line(points={{-28,80},{-18,80},{-18,142},{-185,142},{-185,245},{-195,245}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(selfDischarge.heatPort,heatPort) annotation(Line(points={{-225,215},{-225,205},{285,205},{285,-120}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(r0.heatPort,heatPort) annotation(Line(points={{115,44},{115,-120},{285,-120}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(currentSensor.i,limIntegrator.u) annotation(Line(points={{-250,40.4},{-250,30.4},{-325,30.4},{-325,-110},{-302.8,-110}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(limIntegrator.y,ocv_soc.u) annotation(Line(points={{-201.6,-110},{-122.8,-110}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(ocv_soc.y[1],gainV.u) annotation(Line(points={{-21.6,-110},{-11.6,-110},{-11.6,298.2},{-80,298.2},{-80,288.2}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(gainV.y,ocv.v) annotation(Line(points={{-80,205.4},{-80,142.4}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(limIntegrator.y,SOC) annotation(Line(points={{-201.6,-110},{-191.6,-110},{-191.6,-204.6},{135,-204.6},{135,-245}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(limIntegrator.y,limits.u) annotation(Line(points={{-201.6,-110},{-118.48,-110},{-118.48,-245},{-108.48,-245}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>带公开荷电状态接口的电池组</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Models.BatteryCellStackCore</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>保留原电池组电化学等效网络及唯一荷电状态，以公开SOC连接器向上层提供状态；电芯限制由现有配套部件处理。</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.BatteryUnit\">OneSatSim.Components.BatteryUnit</a> 的 <code>cells</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>p</code></td><td>Modelica.Electrical.Analog.Interfaces.PositivePin</td><td>public</td><td>按声明/类型合同</td><td>电气正端</td></tr><tr><td><code>n</code></td><td>Modelica.Electrical.Analog.Interfaces.NegativePin</td><td>public</td><td>按声明/类型合同</td><td>电气负端</td></tr><tr><td><code>heatPort</code></td><td>Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a</td><td>public</td><td>按声明/类型合同</td><td>热流接口</td></tr><tr><td><code>SOC</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>荷电状态</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>Ns</code></td><td>Integer</td><td>配置项 Ns；Series cells</td><td><code>=1</code></td></tr><tr><td><code>Np</code></td><td>Integer</td><td>配置项 Np；Parallel cells</td><td><code>=1</code></td></tr><tr><td><code>cellData</code></td><td>Modelica.Electrical.Batteries.ParameterRecords.CellData</td><td>任务级参数: 8.5 Ah per parallel cell</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>initialSOC</code></td><td>Real</td><td>场景初始SOC</td><td><code>=0.78</code></td></tr><tr><td><code>SOCtolerance</code></td><td>Real</td><td>配置项 SOCtolerance</td><td><code>=1e-9</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>currentSensor</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Sensors.CurrentSensor\">Modelica.Electrical.Analog.Sensors.CurrentSensor</a></td><td>电流传感器</td></tr><tr><td><code>limIntegrator</code></td><td><a href=\"modelica://Modelica.Blocks.Continuous.LimIntegrator\">Modelica.Blocks.Continuous.LimIntegrator</a></td><td>计算/接口量 limIntegrator</td></tr><tr><td><code>ocv_soc</code></td><td><a href=\"modelica://Modelica.Blocks.Tables.CombiTable1Ds\">Modelica.Blocks.Tables.CombiTable1Ds</a></td><td>计算/接口量 ocv_soc</td></tr><tr><td><code>gainV</code></td><td><a href=\"modelica://Modelica.Blocks.Math.Gain\">Modelica.Blocks.Math.Gain</a></td><td>增益V</td></tr><tr><td><code>ocv</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Sources.SignalVoltage\">Modelica.Electrical.Analog.Sources.SignalVoltage</a></td><td>计算/接口量 ocv</td></tr><tr><td><code>selfDischarge</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 selfDischarge</td></tr><tr><td><code>r0</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Resistor\">Modelica.Electrical.Analog.Basic.Resistor</a></td><td>计算/接口量 r0</td></tr><tr><td><code>limits</code></td><td><a href=\"modelica://OneSatSim.Foundation.Models.BatteryCellLimits\">OneSatSim.Foundation.Models.BatteryCellLimits</a></td><td>电芯参数与荷电状态边界实例</td></tr></table><h3>使用边界</h3><p>本工程的轨道环境采用离线固化数据；任务、姿态、电热及信息边界按当前配置和接口使用。已有未完成任务目标与平台状态见根README，不由本次注释更新改写。</p></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={77,126,172}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-58.04,-17.04},{21.16,31.2}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Rectangle(extent={{-51.56,-8.4},{-38.6,8.16}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{-47.24,8.16},{-42.92,10.32}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-47.96,3.12},{-42.2,3.12}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-45.08,0.24},{-45.08,6}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{-33.56,-8.4},{-20.6,8.16}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{-29.24,8.16},{-24.92,10.32}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-29.96,3.12},{-24.2,3.12}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-27.08,0.24},{-27.08,6}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{-15.56,-8.4},{-2.6,8.16}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{-11.24,8.16},{-6.92,10.32}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-11.96,3.12},{-6.2,3.12}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-9.08,0.24},{-9.08,6}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{2.44,-8.4},{15.4,8.16}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{6.76,8.16},{11.08,10.32}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{6.04,3.12},{11.8,3.12}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{8.92,0.24},{8.92,6}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-51.56,-10.56},{15.4,-10.56}}, color={77,126,172}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{-51.56,12.48},{-38.6,29.04}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{-47.24,29.04},{-42.92,31.2}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-47.96,24},{-42.2,24}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-45.08,21.12},{-45.08,26.88}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{-33.56,12.48},{-20.6,29.04}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{-29.24,29.04},{-24.92,31.2}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-29.96,24},{-24.2,24}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-27.08,21.12},{-27.08,26.88}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{-15.56,12.48},{-2.6,29.04}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{-11.24,29.04},{-6.92,31.2}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-11.96,24},{-6.2,24}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-9.08,21.12},{-9.08,26.88}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{2.44,12.48},{15.4,29.04}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{6.76,29.04},{11.08,31.2}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{6.04,24},{11.8,24}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{8.92,21.12},{8.92,26.88}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-51.56,10.32},{15.4,10.32}}, color={77,126,172}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-61.64,19.68},{-68.84,19.68},{-68.84,-7.68},{-61.64,-7.68}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{23.32,19.68},{31.96,19.68}}, color={77,126,172}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{23.32,-6.96},{31.96,-6.96}}, color={77,126,172}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{26.92,24.72},{31.96,24.72}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{29.08,22.56},{29.08,26.88}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-50.12,-24.24},{-42.92,-24.24},{-40.04,-19.92},{-34.28,-27.84},{-28.52,-19.92},{-22.76,-27.84},{-17,-19.92},{-11.24,-24.24},{-1.88,-24.24}}, color={196,94,56}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{43,-31},{72,28}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{47,15},{68,15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,0},{68,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,-15},{68,-15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-57,-51},{37,-34}}, textString="SOC / OCV", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Battery Cell Stack", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-411,-315},{331,397}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-375,161},{-207,179}}, textString="ELECTRICAL TERMINALS", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-275,309},{-107,327}}, textString="SELF DISCHARGE / OCV", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-315,-41},{-189,-23}}, textString="STATE OF CHARGE", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-399,352},{319,381}}, textString="Battery Cell Stack", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-399,344},{319,344}}, color={215,220,226}, thickness=0.25)
    }));
end BatteryCellStackCore;