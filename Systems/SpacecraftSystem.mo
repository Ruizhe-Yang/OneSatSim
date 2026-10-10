within OneSatSim.Systems;
model SpacecraftSystem "12U立方星总体系统"
  parameter OneSatSim.Scenarios.SpacecraftDesignConfig designConfig "由顶层传入的整星硬件设计配置";
  parameter OneSatSim.Scenarios.ScenarioConfig scenario "由顶层传入的静态场景";
  final parameter OneSatSim.Foundation.Types.ImagingCapabilities imagingCapabilities(
    storedImageBytes=designConfig.payload.earthCamera.StoredImageSize,
    captureDuration_s=designConfig.payload.earthCamera.CaptureDuration)
    "成像Capabilities；One Earth-camera capability source for device, mission and opportunity budget";
  final parameter OneSatSim.Foundation.Types.SurfaceGeometry surfaceGeometry(
    width=designConfig.structure.structure.PrimaryFrameWidth,
    height=designConfig.structure.structure.PrimaryFrameHeight,
    length=designConfig.structure.structure.PrimaryFrameLength,
    plusXCoveredArea=designConfig.eps.solarArrayPlusX.ActiveArea,
    plusYCoveredArea=designConfig.eps.solarArrayPlusY.ActiveArea,
    minusXCoveredArea=designConfig.eps.solarArrayMinusX.ActiveArea)
    "surface几何；One effective source for structural dimensions and mounted-array coverage";
  inner Modelica.Mechanics.MultiBody.World world(gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.NoGravity,driveTrainMechanics3D=true)  "计算/接口量 world" annotation(Placement(visible=true, transformation(origin={-425,300}, extent={{-22,-22},{22,22}}, rotation=0)));
  Foundation.Interfaces.EnvironmentPort environment  "外部环境接口或实例" annotation(Placement(transformation(origin={-435,0},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={-88,-1},
extent={{-12,-12},{12,12}}),
iconVisible=true));
  Foundation.Interfaces.OnboardTelemetryPort onboardTelemetry  "onboard遥测" annotation(Placement(transformation(origin={430,-21},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={88,-1},
extent={{-12,-12},{12,12}}),
iconVisible=true));
  Four_systems.MechanicsOverall mechanicsOverall(scenario=scenario)  "机械动力学总体实例" annotation(Placement(visible=true, transformation(origin={-360,0}, extent={{-35,-35},{35,35}}, rotation=0)));
  Four_systems.ElectricalOverall electricalOverall  "电气总体实例" annotation(Placement(transformation(origin={-15,233},
extent={{-35,-35},{35,35}})));
  Four_systems.ThermalOverall thermalOverall(config=designConfig.thermalControl.overall,
    surfaceGeometry=surfaceGeometry,
    initialBusDeckTemperature=scenario.initialConditions.busDeckTemperature,
    initialExternalShellTemperature=scenario.initialConditions.externalShellTemperature)  "热学总体实例" annotation(Placement(transformation(origin={-4,-228},
extent={{-35,-35},{35,35}})));
  Four_systems.InformationOverall informationOverall  "信息总体实例" annotation(Placement(transformation(origin={348,-21},
extent={{-35,-35},{35,35}})));
  N_systems.ElectricalPowerSystem electricalPowerSystem(designConfig=designConfig.eps,initialConditions=scenario.initialConditions)  "电源分系统实例" annotation(Placement(transformation(origin={-250,117.37262},
extent={{-60,-60},{60,60}})));
  N_systems.GNCSystem gncSystem(designConfig=designConfig.gnc,initialConditions=scenario.initialConditions,
    massProperties=scenario.massProperties,imagingCapabilities=imagingCapabilities)  "姿轨控分系统实例" annotation(Placement(transformation(origin={-93,117.37262},
extent={{-60,-60},{60,60}})));
  N_systems.PayloadSystem payloadSystem(designConfig=designConfig.payload,initialConditions=scenario.initialConditions,
    imagingCapabilities=imagingCapabilities)  "载荷分系统实例" annotation(Placement(transformation(origin={63.5,117.32},
extent={{-60,-60},{60,60}})));
  N_systems.DataHandlingSystem dataHandlingSystem(designConfig=designConfig.dataHandling,
    initialConditions=scenario.initialConditions,
    imagingCapabilities=imagingCapabilities,
    operationalSnapshotStart=scenario.operationalSnapshotStart)  "数管分系统实例" annotation(Placement(transformation(origin={220,117.37262},
extent={{-60,-60},{60,60}})));
  N_systems.CommunicationSystem communicationSystem (designConfig=designConfig.communication)  "测控数传分系统实例" annotation(Placement(transformation(origin={226,-110.738},
extent={{-60,-60},{60,60}})));
  N_systems.NavigationSystem navigationSystem (designConfig=designConfig.navigation)  "导航分系统实例" annotation(Placement(transformation(origin={78,-110},
extent={{-60,-60},{60,60}})));
  N_systems.ThermalControlSystem thermalControlSystem (designConfig=designConfig.thermalControl)  "热控分系统实例" annotation(Placement(transformation(origin={-82,-110.738},
extent={{-60,-60},{60,60}})));
  N_systems.StructureSystem structureSystem(designConfig=designConfig.structure)  "结构分系统实例" annotation(Placement(transformation(origin={-222,-110},
extent={{-60,-60},{60,60}})));
equation
  connect(mechanicsOverall.subsystem[1],electricalPowerSystem.mechanical) annotation(Line(origin={0,0},
points={{-324.832,-0.35},{-318.8,-0.35},{-318.8,118.693},{-310,118.693}},
color={95,95,95},
thickness=0.5));
  connect(mechanicsOverall.subsystem[2],gncSystem.mechanical) annotation(Line(origin={0,0},
points={{-324.832,-0.35},{-164,-0.35},{-164,118.20524},{-153,118.20524}},
color={95,95,95},
thickness=0.5));
  connect(mechanicsOverall.subsystem[3],payloadSystem.mechanical) annotation(Line(origin={0,0},
points={{-324.832,-0.35},{-5.988,-0.35},{-5.988,116.72},{2.924,116.72}},
color={95,95,95},
thickness=0.5));
  connect(mechanicsOverall.subsystem[4],dataHandlingSystem.mechanical) annotation(Line(origin={0,0},
points={{-324.832,-0.35},{142,-0.35},{142,118.09262},{160,118.09262}},
color={95,95,95},
thickness=0.5));
  connect(mechanicsOverall.subsystem[5],communicationSystem.mechanical) annotation(Line(origin={0,0},
points={{-324.832,-0.35},{165.712,-0.35},{165.712,-110.6}},
color={95,95,95},
thickness=0.5));
  connect(mechanicsOverall.subsystem[6],navigationSystem.mechanical) annotation(Line(origin={0,0},
points={{-324.832,-0.35},{18,-0.35},{18,-110}},
color={95,95,95},
thickness=0.5));
  connect(mechanicsOverall.subsystem[7],thermalControlSystem.mechanical) annotation(Line(origin={0,0},
points={{-324.832,-0.35},{-142,-0.35},{-142,-111.338}},
color={95,95,95},
thickness=0.5));
  connect(mechanicsOverall.subsystem[8],structureSystem.mechanical) annotation(Line(origin={0,0},
points={{-324.832,-0.35},{-282,-0.35},{-282,-110.6}},
color={95,95,95},
thickness=0.5));
  connect(electricalOverall.subsystem[1],electricalPowerSystem.power) annotation(Line(origin={0,0},
points={{-15,198.168},{-15,188.053},{-245.5,188.053},{-245.5,176.46062}},
color={245,158,11},
thickness=0.5));
  connect(electricalOverall.subsystem[2],gncSystem.power) annotation(Line(origin={0,0},
points={{-15,198.168},{-15,188},{-90.912,188},{-90.912,175.885}},
color={245,158,11},
thickness=0.5));
  connect(electricalOverall.subsystem[3],payloadSystem.power) annotation(Line(origin={0,0},
points={{-15,198.168},{-15,189.2},{63.5,189.2},{63.5,177.608}},
color={245,158,11},
thickness=0.5),__MWORKS(BlockSystem(NamedSignal)));
  connect(electricalOverall.subsystem[4],dataHandlingSystem.power) annotation(Line(origin={0,0},
points={{-15,198.168},{-15,190},{220,190},{220,178.28462}},
color={245,158,11},
thickness=0.5));
  connect(electricalOverall.subsystem[5],communicationSystem.power) annotation(Line(origin={0,0},
points={{-15,198.168},{-15,26},{226,26},{226,-49.826}},
color={245,158,11},
thickness=0.5));
  connect(electricalOverall.subsystem[6],navigationSystem.power) annotation(Line(origin={0,0},
points={{-15,198.168},{-15,26},{78,26},{78,-49.088}},
color={245,158,11},
thickness=0.5));
  connect(electricalOverall.subsystem[7],thermalControlSystem.power) annotation(Line(origin={0,0},
points={{-15,198.168},{-15,26},{-77.5,26},{-77.5,-50.45}},
color={245,158,11},
thickness=0.5));
  connect(electricalOverall.subsystem[8],structureSystem.power) annotation(Line(origin={0,0},
points={{-15,198.168},{-15,26},{-222,26},{-222,-49.088}},
color={245,158,11},
thickness=0.5));
  connect(thermalOverall.subsystem[1],electricalPowerSystem.thermal) annotation(Line(origin={0,0},
points={{-1.375,-192.832},{-1.375,46},{-250,46},{-250,57.66062}},
color={191,0,0},
thickness=0.5));
  connect(thermalOverall.subsystem[2],gncSystem.thermal) annotation(Line(origin={0,0},
points={{-1.375,-192.832},{-1.375,46},{-93,46},{-93,59.17262}},
color={191,0,0},
thickness=0.5));
  connect(thermalOverall.subsystem[3],payloadSystem.thermal) annotation(Line(origin={0,0},
points={{-1.375,-192.832},{-1.375,46},{63.5,46},{63.5,59.12}},
color={191,0,0},
thickness=0.5));
  connect(thermalOverall.subsystem[4],dataHandlingSystem.thermal) annotation(Line(origin={0,0},
points={{-1.375,-192.832},{-1.375,46},{220,46},{220,57.37262}},
color={191,0,0},
thickness=0.5),__MWORKS(BlockSystem(NamedSignal)));
  connect(thermalOverall.subsystem[5],communicationSystem.thermal) annotation(Line(origin={0,0},
points={{-1.375,-192.832},{-1.375,-179.362},{226,-179.362},{226,-170.45}},
color={191,0,0},
thickness=0.5));
  connect(thermalOverall.subsystem[6],navigationSystem.thermal) annotation(Line(origin={0,0},
points={{-1.375,-192.832},{-1.375,-179.824},{78,-179.824},{78,-170.912}},
color={191,0,0},
thickness=0.5));
  connect(thermalOverall.subsystem[7],thermalControlSystem.thermal) annotation(Line(origin={0,0},
points={{-1.375,-192.832},{-1.375,-179.938},{-82,-179.938},{-82,-171.026}},
color={191,0,0},
thickness=0.5));
  connect(thermalOverall.subsystem[8],structureSystem.thermal) annotation(Line(origin={0,0},
points={{-1.375,-192.832},{-1.375,-178.624},{-222,-178.624},{-222,-169.712}},
color={191,0,0},
thickness=0.5));
  connect(informationOverall.subsystem[1],electricalPowerSystem.information) annotation(Line(origin={0,0},
points={{313.7,-21.35},{-180.8,-21.35},{-180.8,118.153},{-189.712,118.153}},
color={0,102,255},
thickness=0.5));
  connect(informationOverall.subsystem[2],gncSystem.information) annotation(Line(origin={0,0},
points={{313.7,-21.35},{-23.8,-21.35},{-23.8,116.773},{-32.712,116.773}},
color={0,102,255},
thickness=0.5));
  connect(informationOverall.subsystem[3],payloadSystem.information) annotation(Line(origin={0,0},
points={{313.7,-21.35},{132.7,-21.35},{132.7,116.72},{123.788,116.72}},
color={0,102,255},
thickness=0.5));
  connect(informationOverall.subsystem[4],dataHandlingSystem.information) annotation(Line(origin={0,0},
points={{313.7,-21.35},{289.2,-21.35},{289.2,116.77262},{280,116.77262}},
color={0,102,255},
thickness=0.5));
  connect(informationOverall.subsystem[5],communicationSystem.information) annotation(Line(origin={0,0},
points={{313.7,-21.35},{295.2,-21.35},{295.2,-111.338},{286.288,-111.338}},
color={0,102,255},
thickness=0.5));
  connect(informationOverall.subsystem[6],navigationSystem.information) annotation(Line(origin={0,0},
points={{313.7,-21.35},{147.2,-21.35},{147.2,-110.6},{138.288,-110.6}},
color={0,102,255},
thickness=0.5));
  connect(informationOverall.subsystem[7],thermalControlSystem.information) annotation(Line(origin={0,0},
points={{313.7,-21.35},{-13.376,-21.35},{-13.376,-111.338},{-22.288,-111.338}},
color={0,102,255},
thickness=0.5));
  connect(mechanicsOverall.euler,environment.euler) annotation(Line(origin={0,0},
points={{-391.15,4.823},{-398,4.823},{-398,0},{-435,0}},
color={0,0,127},
thickness=0.35));
  connect(mechanicsOverall.bodyRate,environment.bodyRate) annotation(Line(origin={0,0},
points={{-391.15,-2.2015},{-398,-2.2015},{-398,0},{-435,0}},
color={0,0,127},
thickness=0.35));
  connect(environment,electricalPowerSystem.environment) annotation(Line(origin={0,0},
points={{-435,0},{-397,0},{-397,66.37262},{-310,66.37262}},
color={0,166,81},
thickness=0.5));
  connect(environment,gncSystem.environment) annotation(Line(origin={0,0},
points={{-435,0},{-397,0},{-397,37},{-162.2,37},{-162.2,64.87262},{-153,64.87262}},
color={0,166,81},
thickness=0.5));
  connect(environment,dataHandlingSystem.environment) annotation(Line(origin={0,0},
points={{-435,0},{-397,0},{-397,37},{150.8,37},{150.8,64.87262},{160,64.87262}},
color={0,166,81},
thickness=0.5));
  connect(environment,navigationSystem.environment) annotation(Line(origin={0,0},
points={{-435,0},{-397,0},{-397,-37},{8.8,-37},{8.8,-162.5},{18,-162.5}},
color={0,166,81},
thickness=0.5));
  connect(environment,thermalOverall.environment) annotation(Line(origin={0,0},
points={{-435,0},{-397,0},{-397,-258.625},{-39,-258.625}},
color={0,166,81},
thickness=0.5));
  connect(informationOverall.telemetry,onboardTelemetry) annotation(Line(origin={-12,-21},
points={{390.8,-0.35},{442,-0.35},{442,0}},
color={213,0,143},
thickness=0.5));
  annotation(Documentation(info="<html><h2>12U立方星总体系统</h2><p><b>类路径：</b><code>OneSatSim.Systems.SpacecraftSystem</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>装配八个分系统和四个跨域总体连接网络，通过唯一环境边界与外部轨道环境耦合，并提供星上遥测出口。</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Simulation.CompleteMission\">OneSatSim.Simulation.CompleteMission</a> 的 <code>spacecraft</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>environment</code></td><td>Foundation.Interfaces.EnvironmentPort</td><td>public</td><td>按声明/类型合同</td><td>外部环境接口或实例</td></tr><tr><td><code>onboardTelemetry</code></td><td>Foundation.Interfaces.OnboardTelemetryPort</td><td>public</td><td>按声明/类型合同</td><td>onboard遥测</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>designConfig</code></td><td>OneSatSim.Scenarios.SpacecraftDesignConfig</td><td>由顶层传入的整星硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>scenario</code></td><td>OneSatSim.Scenarios.ScenarioConfig</td><td>由顶层传入的静态场景</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>imagingCapabilities</code></td><td>OneSatSim.Foundation.Types.ImagingCapabilities</td><td>成像Capabilities；One Earth-camera capability source for device, mission and opportunity budget</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>surfaceGeometry</code></td><td>OneSatSim.Foundation.Types.SurfaceGeometry</td><td>surface几何；One effective source for structural dimensions and mounted-array coverage</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>world</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.World\">Modelica.Mechanics.MultiBody.World</a></td><td>计算/接口量 world</td></tr><tr><td><code>mechanicsOverall</code></td><td><a href=\"modelica://OneSatSim.Systems.Four_systems.MechanicsOverall\">OneSatSim.Systems.Four_systems.MechanicsOverall</a></td><td>机械动力学总体实例</td></tr><tr><td><code>electricalOverall</code></td><td><a href=\"modelica://OneSatSim.Systems.Four_systems.ElectricalOverall\">OneSatSim.Systems.Four_systems.ElectricalOverall</a></td><td>电气总体实例</td></tr><tr><td><code>thermalOverall</code></td><td><a href=\"modelica://OneSatSim.Systems.Four_systems.ThermalOverall\">OneSatSim.Systems.Four_systems.ThermalOverall</a></td><td>热学总体实例</td></tr><tr><td><code>informationOverall</code></td><td><a href=\"modelica://OneSatSim.Systems.Four_systems.InformationOverall\">OneSatSim.Systems.Four_systems.InformationOverall</a></td><td>信息总体实例</td></tr><tr><td><code>electricalPowerSystem</code></td><td><a href=\"modelica://OneSatSim.Systems.N_systems.ElectricalPowerSystem\">OneSatSim.Systems.N_systems.ElectricalPowerSystem</a></td><td>电源分系统实例</td></tr><tr><td><code>gncSystem</code></td><td><a href=\"modelica://OneSatSim.Systems.N_systems.GNCSystem\">OneSatSim.Systems.N_systems.GNCSystem</a></td><td>姿轨控分系统实例</td></tr><tr><td><code>payloadSystem</code></td><td><a href=\"modelica://OneSatSim.Systems.N_systems.PayloadSystem\">OneSatSim.Systems.N_systems.PayloadSystem</a></td><td>载荷分系统实例</td></tr><tr><td><code>dataHandlingSystem</code></td><td><a href=\"modelica://OneSatSim.Systems.N_systems.DataHandlingSystem\">OneSatSim.Systems.N_systems.DataHandlingSystem</a></td><td>数管分系统实例</td></tr><tr><td><code>communicationSystem</code></td><td><a href=\"modelica://OneSatSim.Systems.N_systems.CommunicationSystem\">OneSatSim.Systems.N_systems.CommunicationSystem</a></td><td>测控数传分系统实例</td></tr><tr><td><code>navigationSystem</code></td><td><a href=\"modelica://OneSatSim.Systems.N_systems.NavigationSystem\">OneSatSim.Systems.N_systems.NavigationSystem</a></td><td>导航分系统实例</td></tr><tr><td><code>thermalControlSystem</code></td><td><a href=\"modelica://OneSatSim.Systems.N_systems.ThermalControlSystem\">OneSatSim.Systems.N_systems.ThermalControlSystem</a></td><td>热控分系统实例</td></tr><tr><td><code>structureSystem</code></td><td><a href=\"modelica://OneSatSim.Systems.N_systems.StructureSystem\">OneSatSim.Systems.N_systems.StructureSystem</a></td><td>结构分系统实例</td></tr></table><h3>使用边界</h3><p>本工程的轨道环境采用离线固化数据；任务、姿态、电热及信息边界按当前配置和接口使用。已有未完成任务目标与平台状态见根README，不由本次注释更新改写。</p></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Spacecraft", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-30,33},{24,45},{47,26},{-7,14},{-30,33}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-30,33},{-7,14},{-7,-46},{-30,-27},{-30,33}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-7,14},{47,26},{47,-34},{-7,-46},{-7,14}}, lineColor={0,0,0}, fillColor={246,247,248}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{-30,13},{-7,-6},{47,6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-30,-7},{-7,-26},{47,-14}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-2.68,14.96},{-2.68,-45.04}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{42.68,25.04},{42.68,-34.96}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Polygon(points={{-3,11},{6,13},{6,-1},{-3,-3},{-3,11}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{-3,-6},{6,-4},{6,-18},{-3,-20},{-3,-6}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{-3,-23},{6,-21},{6,-35},{-3,-37},{-3,-23}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{8.5,13.55},{17.5,15.55},{17.5,1.55},{8.5,-0.45},{8.5,13.55}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{8.5,-3.45},{17.5,-1.45},{17.5,-15.45},{8.5,-17.45},{8.5,-3.45}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{8.5,-20.45},{17.5,-18.45},{17.5,-32.45},{8.5,-34.45},{8.5,-20.45}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{20,16.1},{29,18.1},{29,4.1},{20,2.1},{20,16.1}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{20,-0.9},{29,1.1},{29,-12.9},{20,-14.9},{20,-0.9}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{20,-17.9},{29,-15.9},{29,-29.9},{20,-31.9},{20,-17.9}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{31.5,18.65},{40.5,20.65},{40.5,6.65},{31.5,4.65},{31.5,18.65}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{31.5,1.65},{40.5,3.65},{40.5,-10.35},{31.5,-12.35},{31.5,1.65}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{31.5,-15.35},{40.5,-13.35},{40.5,-27.35},{31.5,-29.35},{31.5,-15.35}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{-26,25},{-12,14},{-12,1},{-26,12},{-26,25}}, lineColor={0,0,0}, fillColor={230,240,247}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{-26,8},{-12,-3},{-12,-16},{-26,-5},{-26,8}}, lineColor={0,0,0}, fillColor={230,240,247}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{-26,-9},{-12,-20},{-12,-33},{-26,-22},{-26,-9}}, lineColor={0,0,0}, fillColor={230,240,247}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Ellipse(extent={{-1,26},{15,39}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{3,29},{11,36}}, lineColor={0,0,0}, fillColor={223,233,238}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Ellipse(extent={{-31.7,31.3},{-28.3,34.7}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-30.85,33},{-29.15,33}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-8.7,12.3},{-5.3,15.7}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-7.85,14},{-6.15,14}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{45.3,24.3},{48.7,27.7}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{46.15,26},{47.85,26}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-31.7,-28.7},{-28.3,-25.3}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-30.85,-27},{-29.15,-27}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-8.7,-47.7},{-5.3,-44.3}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-7.85,-46},{-6.15,-46}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{45.3,-35.7},{48.7,-32.3}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{46.15,-34},{47.85,-34}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="12U Spacecraft", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-480,-380},{480,380}}, preserveAspectRatio=true, grid={2,2}), graphics={Text(extent={{-430,345},{430,370}}, textString="12U SPACECRAFT · FOUR DOMAIN NETWORKS", lineColor={45,65,95})}));
end SpacecraftSystem;