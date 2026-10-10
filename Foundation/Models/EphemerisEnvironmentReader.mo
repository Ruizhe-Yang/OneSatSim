within OneSatSim.Foundation.Models;
model EphemerisEnvironmentReader "Single generated environment table and signal adapter"
  import SI=Modelica.Units.SI;
  parameter SI.Time simulationDuration "生成环境覆盖的仿真时长 [s]" ;
  parameter Integer tableRows(min=2) "配置项 tableRows" ;
  OneSatSim.Foundation.Interfaces.EphemerisPort ephemeris 
     "计算/接口量 ephemeris" annotation(Placement(visible=true, transformation(origin={220,0}, extent={{-18,-18},{18,18}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Modelica.Blocks.Sources.CombiTimeTable environmentTable(
    tableOnFile=false,
    table=OneSatSim.Scenarios.GeneratedEnvironmentData.table,
    columns={2,3,4,5,6,7,8,9,10,11,12,13,14,15,16},
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.NoExtrapolation,
    timeEvents=Modelica.Blocks.Types.TimeEvents.NoTimeEvents,
    verboseRead=false)  "环境Table" annotation(Placement(visible=true, transformation(origin={-105,0}, extent={{-44,-44},{44,44}}, rotation=0)));
  EphemerisDataAdapter adapter(simulationDuration=simulationDuration,tableRows=tableRows) 
     "星历表信号与导数一致适配实例" annotation(Placement(visible=true, transformation(origin={65,0}, extent={{-60,-60},{60,60}}, rotation=0)));
equation
  connect(environmentTable.y[1:3],adapter.positionData) annotation(Line(points={{-56.6,0},{1.6,0},{1.6,24},{11.6,24}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(environmentTable.y[4:6],adapter.sunDirectionData) annotation(Line(points={{-56.6,0},{11.6,0}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(environmentTable.y[7:15],adapter.earthToInertialData) annotation(Line(points={{-56.6,0},{1.6,0},{1.6,-24},{11.6,-24}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(adapter.ephemeris,ephemeris) annotation(Line(points={{118.4,0},{220,0}}, color={0,172,193}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Ellipse(extent={{-24,-6.6},{8.4,25.8}}, lineColor={0,0,0}, fillColor={239,246,250}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-14.28,-6.6},{-1.32,25.8}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Ellipse(extent={{-24,3.93},{8.4,15.27}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Line(points={{-24,9.6},{8.4,9.6}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-7.8,-6.6},{-7.8,25.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-43.2,-9.6},{34.8,38.4}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.7, startAngle=0, endAngle=360),
      Rectangle(extent={{21.6,24.6},{27.6,30.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Rectangle(extent={{16.8,25.2},{21,30}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{28.2,25.2},{32.4,30}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{32.4,15.6},{36.6,10.2},{34.8,4.8}}, color={73,112,158}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Ephemeris Reader", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-201,-98},{267,202}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-175,104},{-57.4,122}}, textString="EMBEDDED TABLE", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-15,114},{169.8,132}}, textString="VECTOR / FRAME ADAPTER", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-189,157},{255,186}}, textString="Embedded Ephemeris Reader", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-189,149},{255,149}}, color={215,220,226}, thickness=0.25)
    }), Documentation(info="<html><h2>固化星历表读取装配</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Models.EphemerisEnvironmentReader</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>固化星历表读取装配。原源码功能描述：Single generated environment table and signal adapter</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Simulation.OrbitalEnvironment\">OneSatSim.Simulation.OrbitalEnvironment</a> 的 <code>ephemerisReader</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>ephemeris</code></td><td>OneSatSim.Foundation.Interfaces.EphemerisPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 ephemeris</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>simulationDuration</code></td><td>SI.Time</td><td>生成环境覆盖的仿真时长 [s]</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>tableRows</code></td><td>Integer</td><td>配置项 tableRows</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>environmentTable</code></td><td><a href=\"modelica://Modelica.Blocks.Sources.CombiTimeTable\">Modelica.Blocks.Sources.CombiTimeTable</a></td><td>环境Table</td></tr><tr><td><code>adapter</code></td><td><a href=\"modelica://OneSatSim.Foundation.Models.EphemerisDataAdapter\">OneSatSim.Foundation.Models.EphemerisDataAdapter</a></td><td>星历表信号与导数一致适配实例</td></tr></table></html>"));
end EphemerisEnvironmentReader;