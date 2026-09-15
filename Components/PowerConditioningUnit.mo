within OneSatSim.Components;
model PowerConditioningUnit "电源调节与配电组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.PcduComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Voltage nominalVoltage5V=config.NominalVoltage5V
    "5V名义输出电压；Excel单位V，当前设计基线";
  parameter Modelica.Units.SI.Power powerLimit5V=config.PowerLimit5V
    "5V输出功率上限；Excel单位W，当前设计基线";
  parameter Modelica.Units.SI.Voltage minimumInputVoltage5V=config.MinimumInputVoltage5V
    "5V变换最低输入电压；Excel单位V，当前设计基线";
  parameter Modelica.Units.SI.Resistance outputResistance5V=config.OutputResistance5V
    "5V输出等效内阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.Resistance overloadDroop5V=config.OverloadDroop5V
    "5V过载压降系数；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.Voltage nominalVoltage3V3=config.NominalVoltage3V3
    "3.3V名义输出电压；Excel单位V，当前设计基线";
  parameter Modelica.Units.SI.Power powerLimit3V3=config.PowerLimit3V3
    "3.3V输出功率上限；Excel单位W，当前设计基线";
  parameter Modelica.Units.SI.Voltage minimumInputVoltage3V3=config.MinimumInputVoltage3V3
    "3.3V变换最低输入电压；Excel单位V，当前设计基线";
  parameter Modelica.Units.SI.Resistance outputResistance3V3=config.OutputResistance3V3
    "3.3V输出等效内阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.Resistance overloadDroop3V3=config.OverloadDroop3V3
    "3.3V过载压降系数；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.Resistance housekeepingResistance12=config.HousekeepingResistance12
    "PCDU自耗等效电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity boardHeatCapacity=config.BoardHeatCapacity
    "PCDU板等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountConductance=config.MountConductance
    "PCDU安装导热；Excel单位W/K，当前设计基线";
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
  parameter Modelica.Units.SI.Temperature initialBoardTemperature=310.65 "场景PCDU/MPPT板初温";
  parameter Real regulatorEfficiency(min=0.8,max=1)=config.RegulatorEfficiency12 "12 V平均值变换效率";
  parameter Modelica.Units.SI.Voltage minimumInputVoltage=config.MinimumInputVoltage12;
  parameter Modelica.Units.SI.Current maximumInputCurrent=config.MaximumInputCurrent12;
  parameter Modelica.Units.SI.Current maximumOutputCurrent=config.MaximumOutputCurrent12;
  parameter Modelica.Units.SI.Power maximumOutputPower=config.MaximumOutputPower12;
  parameter Modelica.Units.SI.Resistance outputResistance12=config.OutputResistance12
    "系统级 12 V load regulation/droop";
  parameter Modelica.Units.SI.Resistance overloadDroop12=config.OverloadDroop12
    "Additional continuous voltage droop above available current";
  parameter Real eta5(min=0.5,max=1)=config.Efficiency5V "任务级参数";
  parameter Real eta3V3(min=0.5,max=1)=config.Efficiency3V3 "任务级参数";
  parameter Modelica.Units.SI.Current currentLimit5=config.CurrentLimit5V;
  parameter Modelica.Units.SI.Current currentLimit3V3=config.CurrentLimit3V3;
  Foundation.Interfaces.SourcePowerPort rawSource "太阳阵/电池原始双线汇流输入" annotation(Placement(transformation(extent={{-42,90},{-22,110}}),iconTransformation(extent={{-42,90},{-22,110}})));
  Foundation.Interfaces.PowerPort regulatedPower "12/5/3.3 V受控负载母线输出" annotation(Placement(transformation(extent={{22,90},{42,110}}),iconTransformation(extent={{22,90},{42,110}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,28},{110,48}}),iconTransformation(extent={{90,28},{110,48}})));
  Foundation.Models.AverageDCDCConverterCore converter5(
    nominalOutputVoltage=nominalVoltage5V,efficiency=eta5,outputCurrentLimit=currentLimit5,
    outputPowerLimit=powerLimit5V,minimumInputVoltage=minimumInputVoltage5V,outputResistance=outputResistance5V,overloadDroop=overloadDroop5V)
    annotation(Placement(transformation(extent={{-58,18},{-28,48}})));
  Foundation.Models.AverageDCDCConverterCore converter3V3(
    nominalOutputVoltage=nominalVoltage3V3,efficiency=eta3V3,outputCurrentLimit=currentLimit3V3,
    outputPowerLimit=powerLimit3V3,minimumInputVoltage=minimumInputVoltage3V3,outputResistance=outputResistance3V3,overloadDroop=overloadDroop3V3)
    annotation(Placement(transformation(extent={{12,18},{42,48}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltage12 annotation(Placement(transformation(origin={-68,-28},extent={{-8,-8},{8,8}},rotation=270)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltage5 annotation(Placement(transformation(origin={-28,-28},extent={{-8,-8},{8,8}},rotation=270)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltage3V3 annotation(Placement(transformation(origin={20,-28},extent={{-8,-8},{8,8}},rotation=270)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor current5 annotation(Placement(transformation(extent={{-20,26},{0,46}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor current3V3 annotation(Placement(transformation(extent={{50,26},{70,46}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor pcduHousekeepingCurrent
    "PCDU board self-consumption branch only; not the spacecraft 12 V bus current" annotation(Placement(transformation(extent={{-90,-58},{-70,-38}})));
  Modelica.Electrical.Analog.Basic.Resistor pcdHousekeeping12(R=housekeepingResistance12,useHeatPort=true) "系统级 PDB 12 V monitored branch, about 0.130 A" annotation(Placement(transformation(extent={{-62,-58},{-42,-38}})));
  Foundation.Interfaces.RealSignalReader batterySOCFromInformation annotation(Placement(transformation(extent={{58,82},{70,92}})));
  Foundation.Interfaces.BooleanSignalReader batteryChargeAllowedFromInformation annotation(Placement(transformation(extent={{58,70},{70,80}})));
  Foundation.Interfaces.RealSignalReader batteryBranchCurrentFromInformation annotation(Placement(transformation(extent={{58,58},{70,68}})));
  Foundation.Interfaces.IntegerSignalReader batteryHeaterStateFromInformation[2] annotation(Placement(transformation(extent={{58,46},{70,56}})));
  Foundation.Interfaces.RealSignalReader availableSolarPowerFromInformation[3] annotation(Placement(transformation(extent={{74,34},{86,44}})));
  Foundation.Interfaces.RealSignalReader pdCurrentFromInformation[24] annotation(Placement(transformation(extent={{42,-2},{54,8}})));
  Foundation.Interfaces.IntegerSignalReader equipmentStatusFromInformation[6] annotation(Placement(transformation(extent={{58,10},{70,20}})));
  Foundation.Calculations.PowerConditioningCalculation powerCalculation(
    regulatorEfficiency=regulatorEfficiency,
    minimumInputVoltage=minimumInputVoltage,
    maximumInputCurrent=maximumInputCurrent,
    maximumOutputCurrent=maximumOutputCurrent,
    maximumOutputPower=maximumOutputPower,
    outputResistance12=outputResistance12,
    overloadDroop12=overloadDroop12) annotation(Placement(transformation(extent={{14,56},{44,92}})));
  Foundation.Calculations.PowerDistributionStatusCalculation distributionStatusCalculation annotation(Placement(transformation(extent={{12,-86},{38,-68}})));
  Modelica.Blocks.Sources.Constant zeroCurrent[8](each k=0) annotation(Placement(transformation(extent={{-62,-88},{-42,-72}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor boardHeat(C=boardHeatCapacity,T(start=initialBoardTemperature,fixed=true)) "系统级 initial PCDU/MPPT board work point" annotation(Placement(transformation(extent={{45,-78},{65,-58}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor mounting(G=mountConductance) "系统级等效 PCDU mounting path" annotation(Placement(transformation(extent={{75,-76},{95,-60}})));
  Modelica.Mechanics.MultiBody.Parts.Body boardBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-88,2},{-68,22}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor sourceVoltage "原始电源路径电压" annotation(Placement(transformation(origin={-82,64},extent={{-8,-8},{8,8}},rotation=270)));
  Modelica.Electrical.Analog.Basic.Ground rawSourceReference
    "原始太阳阵/电池双线域的电位参考；不传输或消耗功率" annotation(Placement(transformation(extent={{-96,30},{-76,50}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent sourceCurrentSink "按平均功率从太阳阵/电池汇流端取电" annotation(Placement(transformation(extent={{-72,54},{-52,74}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage regulatedVoltageSource
    "系统级 average 12 V source with finite droop; no fast PI or switching state" annotation(Placement(transformation(extent={{-42,54},{-22,74}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor loadBus12Current
    "Total current delivered into the regulated 12 V load bus, including derived 5/3.3 V loads" annotation(Placement(transformation(extent={{-18,54},{2,74}})));
  Modelica.Blocks.Interfaces.RealOutput regulatedOutputPower(unit="W") annotation(Placement(transformation(extent={{95,-5},{105,5}}),iconTransformation(extent={{95,-5},{105,5}})));
  Modelica.Blocks.Interfaces.RealOutput weightedAvailableSolarPower(unit="W") annotation(Placement(transformation(extent={{95,-43},{105,-33}}),iconTransformation(extent={{95,-43},{105,-33}})));
  Modelica.Blocks.Continuous.FirstOrder sourceVoltageAverage(
    T=30,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=15.92) "实际原始电源端电压的30 s慢变平均" annotation(Placement(transformation(extent={{80,78},{96,94}})));
  Modelica.Blocks.Continuous.FirstOrder loadCurrentAverage(
    T=30,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=2.2) "Slow average excludes device-capacitor inrush from the voltage command" annotation(Placement(transformation(extent={{80,54},{96,70}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow regulatorLoss annotation(Placement(transformation(extent={{75,-96},{95,-76}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[20] annotation(Placement(transformation(extent={{78,20},{86,28}})));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[24] annotation(Placement(transformation(extent={{78,0},{86,8}})));
equation
  connect(rawSource.p,sourceVoltage.p) annotation(Line(points={{-32,100},{-32,94},{-82,94},{-82,72}},color={0,0,255}));
  connect(sourceVoltage.n,rawSource.n) annotation(Line(points={{-82,56},{-82,94},{-32,94},{-32,100}},color={0,0,255}));
  connect(rawSourceReference.p,rawSource.n) annotation(Line(points={{-86,50},{-32,50},{-32,100}},color={0,0,255}));
  connect(rawSource.p,sourceCurrentSink.p) annotation(Line(points={{-32,100},{-32,94},{-72,94},{-72,64}},color={0,0,255}));
  connect(sourceCurrentSink.n,rawSource.n) annotation(Line(points={{-52,64},{-52,94},{-32,94},{-32,100}},color={0,0,255}));
  connect(information.device.batterySOC,batterySOCFromInformation.u) annotation(Line(points={{100,38},{100,45.5},{71.5,45.5},{71.5,87},{58,87}},color={0,0,127}));
  connect(batterySOCFromInformation.y,powerCalculation.batterySOC) annotation(Line(points={{70,87},{14,87}},color={0,0,127}));
  connect(information.device.batteryChargeAllowed,batteryChargeAllowedFromInformation.u) annotation(Line(points={{100,38},{100,75},{58,75}},color={255,0,255}));
  connect(batteryChargeAllowedFromInformation.y,powerCalculation.batteryChargeAllowed) annotation(Line(points={{70,75},{14,75},{14,81.8}},color={255,0,255}));
  connect(information.device.pdCurrent[22],batteryBranchCurrentFromInformation.u) annotation(Line(points={{100,38},{100,45.5},{71.5,45.5},{71.5,63},{58,63}},color={0,0,127}));
  connect(batteryBranchCurrentFromInformation.y,powerCalculation.batteryBranchCurrent) annotation(Line(points={{70,63},{14,63},{14,77.3}},color={0,0,127}));
  connect(information.device.tcState[17],batteryHeaterStateFromInformation[1].u) annotation(Line(points={{100,38},{94,38},{94,51},{58,51}},color={255,127,0}));
  connect(information.device.tcState[18],batteryHeaterStateFromInformation[2].u) annotation(Line(points={{100,38},{94,38},{94,51},{58,51}},color={255,127,0}));
  connect(batteryHeaterStateFromInformation.y,powerCalculation.batteryHeaterState) annotation(Line(points={{70,51},{8,51},{8,73},{14,73}},color={255,127,0}));
  connect(information.device.availableSolarPower,availableSolarPowerFromInformation.u) annotation(Line(points={{100,38},{94,38},{94,39},{74,39}},color={0,0,127}));
  connect(availableSolarPowerFromInformation.y,powerCalculation.availableSolarPower) annotation(Line(points={{86,39},{71.5,39},{71.5,24.5},{43.5,24.5},{43.5,68.3},{14,68.3}},color={0,0,127}));
  connect(information.device.pdCurrent,pdCurrentFromInformation.u) annotation(Line(points={{100,38},{100,32.5},{71.5,32.5},{71.5,3},{42,3}},color={0,0,127}));
  connect(pdCurrentFromInformation.y,distributionStatusCalculation.pdCurrent) annotation(Line(points={{54,3},{29.5,3},{29.5,-74.05},{12,-74.05}},color={0,0,127}));
  connect(information.device.basebandStatus,equipmentStatusFromInformation[1].u) annotation(Line(points={{100,38},{94,38},{94,15},{58,15}},color={255,127,0}));
  connect(information.device.transmitterStatus,equipmentStatusFromInformation[2].u) annotation(Line(points={{100,38},{94,38},{94,15},{58,15}},color={255,127,0}));
  connect(information.device.naviEnhanceStatus,equipmentStatusFromInformation[3].u) annotation(Line(points={{100,38},{94,38},{94,15},{58,15}},color={255,127,0}));
  connect(information.device.spaceTimeStatus,equipmentStatusFromInformation[4].u) annotation(Line(points={{100,38},{94,38},{94,15},{58,15}},color={255,127,0}));
  connect(information.device.cameraStatus,equipmentStatusFromInformation[5].u) annotation(Line(points={{100,38},{94,38},{94,15},{58,15}},color={255,127,0}));
  connect(information.device.cmosStatus,equipmentStatusFromInformation[6].u) annotation(Line(points={{100,38},{94,38},{94,15},{58,15}},color={255,127,0}));
  connect(equipmentStatusFromInformation.y,distributionStatusCalculation.equipmentStatus) annotation(Line(points={{70,15},{72,15},{72,-81.95},{12,-81.95}},color={255,127,0}));
  connect(sourceVoltage.v,powerCalculation.sourceVoltage) annotation(Line(points={{-74,64},{-74,52.5},{21.5,52.5},{21.5,56}},color={0,0,127}));
  connect(voltage12.v,powerCalculation.busVoltage12) annotation(Line(points={{-60,-28},{-60,52.5},{27.5,52.5},{27.5,56}},color={0,0,127}));
  connect(loadBus12Current.i,powerCalculation.loadBusCurrent) annotation(Line(points={{-8,54},{33.5,54},{33.5,56}},color={0,0,127}));
  connect(sourceVoltageAverage.y,powerCalculation.sourceVoltageAverage) annotation(Line(points={{96.8,86},{96.8,93.5},{43.5,93.5},{43.5,65.6},{14,65.6}},color={0,0,127}));
  connect(loadCurrentAverage.y,powerCalculation.loadCurrentAverage) annotation(Line(points={{96.8,62},{71.5,62},{71.5,93.5},{43.5,93.5},{43.5,61.1},{14,61.1}},color={0,0,127}));
  connect(powerCalculation.sourceCurrentCommand,sourceCurrentSink.i) annotation(Line(points={{44,78},{50,78},{50,52},{-62,52}},color={0,0,127}));
  connect(regulatedVoltageSource.n,regulatedPower.n12) annotation(Line(points={{-42,64},{-19.5,64},{-19.5,100},{32,100}},color={0,0,255}));
  connect(regulatedVoltageSource.p,loadBus12Current.p) annotation(Line(points={{-22,64},{-18,64}},color={0,0,255}));
  connect(loadBus12Current.n,regulatedPower.p12) annotation(Line(points={{2,64},{2,94},{32,94},{32,100}},color={0,0,255}));
  connect(powerCalculation.regulatedVoltageCommand,regulatedVoltageSource.v) annotation(Line(points={{44,82},{44,52},{-32,52}},color={0,0,127}));
  connect(powerCalculation.loadCurrentMeasurement,loadCurrentAverage.u) annotation(Line(points={{44,88},{44,93.5},{78.4,93.5},{78.4,62}},color={0,0,127}));
  connect(sourceVoltage.v,sourceVoltageAverage.u) annotation(Line(points={{-74,64},{-74,52.5},{56.5,52.5},{56.5,93.5},{78.4,93.5},{78.4,86}},color={0,0,127}));
  connect(sourceVoltageAverage.y,informationRealBridge[1].u) annotation(Line(points={{96.8,86},{72.5,86},{72.5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.rawSourceBusVoltageAverage) annotation(Line(points={{86,24},{94,24},{94,38},{100,38}},color={0,0,127}));
  connect(powerCalculation.solarCurtailmentCommand,informationRealBridge[2].u) annotation(Line(points={{44,74.5},{44,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[2].y,information.device.solarCurtailmentFactor) annotation(Line(points={{86,24},{94,24},{94,38},{100,38}},color={0,0,127}));
  connect(regulatedPower.p12,converter5.p1) annotation(Line(points={{32,100},{12.5,100},{12.5,49.5},{-58,49.5},{-58,40.5}},color={0,0,255}));
  connect(regulatedPower.n12,converter5.n1) annotation(Line(points={{32,100},{12.5,100},{12.5,49.5},{-58,49.5},{-58,25.5}},color={0,0,255}));
  connect(regulatedPower.p12,converter3V3.p1) annotation(Line(points={{32,100},{32,94},{12,94},{12,40.5}},color={0,0,255}));
  connect(regulatedPower.n12,converter3V3.n1) annotation(Line(points={{32,100},{32,94},{12,94},{12,25.5}},color={0,0,255}));
  connect(converter5.p2,current5.p) annotation(Line(points={{-28,40.5},{-28,36},{-20,36}},color={0,0,255}));
  connect(current5.n,regulatedPower.p5) annotation(Line(points={{0,36},{10.5,36},{10.5,100},{32,100}},color={0,0,255}));
  connect(converter5.n2,regulatedPower.n5) annotation(Line(points={{-28,25.5},{-28,88.5},{12.5,88.5},{12.5,100},{32,100}},color={0,0,255}));
  connect(converter3V3.p2,current3V3.p) annotation(Line(points={{42,40.5},{42,36},{50,36}},color={0,0,255}));
  connect(current3V3.n,regulatedPower.p33) annotation(Line(points={{70,36},{70,94},{32,94},{32,100}},color={0,0,255}));
  connect(converter3V3.n2,regulatedPower.n33) annotation(Line(points={{42,25.5},{45.5,25.5},{45.5,100},{32,100}},color={0,0,255}));
  connect(voltage12.p,regulatedPower.p12) annotation(Line(points={{-68,-20},{-68,0.5},{10.5,0.5},{10.5,100},{32,100}},color={0,0,255}));
  connect(voltage12.n,regulatedPower.n12) annotation(Line(points={{-68,-36},{-68,0.5},{10.5,0.5},{10.5,100},{32,100}},color={0,0,255}));
  connect(voltage5.p,regulatedPower.p5) annotation(Line(points={{-28,-20},{10.5,-20},{10.5,100},{32,100}},color={0,0,255}));
  connect(voltage5.n,regulatedPower.n5) annotation(Line(points={{-28,-36},{10.5,-36},{10.5,100},{32,100}},color={0,0,255}));
  connect(voltage3V3.p,regulatedPower.p33) annotation(Line(points={{20,-20},{10.5,-20},{10.5,100},{32,100}},color={0,0,255}));
  connect(voltage3V3.n,regulatedPower.n33) annotation(Line(points={{20,-36},{10.5,-36},{10.5,100},{32,100}},color={0,0,255}));
  connect(voltage12.v,informationRealBridge[3].u) annotation(Line(points={{-60,-28},{-60,-3.5},{76.5,-3.5},{76.5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[3].y,information.device.busVoltage[1]) annotation(Line(points={{86,24},{94,24},{94,38},{100,38}},color={0,0,127}));
  connect(voltage5.v,informationRealBridge[4].u) annotation(Line(points={{-20,-28},{-20,-3.5},{76.5,-3.5},{76.5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[4].y,information.device.busVoltage[2]) annotation(Line(points={{86,24},{94,24},{94,38},{100,38}},color={0,0,127}));
  connect(voltage3V3.v,informationRealBridge[5].u) annotation(Line(points={{28,-28},{78,-28},{78,24}},color={0,0,127}));
  connect(informationRealBridge[5].y,information.device.busVoltage[3]) annotation(Line(points={{86,24},{94,24},{94,38},{100,38}},color={0,0,127}));
  connect(distributionStatusCalculation.pdState[1],informationIntegerBridge[1].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[1].y,information.device.pdState[1]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[2],informationIntegerBridge[2].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[2].y,information.device.pdState[2]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[3],informationIntegerBridge[3].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[3].y,information.device.pdState[3]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[4],informationIntegerBridge[4].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[4].y,information.device.pdState[4]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[5],informationIntegerBridge[5].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[5].y,information.device.pdState[5]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[6],informationIntegerBridge[6].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[6].y,information.device.pdState[6]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[7],informationIntegerBridge[7].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[7].y,information.device.pdState[7]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[8],informationIntegerBridge[8].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[8].y,information.device.pdState[8]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[9],informationIntegerBridge[9].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[9].y,information.device.pdState[9]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[10],informationIntegerBridge[10].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[10].y,information.device.pdState[10]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[11],informationIntegerBridge[11].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[11].y,information.device.pdState[11]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[12],informationIntegerBridge[12].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[12].y,information.device.pdState[12]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[13],informationIntegerBridge[13].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[13].y,information.device.pdState[13]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[14],informationIntegerBridge[14].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[14].y,information.device.pdState[14]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[15],informationIntegerBridge[15].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[15].y,information.device.pdState[15]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[16],informationIntegerBridge[16].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[16].y,information.device.pdState[16]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[17],informationIntegerBridge[17].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[17].y,information.device.pdState[17]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[18],informationIntegerBridge[18].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[18].y,information.device.pdState[18]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[19],informationIntegerBridge[19].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[19].y,information.device.pdState[19]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[20],informationIntegerBridge[20].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[20].y,information.device.pdState[20]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[21],informationIntegerBridge[21].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[21].y,information.device.pdState[21]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[22],informationIntegerBridge[22].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[22].y,information.device.pdState[22]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[23],informationIntegerBridge[23].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[23].y,information.device.pdState[23]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(distributionStatusCalculation.pdState[24],informationIntegerBridge[24].u) annotation(Line(points={{-71,-78},{-71,-59.5},{43.5,-59.5},{43.5,-3.5},{78,-3.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[24].y,information.device.pdState[24]) annotation(Line(points={{86,4},{94,4},{94,38},{100,38}},color={255,127,0}));
  connect(current5.i,informationRealBridge[6].u) annotation(Line(points={{-10,26},{-10,16.5},{56.5,16.5},{56.5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[6].y,information.device.busCurrent[2]) annotation(Line(points={{86,24},{94,24},{94,38},{100,38}},color={0,0,127}));
  connect(current3V3.i,informationRealBridge[7].u) annotation(Line(points={{60,26},{78,26},{78,24}},color={0,0,127}));
  connect(informationRealBridge[7].y,information.device.busCurrent[3]) annotation(Line(points={{86,24},{94,24},{94,38},{100,38}},color={0,0,127}));
  connect(regulatedPower.p12,pcduHousekeepingCurrent.p) annotation(Line(points={{32,100},{10.5,100},{10.5,-18.5},{-90,-18.5},{-90,-48}},color={0,0,255}));
  connect(pcduHousekeepingCurrent.n,pcdHousekeeping12.p) annotation(Line(points={{-70,-48},{-62,-48}},color={0,0,255}));
  connect(pcdHousekeeping12.n,regulatedPower.n12) annotation(Line(points={{-42,-48},{10.5,-48},{10.5,100},{32,100}},color={0,0,255}));
  connect(loadBus12Current.i,informationRealBridge[8].u) annotation(Line(points={{-8,54},{48.5,54},{48.5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[8].y,information.device.busCurrent[1]) annotation(Line(points={{86,24},{94,24},{94,38},{100,38}},color={0,0,127}));
  connect(pcdHousekeeping12.heatPort,boardHeat.port) annotation(Line(points={{-52,-58},{55,-58},{55,-78}},color={191,0,0}));
  connect(converter5.heatPort,boardHeat.port) annotation(Line(points={{-43,18},{-43,-18.5},{55,-18.5},{55,-78}},color={191,0,0}));
  connect(converter3V3.heatPort,boardHeat.port) annotation(Line(points={{27,18},{40.5,18},{40.5,-78},{55,-78}},color={191,0,0}));
  connect(powerCalculation.regulatorLossPower,regulatorLoss.Q_flow) annotation(Line(points={{44,78},{44,21.5},{73.5,21.5},{73.5,-86},{75,-86}},color={0,0,127}));
  connect(powerCalculation.regulatedOutputPower,regulatedOutputPower) annotation(Line(points={{44,65.5},{44,21.5},{76.5,21.5},{76.5,9.5},{100,9.5},{100,0}},color={0,0,127}));
  connect(powerCalculation.weightedAvailableSolarPower,weightedAvailableSolarPower) annotation(Line(points={{44,58.3},{44,21.5},{76.5,21.5},{76.5,-38},{100,-38}},color={0,0,127}));
  connect(regulatorLoss.port,boardHeat.port) annotation(Line(points={{95,-86},{95,-78},{55,-78}},color={191,0,0}));
  connect(powerCalculation.chargerVoltage[1],informationRealBridge[9].u) annotation(Line(points={{44,70.9},{44,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[9].y,information.device.chargerVoltage[1]) annotation(Line(points={{86,24},{94,24},{94,38},{100,38}},color={0,0,127}));
  connect(powerCalculation.chargerVoltage[2],informationRealBridge[10].u) annotation(Line(points={{44,70.9},{44,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[10].y,information.device.chargerVoltage[2]) annotation(Line(points={{86,24},{94,24},{94,38},{100,38}},color={0,0,127}));
  connect(powerCalculation.chargerCurrent[1],informationRealBridge[11].u) annotation(Line(points={{44,67.3},{44,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[11].y,information.device.chargerCurrent[1]) annotation(Line(points={{86,24},{94,24},{94,38},{100,38}},color={0,0,127}));
  connect(powerCalculation.chargerCurrent[2],informationRealBridge[12].u) annotation(Line(points={{44,67.3},{44,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[12].y,information.device.chargerCurrent[2]) annotation(Line(points={{86,24},{94,24},{94,38},{100,38}},color={0,0,127}));
  connect(zeroCurrent[1].y,informationRealBridge[13].u) annotation(Line(points={{-41,-80},{10.5,-80},{10.5,-3.5},{76.5,-3.5},{76.5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[13].y,information.device.pdCurrent[6]) annotation(Line(points={{86,24},{94,24},{94,38},{100,38}},color={0,0,127}));
  connect(zeroCurrent[2].y,informationRealBridge[14].u) annotation(Line(points={{-41,-80},{10.5,-80},{10.5,-3.5},{76.5,-3.5},{76.5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[14].y,information.device.pdCurrent[7]) annotation(Line(points={{86,24},{94,24},{94,38},{100,38}},color={0,0,127}));
  connect(zeroCurrent[3].y,informationRealBridge[15].u) annotation(Line(points={{-41,-80},{10.5,-80},{10.5,-3.5},{76.5,-3.5},{76.5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[15].y,information.device.pdCurrent[9]) annotation(Line(points={{86,24},{94,24},{94,38},{100,38}},color={0,0,127}));
  connect(zeroCurrent[4].y,informationRealBridge[16].u) annotation(Line(points={{-41,-80},{10.5,-80},{10.5,-3.5},{76.5,-3.5},{76.5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[16].y,information.device.pdCurrent[10]) annotation(Line(points={{86,24},{94,24},{94,38},{100,38}},color={0,0,127}));
  connect(zeroCurrent[5].y,informationRealBridge[17].u) annotation(Line(points={{-41,-80},{10.5,-80},{10.5,-3.5},{76.5,-3.5},{76.5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[17].y,information.device.pdCurrent[11]) annotation(Line(points={{86,24},{94,24},{94,38},{100,38}},color={0,0,127}));
  connect(zeroCurrent[6].y,informationRealBridge[18].u) annotation(Line(points={{-41,-80},{10.5,-80},{10.5,-3.5},{76.5,-3.5},{76.5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[18].y,information.device.pdCurrent[18]) annotation(Line(points={{86,24},{94,24},{94,38},{100,38}},color={0,0,127}));
  connect(zeroCurrent[7].y,informationRealBridge[19].u) annotation(Line(points={{-41,-80},{10.5,-80},{10.5,-3.5},{76.5,-3.5},{76.5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[19].y,information.device.pdCurrent[23]) annotation(Line(points={{86,24},{94,24},{94,38},{100,38}},color={0,0,127}));
  connect(zeroCurrent[8].y,informationRealBridge[20].u) annotation(Line(points={{-41,-80},{10.5,-80},{10.5,-3.5},{76.5,-3.5},{76.5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[20].y,information.device.pdCurrent[24]) annotation(Line(points={{86,24},{94,24},{94,38},{100,38}},color={0,0,127}));
  connect(boardHeat.port,mounting.port_a) annotation(Line(points={{55,-78},{55,-68},{75,-68}},color={191,0,0}));
  connect(mounting.port_b,thermal) annotation(Line(points={{95,-68},{66.5,-68},{66.5,-100},{0,-100}},color={191,0,0}));
  connect(boardBody.frame_a,mechanical) annotation(Line(points={{-88,12},{-94,12},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  annotation(
    Icon(
      coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),
      graphics={
        Rectangle(extent={{-100,100},{100,-100}},lineColor={35,85,150},
          fillColor={240,246,253},fillPattern=FillPattern.Solid),

        Rectangle(extent={{-80,48},{-48,-8}},lineColor={50,95,155},
          fillColor={209,224,244},fillPattern=FillPattern.Solid),
        Text(extent={{-77,37},{-51,5}},textString="12",
          lineColor={35,85,150}),

        Polygon(points={{-42,20},{-28,32},{-28,25},{-8,25},{-8,15},
          {-28,15},{-28,8},{-42,20}},lineColor={35,85,150},
          fillColor={70,125,190},fillPattern=FillPattern.Solid),

        Rectangle(extent={{-2,48},{30,4}},lineColor={35,85,150},
          fillColor={224,235,249},fillPattern=FillPattern.Solid),
        Text(extent={{1,37},{27,10}},textString="5 V",
          lineColor={35,85,150}),

        Rectangle(extent={{42,48},{78,4}},lineColor={35,85,150},
          fillColor={224,235,249},fillPattern=FillPattern.Solid),
        Text(extent={{44,37},{76,10}},textString="3.3 V",
          lineColor={35,85,150}),

        Line(points={{-65,-16},{-65,-42},{65,-42},{65,-16}},
          color={35,85,150},thickness=0.8),
        Ellipse(extent={{-72,-25},{-58,-39}},lineColor={35,85,150},
          fillColor={244,249,255},fillPattern=FillPattern.Solid),
        Ellipse(extent={{-8,-25},{6,-39}},lineColor={35,85,150},
          fillColor={244,249,255},fillPattern=FillPattern.Solid),
        Ellipse(extent={{58,-25},{72,-39}},lineColor={35,85,150},
          fillColor={244,249,255},fillPattern=FillPattern.Solid),

        Line(points={{-16,62},{16,62}},color={190,110,45},thickness=1),
        Polygon(points={{16,62},{7,68},{7,56},{16,62}},
          lineColor={190,110,45},fillColor={220,145,60},
          fillPattern=FillPattern.Solid),
        Ellipse(extent={{-3,48},{27,78}},startAngle=200,endAngle=340,
          closure=EllipseClosure.None,lineColor={190,110,45},lineThickness=0.8),

        Text(extent={{-90,-78},{90,-58}},textString="PCDU / MPPT",
          lineColor={35,85,150})
      }),
    Diagram(coordinateSystem(extent={{-110,-110},{110,110}},
preserveAspectRatio=true,
grid={2,2}),graphics = {Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Rectangle(origin={-7,30},
lineColor={155,185,220},
fillColor={250,252,255},
fillPattern=FillPattern.Solid,
extent={{-85,20},{85,-20}}), Rectangle(origin={0,75},
lineColor={155,185,220},
fillColor={248,251,255},
fillPattern=FillPattern.Solid,
extent={{-96,23},{96,-23}}), Text(origin={0,93.5},
lineColor={35,85,150},
extent={{-94,3.5},{94,-3.5}},
textString="RAW 12 V INPUT & CONTINUOUS AVERAGE REGULATION",
textColor={35,85,150}), Text(origin={1,55},
lineColor={105,105,105},
extent={{-93,3},{93,-3}},
textString="Voltage/load feedback → 30 s averages → algebraic regulation → source/load commands",
textColor={105,105,105}), Text(origin={-7,45.5},
lineColor={35,85,150},
extent={{-83,3.5},{83,-3.5}},
textString="AVERAGE CONVERSION / REGULATION & CURRENT SENSING",
textColor={35,85,150}), Rectangle(origin={-27,-55},
lineColor={155,195,175},
fillColor={249,253,250},
fillPattern=FillPattern.Solid,
extent={{-69,37},{69,-37}}), Text(origin={-27,-22.5},
lineColor={45,115,80},
extent={{-67,3.5},{67,-3.5}},
textString="BUS MONITORING / PDB & CHARGER TELEMETRY",
textColor={45,115,80}), Rectangle(origin={70,-79},
lineColor={225,175,145},
fillColor={255,250,247},
fillPattern=FillPattern.Solid,
extent={{-30,25},{30,-25}}), Text(origin={70,-58.5},
lineColor={170,75,45},
extent={{-28,3.5},{28,-3.5}},
textString="LOSS & THERMAL REJECTION",
textColor={170,75,45}), Text(origin={0,102.5},
lineColor={95,95,95},
extent={{-22,3.5},{22,-3.5}},
textString="STRUCTURAL BOARD",
textColor={95,95,95}), Text(origin={87,2.5},
lineColor={0,90,180},
extent={{-19,3.5},{19,-3.5}},
textString="STATUS / TELEMETRY",
textColor={0,90,180}), Text(origin={76,-102},
lineColor={170,45,35},
extent={{-29,-3},{29,3}},
textString="SPACECRAFT THERMAL NETWORK",
textColor={170,45,35})}),
    Documentation(info="<html><h4>用途与系统角色</h4><p>构造连续平均值12 V电源路径以及12/5/3.3 V母线、电压变换、动态配电状态和电源工程量。</p><h4>白箱信号路径</h4><p>电池SOC、充电许可、支路电流、太阳阵功率、加热器与设备状态先经过显式Real/Boolean/Integer SignalReader，再分别进入PowerConditioningCalculation和PowerDistributionStatusCalculation。Calculation集中完成稳压、功率守恒、损耗和配电状态代数计算；父组件只保留标准电气、热、机械元件及connect连线。</p><h4>稳压与功率路径</h4><p><b>rawSource</b>是太阳阵与电池共享的未稳压双线输入；<b>regulatedPower</b>是唯一对外受控12/5/3.3 V负载母线。12 V侧采用线路调整率、负载droop、欠压降额与平滑限流的连续平均值电源，源侧按Pin=Pout/eta换算且损耗进入热节点。</p><h4>电流语义</h4><p>loadBus12Current位于regulatedVoltageSource与regulatedPower.p12之间，busCurrent[1]是受控12 V负载母线总输出。</p><h4>接口与电源路径</h4><p>rawSource接收三个体装太阳电池阵与电池形成的未稳压双线电源，regulatedPower向八个分系统提供受控12/5/3.3 V母线，information读取SOC、充电许可、支路电流和设备状态并发布母线、MPPT、Charger与PDB工程量，thermal和mechanical描述PCDU板的热耗散与安装属性。</p><h4>内部组成与稳压逻辑</h4><p>Real/Boolean/Integer SignalReader只完成共享总线到因果计算端口的恒等交付。PowerConditioningCalculation按负载需求、效率、输入电压、限流、限功率和有限输出阻抗生成12 V平均值电压指令及源侧电流；SignalVoltage与SignalCurrent把该命令落到电气网络。5 V和3.3 V由低阶平均值支路派生，调节损耗进入boardHeat。</p><h4>MPPT、Charger与符号</h4><p>availableSolarPower[1:3]分别对应+X、+Y、-X面。chargerCurrent来自电池公共支路电流并按统一充电正方向形成两路等效通道，不由无关负载电流拼接。solarCurtailmentCommand只在充电受限或源功率过剩时降低太阳阵供给；日影或太阳不足时电池自然补充原始母线。</p><h4>结果查看与参数使用</h4><p>优先查看sourceVoltage.v、loadBus12Current.i、regulatedVoltageCommand、sourceCurrentCommand、regulatorLossPower、chargerCurrent和information.device.busVoltage/busCurrent。outputResistance12控制正常压降，overloadDroop12仅处理超限区；maximumInputCurrent、maximumOutputCurrent和maximumOutputPower用于物理约束，不能用理想恒压或超大电容替代。</p><h4>建模边界</h4><p>这是连续低阶平均值稳压与功率路径模型，不包含PWM、MOSFET、电感开关纹波、芯片环路补偿和EMI动态。适用于24 h任务能量、母线小幅波动、充放电切换和热损耗解释。</p></html>"));
end PowerConditioningUnit;
