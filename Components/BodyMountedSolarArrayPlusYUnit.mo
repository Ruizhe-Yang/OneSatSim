within OneSatSim.Components;
model BodyMountedSolarArrayPlusYUnit "+Y长侧面体装双串太阳电池组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.SolarArrayPlusYComponentConfig config
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
  final parameter Modelica.Units.SI.Resistance inputDampingResistance=220
    "输入DampingResistance [Ohm]；Existing parallel MPPT damping resistor";
  parameter Modelica.Units.SI.Area activeArea=config.ActiveArea
    "激活Area [m2]；PHYSICAL CONFIGURATION: 90 percent cell coverage of one 12U long side";
  parameter Real cellEfficiency(min=0,max=1)=config.CellEfficiency "cell效率；Effective photovoltaic conversion efficiency";
  final parameter Modelica.Units.SI.Area stringAreaA=0.5*activeArea "配置项 stringAreaA [m2]" ;
  final parameter Modelica.Units.SI.Area stringAreaB=0.5*activeArea "配置项 stringAreaB [m2]" ;
  parameter Real solarEOLFactor(min=0,max=1)=config.SolarEOLFactor "配置项 solarEOLFactor" ;
  parameter Boolean useSolarEOL=config.UseSolarEOL "配置项 useSolarEOL；false=BOL factor 1.0; true=EOL factor 0.85";
  final parameter Real solarLifeFactor=if useSolarEOL then solarEOLFactor else 1 "配置项 solarLifeFactor" ;
  parameter Real etaMPPT(min=0,max=1)=config.MPPTDeliveryEfficiency
    "任务级参数: average MPPT plus dual-harness delivery efficiency";
  parameter Real panelSolarAbsorptivity(min=0,max=1)=config.SolarAbsorptivity "配置项 panelSolarAbsorptivity" ;
  parameter Real panelInfraredAbsorptivity(min=0,max=1)=config.InfraredAbsorptivity "配置项 panelInfraredAbsorptivity" ;
  parameter Real panelEmissivity(min=0,max=1)=config.Emissivity "配置项 panelEmissivity" ;
  parameter Modelica.Units.SI.ThermalConductance panelMountConductance=config.MountConductance "配置项 panelMountConductance [W/K]" ;
  parameter Real panelNormalBody[3]={config.Normal_X,config.Normal_Y,config.Normal_Z}
    "panelNormal本体；PHYSICAL INSTALLATION: body +Y";
  Foundation.Interfaces.SourcePowerPort sourcePower  "源功率" annotation(Placement(visible=true, transformation(origin={535,230}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,95}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.ThermalPort thermal  "热学" annotation(Placement(visible=true, transformation(origin={530,-135}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,-97}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(visible=true, transformation(origin={-470,-245}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-12,-12},{12,12}}, rotation=0)));
  Foundation.Interfaces.EnvironmentPort environment  "外部环境接口或实例" annotation(Placement(visible=true, transformation(origin={-470,150}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-12,-12},{12,12}}, rotation=0)));
  Foundation.Interfaces.InformationPort information  "计算/接口量 information" annotation(Placement(visible=true, transformation(origin={535,25}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.RealSignalReader sunVectorFromEnvironment[3]  "可扩展总线实数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-330,200}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.RealSignalReader solarFluxFromEnvironment  "可扩展总线实数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-185,265}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.RealSignalReader earthVectorFromEnvironment[3]  "可扩展总线实数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-330,75}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.RealSignalReader albedoFluxFromEnvironment  "可扩展总线实数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-185,130}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.RealSignalReader earthInfraredFluxFromEnvironment  "可扩展总线实数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-330,-60}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.RealSignalReader curtailmentFromInformation  "可扩展总线实数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={10,-120}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Calculations.SolarArrayPerformanceCalculation solarCalculation(
    activeArea=activeArea,cellEfficiency=cellEfficiency,solarLifeFactor=solarLifeFactor,
    etaMPPT=etaMPPT,harnessResistance=harnessResistance,
    parasiticConductance=1/inputDampingResistance,
    panelNormalBody=panelNormalBody,nominalSubArrayVoltage=5.5,nominalMpptVoltage=3.445,
    solarAbsorptivity=panelSolarAbsorptivity,infraredAbsorptivity=panelInfraredAbsorptivity) 
     "体装太阳阵电热性能计算实例" annotation(Placement(visible=true, transformation(origin={0,110}, extent={{-76,-76},{76,76}}, rotation=0)));
  Modelica.Electrical.Analog.Sources.SignalCurrent sourceA  "源A" annotation(Placement(visible=true, transformation(origin={180,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor mpptCurrent  "mppt电流" annotation(Placement(visible=true, transformation(origin={280,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor equivalentDualHarness(R=harnessResistance,useHeatPort=true)
    "两条0.08/0.09 ohm线束的并联平均值等效" annotation(Placement(visible=true, transformation(origin={385,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor terminalVoltage  "terminal电压" annotation(Placement(visible=true, transformation(origin={285,125}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor inputDamping(R=inputDampingResistance,useHeatPort=true)
    "MPPT2输入泄放及阻尼通路" annotation(Placement(visible=true, transformation(origin={395,125}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow solarHeatInput  "solar热流输入" annotation(Placement(visible=true, transformation(origin={170,-105}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor panelThermalMass(C=panelHeatCapacity,T(start=310.03,fixed=false))  "panel热学质量" annotation(Placement(visible=true, transformation(origin={290,-105}, extent={{-30,-30},{30,30}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor faceMountPath(G=panelMountConductance)
    "面板至舱板安装导热" annotation(Placement(visible=true, transformation(origin={415,-135}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.BodyRadiation panelRadiation(Gr=panelEmissivity*activeArea)  "计算/接口量 panelRadiation" annotation(Placement(visible=true, transformation(origin={290,-260}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature deepSpace(T=3)  "计算/接口量 deepSpace" annotation(Placement(visible=true, transformation(origin={420,-260}, extent={{-24,-24},{24,24}}, rotation=180)));
  Modelica.Mechanics.MultiBody.Parts.Body panelBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ)  "panel本体" annotation(Placement(visible=true, transformation(origin={-360,-245}, extent={{-32,-32},{32,32}}, rotation=0)));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[6]  "实数因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={410,-10}, extent={{-16,-16},{16,16}}, rotation=0)));
equation
  connect(environment.sunVectorBody,sunVectorFromEnvironment.u) annotation(Line(points={{-470,150},{-470,200},{-344.24,200}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(environment.solarFlux,solarFluxFromEnvironment.u) annotation(Line(points={{-470,150},{-470,265},{-199.24,265}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(environment.earthVectorBody,earthVectorFromEnvironment.u) annotation(Line(points={{-470,150},{-470,75},{-344.24,75}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(environment.albedoFlux,albedoFluxFromEnvironment.u) annotation(Line(points={{-470,150},{-470,130},{-199.24,130}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(environment.earthInfraredFlux,earthInfraredFluxFromEnvironment.u) annotation(Line(points={{-470,150},{-470,-60},{-344.24,-60}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information.device.solarCurtailmentFactor,curtailmentFromInformation.u) annotation(Line(points={{535,25},{535,-71},{-37.38,-71},{-37.38,-120},{-4.24,-120}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(sunVectorFromEnvironment.y,solarCalculation.sunVectorBody) annotation(Line(points={{-315.76,200},{-77.64,200},{-77.64,170.8},{-67.64,170.8}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(solarFluxFromEnvironment.y,solarCalculation.solarFlux) annotation(Line(points={{-170.76,265},{-77.64,265},{-77.64,153.42857},{-67.64,153.42857}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(earthVectorFromEnvironment.y,solarCalculation.earthVectorBody) annotation(Line(points={{-315.76,75},{-77.64,75},{-77.64,136.05714},{-67.64,136.05714}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(albedoFluxFromEnvironment.y,solarCalculation.albedoFlux) annotation(Line(points={{-170.76,130},{-77.64,130},{-77.64,118.68571},{-67.64,118.68571}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(earthInfraredFluxFromEnvironment.y,solarCalculation.earthInfraredFlux) annotation(Line(points={{-315.76,-60},{-77.64,-60},{-77.64,101.31429},{-67.64,101.31429}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(curtailmentFromInformation.y,solarCalculation.curtailment) annotation(Line(points={{24.24,-120},{57.38,-120},{57.38,-71},{-77.64,-71},{-77.64,83.94286},{-67.64,83.94286}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(terminalVoltage.v,solarCalculation.measuredTerminalVoltage) annotation(Line(points={{285,98.6},{285,26.28},{-77.64,26.28},{-77.64,66.57143},{-67.64,66.57143}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mpptCurrent.i,solarCalculation.measuredTerminalCurrent) annotation(Line(points={{280,203.6},{280,193.6},{-77.64,193.6},{-77.64,49.2},{-67.64,49.2}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(solarCalculation.sourceCurrentCommand,sourceA.i) annotation(Line(points={{67.64,170.8},{77.64,170.8},{77.64,268.8},{180,268.8},{180,258.8}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(sourceA.p,sourcePower.n) annotation(Line(points={{156,230},{146,230},{146,196},{535,196},{535,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(sourceA.n,mpptCurrent.p) annotation(Line(points={{204,230},{256,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mpptCurrent.n,equivalentDualHarness.p) annotation(Line(points={{304,230},{361,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(equivalentDualHarness.n,sourcePower.p) annotation(Line(points={{409,230},{535,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(terminalVoltage.p,sourcePower.p) annotation(Line(points={{261,125},{251,125},{251,159},{535,159},{535,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(terminalVoltage.n,sourcePower.n) annotation(Line(points={{309,125},{319,125},{319,159},{535,159},{535,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(inputDamping.p,sourcePower.p) annotation(Line(points={{371,125},{361,125},{361,159},{535,159},{535,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(inputDamping.n,sourcePower.n) annotation(Line(points={{419,125},{535,125},{535,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(solarCalculation.subArrayVoltage,informationRealBridge[1].u) annotation(Line(points={{67.64,83.94286},{324,83.94286},{324,-10},{395.76,-10}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[1].y,information.device.subArrayVoltage[2]) annotation(Line(points={{424.24,-10},{535,-10},{535,25}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(solarCalculation.mpptOperatingVoltage,informationRealBridge[2].u) annotation(Line(points={{67.64,66.57143},{324,66.57143},{324,-10},{395.76,-10}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[2].y,information.device.mpptVoltage[2]) annotation(Line(points={{424.24,-10},{535,-10},{535,25}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(solarCalculation.mpptTelemetryCurrent,informationRealBridge[3].u) annotation(Line(points={{67.64,49.2},{324,49.2},{324,-10},{395.76,-10}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[3].y,information.device.mpptCurrent[2]) annotation(Line(points={{424.24,-10},{535,-10},{535,25}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(solarCalculation.deliveredPower,informationRealBridge[4].u) annotation(Line(points={{67.64,118.68571},{77.64,118.68571},{77.64,91},{362.62,91},{362.62,-10},{395.76,-10}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[4].y,information.device.solarOutputPower[2]) annotation(Line(points={{424.24,-10},{535,-10},{535,25}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(solarCalculation.availablePower,informationRealBridge[5].u) annotation(Line(points={{67.64,136.05714},{77.64,136.05714},{77.64,91},{362.62,91},{362.62,-10},{395.76,-10}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[5].y,information.device.availableSolarPower[2]) annotation(Line(points={{424.24,-10},{535,-10},{535,25}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(solarCalculation.incidenceCos,informationRealBridge[6].u) annotation(Line(points={{67.64,153.42857},{324,153.42857},{324,-10},{395.76,-10}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[6].y,information.device.solarIncidenceCos[2]) annotation(Line(points={{424.24,-10},{535,-10},{535,25}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(solarCalculation.absorbedHeat,solarHeatInput.Q_flow) annotation(Line(points={{67.64,101.31429},{77.64,101.31429},{77.64,-105},{146,-105}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(solarHeatInput.port,panelThermalMass.port) annotation(Line(points={{194,-105},{204,-105},{204,-145},{290,-145},{290,-135}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(equivalentDualHarness.heatPort,panelThermalMass.port) annotation(Line(points={{385,206},{385,196},{324,196},{324,-145},{290,-145},{290,-135}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(inputDamping.heatPort,panelThermalMass.port) annotation(Line(points={{395,101},{395,91},{324,91},{324,-145},{290,-145},{290,-135}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(panelThermalMass.port,faceMountPath.port_a) annotation(Line(points={{290,-135},{290,-145},{381,-145},{381,-135},{391,-135}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(faceMountPath.port_b,thermal) annotation(Line(points={{439,-135},{530,-135}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(panelThermalMass.port,panelRadiation.port_a) annotation(Line(points={{290,-135},{290,-145},{256,-145},{256,-260},{266,-260}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(panelRadiation.port_b,deepSpace.port) annotation(Line(points={{314,-260},{396,-260}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(panelBody.frame_a,mechanical) annotation(Line(points={{-392,-245},{-470,-245}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>+Y长侧面体装双串太阳电池组件</h2><p><b>类路径：</b><code>OneSatSim.Components.BodyMountedSolarArrayPlusYUnit</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>+Y长侧面体装双串太阳电池组件</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.N_systems.ElectricalPowerSystem\">OneSatSim.Systems.N_systems.ElectricalPowerSystem</a> 的 <code>solarArrayPlusY</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>sourcePower</code></td><td>Foundation.Interfaces.SourcePowerPort</td><td>public</td><td>按声明/类型合同</td><td>源功率</td></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr><tr><td><code>environment</code></td><td>Foundation.Interfaces.EnvironmentPort</td><td>public</td><td>按声明/类型合同</td><td>外部环境接口或实例</td></tr><tr><td><code>information</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr><tr><td><code>sunVectorFromEnvironment[3]</code></td><td>Foundation.Interfaces.RealSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线实数信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>solarFluxFromEnvironment</code></td><td>Foundation.Interfaces.RealSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线实数信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>earthVectorFromEnvironment[3]</code></td><td>Foundation.Interfaces.RealSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线实数信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>albedoFluxFromEnvironment</code></td><td>Foundation.Interfaces.RealSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线实数信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>earthInfraredFluxFromEnvironment</code></td><td>Foundation.Interfaces.RealSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线实数信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>curtailmentFromInformation</code></td><td>Foundation.Interfaces.RealSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线实数信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>informationRealBridge[6]</code></td><td>Foundation.Interfaces.RealSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>实数因果输出到可扩展信息总线的无状态恒等桥实例</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>config</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.SolarArrayPlusYComponentConfig</td><td>由所属N-System传入的硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>harnessResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>太阳阵线束/阻断路径电阻；Excel单位Ω，当前设计基线</td><td><code>=config.HarnessResistance</code></td></tr><tr><td><code>panelHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>面板等效热容；Excel单位J/K，当前设计基线</td><td><code>=config.PanelHeatCapacity</code></td></tr><tr><td><code>mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel单位kg，当前设计基线</td><td><code>=config.Mass</code></td></tr><tr><td><code>rcm_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel单位m，当前设计基线</td><td><code>=config.RCM_X</code></td></tr><tr><td><code>rcm_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel单位m，当前设计基线</td><td><code>=config.RCM_Y</code></td></tr><tr><td><code>rcm_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel单位m，当前设计基线</td><td><code>=config.RCM_Z</code></td></tr><tr><td><code>inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_XX</code></td></tr><tr><td><code>inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_YY</code></td></tr><tr><td><code>inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_ZZ</code></td></tr><tr><td><code>inputDampingResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>输入DampingResistance [Ohm]；Existing parallel MPPT damping resistor</td><td><code>=220</code></td></tr><tr><td><code>activeArea</code></td><td>Modelica.Units.SI.Area</td><td>激活Area [m2]；PHYSICAL CONFIGURATION: 90 percent cell coverage of one 12U long side</td><td><code>=config.ActiveArea</code></td></tr><tr><td><code>cellEfficiency</code></td><td>Real</td><td>cell效率；Effective photovoltaic conversion efficiency</td><td><code>=config.CellEfficiency</code></td></tr><tr><td><code>stringAreaA</code></td><td>Modelica.Units.SI.Area</td><td>配置项 stringAreaA [m2]</td><td><code>=0.5*activeArea</code></td></tr><tr><td><code>stringAreaB</code></td><td>Modelica.Units.SI.Area</td><td>配置项 stringAreaB [m2]</td><td><code>=0.5*activeArea</code></td></tr><tr><td><code>solarEOLFactor</code></td><td>Real</td><td>配置项 solarEOLFactor</td><td><code>=config.SolarEOLFactor</code></td></tr><tr><td><code>useSolarEOL</code></td><td>Boolean</td><td>配置项 useSolarEOL；false=BOL factor 1.0; true=EOL factor 0.85</td><td><code>=config.UseSolarEOL</code></td></tr><tr><td><code>solarLifeFactor</code></td><td>Real</td><td>配置项 solarLifeFactor</td><td><code>=if useSolarEOL then solarEOLFactor else 1</code></td></tr><tr><td><code>etaMPPT</code></td><td>Real</td><td>任务级参数: average MPPT plus dual-harness delivery efficiency</td><td><code>=config.MPPTDeliveryEfficiency</code></td></tr><tr><td><code>panelSolarAbsorptivity</code></td><td>Real</td><td>配置项 panelSolarAbsorptivity</td><td><code>=config.SolarAbsorptivity</code></td></tr><tr><td><code>panelInfraredAbsorptivity</code></td><td>Real</td><td>配置项 panelInfraredAbsorptivity</td><td><code>=config.InfraredAbsorptivity</code></td></tr><tr><td><code>panelEmissivity</code></td><td>Real</td><td>配置项 panelEmissivity</td><td><code>=config.Emissivity</code></td></tr><tr><td><code>panelMountConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>配置项 panelMountConductance [W/K]</td><td><code>=config.MountConductance</code></td></tr><tr><td><code>panelNormalBody[3]</code></td><td>Real</td><td>panelNormal本体；PHYSICAL INSTALLATION: body +Y</td><td><code>={config.Normal_X,config.Normal_Y,config.Normal_Z}</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>solarCalculation</code></td><td><a href=\"modelica://OneSatSim.Foundation.Calculations.SolarArrayPerformanceCalculation\">OneSatSim.Foundation.Calculations.SolarArrayPerformanceCalculation</a></td><td>体装太阳阵电热性能计算实例</td></tr><tr><td><code>sourceA</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Sources.SignalCurrent\">Modelica.Electrical.Analog.Sources.SignalCurrent</a></td><td>源A</td></tr><tr><td><code>mpptCurrent</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Sensors.CurrentSensor\">Modelica.Electrical.Analog.Sensors.CurrentSensor</a></td><td>mppt电流</td></tr><tr><td><code>equivalentDualHarness</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Resistor\">Modelica.Electrical.Analog.Basic.Resistor</a></td><td>两条0.08/0.09 ohm线束的并联平均值等效</td></tr><tr><td><code>terminalVoltage</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Sensors.VoltageSensor\">Modelica.Electrical.Analog.Sensors.VoltageSensor</a></td><td>terminal电压</td></tr><tr><td><code>inputDamping</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Resistor\">Modelica.Electrical.Analog.Basic.Resistor</a></td><td>MPPT2输入泄放及阻尼通路</td></tr><tr><td><code>solarHeatInput</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow\">Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow</a></td><td>solar热流输入</td></tr><tr><td><code>panelThermalMass</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a></td><td>panel热学质量</td></tr><tr><td><code>faceMountPath</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">Modelica.Thermal.HeatTransfer.Components.ThermalConductor</a></td><td>面板至舱板安装导热</td></tr><tr><td><code>panelRadiation</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.BodyRadiation\">Modelica.Thermal.HeatTransfer.Components.BodyRadiation</a></td><td>计算/接口量 panelRadiation</td></tr><tr><td><code>deepSpace</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Sources.FixedTemperature\">Modelica.Thermal.HeatTransfer.Sources.FixedTemperature</a></td><td>计算/接口量 deepSpace</td></tr><tr><td><code>panelBody</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">Modelica.Mechanics.MultiBody.Parts.Body</a></td><td>panel本体</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={77,126,172}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Power unit", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-46,-40},{17,44}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Rectangle(extent={{-42,-36},{-29.75,-25}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-40,-34},{-31.75,-27}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-42,-23},{-29.75,-12}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-40,-21},{-31.75,-14}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-42,-10},{-29.75,1}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-40,-8},{-31.75,-1}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-42,3},{-29.75,14}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-40,5},{-31.75,12}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-42,16},{-29.75,27}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-40,18},{-31.75,25}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-42,29},{-29.75,40}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-40,31},{-31.75,38}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-27.75,-36},{-15.5,-25}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-25.75,-34},{-17.5,-27}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-27.75,-23},{-15.5,-12}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-25.75,-21},{-17.5,-14}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-27.75,-10},{-15.5,1}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-25.75,-8},{-17.5,-1}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-27.75,3},{-15.5,14}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-25.75,5},{-17.5,12}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-27.75,16},{-15.5,27}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-25.75,18},{-17.5,25}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-27.75,29},{-15.5,40}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-25.75,31},{-17.5,38}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-13.5,-36},{-1.25,-25}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-11.5,-34},{-3.25,-27}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-13.5,-23},{-1.25,-12}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-11.5,-21},{-3.25,-14}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-13.5,-10},{-1.25,1}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-11.5,-8},{-3.25,-1}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-13.5,3},{-1.25,14}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-11.5,5},{-3.25,12}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-13.5,16},{-1.25,27}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-11.5,18},{-3.25,25}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-13.5,29},{-1.25,40}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-11.5,31},{-3.25,38}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{0.75,-36},{13,-25}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{2.75,-34},{11,-27}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{0.75,-23},{13,-12}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{2.75,-21},{11,-14}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{0.75,-10},{13,1}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{2.75,-8},{11,-1}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{0.75,3},{13,14}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{2.75,5},{11,12}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{0.75,16},{13,27}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{2.75,18},{11,25}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{0.75,29},{13,40}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{2.75,31},{11,38}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Ellipse(extent={{46,29},{60,43}}, lineColor={0,0,0}, fillColor={255,246,210}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Line(points={{63,36},{68,36}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{60.071068,43.071068},{63.606602,46.606602}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{53,46},{53,51}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{45.928932,43.071068},{42.393398,46.606602}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{43,36},{38,36}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{45.928932,28.928932},{42.393398,25.393398}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{53,26},{53,21}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{60.071068,28.928932},{63.606602,25.393398}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{43,26},{17,9}}, color={212,109,62}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{49,18},{19,-1}}, color={212,109,62}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-15,-42},{-15,-48},{31,-48},{31,-24}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid),
      Polygon(points={{25,-24},{37,-24},{31,-14},{25,-24}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6),
      Line(points={{25,-14},{37,-14}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{31,-14},{31,-4},{61,-4}}, color={77,126,172}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Text(extent={{36,-41},{67,-22}}, textString="+Y", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Line(points={{-40,45},{-40,50},{-18,50},{-18,45}}, color={77,126,172}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-10,45},{-10,54},{11,54},{11,45}}, color={77,126,172}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Solar Array +Y", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-514,-322},{579,422}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-395,334},{-176.6,352}}, textString="Environment and conversion", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{125,294},{259.4,312}}, textString="Power generation", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{110,-37},{252.8,-19}}, textString="Thermal rejection", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-502,377},{567,406}}, textString="Solar array: environment, power and heat", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-502,369},{567,369}}, color={215,220,226}, thickness=0.25)
    }));
end BodyMountedSolarArrayPlusYUnit;