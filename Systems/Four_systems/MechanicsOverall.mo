within OneSatSim.Systems.Four_systems;
model MechanicsOverall "机械动力学总体"
  parameter OneSatSim.Scenarios.ScenarioConfig scenario "轨道、站点、目标和姿态场景";
  Foundation.Interfaces.MechanicalPort subsystem[8]  "计算/接口量 subsystem" annotation(Placement(transformation(origin={10,-135},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={100.48,-1},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Modelica.Blocks.Interfaces.RealOutput euler[3](each unit="rad")  "计算/接口量 euler [rad]" annotation(Placement(transformation(origin={200,95},
extent={{-6,-6},{6,6}}),
iconTransformation(origin={-89,13.78},
extent={{-6,-6},{6,6}}),
iconVisible=true));
  Modelica.Blocks.Interfaces.RealOutput bodyRate[3](each unit="rad/s")  "机体系陀螺角速率 [rad/s]" annotation(Placement(transformation(origin={200,-70},
extent={{-6,-6},{6,6}}),
iconTransformation(origin={-89,-6.29},
extent={{-6,-6},{6,6}}),
iconVisible=true));
  outer Modelica.Mechanics.MultiBody.World world  "计算/接口量 world" annotation(Placement(visible=true, transformation(origin={-250,20}, extent={{-28,-28},{28,28}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Joints.FreeMotionScalarInit freeMotion(use_angle=true,use_w=true,angle_1(fixed=true,start=scenario.initialConditions.roll),angle_2(fixed=true,start=scenario.initialConditions.pitch),angle_3(fixed=true,start=scenario.initialConditions.yaw),w_rel_b_1(fixed=true,start=scenario.initialConditions.wx),w_rel_b_2(fixed=true,start=scenario.initialConditions.wy),w_rel_b_3(fixed=true,start=scenario.initialConditions.wz))  "计算/接口量 freeMotion" annotation(Placement(visible=true, transformation(origin={-125,20}, extent={{-65,-65},{65,65}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngles eulerSensor  "euler传感器" annotation(Placement(visible=true, transformation(origin={85,95}, extent={{-30,-30},{30,30}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngularVelocity rateSensor(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)  "速率传感器" annotation(Placement(visible=true, transformation(origin={85,-70}, extent={{-30,-30},{30,30}}, rotation=0)));
equation
  connect(eulerSensor.angles,euler) annotation(Line(points={{118,95},{200,95}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(rateSensor.w,bodyRate) annotation(Line(points={{118,-70},{200,-70}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(world.frame_b,freeMotion.frame_a) annotation(Line(points={{-222,20},{-190,20}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(freeMotion.frame_b,eulerSensor.frame_a) annotation(Line(points={{-60,20},{45,20},{45,95},{55,95}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(freeMotion.frame_b,rateSensor.frame_a) annotation(Line(points={{-60,20},{45,20},{45,-70},{55,-70}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(freeMotion.frame_b,subsystem[1]) annotation(Line(points={{-60,20},{10,20},{10,-135}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(freeMotion.frame_b,subsystem[2]) annotation(Line(points={{-60,20},{10,20},{10,-135}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(freeMotion.frame_b,subsystem[3]) annotation(Line(points={{-60,20},{10,20},{10,-135}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(freeMotion.frame_b,subsystem[4]) annotation(Line(points={{-60,20},{10,20},{10,-135}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(freeMotion.frame_b,subsystem[5]) annotation(Line(points={{-60,20},{10,20},{10,-135}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(freeMotion.frame_b,subsystem[6]) annotation(Line(points={{-60,20},{10,20},{10,-135}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(freeMotion.frame_b,subsystem[7]) annotation(Line(points={{-60,20},{10,20},{10,-135}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(freeMotion.frame_b,subsystem[8]) annotation(Line(points={{-60,20},{10,20},{10,-135}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>机械动力学总体</h2><p><b>类路径：</b><code>OneSatSim.Systems.Four_systems.MechanicsOverall</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>机械动力学总体</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.SpacecraftSystem\">OneSatSim.Systems.SpacecraftSystem</a> 的 <code>mechanicsOverall</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>subsystem[8]</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 subsystem</td></tr><tr><td><code>euler[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>rad</td><td>计算/接口量 euler [rad]</td></tr><tr><td><code>bodyRate[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>rad/s</td><td>机体系陀螺角速率 [rad/s]</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>scenario</code></td><td>OneSatSim.Scenarios.ScenarioConfig</td><td>轨道、站点、目标和姿态场景</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>world</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.World\">Modelica.Mechanics.MultiBody.World</a></td><td>计算/接口量 world</td></tr><tr><td><code>freeMotion</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Joints.FreeMotionScalarInit\">Modelica.Mechanics.MultiBody.Joints.FreeMotionScalarInit</a></td><td>计算/接口量 freeMotion</td></tr><tr><td><code>eulerSensor</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngles\">Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngles</a></td><td>euler传感器</td></tr><tr><td><code>rateSensor</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngularVelocity\">Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngularVelocity</a></td><td>速率传感器</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={113,122,132}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Domain assembly", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-33.8,19.78},{1.84,27.7},{17.02,15.16},{-18.62,7.24},{-33.8,19.78}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-33.8,19.78},{-18.62,7.24},{-18.62,-32.36},{-33.8,-19.82},{-33.8,19.78}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-18.62,7.24},{17.02,15.16},{17.02,-24.44},{-18.62,-32.36},{-18.62,7.24}}, lineColor={0,0,0}, fillColor={246,247,248}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{-33.8,6.58},{-18.62,-5.96},{17.02,1.96}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-33.8,-6.62},{-18.62,-19.16},{17.02,-11.24}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-15.7688,7.8736},{-15.7688,-31.7264}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{14.1688,14.5264},{14.1688,-25.0736}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-33.8,19.78},{-18.62,-32.36}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-18.62,7.24},{-33.8,-19.82}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-18.62,7.24},{17.02,-24.44}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{17.02,15.16},{-18.62,-32.36}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Ellipse(extent={{-14.66,15.16},{-4.1,23.74}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{-12.02,17.14},{-6.74,21.76}}, lineColor={0,0,0}, fillColor={223,233,238}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Ellipse(extent={{-34.922,18.658},{-32.678,20.902}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-34.361,19.78},{-33.239,19.78}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-19.742,6.118},{-17.498,8.362}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-19.181,7.24},{-18.059,7.24}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{15.898,14.038},{18.142,16.282}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{16.459,15.16},{17.581,15.16}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-34.922,-20.942},{-32.678,-18.698}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-34.361,-19.82},{-33.239,-19.82}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-19.742,-33.482},{-17.498,-31.238}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-19.181,-32.36},{-18.059,-32.36}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{15.898,-25.562},{18.142,-23.318}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{16.459,-24.44},{17.581,-24.44}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{40,-25},{67,-25}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{40,-25},{25.96,-7.72}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{40,-25},{40,2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-45,31},{-20,49},{9,47},{27,32}}, color={76,128,143}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{-58,-3},{-54,-26},{-34,-42}}, color={76,128,143}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{18,0},{41,13},{67,13}}, color={76,128,143}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{18,0},{50,41}}, color={113,122,132}, thickness=0.55, pattern=LinePattern.Dash),
      Ellipse(extent={{48,35},{60,47}}, lineColor={76,128,143}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, startAngle=0, endAngle=360),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Rigid-Body Dynamics", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-321,-179},{244,242}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-295,113},{-143.8,131}}, textString="Inertial reference", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-205,143},{-62.2,161}}, textString="Rigid-body motion", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{40,154},{182.8,172}}, textString="State measurement", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-309,197},{232,226}}, textString="Rigid-Body Dynamics", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-309,189},{232,189}}, color={215,220,226}, thickness=0.25)
    }));
end MechanicsOverall;