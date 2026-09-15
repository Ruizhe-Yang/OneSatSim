within OneSatSim.Systems.Four_systems;
model ThermalOverall "热学总体"
  parameter OneSatSim.Scenarios.DesignConfigRecords.OverallComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.HeatCapacity busDeckHeatCapacity=config.BusDeckHeatCapacity
    "内部设备舱板热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity externalShellHeatCapacity=config.ExternalShellHeatCapacity
    "外表面热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance shellToBusConductance=config.ShellToBusConductance
    "外壳-舱板导热；Excel单位W/K，当前设计基线";
  parameter Modelica.Units.SI.Temperature initialBusDeckTemperature=304.31 "场景内部设备舱板初温";
  parameter Modelica.Units.SI.Temperature initialExternalShellTemperature=276.27 "场景外表面等效热节点初温";
  parameter Modelica.Units.SI.Area grossLongFaceArea=0.226*0.340 "12U长侧面面积";
  parameter Modelica.Units.SI.Area grossEndFaceArea=0.226*0.226 "12U端面面积";
  parameter Modelica.Units.SI.Area plusXCellCoveredArea=0.069156 "+X体装太阳电池覆盖面积";
  parameter Modelica.Units.SI.Area plusYCellCoveredArea=0.069156 "+Y体装太阳电池覆盖面积";
  parameter Modelica.Units.SI.Area minusXCellCoveredArea=0.062240 "-X体装太阳电池覆盖面积";
  parameter Real bodySolarAbsorptivity(min=0,max=1)=config.BodySolarAbsorptivity;
  parameter Real bodyInfraredAbsorptivity(min=0,max=1)=config.BodyInfraredAbsorptivity;
  parameter Real externalEmissivity(min=0,max=1)=config.ExternalEmissivity;
  parameter Modelica.Units.SI.Area radiatingArea=max(0,
    2*(2*grossLongFaceArea+grossEndFaceArea)-plusXCellCoveredArea-plusYCellCoveredArea-minusXCellCoveredArea)
    "扣除三个独立面板覆盖区后的裸露外壳辐射面积";
  Foundation.Interfaces.ThermalPort subsystem[8] annotation(Placement(transformation(extent={{-112,-10},{-92,10}})));
  Foundation.Interfaces.EnvironmentPort environment annotation(Placement(transformation(extent={{-112,55},{-92,75}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor busDeck(
    C=busDeckHeatCapacity,T(start=initialBusDeckTemperature,fixed=true))
    "内部设备安装舱板热节点" annotation(Placement(transformation(extent={{-25,-5},{-5,15}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor externalShell(
    C=externalShellHeatCapacity,T(start=initialExternalShellTemperature,fixed=false))
    "直接接收太阳、反照和地球红外的外壳热节点" annotation(Placement(transformation(extent={{15,35},{35,55}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor shellToBus(G=shellToBusConductance)
    "外壳至设备舱板的有限安装导热" annotation(Placement(transformation(extent={{0,15},{20,31}})));
  Modelica.Thermal.HeatTransfer.Components.BodyRadiation bodyRadiation(
    Gr=externalEmissivity*radiatingArea)
    "裸露外壳对深空Stefan-Boltzmann辐射路径" annotation(Placement(transformation(extent={{45,15},{65,35}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature deepSpace(T=3)
    annotation(Placement(transformation(extent={{75,15},{95,35}})));
  Foundation.Calculations.ExternalOrbitalHeatCalculation externalHeatCalculation(
    grossLongFaceArea=grossLongFaceArea,
    grossEndFaceArea=grossEndFaceArea,
    plusXCellCoveredArea=plusXCellCoveredArea,
    plusYCellCoveredArea=plusYCellCoveredArea,
    minusXCellCoveredArea=minusXCellCoveredArea,
    bodySolarAbsorptivity=bodySolarAbsorptivity,
    bodyInfraredAbsorptivity=bodyInfraredAbsorptivity)
    "太阳、反照与地球红外热流计算" annotation(Placement(transformation(extent={{-86,30},{-62,46}})));
  Foundation.Interfaces.RealSignalReader sunVectorReader[3]
    annotation(Placement(transformation(extent={{-96,42},{-88,46}})));
  Foundation.Interfaces.RealSignalReader earthVectorReader[3]
    annotation(Placement(transformation(extent={{-96,39.5},{-88,43.5}})));
  Foundation.Interfaces.RealSignalReader solarFluxReader
    annotation(Placement(transformation(extent={{-96,37},{-88,41}})));
  Foundation.Interfaces.RealSignalReader albedoFluxReader
    annotation(Placement(transformation(extent={{-96,34.5},{-88,38.5}})));
  Foundation.Interfaces.RealSignalReader earthInfraredFluxReader
    annotation(Placement(transformation(extent={{-96,32},{-88,36}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow externalHeat
    "Single external orbital heat-flow source; no added thermal state" annotation(Placement(transformation(extent={{-50,40},{-30,60}})));
equation
  connect(subsystem[1],subsystem[2]) annotation(Line(points={{-102,0},{-75,0}},color={191,0,0}));
  connect(subsystem[1],subsystem[3]) annotation(Line(points={{-102,0},{-65,0}},color={191,0,0}));
  connect(subsystem[1],subsystem[4]) annotation(Line(points={{-102,0},{-55,0}},color={191,0,0}));
  connect(subsystem[1],subsystem[5]) annotation(Line(points={{-102,0},{-45,0}},color={191,0,0}));
  connect(subsystem[1],subsystem[6]) annotation(Line(points={{-102,0},{-35,0}},color={191,0,0}));
  connect(subsystem[1],subsystem[7]) annotation(Line(points={{-102,0},{-25,0}},color={191,0,0}));
  connect(subsystem[1],subsystem[8]) annotation(Line(points={{-102,0},{-15,0}},color={191,0,0}));
  connect(subsystem[1],busDeck.port) annotation(Line(points={{-102,0},{-15,0},{-15,-5}},color={191,0,0}));
  connect(busDeck.port,shellToBus.port_a) annotation(Line(points={{-15,-5},{-15,23},{0,23}},color={191,0,0}));
  connect(shellToBus.port_b,externalShell.port) annotation(Line(points={{20,23},{25,23},{25,35}},color={191,0,0}));
  connect(externalShell.port,bodyRadiation.port_a) annotation(Line(points={{25,35},{45,25}},color={191,0,0}));
  connect(bodyRadiation.port_b,deepSpace.port) annotation(Line(points={{65,25},{75,25}},color={191,0,0}));
  connect(environment.sunVectorBody,sunVectorReader.u) annotation(Line(points={{-102,65},{-98,65},{-98,44},{-96,44}},color={0,0,127}));
  connect(sunVectorReader.y,externalHeatCalculation.sunVectorBody) annotation(Line(points={{-87.6,44},{-87,44},{-87,43.2},{-86,43.2}},color={0,0,127}));
  connect(environment.earthVectorBody,earthVectorReader.u) annotation(Line(points={{-102,65},{-100,65},{-100,41.5},{-96,41.5}},color={0,0,127}));
  connect(earthVectorReader.y,externalHeatCalculation.earthVectorBody) annotation(Line(points={{-87.6,41.5},{-87,41.5},{-87,40.8},{-86,40.8}},color={0,0,127}));
  connect(environment.solarFlux,solarFluxReader.u) annotation(Line(points={{-102,65},{-102,39},{-96,39}},color={0,0,127}));
  connect(solarFluxReader.y,externalHeatCalculation.solarFlux) annotation(Line(points={{-87.6,39},{-87,39},{-87,38.4},{-86,38.4}},color={0,0,127}));
  connect(environment.albedoFlux,albedoFluxReader.u) annotation(Line(points={{-102,65},{-104,65},{-104,36.5},{-96,36.5}},color={0,0,127}));
  connect(albedoFluxReader.y,externalHeatCalculation.albedoFlux) annotation(Line(points={{-87.6,36.5},{-87,36.5},{-87,36},{-86,36}},color={0,0,127}));
  connect(environment.earthInfraredFlux,earthInfraredFluxReader.u) annotation(Line(points={{-102,65},{-106,65},{-106,34},{-96,34}},color={0,0,127}));
  connect(earthInfraredFluxReader.y,externalHeatCalculation.earthInfraredFlux) annotation(Line(points={{-87.6,34},{-87,34},{-87,33.6},{-86,33.6}},color={0,0,127}));
  connect(externalHeatCalculation.externalHeatFlow,externalHeat.Q_flow) annotation(Line(points={{-60.8,38},{-50,38},{-50,50}},color={0,0,127}));
  connect(externalHeat.port,externalShell.port) annotation(Line(points={{-30,50},{25,50},{25,35}},color={191,0,0}));
  annotation(Icon(graphics={Rectangle(extent={{-100,85},{100,-85}},lineColor={190,50,35},fillColor={252,232,225},fillPattern=FillPattern.Solid),Ellipse(extent={{-45,45},{45,-45}},fillColor={235,135,105},fillPattern=FillPattern.Solid),Line(points={{45,0},{80,0}},color={190,50,35},thickness=2),Polygon(points={{65,15},{90,0},{65,-15},{65,15}},fillColor={190,50,35},fillPattern=FillPattern.Solid),Text(extent={{-92,-82},{92,-58}},textString="THERMAL OVERALL")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}}),graphics={Text(extent={{-94,80},{94,66}},textString="8个热端口-BusDeck-ExternalShell-深空辐射")}),Documentation(info="<html><h4>总体职责</h4><p>八个分系统热端进入内部设备舱板BusDeck；外部太阳、反照与地球红外进入外表面等效热节点ExternalShell，两节点通过有限导热连接。</p><h4>散热边界</h4><p>采用Modelica 4.0.0 BodyRadiation，按epsilon*A*sigma*(Tshell^4-3K^4)向深空辐射，不使用固定温度线性热沉。</p><p>体装太阳电池阵覆盖面积从裸露本体吸收面积扣除，索引语义为1=+X、2=+Y、3=-X。</p></html>"));
end ThermalOverall;
