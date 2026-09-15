within NISSA_12UCubeSat.Components;
model BodyMountedSolarArrayPlusXUnit "+X长侧面体装太阳电池组件"
  parameter NISSA_12UCubeSat.Scenarios.DesignConfigRecords.SolarArrayPlusXComponentConfig config
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
    "PHYSICAL INSTALLATION: body +X";
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
  Foundation.Calculations.BodyMountedSolarArrayPlusXCalculation solarCalculation(
    activeArea=activeArea,cellEfficiency=cellEfficiency,solarLifeFactor=solarLifeFactor,
    etaMPPT=etaMPPT,panelNormalBody=panelNormalBody,
    solarAbsorptivity=panelSolarAbsorptivity,infraredAbsorptivity=panelInfraredAbsorptivity)
    annotation(Placement(transformation(extent={{-62,-2},{-30,20}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent stringSource annotation(Placement(transformation(extent={{-38,24},{-18,44}})));
  Modelica.Electrical.Analog.Basic.Resistor blockingHarness(R=harnessResistance,useHeatPort=true)
    "Average MPPT/harness path; the nonnegative controlled source already enforces reverse blocking" annotation(Placement(transformation(extent={{15,24},{35,44}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor mpptCurrent annotation(Placement(transformation(extent={{-10,24},{10,44}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor mpptVoltage annotation(Placement(transformation(origin={42,0},extent={{-9,-9},{9,9}},rotation=270)));
  Modelica.Electrical.Analog.Basic.Conductor inputFilter(G=0) annotation(Placement(transformation(origin={68,0},extent={{-9,-9},{9,9}},rotation=270)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatInput annotation(Placement(transformation(extent={{-35,-28},{-15,-8}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor panelThermalMass(C=panelHeatCapacity,T(start=301.64,fixed=false)) annotation(Placement(transformation(extent={{0,-45},{20,-25}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor faceMountPath(G=panelMountConductance) "面板至舱板安装导热" annotation(Placement(transformation(extent={{35,-43},{55,-27}})));
  Modelica.Thermal.HeatTransfer.Components.BodyRadiation panelRadiation(Gr=panelEmissivity*activeArea) annotation(Placement(transformation(extent={{35,-68},{55,-48}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature deepSpace(T=3) annotation(Placement(transformation(extent={{65,-68},{85,-48}})));
  Modelica.Mechanics.MultiBody.Parts.Body panelBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-88,-26},{-68,-6}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[6] annotation(Placement(transformation(extent={{78,20},{86,28}})));
equation
  connect(environment.sunVectorBody,sunVectorFromEnvironment.u) annotation(Line(points={{-100,-52},{-66.5,-52},{-66.5,70},{-90,70}},color={0,0,127}));
  connect(environment.solarFlux,solarFluxFromEnvironment.u) annotation(Line(points={{-100,-52},{-66.5,-52},{-66.5,58},{-90,58}},color={0,0,127}));
  connect(environment.earthVectorBody,earthVectorFromEnvironment.u) annotation(Line(points={{-100,-52},{-66.5,-52},{-66.5,26},{-90,26}},color={0,0,127}));
  connect(environment.albedoFlux,albedoFluxFromEnvironment.u) annotation(Line(points={{-100,-52},{-66.5,-52},{-66.5,16},{-90,16}},color={0,0,127}));
  connect(environment.earthInfraredFlux,earthInfraredFluxFromEnvironment.u) annotation(Line(points={{-100,-52},{-94,-52},{-94,6},{-90,6}},color={0,0,127}));
  connect(information.device.solarCurtailmentFactor,curtailmentFromInformation.u) annotation(Line(points={{100,0},{94,0},{94,46},{-90,46}},color={0,0,127}));
  connect(information.device.rawSourceBusVoltageAverage,rawBusVoltageFromInformation.u) annotation(Line(points={{100,0},{100,10.5},{-28.5,10.5},{-28.5,22.5},{-76.5,22.5},{-76.5,34},{-90,34}},color={0,0,127}));
  connect(sunVectorFromEnvironment.y,solarCalculation.sunVectorBody) annotation(Line(points={{-78,70},{-70,70},{-70,16.5},{-62,16.5}},color={0,0,127}));
  connect(solarFluxFromEnvironment.y,solarCalculation.solarFlux) annotation(Line(points={{-78,58},{-68,58},{-68,13.2},{-62,13.2}},color={0,0,127}));
  connect(earthVectorFromEnvironment.y,solarCalculation.earthVectorBody) annotation(Line(points={{-78,26},{-72,26},{-72,11},{-62,11}},color={0,0,127}));
  connect(albedoFluxFromEnvironment.y,solarCalculation.albedoFlux) annotation(Line(points={{-78,16},{-74,16},{-74,9},{-62,9}},color={0,0,127}));
  connect(earthInfraredFluxFromEnvironment.y,solarCalculation.earthInfraredFlux) annotation(Line(points={{-78,6},{-76,6},{-76,7},{-62,7}},color={0,0,127}));
  connect(curtailmentFromInformation.y,solarCalculation.curtailment) annotation(Line(points={{-78,46},{-66,46},{-66,9.9},{-62,9.9}},color={0,0,127}));
  connect(rawBusVoltageFromInformation.y,solarCalculation.rawSourceVoltage) annotation(Line(points={{-78,34},{-64,34},{-64,6.6},{-62,6.6}},color={0,0,127}));
  connect(mpptVoltage.v,solarCalculation.measuredTerminalVoltage) annotation(Line(points={{51.9,0},{-58,0},{-58,3.3},{-62,3.3}},color={0,0,127}));
  connect(mpptCurrent.i,solarCalculation.measuredTerminalCurrent) annotation(Line(points={{0,23},{-56,23},{-56,0},{-62,0}},color={0,0,127}));
  connect(solarCalculation.sourceCurrentCommand,stringSource.i) annotation(Line(points={{-29.6,17.8},{-28,17.8},{-28,46}},color={0,0,127}));
  connect(stringSource.p,sourcePower.n) annotation(Line(points={{-38,34},{-38,94},{0,94},{0,100}},color={0,0,255}));
  connect(stringSource.n,mpptCurrent.p) annotation(Line(points={{-18,34},{-10,34}},color={0,0,255}));
  connect(mpptCurrent.n,blockingHarness.p) annotation(Line(points={{10,34},{15,34}},color={0,0,255}));
  connect(blockingHarness.n,sourcePower.p) annotation(Line(points={{35,34},{35,94},{0,94},{0,100}},color={0,0,255}));
  connect(mpptVoltage.p,sourcePower.p) annotation(Line(points={{42,9},{42,94},{0,94},{0,100}},color={0,0,255}));
  connect(mpptVoltage.n,sourcePower.n) annotation(Line(points={{42,-9},{42,94},{0,94},{0,100}},color={0,0,255}));
  connect(inputFilter.p,sourcePower.p) annotation(Line(points={{68,9},{68,94},{0,94},{0,100}},color={0,0,255}));
  connect(inputFilter.n,sourcePower.n) annotation(Line(points={{68,-9},{68,94},{0,94},{0,100}},color={0,0,255}));
  connect(solarCalculation.subArrayVoltage,informationRealBridge[1].u) annotation(Line(points={{-29.6,5.5},{31.5,5.5},{31.5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.subArrayVoltage[1]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(solarCalculation.mpptOperatingVoltage,informationRealBridge[2].u) annotation(Line(points={{-29.6,3.3},{31.5,3.3},{31.5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[2].y,information.device.mpptVoltage[1]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(solarCalculation.mpptTelemetryCurrent,informationRealBridge[3].u) annotation(Line(points={{-29.6,1.1},{31.5,1.1},{31.5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[3].y,information.device.mpptCurrent[1]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(solarCalculation.deliveredPower,informationRealBridge[4].u) annotation(Line(points={{-29.6,12.1},{78,12.1},{78,24}},color={0,0,127}));
  connect(informationRealBridge[4].y,information.device.solarOutputPower[1]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(solarCalculation.availablePower,informationRealBridge[5].u) annotation(Line(points={{-29.6,14.3},{78,14.3},{78,24}},color={0,0,127}));
  connect(informationRealBridge[5].y,information.device.availableSolarPower[1]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(solarCalculation.incidenceCos,informationRealBridge[6].u) annotation(Line(points={{-29.6,16.5},{78,16.5},{78,24}},color={0,0,127}));
  connect(informationRealBridge[6].y,information.device.solarIncidenceCos[1]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(solarCalculation.absorbedHeat,heatInput.Q_flow) annotation(Line(points={{-29.6,9.9},{-35,9.9},{-35,-18}},color={0,0,127}));
  connect(heatInput.port,panelThermalMass.port) annotation(Line(points={{-15,-18},{10,-18},{10,-25}},color={191,0,0}));
  connect(blockingHarness.heatPort,panelThermalMass.port) annotation(Line(points={{25,24},{25,-2},{10,-2},{10,-25}},color={191,0,0}));
  connect(panelThermalMass.port,faceMountPath.port_a) annotation(Line(points={{10,-45},{10,-35},{35,-35}},color={191,0,0}));
  connect(faceMountPath.port_b,thermal) annotation(Line(points={{55,-35},{55,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(panelThermalMass.port,panelRadiation.port_a) annotation(Line(points={{10,-45},{10,-58},{35,-58}},color={191,0,0}));
  connect(panelRadiation.port_b,deepSpace.port) annotation(Line(points={{55,-58},{65,-58}},color={191,0,0}));
  connect(panelBody.frame_a,mechanical) annotation(Line(points={{-88,-16},{-94,-16},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={30,70,130},fillColor={224,235,250},fillPattern=FillPattern.Solid),Rectangle(extent={{-78,52},{78,-34}},lineColor={20,55,110},fillColor={30,76,145},fillPattern=FillPattern.Solid),Line(points={{-39,52},{-39,-34}},color={215,230,248},thickness=0.5),Line(points={{0,52},{0,-34}},color={215,230,248},thickness=0.5),Line(points={{39,52},{39,-34}},color={215,230,248},thickness=0.5),Line(points={{-78,23},{78,23}},color={215,230,248},thickness=0.5),Line(points={{-78,-6},{78,-6}},color={215,230,248},thickness=0.5),Text(extent={{-82,-67},{-24,-45}},textString="+X",lineColor={25,65,120}),Text(extent={{-18,-67},{82,-45}},textString="MPPT 1",lineColor={25,65,120})}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Rectangle(extent={{-85,56},{78,16}},lineColor={0,0,160},pattern=LinePattern.Dash),Text(extent={{-80,65},{45,55}},textString="光生电流-防反二极管-滤波")}),Documentation(info="<html><h4>功能定位</h4><p>安装于+X长侧面的独立体装太阳电池阵，毛面积为0.34 m×0.226 m，电池片覆盖率为90%。</p><h4>物理实现</h4><p>可用太阳功率由入射几何、光电效率和辐照度决定；端口功率表示向原始电源母线交付的功率。MPPT电压和电流构成同一平均值工作点。</p><h4>建模边界</h4><p>板级去耦和电磁兼容元件采用直流平均值等效，保留稳态电流、功率、损耗、热量和遥测语义。</p><h4>物理对象与接口</h4><p>本模型表示安装在+X面的独立体装太阳电池阵。environment提供机体系太阳向量和太阳辐照度，information提供源端母线电压及PCDU限功率系数，同时接收本面MPPT电压、电流、可用功率和温度；sourcePower连接原始电源双线域，thermal和mechanical分别连接面板热节点及安装质量。</p><h4>内部路径与主要计算</h4><p>共享环境量先由RealSignalReader形成明确因果输入，BodyMountedSolarArrayPlusXCalculation依据+X法向、有效面积、光电效率、温度系数和入射余弦计算光生电流及功率。SignalCurrent、防反向二极管、电压/电流传感器、面板热容和安装导热构成可追踪白箱；Calculation输出再经Bridge回写统一信息总线。</p><h4>结果变量与使用方法</h4><p>优先查看solarCalculation.incidenceCos、availablePower、mpptVoltage、mpptCurrent以及panelThermalMass.T，并和environment.eclipse、solarFlux及information.device.solarCurtailmentFactor联合解释。该面索引为1；三个面必须分别分析，不能把阵列功率简单视为相同副本。</p><h4>建模边界</h4><p>采用连续平均值MPPT和单结等效功率关系，不展开逐片I-V曲线、旁路二极管失配、局部遮挡、辐照退化与开关级变换器。输出仍满足源端电压和功率限制，适用于总体能量与热平衡。</p></html>"));
end BodyMountedSolarArrayPlusXUnit;
