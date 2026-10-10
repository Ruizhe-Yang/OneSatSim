within OneSatSim.Systems.Four_systems;
model InformationOverall "信息总体"
  Foundation.Interfaces.InformationPort subsystem[7]  "计算/接口量 subsystem" annotation(Placement(transformation(origin={115,120},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={-98,-1},
extent={{-12,-12},{12,12}}),
iconVisible=true));
  Foundation.Interfaces.OnboardTelemetryPort telemetry  "只读遥测信息接口" annotation(Placement(transformation(origin={165,35},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={98,-1},
extent={{-12,-12},{12,12}}),
iconVisible=true));
  Foundation.Models.EngineeringTelemetryObserver engineeringTelemetryObserver 
     "整星信息总线的只读工程遥测观察器实例" annotation(Placement(visible=true, transformation(origin={0,0}, extent={{-75,-75},{75,75}}, rotation=0)));
equation
  connect(subsystem[1],engineeringTelemetryObserver.live) annotation(Line(points={{115,120},{115,60},{66.75,60}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(engineeringTelemetryObserver.telemetry,telemetry) annotation(Line(points={{66.75,55.55555},{165,55.55555},{165,35}}, color={213,0,143}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1],subsystem[2]) annotation(Line(points={{115,120}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1],subsystem[3]) annotation(Line(points={{115,120}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1],subsystem[4]) annotation(Line(points={{115,120}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1],subsystem[5]) annotation(Line(points={{115,120}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1],subsystem[6]) annotation(Line(points={{115,120}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1],subsystem[7]) annotation(Line(points={{115,120}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>信息总体</h2><p><b>类路径：</b><code>OneSatSim.Systems.Four_systems.InformationOverall</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>信息总体</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.SpacecraftSystem\">OneSatSim.Systems.SpacecraftSystem</a> 的 <code>informationOverall</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>subsystem[7]</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 subsystem</td></tr><tr><td><code>telemetry</code></td><td>Foundation.Interfaces.OnboardTelemetryPort</td><td>public</td><td>按声明/类型合同</td><td>只读遥测信息接口</td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>engineeringTelemetryObserver</code></td><td><a href=\"modelica://OneSatSim.Foundation.Models.EngineeringTelemetryObserver\">OneSatSim.Foundation.Models.EngineeringTelemetryObserver</a></td><td>整星信息总线的只读工程遥测观察器实例</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={83,131,109}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Domain assembly", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-68,20},{-38,20},{-38,-21},{-68,-21}}, color={83,131,109}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{-53,-21},{-53,20}}, color={83,131,109}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{-16,-33},{61,38}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Rectangle(extent={{-9,-24},{54,29}}, lineColor={0,0,0}, fillColor={246,249,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-34,0},{-16,0}}, color={83,131,109}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-5,-15},{7,-15},{13,9},{20,-12},{29,16},{39,-2},{48,5}}, color={83,131,109}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-2,21},{27,21}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{37,17},{48,24}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.4, radius=0),
      Line(points={{3,-41},{42,-41}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Information Network", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-113,-113},{209,208}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-101,163},{197,192}}, textString="Information Network", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-101,155},{197,155}}, color={215,220,226}, thickness=0.25)
    }));
end InformationOverall;