within OneSatSim.Systems.N_systems;
model DataHandlingSystem "数管分系统"
  parameter OneSatSim.Scenarios.DesignConfigRecords.DataHandlingDesignConfig designConfig "分系统硬件设计配置";
  parameter OneSatSim.Scenarios.InitialConditionConfig initialConditions "场景初始条件";
  parameter OneSatSim.Foundation.Types.ImagingCapabilities imagingCapabilities
    "成像Capabilities；Earth-camera capability shared with payload system";
  parameter Boolean operationalSnapshotStart=true "从正常在轨快照启动任务控制";
  Foundation.Interfaces.PowerPort power  "功率" annotation(Placement(transformation(origin={0,175},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={0,101.52},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Foundation.Interfaces.ThermalPort thermal  "热学" annotation(Placement(transformation(origin={0,-155},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={0,-100},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(transformation(origin={-220,101},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={-100,1.2},
extent={{-12,-12},{12,12}}),
iconVisible=true));
  Foundation.Interfaces.InformationPort information  "计算/接口量 information" annotation(Placement(transformation(origin={255,100},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={100,-1},
extent={{-12,-12},{12,12}}),
iconVisible=true));
  Foundation.Interfaces.EnvironmentPort environment  "外部环境接口或实例" annotation(Placement(transformation(origin={-220,25},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={-100,-87.5},
extent={{-12,-12},{12,12}}),
iconVisible=true));
  Components.OnboardComputerUnit obc(config=designConfig.obc,
    imagingCapabilities=imagingCapabilities,
    operationalSnapshotStart=operationalSnapshotStart,
    initialCpuTemperature=initialConditions.obcCpuTemperature,
    initialBoardTemperature=initialConditions.obcBoardTemperature)  "星务计算机与遥测处理组件实例" annotation(Placement(visible=true, transformation(origin={-90,25}, extent={{-95,-95},{95,95}}, rotation=0)));
  Components.DataRecorderUnit recorder(config=designConfig.recorder,initialStoredBytes=initialConditions.dataRecorderStoredBytes)  "星上数据记录器组件实例" annotation(Placement(visible=true, transformation(origin={135,-15}, extent={{-55,-55},{55,55}}, rotation=0)));
  Foundation.Interfaces.MissionSelectionPublisher activeSelectionPublisher  "已锁存任务对象索引的无状态发布适配器实例" annotation(Placement(transformation(origin={125,-105}, extent={{-16,-16},{16,16}})));
equation
  connect(power,obc.power) annotation(Line(points={{0,175},{-90,175},{-90,115.25}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power,recorder.power) annotation(Line(points={{0,175},{0,47.25},{135,47.25},{135,37.25}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,obc.thermal) annotation(Line(points={{0,-155},{-90,-155},{-90,-67.15}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,recorder.thermal) annotation(Line(points={{0,-155},{135,-155},{135,-68.35}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,obc.mechanical) annotation(Line(points={{-220,101},{-174.55,101}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,recorder.mechanical) annotation(Line(points={{-220,101},{-220,-77.15},{76.05,-77.15},{76.05,-15},{86.05,-15}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,obc.information) annotation(Line(points={{255,100},{255,112},{4.55,112},{4.55,101},{-5.45,101}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,recorder.information) annotation(Line(points={{255,100},{255,-15},{183.95,-15}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(environment,obc.environment) annotation(Line(points={{-220,25},{-174.55,25}}, color={0,166,81}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(obc.activeMissionSelection,activeSelectionPublisher.selection) annotation(Line(points={{-5.45,-51},{40,-51},{40,-105},{109,-105}}, color={255,109,0}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(activeSelectionPublisher.targetIndex,environment.activeTargetIndex) annotation(Line(points={{141,-97.8},{180,-97.8},{180,-135},{-220,-135},{-220,25}}, color={255,127,0}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(activeSelectionPublisher.groundStationIndex,environment.activeGroundStationIndex) annotation(Line(points={{141,-112.2},{190,-112.2},{190,-145},{-220,-145},{-220,25}}, color={255,127,0}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>数管分系统</h2><p><b>类路径：</b><code>OneSatSim.Systems.N_systems.DataHandlingSystem</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>数管分系统</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.SpacecraftSystem\">OneSatSim.Systems.SpacecraftSystem</a> 的 <code>dataHandlingSystem</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>power</code></td><td>Foundation.Interfaces.PowerPort</td><td>public</td><td>按声明/类型合同</td><td>功率</td></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr><tr><td><code>information</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr><tr><td><code>environment</code></td><td>Foundation.Interfaces.EnvironmentPort</td><td>public</td><td>按声明/类型合同</td><td>外部环境接口或实例</td></tr><tr><td><code>activeSelectionPublisher</code></td><td>Foundation.Interfaces.MissionSelectionPublisher</td><td>public</td><td>按声明/类型合同</td><td>已锁存任务对象索引的无状态发布适配器实例</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>designConfig</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.DataHandlingDesignConfig</td><td>分系统硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>initialConditions</code></td><td>OneSatSim.Scenarios.InitialConditionConfig</td><td>场景初始条件</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>imagingCapabilities</code></td><td>OneSatSim.Foundation.Types.ImagingCapabilities</td><td>成像Capabilities；Earth-camera capability shared with payload system</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>operationalSnapshotStart</code></td><td>Boolean</td><td>从正常在轨快照启动任务控制</td><td><code>=true</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>obc</code></td><td><a href=\"modelica://OneSatSim.Components.OnboardComputerUnit\">OneSatSim.Components.OnboardComputerUnit</a></td><td>星务计算机与遥测处理组件实例</td></tr><tr><td><code>recorder</code></td><td><a href=\"modelica://OneSatSim.Components.DataRecorderUnit\">OneSatSim.Components.DataRecorderUnit</a></td><td>星上数据记录器组件实例</td></tr></table><h3>使用边界</h3><p>本工程的轨道环境采用离线固化数据；任务、姿态、电热及信息边界按当前配置和接口使用。已有未完成任务目标与平台状态见根README，不由本次注释更新改写。</p></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={83,131,109}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Subsystem", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-57.92,-22.32},{9.92,27.6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Rectangle(extent={{-41.28,-10.8},{-12.48,18}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Rectangle(extent={{-36.8,-6.32},{-16.96,13.52}}, lineColor={0,0,0}, fillColor={234,240,245}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-47.04,-6.96},{-41.28,-6.96}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-12.48,-6.96},{-6.72,-6.96}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-36.16,-10.8},{-36.16,-16.56}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-36.16,18},{-36.16,23.76}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-47.04,0.08},{-41.28,0.08}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-12.48,0.08},{-6.72,0.08}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-29.12,-10.8},{-29.12,-16.56}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-29.12,18},{-29.12,23.76}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-47.04,7.12},{-41.28,7.12}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-12.48,7.12},{-6.72,7.12}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-22.08,-10.8},{-22.08,-16.56}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-22.08,18},{-22.08,23.76}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-47.04,14.16},{-41.28,14.16}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-12.48,14.16},{-6.72,14.16}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-15.04,-10.8},{-15.04,-16.56}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-15.04,18},{-15.04,23.76}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Ellipse(extent={{-54.592,-18.992},{-52.288,-16.688}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-54.016,-17.84},{-52.864,-17.84}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{4.288,-18.992},{6.592,-16.688}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{4.864,-17.84},{6.016,-17.84}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-54.592,21.968},{-52.288,24.272}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-54.016,23.12},{-52.864,23.12}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{4.288,21.968},{6.592,24.272}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{4.864,23.12},{6.016,23.12}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-2.88,11.6},{4.16,20.56}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{-2.88,-1.2},{4.16,6.48}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{-2.88,-14},{4.16,-6.32}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-34.24,6.48},{-28.48,6.48},{-28.48,0.72},{-22.08,0.72},{-22.08,6.48}}, color={83,131,109}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-34.24,-2.48},{-21.44,-2.48}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Rectangle(extent={{24.6,-22.6},{61,5.8}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Rectangle(extent={{29.4,-18.2},{38.6,-9.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{27.8,-16.6},{29.4,-16.6}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{38.6,-16.6},{40.2,-16.6}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{27.8,-14.2},{29.4,-14.2}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{38.6,-14.2},{40.2,-14.2}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{27.8,-11.8},{29.4,-11.8}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{38.6,-11.8},{40.2,-11.8}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Rectangle(extent={{29.4,-6.6},{38.6,1.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{27.8,-5},{29.4,-5}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{38.6,-5},{40.2,-5}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{27.8,-2.6},{29.4,-2.6}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{38.6,-2.6},{40.2,-2.6}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{27.8,-0.2},{29.4,-0.2}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{38.6,-0.2},{40.2,-0.2}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Rectangle(extent={{43,-18.2},{52.2,-9.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{41.4,-16.6},{43,-16.6}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{52.2,-16.6},{53.8,-16.6}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{41.4,-14.2},{43,-14.2}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{52.2,-14.2},{53.8,-14.2}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{41.4,-11.8},{43,-11.8}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{52.2,-11.8},{53.8,-11.8}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Rectangle(extent={{43,-6.6},{52.2,1.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{41.4,-5},{43,-5}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{52.2,-5},{53.8,-5}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{41.4,-2.6},{43,-2.6}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{52.2,-2.6},{53.8,-2.6}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{41.4,-0.2},{43,-0.2}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{52.2,-0.2},{53.8,-0.2}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{17,0.2},{23,0.2}}, color={83,131,109}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{62.6,-13.4},{72.6,-13.4}}, color={83,131,109}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{64.2,-2.2},{72.2,0.2}}, lineColor={0,0,0}, fillColor={227,240,232}, fillPattern=FillPattern.Solid, lineThickness=0.4, radius=0),
      Rectangle(extent={{64.2,1.8},{72.2,4.2}}, lineColor={0,0,0}, fillColor={227,240,232}, fillPattern=FillPattern.Solid, lineThickness=0.4, radius=0),
      Rectangle(extent={{64.2,5.8},{72.2,8.2}}, lineColor={0,0,0}, fillColor={227,240,232}, fillPattern=FillPattern.Solid, lineThickness=0.4, radius=0),
      Line(points={{27.8,-26.2},{57.8,-26.2}}, color={113,122,132}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{27.8,-26.2},{48.2,-26.2}}, color={83,131,109}, thickness=2, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Data Handling System", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-264,-199},{299,290}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-195,202},{23.4,220}}, textString="Autonomous mission control", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{60,84},{228,102}}, textString="Payload data storage", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-252,245},{287,274}}, textString="Data Handling System", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-252,237},{287,237}}, color={215,220,226}, thickness=0.25)
    }));
end DataHandlingSystem;