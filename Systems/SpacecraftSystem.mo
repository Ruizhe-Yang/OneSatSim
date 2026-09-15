within NISSA_12UCubeSat.Systems;
model SpacecraftSystem "12U立方星总体系统"
  parameter NISSA_12UCubeSat.Scenarios.SpacecraftDesignConfig designConfig "由顶层传入的整星硬件设计配置";
  parameter NISSA_12UCubeSat.Scenarios.ScenarioConfig scenario "由顶层传入的静态场景";
  inner Modelica.Mechanics.MultiBody.World world(gravityType=Modelica.Mechanics.MultiBody.Types.GravityTypes.NoGravity,driveTrainMechanics3D=true) annotation(Placement(transformation(extent={{-178,130},{-158,150}})));
  Foundation.Interfaces.OnboardTelemetryPort onboardTelemetry annotation(Placement(transformation(origin={140,-60},
extent={{-10,-10},{10,10}}),
iconTransformation(origin={110,-55},
extent={{-10,-10},{10,10}})));
  Four_systems.MechanicsOverall mechanicsOverall(scenario=scenario) annotation(Placement(transformation(origin={-158,-4.44089e-16},
extent={{-20,-20},{20,20}},
rotation=180)));
  Four_systems.ElectricalOverall electricalOverall annotation(Placement(transformation(origin={0,135},
extent={{-20,-20},{20,20}},
rotation=90)));
  Four_systems.ThermalOverall thermalOverall(config=designConfig.thermalControl.overall,
    initialBusDeckTemperature=scenario.initialConditions.busDeckTemperature,
    initialExternalShellTemperature=scenario.initialConditions.externalShellTemperature) annotation(Placement(transformation(origin={1.77636e-15,-150},
extent={{-20,-20},{20,20}},
rotation=-90)));
  Four_systems.InformationOverall informationOverall annotation(Placement(transformation(origin={170,0},
extent={{-20,-20},{20,20}})));
  Foundation.Models.EngineeringTelemetryObserver engineeringTelemetryObserver 
    annotation(Placement(transformation(origin={170,-60},extent={{-20,-12},{20,12}})));
  N_systems.ElectricalPowerSystem electricalPowerSystem(designConfig=designConfig.eps,initialConditions=scenario.initialConditions) annotation(Placement(transformation(origin={-90,65},
extent={{-20,-20},{20,20}})));
  N_systems.GNCSystem gncSystem(designConfig=designConfig.gnc,initialConditions=scenario.initialConditions,massProperties=scenario.massProperties) annotation(Placement(transformation(origin={-30,65},
extent={{-20,-20},{20,20}})));
  N_systems.PayloadSystem payloadSystem(designConfig=designConfig.payload,initialConditions=scenario.initialConditions) annotation(Placement(transformation(origin={30,65},
extent={{-20,-20},{20,20}})));
  N_systems.DataHandlingSystem dataHandlingSystem(designConfig=designConfig.dataHandling,
    initialConditions=scenario.initialConditions,
    operationalSnapshotStart=scenario.operationalSnapshotStart) annotation(Placement(transformation(origin={90,65},
extent={{-20,-20},{20,20}})));
  N_systems.CommunicationSystem communicationSystem (designConfig=designConfig.communication)annotation(Placement(transformation(origin={90,-65},
extent={{-20,-20},{20,20}})));
  N_systems.NavigationSystem navigationSystem (designConfig=designConfig.navigation)annotation(Placement(transformation(origin={30,-65},
extent={{-20,-20},{20,20}})));
  N_systems.ThermalControlSystem thermalControlSystem (designConfig=designConfig.thermalControl)annotation(Placement(transformation(origin={-30,-65},
extent={{-20,-20},{20,20}})));
  N_systems.StructureSystem structureSystem(designConfig=designConfig.structure) annotation(Placement(transformation(origin={-90,-65},
extent={{-20,-20},{20,20}})));
equation
  connect(mechanicsOverall.subsystem[1],electricalPowerSystem.mechanical) annotation(Line(origin={0,0},
points={{-137.6,0},{-115,0},{-115,65},{-110.4,65}},
color={95,95,95},thickness=0.5));
  connect(mechanicsOverall.subsystem[2],gncSystem.mechanical) annotation(Line(origin={0,0},
points={{-137.6,0},{-55,0},{-55,65},{-50.4,65}},
color={95,95,95},thickness=0.5));
  connect(mechanicsOverall.subsystem[3],payloadSystem.mechanical) annotation(Line(origin={0,0},
points={{-137.6,0},{5,0},{5,65},{9.6,65}},
color={95,95,95},thickness=0.5));
  connect(mechanicsOverall.subsystem[4],dataHandlingSystem.mechanical) annotation(Line(origin={0,0},
points={{-137.6,0},{65,0},{65,65},{69.6,65}},
color={95,95,95},thickness=0.5));
  connect(mechanicsOverall.subsystem[5],communicationSystem.mechanical) annotation(Line(origin={0,0},
points={{-137.6,0},{65,0},{65,-65},{69.6,-65}},
color={95,95,95},thickness=0.5));
  connect(mechanicsOverall.subsystem[6],navigationSystem.mechanical) annotation(Line(origin={0,0},
points={{-137.6,0},{5,0},{5,-65},{9.6,-65}},
color={95,95,95},thickness=0.5));
  connect(mechanicsOverall.subsystem[7],thermalControlSystem.mechanical) annotation(Line(origin={0,0},
points={{-137.6,0},{-55,0},{-55,-65},{-50.4,-65}},
color={95,95,95},thickness=0.5));
  connect(mechanicsOverall.subsystem[8],structureSystem.mechanical) annotation(Line(origin={0,0},
points={{-137.6,0},{-115,0},{-115,-65},{-110.4,-65}},
color={95,95,95},thickness=0.5));
  connect(electricalOverall.subsystem[1],electricalPowerSystem.power) annotation(Line(origin={0,0},
points={{0,114.6},{0,105},{-90,105},{-90,85}},
color={0,0,255}));
  connect(electricalOverall.subsystem[2],gncSystem.power) annotation(Line(origin={0,0},
points={{0,114.6},{0,105},{-30,105},{-30,85}},
color={0,0,255}));
  connect(electricalOverall.subsystem[3],payloadSystem.power) annotation(Line(origin={0,0},
points={{0,114.6},{0,105},{30,105},{30,85}},
color={0,0,255}));
  connect(electricalOverall.subsystem[4],dataHandlingSystem.power) annotation(Line(origin={0,0},
points={{0,114.6},{0,105},{90,105},{90,85}},
color={0,0,255}));
  connect(electricalOverall.subsystem[5],communicationSystem.power) annotation(Line(origin={0,0},
points={{0,114.6},{0,105},{60,105},{60,-38},{90,-38},{90,-45}},
color={0,0,255}));
  connect(electricalOverall.subsystem[6],navigationSystem.power) annotation(Line(origin={0,0},
points={{0,114.6},{0,105},{0,105},{0,-38},{30,-38},{30,-45}},
color={0,0,255}));
  connect(electricalOverall.subsystem[7],thermalControlSystem.power) annotation(Line(origin={0,0},
points={{0,114.6},{0,105},{-60,105},{-60,-38},{-30,-38},{-30,-45}},
color={0,0,255}));
  connect(electricalOverall.subsystem[8],structureSystem.power) annotation(Line(origin={0,0},
points={{0,114.6},{0,105},{-122,105},{-122,-38},{-90,-38},{-90,-45}},
color={0,0,255}));
  connect(thermalOverall.subsystem[1],electricalPowerSystem.thermal) annotation(Line(origin={0,0},
points={{0,-129.6},{0,-105},{-122,-105},{-122,38},{-90,38},{-90,45}},
color={191,0,0}));
  connect(thermalOverall.subsystem[2],gncSystem.thermal) annotation(Line(origin={0,0},
points={{0,-129.6},{0,-105},{-60,-105},{-60,38},{-30,38},{-30,45}},
color={191,0,0}));
  connect(thermalOverall.subsystem[3],payloadSystem.thermal) annotation(Line(origin={0,0},
points={{0,-129.6},{0,-105},{0,-105},{0,38},{30,38},{30,45}},
color={191,0,0}));
  connect(thermalOverall.subsystem[4],dataHandlingSystem.thermal) annotation(Line(origin={0,0},
points={{0,-129.6},{0,-105},{60,-105},{60,38},{90,38},{90,45}},
color={191,0,0}));
  connect(thermalOverall.subsystem[5],communicationSystem.thermal) annotation(Line(origin={0,0},
points={{0,-129.6},{0,-105},{90,-105},{90,-85}},
color={191,0,0}));
  connect(thermalOverall.subsystem[6],navigationSystem.thermal) annotation(Line(origin={0,0},
points={{0,-129.6},{0,-105},{30,-105},{30,-85}},
color={191,0,0}));
  connect(thermalOverall.subsystem[7],thermalControlSystem.thermal) annotation(Line(origin={0,0},
points={{0,-129.6},{0,-105},{-30,-105},{-30,-85}},
color={191,0,0}));
  connect(thermalOverall.subsystem[8],structureSystem.thermal) annotation(Line(origin={0,0},
points={{0,-129.6},{0,-105},{-90,-105},{-90,-85}},
color={191,0,0}));
  connect(informationOverall.subsystem[1],electricalPowerSystem.information) annotation(Line(origin={0,0},
points={{149.6,0},{-65,0},{-65,65},{-69.6,65}},
color={0,90,180},thickness=0.5));
  connect(informationOverall.subsystem[2],gncSystem.information) annotation(Line(origin={0,0},
points={{149.6,0},{-5,0},{-5,65},{-9.6,65}},
color={0,90,180},thickness=0.5));
  connect(informationOverall.subsystem[3],payloadSystem.information) annotation(Line(origin={0,0},
points={{149.6,0},{55,0},{55,65},{50.4,65}},
color={0,90,180},thickness=0.5));
  connect(informationOverall.subsystem[4],dataHandlingSystem.information) annotation(Line(origin={0,0},
points={{149.6,0},{115,0},{115,65},{110.4,65}},
color={0,90,180},thickness=0.5));
  connect(informationOverall.subsystem[5],communicationSystem.information) annotation(Line(origin={0,0},
points={{149.6,0},{115,0},{115,-65},{110.4,-65}},
color={0,90,180},thickness=0.5));
  connect(informationOverall.subsystem[6],navigationSystem.information) annotation(Line(origin={0,0},
points={{149.6,0},{55,0},{55,-65},{50.4,-65}},
color={0,90,180},thickness=0.5));
  connect(informationOverall.subsystem[7],thermalControlSystem.information) annotation(Line(origin={0,0},
points={{149.6,0},{-5,0},{-5,-65},{-9.6,-65}},
color={0,90,180},thickness=0.5));
  connect(informationOverall.subsystem[8],structureSystem.information) annotation(Line(origin={0,0},
points={{149.6,0},{-65,0},{-65,-65},{-69.6,-65}},
color={0,90,180},thickness=0.5));
  connect(dataHandlingSystem.activeMissionSelection,mechanicsOverall.activeMissionSelection) annotation(Line(points={{110,56},{125,56},{125,-30},{-148,-30},{-148,-20.4}},color={75,105,145},thickness=0.5));
  connect(mechanicsOverall.environment,electricalPowerSystem.environment) annotation(Line(origin={0,0},
points={{-178.4,0},{-184,0},{-184,96},{-115,96},{-115,78},{-110.4,78}},
color={0,110,70}));
  connect(mechanicsOverall.environment,gncSystem.environment) annotation(Line(origin={0,0},
points={{-178.4,0},{-184,0},{-184,96},{-55,96},{-55,78},{-50.4,78}},
color={0,110,70}));
  connect(mechanicsOverall.environment,dataHandlingSystem.environment) annotation(Line(origin={0,0},
points={{-178.4,0},{-184,0},{-184,96},{65,96},{65,78},{69.6,78}},
color={0,110,70}));
  connect(mechanicsOverall.environment,navigationSystem.environment) annotation(Line(origin={0,0},
points={{-178.4,0},{-184,0},{-184,-96},{5,-96},{5,-52},{9.6,-52}},
color={0,110,70}));
  connect(mechanicsOverall.environment,thermalOverall.environment) annotation(Line(origin={0,0},
points={{-178.4,0},{-184,0},{-184,-110},{13,-110},{13,-129.6}},
color={0,110,70}));
  connect(informationOverall.subsystem[1],engineeringTelemetryObserver.live) annotation(Line(
    points={{149.6,0},{145,0},{145,-60},{149.6,-60}},
    color={0,90,180},thickness=0.5));
  connect(engineeringTelemetryObserver.telemetry,onboardTelemetry) annotation(Line(
    points={{190.4,-60},{140,-60}},
    color={0,105,165},thickness=0.5));
  annotation(
    Icon(
      coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),
      graphics={
        Rectangle(extent={{-96,86},{96,-86}},lineColor={45,65,95},
          fillColor={242,246,251},fillPattern=FillPattern.Solid),

        Polygon(points={{-32,46},{28,46},{46,28},{-14,28},{-32,46}},
          lineColor={70,85,110},fillColor={214,222,235},fillPattern=FillPattern.Solid),
        Polygon(points={{28,46},{46,28},{46,-38},{28,-54},{28,46}},
          lineColor={70,85,110},fillColor={179,192,213},fillPattern=FillPattern.Solid),
        Rectangle(extent={{-32,46},{28,-54}},lineColor={70,85,110},
          fillColor={199,210,226},fillPattern=FillPattern.Solid),

        Line(points={{-12,46},{-12,-54}},color={120,135,155},thickness=0.5),
        Line(points={{8,46},{8,-54}},color={120,135,155},thickness=0.5),
        Line(points={{-32,21},{28,21}},color={120,135,155},thickness=0.5),
        Line(points={{-32,-4},{28,-4}},color={120,135,155},thickness=0.5),
        Line(points={{-32,-29},{28,-29}},color={120,135,155},thickness=0.5),

        Rectangle(extent={{-82,28},{-32,-32}},lineColor={48,93,150},
          fillColor={87,143,205},fillPattern=FillPattern.Solid),
        Line(points={{-70,28},{-70,-32}},color={220,235,250},thickness=0.5),
        Line(points={{-58,28},{-58,-32}},color={220,235,250},thickness=0.5),
        Line(points={{-46,28},{-46,-32}},color={220,235,250},thickness=0.5),
        Line(points={{-82,8},{-32,8}},color={220,235,250},thickness=0.5),
        Line(points={{-82,-12},{-32,-12}},color={220,235,250},thickness=0.5),

        Rectangle(extent={{46,26},{86,-30}},lineColor={48,93,150},
          fillColor={87,143,205},fillPattern=FillPattern.Solid),
        Line(points={{56,26},{56,-30}},color={220,235,250},thickness=0.5),
        Line(points={{66,26},{66,-30}},color={220,235,250},thickness=0.5),
        Line(points={{76,26},{76,-30}},color={220,235,250},thickness=0.5),
        Line(points={{46,8},{86,8}},color={220,235,250},thickness=0.5),
        Line(points={{46,-10},{86,-10}},color={220,235,250},thickness=0.5),

        Ellipse(extent={{30,-4},{40,-14}},lineColor={0,105,165},
          fillColor={220,240,250},fillPattern=FillPattern.Solid),
        Line(points={{40,-9},{57,-9}},color={0,105,165},thickness=0.8),
        Ellipse(extent={{52,-19},{72,1}},startAngle=-45,endAngle=45,
          closure=EllipseClosure.None,lineColor={0,105,165},lineThickness=0.8),
        Ellipse(extent={{58,-25},{82,7}},startAngle=-45,endAngle=45,
          closure=EllipseClosure.None,lineColor={0,105,165},lineThickness=0.8),

        Text(extent={{-88,-80},{88,-62}},textString="12U SPACECRAFT",
          lineColor={45,65,95})}),
    Diagram(
      coordinateSystem(extent={{-190,-175},{195,165}},grid={5,5},
        preserveAspectRatio=true),
      graphics={
        Rectangle(extent={{-124,92},{124,-92}},lineColor={195,205,218},
          fillColor={249,251,254},fillPattern=FillPattern.Solid),
        Text(extent={{-120,90},{120,82}},textString="8 PROFESSIONAL SUBSYSTEMS",
          lineColor={70,85,110}),

        Text(extent={{-28,161},{28,153}},textString="ELECTRICAL DOMAIN OVERALL",
          lineColor={0,0,180}),
        Text(extent={{-28,-157},{28,-165}},textString="THERMAL DOMAIN OVERALL",
          lineColor={165,25,25}),
        Text(extent={{-187,30},{-132,22}},textString="MECHANICS & ENVIRONMENT",
          lineColor={70,100,80}),
        Text(extent={{132,30},{191,22}},textString="INFORMATION & TELEMETRY",
          lineColor={0,90,150}),

        Text(extent={{-111,41},{-69,34}},textString="Electrical Power",
          lineColor={85,85,95}),
        Text(extent={{-50,41},{-10,34}},textString="GNC",
          lineColor={85,85,95}),
        Text(extent={{10,41},{50,34}},textString="Payload",
          lineColor={85,85,95}),
        Text(extent={{69,41},{111,34}},textString="Data Handling",
          lineColor={85,85,95}),

        Text(extent={{-111,-89},{-69,-96}},textString="Structure",
          lineColor={85,85,95}),
        Text(extent={{-51,-89},{-9,-96}},textString="Thermal Control",
          lineColor={85,85,95}),
        Text(extent={{9,-89},{51,-96}},textString="Navigation",
          lineColor={85,85,95}),
        Text(extent={{68,-89},{112,-96}},textString="Communication",
          lineColor={85,85,95}),

        Text(extent={{-120,13},{120,5}},
          textString="CENTRAL CROSS-DOMAIN INTEGRATION CORRIDOR",
          lineColor={135,135,145}),
        Text(extent={{-118,111},{118,103}},
          textString="POWER DISTRIBUTION CORRIDOR",
          lineColor={0,0,180}),
        Text(extent={{-118,-101},{118,-109}},
          textString="THERMAL EXCHANGE CORRIDOR",
          lineColor={165,25,25})
      }),
    Documentation(info="<html><h4>功能定位</h4><p>整星总体系统采用1+4+8白箱集成：一个整星、四个领域总体和八个专业分系统。</p><h4>模型结构</h4><p>本类拥有唯一的inner MultiBody.World。轨道平动传播与整星姿态动力学相互解耦，以维持24 h系统级快速仿真。</p><h4>信息关系</h4><p>连接到MechanicsOverall的信息接口只传递活动视线求解需要的指令锁存对象索引；整星对外仅保留onboardTelemetry输出。</p></html>"));
end SpacecraftSystem;
