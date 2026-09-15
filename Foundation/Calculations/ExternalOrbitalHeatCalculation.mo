within NISSA_12UCubeSat.Foundation.Calculations;
model ExternalOrbitalHeatCalculation "整星外表面轨道热流计算"
  parameter Modelica.Units.SI.Area grossLongFaceArea=0.226*0.340 "12U长侧面面积";
  parameter Modelica.Units.SI.Area grossEndFaceArea=0.226*0.226 "12U端面面积";
  parameter Modelica.Units.SI.Area plusXCellCoveredArea=0.069156 "+X体装太阳电池覆盖面积";
  parameter Modelica.Units.SI.Area plusYCellCoveredArea=0.069156 "+Y体装太阳电池覆盖面积";
  parameter Modelica.Units.SI.Area minusXCellCoveredArea=0.062240 "-X体装太阳电池覆盖面积";
  parameter Real bodySolarAbsorptivity(min=0,max=1)=0.60 "外表面对太阳与反照辐射的吸收率";
  parameter Real bodyInfraredAbsorptivity(min=0,max=1)=0.80 "外表面对地球红外的吸收率";
  final parameter Modelica.Units.SI.Area barePlusXArea=max(0,grossLongFaceArea-plusXCellCoveredArea);
  final parameter Modelica.Units.SI.Area bareMinusXArea=max(0,grossLongFaceArea-minusXCellCoveredArea);
  final parameter Modelica.Units.SI.Area barePlusYArea=max(0,grossLongFaceArea-plusYCellCoveredArea);
  final parameter Modelica.Units.SI.Area bareMinusYArea=grossLongFaceArea;
  final parameter Modelica.Units.SI.Area barePlusZArea=grossEndFaceArea;
  final parameter Modelica.Units.SI.Area bareMinusZArea=grossEndFaceArea;
  Modelica.Blocks.Interfaces.RealInput sunVectorBody[3]
    "太阳方向在本体系中的单位向量" annotation(Placement(transformation(extent={{-120,55},{-80,75}})));
  Modelica.Blocks.Interfaces.RealInput earthVectorBody[3]
    "地心方向在本体系中的单位向量" annotation(Placement(transformation(extent={{-120,25},{-80,45}})));
  Modelica.Blocks.Interfaces.RealInput solarFlux(unit="W/m2")
    "太阳辐照通量" annotation(Placement(transformation(extent={{-120,-5},{-80,15}})));
  Modelica.Blocks.Interfaces.RealInput albedoFlux(unit="W/m2")
    "地球反照通量" annotation(Placement(transformation(extent={{-120,-35},{-80,-15}})));
  Modelica.Blocks.Interfaces.RealInput earthInfraredFlux(unit="W/m2")
    "地球红外通量" annotation(Placement(transformation(extent={{-120,-65},{-80,-45}})));
  Modelica.Blocks.Interfaces.RealOutput externalHeatFlow(unit="W")
    "外表面总吸收热流" annotation(Placement(transformation(extent={{80,-10},{100,10}})));
  Modelica.Units.SI.Area bareProjectedAreaToSun "裸露本体对太阳的投影面积";
  Modelica.Units.SI.Area bareProjectedAreaToEarth "扣除太阳电池覆盖区后的裸露本体对地投影面积";
  Modelica.Units.SI.HeatFlowRate solarBodyHeatFlow "裸露本体吸收的太阳热流";
  Modelica.Units.SI.HeatFlowRate albedoHeatFlow "吸收的地球反照热流";
  Modelica.Units.SI.HeatFlowRate earthIRHeatFlow "吸收的地球红外热流";
equation
  bareProjectedAreaToSun=noEvent(
    barePlusXArea*max(0,sunVectorBody[1])+
    bareMinusXArea*max(0,-sunVectorBody[1])+
    barePlusYArea*max(0,sunVectorBody[2])+
    bareMinusYArea*max(0,-sunVectorBody[2])+
    barePlusZArea*max(0,sunVectorBody[3])+
    bareMinusZArea*max(0,-sunVectorBody[3]));
  bareProjectedAreaToEarth=noEvent(
    barePlusXArea*max(0,earthVectorBody[1])+
    bareMinusXArea*max(0,-earthVectorBody[1])+
    barePlusYArea*max(0,earthVectorBody[2])+
    bareMinusYArea*max(0,-earthVectorBody[2])+
    barePlusZArea*max(0,earthVectorBody[3])+
    bareMinusZArea*max(0,-earthVectorBody[3]));
  solarBodyHeatFlow=bodySolarAbsorptivity*solarFlux*bareProjectedAreaToSun;
  albedoHeatFlow=bodySolarAbsorptivity*albedoFlux*bareProjectedAreaToEarth;
  earthIRHeatFlow=bodyInfraredAbsorptivity*earthInfraredFlux*bareProjectedAreaToEarth;
  externalHeatFlow=solarBodyHeatFlow+albedoHeatFlow+earthIRHeatFlow;
  annotation(
    Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={190,50,35},fillColor={252,232,225},fillPattern=FillPattern.Solid),Ellipse(extent={{-62,34},{-18,-10}},lineColor={230,145,40},fillColor={255,210,90},fillPattern=FillPattern.Solid),Line(points={{-14,12},{55,12}},color={190,50,35},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-92,-24},{92,-56}},textString="ORBIT HEAT")}),
    Documentation(info="<html><h4>功能定位</h4><p>根据太阳/地心方向及太阳、反照、地球红外通量计算裸露整星外表面吸收热流。</p><h4>面积边界</h4><p>+X、+Y与-X体装太阳电池覆盖区同时从太阳、反照和地球红外的外壳投影面积中扣除；这些覆盖区由各自面板热节点独立接收辐射，避免重复或跨节点分配。</p><h4>状态与边界</h4><p>纯代数、无热状态；外壳热容、舱板导热和深空辐射由ThermalOverall承担。</p></html>"));
end ExternalOrbitalHeatCalculation;
