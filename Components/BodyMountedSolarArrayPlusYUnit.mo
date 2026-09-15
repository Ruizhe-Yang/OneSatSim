within NISSA_12UCubeSat.Components;
model BodyMountedSolarArrayPlusYUnit "+Y长侧面体装双串太阳电池组件"
  parameter NISSA_12UCubeSat.Scenarios.DesignConfigRecords.SolarArrayPlusYComponentConfig config
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
    "PHYSICAL CONFIGURATION: 90 percent cell coverage of one 12U long side";
  parameter Real cellEfficiency(min=0,max=1)=config.CellEfficiency "Effective photovoltaic conversion efficiency";
  final parameter Modelica.Units.SI.Area stringAreaA=0.5*activeArea;
  final parameter Modelica.Units.SI.Area stringAreaB=0.5*activeArea;
  parameter Real solarEOLFactor(min=0,max=1)=config.SolarEOLFactor;
  parameter Boolean useSolarEOL=config.UseSolarEOL "false=BOL factor 1.0; true=EOL factor 0.85";
  final parameter Real solarLifeFactor=if useSolarEOL then solarEOLFactor else 1;
  parameter Real etaMPPT(min=0,max=1)=config.MPPTDeliveryEfficiency
    "任务级参数: average MPPT plus dual-harness delivery efficiency";
  parameter Real panelSolarAbsorptivity(min=0,max=1)=config.SolarAbsorptivity;
  parameter Real panelInfraredAbsorptivity(min=0,max=1)=config.InfraredAbsorptivity;
  parameter Real panelEmissivity(min=0,max=1)=config.Emissivity;
  parameter Modelica.Units.SI.ThermalConductance panelMountConductance=config.MountConductance;
  parameter Real panelNormalBody[3]={config.Normal_X,config.Normal_Y,config.Normal_Z}
    "PHYSICAL INSTALLATION: body +Y";
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
  Foundation.Calculations.BodyMountedSolarArrayPlusYCalculation solarCalculation(
    activeArea=activeArea,cellEfficiency=cellEfficiency,solarLifeFactor=solarLifeFactor,
    etaMPPT=etaMPPT,panelNormalBody=panelNormalBody,
    solarAbsorptivity=panelSolarAbsorptivity,infraredAbsorptivity=panelInfraredAbsorptivity)
    annotation(Placement(transformation(extent={{-62,-2},{-30,20}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent sourceA annotation(Placement(transformation(extent={{-48,38},{-28,58}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor mpptCurrent annotation(Placement(transformation(extent={{-22,38},{-2,58}})));
  Modelica.Electrical.Analog.Basic.Resistor equivalentDualHarness(R=harnessResistance,useHeatPort=true)
    "两条0.08/0.09 ohm线束的并联平均值等效" annotation(Placement(transformation(extent={{6,38},{26,58}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor terminalVoltage annotation(Placement(transformation(origin={56,0},extent={{-9,-9},{9,9}},rotation=270)));
  Modelica.Electrical.Analog.Basic.Resistor inputDamping(R=220,useHeatPort=true)
    "MPPT2输入泄放及阻尼通路" annotation(Placement(transformation(origin={76,0},extent={{-9,-9},{9,9}},rotation=270)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow solarHeatInput annotation(Placement(transformation(extent={{-42,-44},{-22,-24}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor panelThermalMass(C=panelHeatCapacity,T(start=310.03,fixed=false)) annotation(Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor faceMountPath(G=panelMountConductance)
    "面板至舱板安装导热" annotation(Placement(transformation(extent={{20,-48},{40,-32}})));
  Modelica.Thermal.HeatTransfer.Components.BodyRadiation panelRadiation(Gr=panelEmissivity*activeArea) annotation(Placement(transformation(extent={{20,-72},{40,-52}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature deepSpace(T=3) annotation(Placement(transformation(extent={{50,-72},{70,-52}})));
  Modelica.Mechanics.MultiBody.Parts.Body panelBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-88,-26},{-68,-6}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[6] annotation(Placement(transformation(extent={{78,20},{86,28}})));
equation
  connect(environment.sunVectorBody,sunVectorFromEnvironment.u) annotation(Line(points={{-100,-52},{-66.5,-52},{-66.5,70},{-90,70}},color={0,0,127}));
  connect(environment.solarFlux,solarFluxFromEnvironment.u) annotation(Line(points={{-100,-52},{-66.5,-52},{-66.5,58},{-90,58}},color={0,0,127}));
  connect(environment.earthVectorBody,earthVectorFromEnvironment.u) annotation(Line(points={{-100,-52},{-66.5,-52},{-66.5,26},{-90,26}},color={0,0,127}));
  connect(environment.albedoFlux,albedoFluxFromEnvironment.u) annotation(Line(points={{-100,-52},{-66.5,-52},{-66.5,16},{-90,16}},color={0,0,127}));
  connect(environment.earthInfraredFlux,earthInfraredFluxFromEnvironment.u) annotation(Line(points={{-100,-52},{-94,-52},{-94,6},{-90,6}},color={0,0,127}));
  connect(information.device.solarCurtailmentFactor,curtailmentFromInformation.u) annotation(Line(points={{100,0},{100,29.5},{-76.5,29.5},{-76.5,46},{-90,46}},color={0,0,127}));
  connect(information.device.rawSourceBusVoltageAverage,rawBusVoltageFromInformation.u) annotation(Line(points={{100,0},{94,0},{94,34},{-90,34}},color={0,0,127}));
  connect(sunVectorFromEnvironment.y,solarCalculation.sunVectorBody) annotation(Line(points={{-78,70},{-70,70},{-70,16.5},{-62,16.5}},color={0,0,127}));
  connect(solarFluxFromEnvironment.y,solarCalculation.solarFlux) annotation(Line(points={{-78,58},{-68,58},{-68,13.2},{-62,13.2}},color={0,0,127}));
  connect(earthVectorFromEnvironment.y,solarCalculation.earthVectorBody) annotation(Line(points={{-78,26},{-72,26},{-72,11},{-62,11}},color={0,0,127}));
  connect(albedoFluxFromEnvironment.y,solarCalculation.albedoFlux) annotation(Line(points={{-78,16},{-74,16},{-74,9},{-62,9}},color={0,0,127}));
  connect(earthInfraredFluxFromEnvironment.y,solarCalculation.earthInfraredFlux) annotation(Line(points={{-78,6},{-76,6},{-76,7},{-62,7}},color={0,0,127}));
  connect(curtailmentFromInformation.y,solarCalculation.curtailment) annotation(Line(points={{-78,46},{-66,46},{-66,9.9},{-62,9.9}},color={0,0,127}));
  connect(rawBusVoltageFromInformation.y,solarCalculation.rawSourceVoltage) annotation(Line(points={{-78,34},{-64,34},{-64,6.6},{-62,6.6}},color={0,0,127}));
  connect(terminalVoltage.v,solarCalculation.measuredTerminalVoltage) annotation(Line(points={{65.9,0},{-58,0},{-58,3.3},{-62,3.3}},color={0,0,127}));
  connect(mpptCurrent.i,solarCalculation.measuredTerminalCurrent) annotation(Line(points={{-12,37},{-56,37},{-56,0},{-62,0}},color={0,0,127}));
  connect(solarCalculation.sourceCurrentCommand,sourceA.i) annotation(Line(points={{-29.6,17.8},{-38,17.8},{-38,60}},color={0,0,127}));
  connect(sourceA.p,sourcePower.n) annotation(Line(points={{-48,48},{-48,94},{0,94},{0,100}},color={0,0,255}));
  connect(sourceA.n,mpptCurrent.p) annotation(Line(points={{-28,48},{-22,48}},color={0,0,255}));
  connect(mpptCurrent.n,equivalentDualHarness.p) annotation(Line(points={{-2,48},{6,48}},color={0,0,255}));
  connect(equivalentDualHarness.n,sourcePower.p) annotation(Line(points={{26,48},{26,94},{0,94},{0,100}},color={0,0,255}));
  connect(terminalVoltage.p,sourcePower.p) annotation(Line(points={{56,9},{56,94},{0,94},{0,100}},color={0,0,255}));
  connect(terminalVoltage.n,sourcePower.n) annotation(Line(points={{56,-9},{56,94},{0,94},{0,100}},color={0,0,255}));
  connect(inputDamping.p,sourcePower.p) annotation(Line(points={{76,9},{76,94},{0,94},{0,100}},color={0,0,255}));
  connect(inputDamping.n,sourcePower.n) annotation(Line(points={{76,-9},{76,94},{0,94},{0,100}},color={0,0,255}));
  connect(solarCalculation.subArrayVoltage,informationRealBridge[1].u) annotation(Line(points={{-29.6,5.5},{-29.6,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.subArrayVoltage[2]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(solarCalculation.mpptOperatingVoltage,informationRealBridge[2].u) annotation(Line(points={{-29.6,3.3},{-29.6,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[2].y,information.device.mpptVoltage[2]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(solarCalculation.mpptTelemetryCurrent,informationRealBridge[3].u) annotation(Line(points={{-29.6,1.1},{-29.6,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[3].y,information.device.mpptCurrent[2]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(solarCalculation.deliveredPower,informationRealBridge[4].u) annotation(Line(points={{-29.6,12.1},{78,12.1},{78,24}},color={0,0,127}));
  connect(informationRealBridge[4].y,information.device.solarOutputPower[2]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(solarCalculation.availablePower,informationRealBridge[5].u) annotation(Line(points={{-29.6,14.3},{78,14.3},{78,24}},color={0,0,127}));
  connect(informationRealBridge[5].y,information.device.availableSolarPower[2]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(solarCalculation.incidenceCos,informationRealBridge[6].u) annotation(Line(points={{-29.6,16.5},{78,16.5},{78,24}},color={0,0,127}));
  connect(informationRealBridge[6].y,information.device.solarIncidenceCos[2]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(solarCalculation.absorbedHeat,solarHeatInput.Q_flow) annotation(Line(points={{-29.6,9.9},{-42,9.9},{-42,-34}},color={0,0,127}));
  connect(solarHeatInput.port,panelThermalMass.port) annotation(Line(points={{-22,-34},{-10,-34},{-10,-30}},color={191,0,0}));
  connect(equivalentDualHarness.heatPort,panelThermalMass.port) annotation(Line(points={{16,38},{16,-30},{-10,-30}},color={191,0,0}));
  connect(inputDamping.heatPort,panelThermalMass.port) annotation(Line(points={{67,0},{67,-30},{-10,-30}},color={191,0,0}));
  connect(panelThermalMass.port,faceMountPath.port_a) annotation(Line(points={{-10,-50},{-10,-40},{20,-40}},color={191,0,0}));
  connect(faceMountPath.port_b,thermal) annotation(Line(points={{40,-40},{40,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(panelThermalMass.port,panelRadiation.port_a) annotation(Line(points={{-10,-50},{-10,-62},{20,-62}},color={191,0,0}));
  connect(panelRadiation.port_b,deepSpace.port) annotation(Line(points={{40,-62},{50,-62}},color={191,0,0}));
  connect(panelBody.frame_a,mechanical) annotation(Line(points={{-88,-16},{-94,-16},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={30,70,130},fillColor={224,235,250},fillPattern=FillPattern.Solid),Rectangle(extent={{-78,52},{78,-34}},lineColor={20,55,110},fillColor={30,76,145},fillPattern=FillPattern.Solid),Line(points={{-39,52},{-39,-34}},color={215,230,248},thickness=0.5),Line(points={{0,52},{0,-34}},color={215,230,248},thickness=0.5),Line(points={{39,52},{39,-34}},color={215,230,248},thickness=0.5),Line(points={{-78,23},{78,23}},color={215,230,248},thickness=0.5),Line(points={{-78,-6},{78,-6}},color={215,230,248},thickness=0.5),Text(extent={{-82,-67},{-24,-45}},textString="+Y",lineColor={25,65,120}),Text(extent={{-18,-67},{82,-45}},textString="MPPT 2",lineColor={25,65,120})}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Rectangle(extent={{-88,64},{48,0}},lineColor={0,0,160},pattern=LinePattern.Dash),Text(extent={{-84,72},{52,62}},textString="两串独立线束损耗并联汇流")}),Documentation(info="<html><h4>功能定位</h4><p>安装于+Y长侧面的独立体装太阳电池阵，毛面积为0.34 m×0.226 m，电池片覆盖率为90%。</p><h4>物理实现</h4><p>内部两串电池经独立线束损耗后并联汇流；+Y入射系数同时驱动可用功率、交付功率、热源和MPPT平均值遥测。</p><h4>接口关系</h4><p>电气端口连接原始电源母线，热端口连接整星热网络，机械端口表达安装关系，InformationPort输出设备状态。</p><h4>物理对象与接口</h4><p>本模型表示安装在+Y面的独立体装太阳电池阵，内部保留两串结构的工程语义。environment提供太阳方向和辐照度，information交付源端电压与限功率系数并接收本面MPPT量；sourcePower、thermal和mechanical分别接入原始电源、整星热网与结构安装基准。</p><h4>内部路径与主要计算</h4><p>RealSignalReader把共享环境字段送入BodyMountedSolarArrayPlusYCalculation。计算核心使用+Y面法向、覆盖面积、效率、温度修正和两串可用性得到光生电流及可用功率；标准库电流源、防反向二极管、传感器和面板热网络承担电热白箱表达。</p><h4>结果变量与使用方法</h4><p>优先查看availablePower、mpptVoltage、mpptCurrent、panelThermalMass.T及两串相关状态，并把本面识别为索引2。+Y功率与+X差异来自安装法向、有效覆盖和瞬时姿态，不应通过人为复制曲线消除。</p><h4>建模边界</h4><p>两串以任务级连续等效表示，不模拟单片失配、焊点热阻、旁路二极管瞬态和高频MPPT扰动观察算法。模型用于24 h发电分配、稳压输入和面板温度评估。</p></html>"));
end BodyMountedSolarArrayPlusYUnit;
