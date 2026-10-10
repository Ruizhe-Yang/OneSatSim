within OneSatSim.Systems.Four_systems;
model ElectricalOverall "电气总体"
  Foundation.Interfaces.PowerPort subsystem[8]  "计算/接口量 subsystem" annotation(Placement(transformation(origin={0,90},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={6.66134e-16,-99.52},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Modelica.Electrical.Analog.Basic.Ground ground12  "地面12" annotation(Placement(visible=true, transformation(origin={-90,-10}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground ground5  "地面5" annotation(Placement(visible=true, transformation(origin={0,-10}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Ground ground3V3  "地面3V3" annotation(Placement(visible=true, transformation(origin={90,-10}, extent={{-24,-24},{24,24}}, rotation=0)));
equation
  connect(subsystem[1],subsystem[2]) annotation(Line(points={{0,90}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1],subsystem[3]) annotation(Line(points={{0,90}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1],subsystem[4]) annotation(Line(points={{0,90}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1],subsystem[5]) annotation(Line(points={{0,90}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1],subsystem[6]) annotation(Line(points={{0,90}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1],subsystem[7]) annotation(Line(points={{0,90}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1],subsystem[8]) annotation(Line(points={{0,90}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1].n12,ground12.p) annotation(Line(points={{0,90},{-145,90},{-145,24},{-90,24},{-90,14}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1].n5,ground5.p) annotation(Line(points={{0,90},{110.2,90},{110.2,24},{0,24},{0,14}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1].n33,ground3V3.p) annotation(Line(points={{0,90},{110.2,90},{110.2,24},{90,24},{90,14}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>电气总体</h2><p><b>类路径：</b><code>OneSatSim.Systems.Four_systems.ElectricalOverall</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>电气总体</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.SpacecraftSystem\">OneSatSim.Systems.SpacecraftSystem</a> 的 <code>electricalOverall</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>subsystem[8]</code></td><td>Foundation.Interfaces.PowerPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 subsystem</td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>ground12</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Ground\">Modelica.Electrical.Analog.Basic.Ground</a></td><td>地面12</td></tr><tr><td><code>ground5</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Ground\">Modelica.Electrical.Analog.Basic.Ground</a></td><td>地面5</td></tr><tr><td><code>ground3V3</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Ground\">Modelica.Electrical.Analog.Basic.Ground</a></td><td>地面3V3</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={77,126,172}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Domain assembly", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-60.85,-12.5},{-13.55,22.7}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Line(points={{-58.1,-9.2},{-16.85,18.85}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-54.8,15},{-42.15,15}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{-54.8,11.15},{-42.15,11.15}}, color={77,126,172}, thickness=0.5, pattern=LinePattern.Dash),
      Line(points={{-32.8,-0.95},{-19.6,-0.95}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{-32.8,-4.8},{-19.6,-4.8}}, color={77,126,172}, thickness=0.5, pattern=LinePattern.Dash),
      Line(points={{-74.6,15},{-60.85,15}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-74.6,-7},{-60.85,-7}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-13.55,15},{4.05,15}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-13.55,-7},{4.05,-7}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-42.15,-14.7},{-42.15,-20.2},{-35,-17.45},{-27.85,-22.4},{-20.7,-18}}, color={196,94,56}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{5,4},{22,4},{22,34},{63,34}}, color={77,126,172}, thickness=0.9, pattern=LinePattern.Solid),
      Line(points={{22,4},{63,4}}, color={77,126,172}, thickness=0.9, pattern=LinePattern.Solid),
      Line(points={{22,4},{22,-26},{63,-26}}, color={77,126,172}, thickness=0.9, pattern=LinePattern.Solid),
      Rectangle(extent={{31,29},{44,39}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Ellipse(extent={{52,31},{58,37}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Line(points={{58,34},{70,34}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid),
      Rectangle(extent={{31,-1},{44,9}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Ellipse(extent={{52,1},{58,7}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Line(points={{58,4},{70,4}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid),
      Rectangle(extent={{31,-31},{44,-21}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Ellipse(extent={{52,-29},{58,-23}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Line(points={{58,-26},{70,-26}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid),
      Text(extent={{32,39},{73,55}}, textString="12 V", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Text(extent={{32,9},{73,25}}, textString="5 V", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Text(extent={{32,-49},{73,-32}}, textString="3.3 V", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Electrical Network", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-171,-72},{152,178}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-135,35},{100.2,53}}, textString="Three shared rail references", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-159,133},{140,162}}, textString="Electrical Network", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-159,125},{140,125}}, color={215,220,226}, thickness=0.25)
    }));
end ElectricalOverall;