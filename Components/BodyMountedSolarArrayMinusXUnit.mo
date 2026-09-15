within NISSA_12UCubeSat.Components;
model BodyMountedSolarArrayMinusXUnit "-X长侧面体装太阳电池组件"
  parameter NISSA_12UCubeSat.Scenarios.DesignConfigRecords.SolarArrayMinusXComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance harnessResistance=config.HarnessResistance
    "太阳阵线束/阻断路径电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity panelHeatCapacity=config.PanelHeatCapacity
    "面板等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.Mass mass=config.Mass
    "质量；Excel单位kg，当前设计基线";
  parameter Modelica.Units.SI.Length rcm_X=config.RCM_X
    "质心偏置X；Excel单位m，当前设计基线";
  parameter Modelica.Units.SI.Length rcm_Y=config.RCM_Y
    "质心偏置Y；Excel单位m，当前设计基线";
  parameter Modelica.Units.SI.Length rcm_Z=config.RCM_Z
    "质心偏置Z；Excel单位m，当前设计基线";
  parameter Modelica.Units.SI.Inertia inertia_XX=config.Inertia_XX
    "局部惯量 Ixx；Excel单位kg·m²，当前设计基线";
  parameter Modelica.Units.SI.Inertia inertia_YY=config.Inertia_YY
    "局部惯量 Iyy；Excel单位kg·m²，当前设计基线";
  parameter Modelica.Units.SI.Inertia inertia_ZZ=config.Inertia_ZZ
    "局部惯量 Izz；Excel单位kg·m²，当前设计基线";
  parameter Modelica.Units.SI.Area grossSideFaceArea=0.34*0.226 "物理几何: 12U long side";
  parameter Modelica.Units.SI.Area activeArea=config.ActiveArea
    "PHYSICAL CONFIGURATION: 81 percent cell coverage of one 12U long side";
  parameter Real cellEfficiency(min=0,max=1)=config.CellEfficiency "Effective photovoltaic conversion efficiency";
  parameter Real solarEOLFactor(min=0,max=1)=config.SolarEOLFactor;
  parameter Boolean useSolarEOL=config.UseSolarEOL "false=BOL factor 1.0; true=EOL factor 0.85";
  final parameter Real solarLifeFactor=if useSolarEOL then solarEOLFactor else 1;
  parameter Real etaMPPT(min=0,max=1)=config.MPPTDeliveryEfficiency
    "任务级参数: average MPPT plus harness delivery efficiency";
  parameter Real panelSolarAbsorptivity(min=0,max=1)=config.SolarAbsorptivity;
  parameter Real panelInfraredAbsorptivity(min=0,max=1)=config.InfraredAbsorptivity;
  parameter Real panelEmissivity(min=0,max=1)=config.Emissivity;
  parameter Modelica.Units.SI.ThermalConductance panelMountConductance=config.MountConductance;
  parameter Real panelNormalBody[3]={config.Normal_X,config.Normal_Y,config.Normal_Z}
    "PHYSICAL INSTALLATION: body -X";
  Foundation.Interfaces.SourcePowerPort sourcePower annotation(Placement(transformation(extent={{-10,90},{10,110}}),iconTransformation(extent={{-10,90},{10,110}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.EnvironmentPort environment annotation(Placement(transformation(extent={{-110,-62},{-90,-42}}),iconTransformation(extent={{-110,-62},{-90,-42}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  Foundation.Interfaces.RealSignalReader sunVectorFromEnvironment[3] annotation(Placement(transformation(extent={{-90,66},{-78,74}})));
  Foundation.Interfaces.RealSignalReader solarFluxFromEnvironment annotation(Placement(transformation(extent={{-90,54},{-78,62}})));
  Foundation.Interfaces.RealSignalReader earthVectorFromEnvironment[3] annotation(Placement(transformation(extent={{-90,22},{-78,30}})));
  Foundation.Interfaces.RealSignalReader albedoFluxFromEnvironment annotation(Placement(transformation(extent={{-90,12},{-78,20}})));
  Foundation.Interfaces.RealSignalReader earthInfraredFluxFromEnvironment annotation(Placement(transformation(extent={{-90,2},{-78,10}})));
  Foundation.Interfaces.RealSignalReader curtailmentFromInformation annotation(Placement(transformation(extent={{-90,42},{-78,50}})));
  Foundation.Interfaces.RealSignalReader rawBusVoltageFromInformation annotation(Placement(transformation(extent={{-90,30},{-78,38}})));
  Foundation.Calculations.BodyMountedSolarArrayMinusXCalculation solarCalculation(
    activeArea=activeArea,cellEfficiency=cellEfficiency,solarLifeFactor=solarLifeFactor,
    etaMPPT=etaMPPT,panelNormalBody=panelNormalBody,
    solarAbsorptivity=panelSolarAbsorptivity,infraredAbsorptivity=panelInfraredAbsorptivity)
    annotation(Placement(transformation(extent={{-62,-2},{-30,20}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent arraySource annotation(Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor mpptCurrent annotation(Placement(transformation(extent={{-5,30},{15,50}})));
  Modelica.Electrical.Analog.Basic.Resistor blockingHarness(R=harnessResistance,useHeatPort=true)
    "Average MPPT/harness path; reverse blocking is inherent in the nonnegative source command" annotation(Placement(transformation(extent={{28,30},{48,50}})));
  Modelica.Electrical.Analog.Basic.Resistor shunt(R=180,useHeatPort=true) annotation(Placement(transformation(origin={62,0},extent={{-10,-10},{10,10}},rotation=270)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor mpptVoltage annotation(Placement(transformation(origin={35,0},extent={{-9,-9},{9,9}},rotation=270)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow solarHeatInput annotation(Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor panelThermalMass(C=panelHeatCapacity,T(start=256.83,fixed=false)) annotation(Placement(transformation(extent={{-30,-48},{-10,-28}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor bracketPath(G=panelMountConductance)
    "面板至舱板安装导热" annotation(Placement(transformation(extent={{18,-46},{38,-30}})));
  Modelica.Thermal.HeatTransfer.Components.BodyRadiation panelRadiation(Gr=panelEmissivity*activeArea) annotation(Placement(transformation(extent={{18,-86},{38,-66}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature deepSpace(T=3) annotation(Placement(transformation(extent={{48,-86},{68,-66}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor minusXFaceThermistor annotation(Placement(transformation(extent={{-8,-76},{12,-56}})));
  Modelica.Mechanics.MultiBody.Parts.Body panelBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-88,-26},{-68,-6}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[7] annotation(Placement(transformation(extent={{78,20},{86,28}})));
equation
  connect(environment.sunVectorBody,sunVectorFromEnvironment.u) annotation(Line(points={{-100,-52},{-66.5,-52},{-66.5,70},{-90,70}},color={0,0,127}));
  connect(environment.solarFlux,solarFluxFromEnvironment.u) annotation(Line(points={{-100,-52},{-66.5,-52},{-66.5,58},{-90,58}},color={0,0,127}));
  connect(environment.earthVectorBody,earthVectorFromEnvironment.u) annotation(Line(points={{-100,-52},{-66.5,-52},{-66.5,26},{-90,26}},color={0,0,127}));
  connect(environment.albedoFlux,albedoFluxFromEnvironment.u) annotation(Line(points={{-100,-52},{-66.5,-52},{-66.5,16},{-90,16}},color={0,0,127}));
  connect(environment.earthInfraredFlux,earthInfraredFluxFromEnvironment.u) annotation(Line(points={{-100,-52},{-94,-52},{-94,6},{-90,6}},color={0,0,127}));
  connect(information.device.solarCurtailmentFactor,curtailmentFromInformation.u) annotation(Line(points={{100,0},{100,51.5},{-90,51.5},{-90,46}},color={0,0,127}));
  connect(information.device.rawSourceBusVoltageAverage,rawBusVoltageFromInformation.u) annotation(Line(points={{100,0},{73.5,0},{73.5,28.5},{-76.5,28.5},{-76.5,34},{-90,34}},color={0,0,127}));
  connect(sunVectorFromEnvironment.y,solarCalculation.sunVectorBody) annotation(Line(points={{-78,70},{-70,70},{-70,16.5},{-62,16.5}},color={0,0,127}));
  connect(solarFluxFromEnvironment.y,solarCalculation.solarFlux) annotation(Line(points={{-78,58},{-68,58},{-68,13.2},{-62,13.2}},color={0,0,127}));
  connect(earthVectorFromEnvironment.y,solarCalculation.earthVectorBody) annotation(Line(points={{-78,26},{-72,26},{-72,11},{-62,11}},color={0,0,127}));
  connect(albedoFluxFromEnvironment.y,solarCalculation.albedoFlux) annotation(Line(points={{-78,16},{-74,16},{-74,9},{-62,9}},color={0,0,127}));
  connect(earthInfraredFluxFromEnvironment.y,solarCalculation.earthInfraredFlux) annotation(Line(points={{-78,6},{-76,6},{-76,7},{-62,7}},color={0,0,127}));
  connect(curtailmentFromInformation.y,solarCalculation.curtailment) annotation(Line(points={{-78,46},{-66,46},{-66,9.9},{-62,9.9}},color={0,0,127}));
  connect(rawBusVoltageFromInformation.y,solarCalculation.rawSourceVoltage) annotation(Line(points={{-78,34},{-64,34},{-64,6.6},{-62,6.6}},color={0,0,127}));
  connect(mpptVoltage.v,solarCalculation.measuredTerminalVoltage) annotation(Line(points={{44.9,0},{-58,0},{-58,3.3},{-62,3.3}},color={0,0,127}));
  connect(mpptCurrent.i,solarCalculation.measuredTerminalCurrent) annotation(Line(points={{5,29},{-56,29},{-56,0},{-62,0}},color={0,0,127}));
  connect(solarCalculation.sourceCurrentCommand,arraySource.i) annotation(Line(points={{-29.6,17.8},{-30,17.8},{-30,52}},color={0,0,127}));
  connect(arraySource.p,sourcePower.n) annotation(Line(points={{-40,40},{-40,94},{0,94},{0,100}},color={0,0,255}));
  connect(arraySource.n,mpptCurrent.p) annotation(Line(points={{-20,40},{-5,40}},color={0,0,255}));
  connect(mpptCurrent.n,blockingHarness.p) annotation(Line(points={{15,40},{28,40}},color={0,0,255}));
  connect(blockingHarness.n,sourcePower.p) annotation(Line(points={{48,40},{48,94},{0,94},{0,100}},color={0,0,255}));
  connect(shunt.p,sourcePower.p) annotation(Line(points={{62,10},{62,94},{0,94},{0,100}},color={0,0,255}));
  connect(shunt.n,sourcePower.n) annotation(Line(points={{62,-10},{62,94},{0,94},{0,100}},color={0,0,255}));
  connect(mpptVoltage.p,sourcePower.p) annotation(Line(points={{35,9},{35,94},{0,94},{0,100}},color={0,0,255}));
  connect(mpptVoltage.n,sourcePower.n) annotation(Line(points={{35,-9},{35,94},{0,94},{0,100}},color={0,0,255}));
  connect(solarCalculation.subArrayVoltage,informationRealBridge[1].u) annotation(Line(points={{-29.6,5.5},{-29.6,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.subArrayVoltage[3]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(solarCalculation.mpptOperatingVoltage,informationRealBridge[2].u) annotation(Line(points={{-29.6,3.3},{-29.6,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[2].y,information.device.mpptVoltage[3]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(solarCalculation.mpptTelemetryCurrent,informationRealBridge[3].u) annotation(Line(points={{-29.6,1.1},{-29.6,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[3].y,information.device.mpptCurrent[3]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(solarCalculation.deliveredPower,informationRealBridge[4].u) annotation(Line(points={{-29.6,12.1},{78,12.1},{78,24}},color={0,0,127}));
  connect(informationRealBridge[4].y,information.device.solarOutputPower[3]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(solarCalculation.availablePower,informationRealBridge[5].u) annotation(Line(points={{-29.6,14.3},{78,14.3},{78,24}},color={0,0,127}));
  connect(informationRealBridge[5].y,information.device.availableSolarPower[3]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(solarCalculation.incidenceCos,informationRealBridge[6].u) annotation(Line(points={{-29.6,16.5},{78,16.5},{78,24}},color={0,0,127}));
  connect(informationRealBridge[6].y,information.device.solarIncidenceCos[3]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(solarCalculation.absorbedHeat,solarHeatInput.Q_flow) annotation(Line(points={{-29.6,9.9},{-44,9.9},{-44,-20},{-60,-20}},color={0,0,127}));
  connect(solarHeatInput.port,panelThermalMass.port) annotation(Line(points={{-40,-20},{-20,-20},{-20,-28}},color={191,0,0}));
  connect(blockingHarness.heatPort,panelThermalMass.port) annotation(Line(points={{38,30},{16.5,30},{16.5,-28},{-20,-28}},color={191,0,0}));
  connect(shunt.heatPort,panelThermalMass.port) annotation(Line(points={{52,0},{52,-28},{-20,-28}},color={191,0,0}));
  connect(panelThermalMass.port,bracketPath.port_a) annotation(Line(points={{-20,-48},{-20,-38},{18,-38}},color={191,0,0}));
  connect(bracketPath.port_b,thermal) annotation(Line(points={{38,-38},{38,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(panelThermalMass.port,panelRadiation.port_a) annotation(Line(points={{-20,-48},{-20,-76},{18,-76}},color={191,0,0}));
  connect(panelRadiation.port_b,deepSpace.port) annotation(Line(points={{38,-76},{48,-76}},color={191,0,0}));
  connect(panelThermalMass.port,minusXFaceThermistor.port) annotation(Line(points={{-20,-48},{-20,-66},{-8,-66}},color={191,0,0}));
  connect(minusXFaceThermistor.T,informationRealBridge[7].u) annotation(Line(points={{12,-66},{78,-66},{78,24}},color={0,0,127}));
  connect(informationRealBridge[7].y,information.device.thermistorTemperature[14]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(panelBody.frame_a,mechanical) annotation(Line(points={{-88,-16},{-94,-16},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={30,70,130},fillColor={224,235,250},fillPattern=FillPattern.Solid),Rectangle(extent={{-78,52},{78,-34}},lineColor={20,55,110},fillColor={30,76,145},fillPattern=FillPattern.Solid),Line(points={{-39,52},{-39,-34}},color={215,230,248},thickness=0.5),Line(points={{0,52},{0,-34}},color={215,230,248},thickness=0.5),Line(points={{39,52},{39,-34}},color={215,230,248},thickness=0.5),Line(points={{-78,23},{78,23}},color={215,230,248},thickness=0.5),Line(points={{-78,-6},{78,-6}},color={215,230,248},thickness=0.5),Text(extent={{-82,-67},{-24,-45}},textString="-X",lineColor={25,65,120}),Text(extent={{-18,-67},{82,-45}},textString="MPPT 3",lineColor={25,65,120})}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Rectangle(extent={{-85,62},{70,16}},lineColor={0,0,160},pattern=LinePattern.Dash),Text(extent={{-82,70},{45,60}},textString="防反/泄放/第三MPPT"),Rectangle(extent={{-42,-18},{45,-78}},lineColor={190,0,0},pattern=LinePattern.Dash),Text(extent={{-40,-10},{45,-22}},textString="太阳面3工程热敏14")}),Documentation(info="<html><h4>功能定位</h4><p>安装于-X长侧面的独立体装太阳电池阵，与+X面相对，毛面积为0.34 m×0.226 m，电池片覆盖率为81%。</p><h4>物理实现</h4><p>+X和-X面的有效入射不会同时为正；独立入射系数同时驱动功率与热量。T14保留为面板工程热敏的物理测量语义。</p><h4>接口关系</h4><p>设备独立接入第三路MPPT、整星热网络、机械安装框架和统一信息接口。</p><h4>物理对象与接口</h4><p>本模型表示安装在-X面的独立体装太阳电池阵，并保留T14工程热敏测点语义。environment、information、sourcePower、thermal和mechanical的职责与另外两面一致，但面法向、覆盖面积、安装热路径和测温位置独立定义。</p><h4>内部路径与主要计算</h4><p>共享太阳向量、辐照度、源端电压和限功率系数经RealSignalReader进入BodyMountedSolarArrayMinusXCalculation。计算核心按-X入射余弦和本面参数形成光生电流、MPPT量及吸收热流；标准库电源支路、传感器、热容、导热和刚体保持图形可追踪。</p><h4>结果变量与使用方法</h4><p>优先查看索引3的availableSolarPower、mpptVoltage、mpptCurrent、T14温度及面板端电流，并结合姿态与日影判断零功率是否物理合理。T14是本面代表测点，不代表三个太阳阵的统一平均温度。</p><h4>建模边界</h4><p>模型不展开单片串并联失配、局部遮挡和开关级MPPT，只保留连续功率、反灌保护、热吸收和安装惯性。其参数不得和+X/+Y面联动覆盖。</p></html>"));
end BodyMountedSolarArrayMinusXUnit;
