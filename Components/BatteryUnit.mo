within OneSatSim.Components;
model BatteryUnit "四串两并锂离子电池组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.BatteryComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Integer seriesCellCount=config.SeriesCellCount
    "串联电芯数；Excel单位1，当前设计基线";
  parameter Integer parallelCellCount=config.ParallelCellCount
    "并联支路数；Excel单位1，当前设计基线";
  parameter Modelica.Units.SI.ElectricCharge cellCapacity=config.CellCapacity_Ah*(if useEOLCapacity then batteryEOLCapacityFactor else 1)
    "单并支路电芯容量；Excel单位Ah，当前设计基线";
  parameter Modelica.Units.SI.Voltage cellOCVMax=config.CellOCVMax
    "单体最高开路电压；Excel单位V，当前设计基线";
  parameter Modelica.Units.SI.Voltage cellOCVMin=config.CellOCVMin
    "单体最低开路电压；Excel单位V，当前设计基线";
  parameter Modelica.Units.SI.Resistance cellInternalResistance=config.CellInternalResistance
    "单体内阻；Excel单位Ω，当前设计基线";
  parameter Real cellSOCMin=config.CellSOCMin
    "电芯模型SOC下界；Excel单位1，当前设计基线";
  parameter Real cellSOCMax=config.CellSOCMax
    "电芯模型SOC上界；Excel单位1，当前设计基线";
  parameter Modelica.Units.SI.Resistance contactResistance=config.ContactResistance
    "电池主路径接触电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity cellHeatCapacity=config.CellHeatCapacity
    "电芯等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity enclosureHeatCapacity=config.EnclosureHeatCapacity
    "电池壳体等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance internalThermalConductance=config.InternalThermalConductance
    "电芯-壳体导热；Excel单位W/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountThermalConductance=config.MountThermalConductance
    "电池安装导热；Excel单位W/K，当前设计基线";
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
  parameter Real batteryEOLCapacityFactor(min=0,max=1)=config.EOLCapacityFactor
    "Capacity multiplier used only when EOL validation is selected";
  parameter Boolean useEOLCapacity=config.UseEOLCapacity
    "false keeps the current approximately 252 Wh BOL battery";
  parameter Modelica.Electrical.Batteries.ParameterRecords.CellData cellData(
    Qnom=cellCapacity,OCVmax=cellOCVMax,OCVmin=cellOCVMin,Ri=cellInternalResistance,SOCmin=cellSOCMin,SOCmax=cellSOCMax,Idis=0)
    "任务级参数: 8.5 Ah per parallel cell";
  parameter Real initialSOC(min=0,max=1)=0.78 "场景初始SOC";
  parameter Modelica.Units.SI.Temperature initialCellTemperature=287.15 "场景电芯初温";
  parameter Modelica.Units.SI.Temperature initialEnclosureTemperature=289.15 "场景壳体初温";
  parameter Modelica.Units.SI.Resistance batteryHeaterResistance=config.HeaterResistance
    "Two direct 14..17 V heater branches, about 2 W each at nominal source voltage";
  Foundation.Interfaces.SourcePowerPort sourcePower annotation(Placement(transformation(extent={{-10,90},{10,110}}),iconTransformation(extent={{-10,90},{10,110}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  Foundation.Models.BatteryCellStackCore cells(Ns=seriesCellCount,Np=parallelCellCount,cellData=cellData,initialSOC=initialSOC) annotation(Placement(transformation(extent={{-75,20},{-35,60}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation(Placement(transformation(extent={{-25,35},{-5,55}})));
  Modelica.Electrical.Analog.Basic.VariableConductor chargeEnable(useHeatPort=false)
    "BMS-controlled average-value bidirectional battery path" annotation(Placement(transformation(extent={{-1,59},{19,79}})));
  Modelica.Electrical.Analog.Basic.Resistor contact(R=contactResistance,useHeatPort=true) annotation(Placement(transformation(extent={{5,35},{25,55}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation(Placement(transformation(origin={45,20},extent={{-10,-10},{10,10}},rotation=270)));
  Foundation.SignalRouting.RealSignalForward batterySOCSignal annotation(Placement(transformation(extent={{52,58},{76,70}})));
  Modelica.Blocks.Sources.Constant chargeTemperatureReference(k=275.65)
    "Midpoint of 273.15/278.15 K BMS hysteresis" annotation(Placement(transformation(extent={{-92,-18},{-72,-4}})));
  Modelica.Blocks.Logical.OnOffController coldChargeInhibit(
    bandwidth=5,pre_y_start=initialCellTemperature < 273.15)
    "true below 273.15 K; false above 278.15 K" annotation(Placement(transformation(extent={{-64,-18},{-44,2}})));
  Modelica.Blocks.Logical.Not chargePermission annotation(Placement(transformation(extent={{-34,-14},{-14,6}})));
  Modelica.Blocks.Sources.Constant chargeSOCReference(k=0.94)
    "Midpoint of 0.92/0.96 SOC charge hysteresis" annotation(Placement(transformation(extent={{-92,0},{-72,14}})));
  Modelica.Blocks.Logical.OnOffController socChargePermission(
    bandwidth=0.04,pre_y_start=initialSOC < 0.96)
    "true below SOC 0.92; false above SOC 0.96" annotation(Placement(transformation(extent={{-64,4},{-44,24}})));
  Modelica.Blocks.Logical.And overallChargePermission
    "Charging requires both temperature and SOC permission" annotation(Placement(transformation(extent={{-8,-20},{12,0}})));
  Modelica.Blocks.Sources.Constant batteryPathConductance(k=1e4)
    "Continuous average battery path; charge protection acts by MPPT surplus curtailment without topology switching"
    annotation(Placement(transformation(extent={{-4,2},{26,16}})));
  Foundation.Interfaces.IntegerSignalReader batteryHeaterState[2]
    "TCB channels 17/18 directly heat cell core and enclosure" annotation(Placement(transformation(extent={{18,-6},{34,8}})));
  Foundation.Calculations.HeaterChannelCalculation batteryHeaterCalculation[2](
    each heaterResistance=batteryHeaterResistance) annotation(Placement(transformation(extent={{40,-20},{62,2}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor batteryHeaterCurrent[2]
    annotation(Placement(transformation(extent={{46,32},{62,48}})));
  Modelica.Electrical.Analog.Basic.VariableConductor batteryHeater[2](each useHeatPort=true)
    annotation(Placement(transformation(extent={{68,32},{84,48}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cellThermalMass(C=cellHeatCapacity,T(start=initialCellTemperature,fixed=true)) "任务级参数 battery thermistor 31 initial work point" annotation(Placement(transformation(extent={{-60,-45},{-40,-25}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor enclosureThermalMass(C=enclosureHeatCapacity,T(start=initialEnclosureTemperature,fixed=true)) "任务级参数 battery thermistor 32 initial work point" annotation(Placement(transformation(extent={{-10,-45},{10,-25}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor internalPath(G=internalThermalConductance) annotation(Placement(transformation(extent={{-35,-42},{-15,-28}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor mountPath(G=mountThermalConductance)
    "任务级参数: insulated battery tray while retaining finite conductive rejection" annotation(Placement(transformation(extent={{20,-42},{40,-28}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor thermistor31 annotation(Placement(transformation(extent={{-36,-72},{-16,-52}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor thermistor32 annotation(Placement(transformation(extent={{16,-72},{36,-52}})));
  Modelica.Mechanics.MultiBody.Parts.Body housing(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-64,-10},{-44,10}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[7] annotation(Placement(transformation(extent={{78,16},{86,24}})));
  Foundation.Interfaces.BooleanSignalBridge informationBooleanBridge[1] annotation(Placement(transformation(extent={{78,-20},{86,-12}})));
equation
  connect(cells.SOC,batterySOCSignal.u) annotation(Line(points={{-55,61},{-55,57.5},{52,57.5},{52,64}},color={0,0,127}));
  connect(information.device.tcState[17],batteryHeaterState[1].u) annotation(Line(points={{100,0},{100,3.5},{18,3.5},{18,1}},color={255,127,0}));
  connect(information.device.tcState[18],batteryHeaterState[2].u) annotation(Line(points={{100,0},{100,3.5},{18,3.5},{18,1}},color={255,127,0}));
  connect(batteryHeaterState.y,batteryHeaterCalculation.controlState) annotation(Line(points={{34,1},{38,1},{38,7},{40,7},{40,-9}},color={255,127,0}));
  connect(cells.p,currentSensor.p) annotation(Line(points={{-75,40},{-84,40},{-84,72},{-25,72},{-25,45}},color={0,0,255}));
  connect(currentSensor.n,chargeEnable.p) annotation(Line(points={{-5,45},{-1,45},{-1,69}},color={0,0,255}));
  connect(chargeEnable.n,contact.p) annotation(Line(points={{19,69},{5,69},{5,45}},color={0,0,255}));
  connect(contact.n,sourcePower.p) annotation(Line(points={{25,45},{25,94},{0,94},{0,100}},color={0,0,255}));
  connect(cells.n,sourcePower.n) annotation(Line(points={{-35,40},{-35,94},{0,94},{0,100}},color={0,0,255}));
  connect(voltageSensor.p,sourcePower.p) annotation(Line(points={{45,30},{45,94},{0,94},{0,100}},color={0,0,255}));
  connect(voltageSensor.n,sourcePower.n) annotation(Line(points={{45,10},{45,94},{0,94},{0,100}},color={0,0,255}));
  connect(cells.heatPort,cellThermalMass.port) annotation(Line(points={{-55,20},{-68,20},{-68,-50},{-50,-50},{-50,-45}},color={191,0,0}));
  connect(contact.heatPort,cellThermalMass.port) annotation(Line(points={{15,35},{15,-23.5},{-50,-23.5},{-50,-45}},color={191,0,0}));
  connect(cellThermalMass.port,internalPath.port_a) annotation(Line(points={{-50,-45},{-50,-50},{-38,-50},{-38,-35},{-35,-35}},color={191,0,0}));
  connect(internalPath.port_b,enclosureThermalMass.port) annotation(Line(points={{-15,-35},{-12,-35},{-12,-50},{0,-50},{0,-45}},color={191,0,0}));
  connect(enclosureThermalMass.port,mountPath.port_a) annotation(Line(points={{0,-45},{0,-50},{16,-50},{16,-35},{20,-35}},color={191,0,0}));
  connect(mountPath.port_b,thermal) annotation(Line(points={{40,-35},{40,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(cellThermalMass.port,thermistor31.port) annotation(Line(points={{-50,-45},{-50,-62},{-36,-62}},color={191,0,0}));
  connect(enclosureThermalMass.port,thermistor32.port) annotation(Line(points={{0,-45},{0,-62},{16,-62}},color={191,0,0}));
  connect(thermistor31.T,informationRealBridge[1].u) annotation(Line(points={{-16,-62},{-16,-46.5},{76.5,-46.5},{76.5,20},{78,20}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.thermistorTemperature[31]) annotation(Line(points={{86,20},{94,20},{94,0},{100,0}},color={0,0,127}));
  connect(thermistor32.T,informationRealBridge[2].u) annotation(Line(points={{36,-62},{78,-62},{78,20}},color={0,0,127}));
  connect(informationRealBridge[2].y,information.device.thermistorTemperature[32]) annotation(Line(points={{86,20},{94,20},{94,0},{100,0}},color={0,0,127}));
  connect(currentSensor.i,informationRealBridge[3].u) annotation(Line(points={{-15,35},{-15,56.5},{66.5,56.5},{66.5,20},{78,20}},color={0,0,127}));
  connect(informationRealBridge[3].y,information.device.pdCurrent[22]) annotation(Line(points={{86,20},{94,20},{94,0},{100,0}},color={0,0,127}));
  connect(voltageSensor.v,informationRealBridge[4].u) annotation(Line(points={{55,20},{78,20}},color={0,0,127}));
  connect(informationRealBridge[4].y,information.device.batteryVoltage) annotation(Line(points={{86,20},{94,20},{94,0},{100,0}},color={0,0,127}));
  connect(batterySOCSignal.y,informationRealBridge[5].u) annotation(Line(points={{77.2,64},{85.5,64},{85.5,20},{78,20}},color={0,0,127}));
  connect(informationRealBridge[5].y,information.device.batterySOC) annotation(Line(points={{86,20},{94,20},{94,0},{100,0}},color={0,0,127}));
  connect(thermistor31.T,coldChargeInhibit.u) annotation(Line(points={{-16,-62},{-66,-62},{-66,-14},{-64,-14}},color={0,0,127}));
  connect(chargeTemperatureReference.y,coldChargeInhibit.reference) annotation(Line(points={{-71,-11},{-68,-11},{-68,-6},{-64,-6}},color={0,0,127}));
  connect(coldChargeInhibit.y,chargePermission.u) annotation(Line(points={{-43,-8},{-36,-8},{-36,-4},{-34,-4}},color={255,0,255}));
  connect(batterySOCSignal.y,socChargePermission.u) annotation(Line(points={{77.2,64},{25,64},{25,10},{-64,10},{-64,8}},color={0,0,127}));
  connect(chargeSOCReference.y,socChargePermission.reference) annotation(Line(points={{-71,7},{-68,7},{-68,16},{-64,16}},color={0,0,127}));
  connect(chargePermission.y,overallChargePermission.u1) annotation(Line(points={{-13,-4},{-12,-4},{-12,-18},{-8,-18},{-8,-10}},color={255,0,255}));
  connect(socChargePermission.y,overallChargePermission.u2) annotation(Line(points={{-43,14},{-8,14},{-8,-18}},color={255,0,255}));
  connect(batteryPathConductance.y,chargeEnable.G) annotation(Line(points={{27.5,9},{27.5,57},{9,57}},color={0,0,127}));
  connect(overallChargePermission.y,informationBooleanBridge[1].u) annotation(Line(points={{13,-10},{13,-21.5},{78,-21.5},{78,-16}},color={255,0,255}));
  connect(informationBooleanBridge[1].y,information.device.batteryChargeAllowed) annotation(Line(points={{86,-16},{94,-16},{94,0},{100,0}},color={255,0,255}));
  connect(batteryHeaterCalculation.conductance,batteryHeater.G) annotation(Line(points={{61,-12.85},{76,-12.85},{76,30}},color={0,0,127}));
  connect(sourcePower.p,batteryHeaterCurrent[1].p) annotation(Line(points={{0,100},{0,94},{46,94},{46,40}},color={0,0,255}));
  connect(sourcePower.p,batteryHeaterCurrent[2].p) annotation(Line(points={{0,100},{0,94},{46,94},{46,40}},color={0,0,255}));
  connect(batteryHeaterCurrent.n,batteryHeater.p) annotation(Line(points={{62,40},{68,40}},color={0,0,255}));
  connect(batteryHeater[1].n,sourcePower.n) annotation(Line(points={{84,40},{84,94},{0,94},{0,100}},color={0,0,255}));
  connect(batteryHeater[2].n,sourcePower.n) annotation(Line(points={{84,40},{84,94},{0,94},{0,100}},color={0,0,255}));
  connect(batteryHeater[1].heatPort,cellThermalMass.port) annotation(Line(points={{76,32},{76,-50},{-50,-50},{-50,-45}},color={191,0,0}));
  connect(batteryHeater[2].heatPort,enclosureThermalMass.port) annotation(Line(points={{76,32},{76,-50},{0,-50},{0,-45}},color={191,0,0}));
  connect(batteryHeaterCurrent[1].i,informationRealBridge[6].u) annotation(Line(points={{54,32},{78,32},{78,20}},color={0,0,127}));
  connect(informationRealBridge[6].y,information.device.tcCurrent[17]) annotation(Line(points={{86,20},{94,20},{94,0},{100,0}},color={0,0,127}));
  connect(batteryHeaterCurrent[2].i,informationRealBridge[7].u) annotation(Line(points={{54,32},{78,32},{78,20}},color={0,0,127}));
  connect(informationRealBridge[7].y,information.device.tcCurrent[18]) annotation(Line(points={{86,20},{94,20},{94,0},{100,0}},color={0,0,127}));
  connect(housing.frame_a,mechanical) annotation(Line(points={{-64,0},{-100,0}},color={95,95,95},thickness=0.5));
  annotation(
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},
preserveAspectRatio=true,
grid={2,2}),graphics = {Rectangle(origin={0,0},
lineColor={45,105,55},
fillColor={239,248,237},
fillPattern=FillPattern.Solid,
extent={{-100,100},{100,-100}}), Rectangle(origin={0,7},
lineColor={35,90,45},
fillColor={211,235,205},
fillPattern=FillPattern.Solid,
extent={{-72,47},{72,-47}}), Rectangle(origin={0,59.5},
lineColor={35,90,45},
fillColor={35,90,45},
fillPattern=FillPattern.Solid,
extent={{-16,5.5},{16,-5.5}}), Rectangle(origin={-40,25},
lineColor={70,125,70},
fillColor={245,251,241},
fillPattern=FillPattern.Solid,
extent={{-18,15},{18,-15}}), Rectangle(origin={-40,-15},
lineColor={70,125,70},
fillColor={245,251,241},
fillPattern=FillPattern.Solid,
extent={{-18,15},{18,-15}}), Rectangle(origin={2,25},
lineColor={70,125,70},
fillColor={245,251,241},
fillPattern=FillPattern.Solid,
extent={{-18,15},{18,-15}}), Rectangle(origin={2,-15},
lineColor={70,125,70},
fillColor={245,251,241},
fillPattern=FillPattern.Solid,
extent={{-18,15},{18,-15}}), Rectangle(origin={44,25},
lineColor={70,125,70},
fillColor={245,251,241},
fillPattern=FillPattern.Solid,
extent={{-18,15},{18,-15}}), Rectangle(origin={44,-15},
lineColor={70,125,70},
fillColor={245,251,241},
fillPattern=FillPattern.Solid,
extent={{-18,15},{18,-15}}), Line(origin={0,0},
points={{-48,26},{-32,26}},
color={45,105,55},
thickness=0.8), Line(origin={0,0},
points={{-6,26},{10,26}},
color={45,105,55},
thickness=0.8), Line(origin={0,0},
points={{36,26},{52,26}},
color={45,105,55},
thickness=0.8), Line(origin={0,0},
points={{-48,-14},{-32,-14}},
color={45,105,55},
thickness=0.8), Line(origin={0,0},
points={{-6,-14},{10,-14}},
color={45,105,55},
thickness=0.8), Line(origin={0,0},
points={{36,-14},{52,-14}},
color={45,105,55},
thickness=0.8), Text(origin={-40,26},
lineColor={45,105,55},
extent={{-14,12},{14,-12}},
textString="1",
textColor={45,105,55}), Text(origin={2,26},
lineColor={45,105,55},
extent={{-14,12},{14,-12}},
textString="2",
textColor={45,105,55}), Text(origin={44,26},
lineColor={45,105,55},
extent={{-14,12},{14,-12}},
textString="3",
textColor={45,105,55}), Rectangle(origin={62,-52},
lineColor={45,105,55},
fillColor={230,243,225},
fillPattern=FillPattern.Solid,
extent={{-10,6},{10,-6}}), Text(origin={0,-68},
lineColor={35,90,45},
extent={{-90,-10},{90,10}},
textString="4S2P Li-ion BATTERY",
textColor={35,90,45})}),
    Diagram(
      coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),
      graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),
        Rectangle(extent={{-90,76},{68,0}},lineColor={128,171,128},
          fillColor={249,253,248},fillPattern=FillPattern.Solid),
        Text(extent={{-88,75},{66,67}},
          textString="4S2P ELECTROCHEMICAL STACK / BMS & TERMINAL MEASUREMENT",
          lineColor={45,105,55}),

        Rectangle(extent={{-70,-18},{56,-80}},lineColor={210,150,145},
          fillColor={255,249,248},fillPattern=FillPattern.Solid),
        Text(extent={{-68,-17},{54,-25}},
          textString="DUAL THERMAL NODES / DUAL THERMISTORS",
          lineColor={165,55,45}),
        Text(extent={{-67,-74},{54,-80}},
          textString="Cell core → enclosure → spacecraft thermal mount",
          lineColor={105,105,105}),

        Rectangle(extent={{-92,-80},{-50,-106}},lineColor={155,155,155},
          fillColor={250,250,250},fillPattern=FillPattern.Solid),
        Text(extent={{-91,-81},{-51,-88}},
          textString="UNUSED 5 V / 3.3 V RAILS",
          lineColor={95,95,95}),
        Text(extent={{-90,-96},{-52,-103}},
          textString="Numerical closure only",
          lineColor={120,120,120}),

        Text(extent={{-22,98},{22,90}},textString="STRUCTURAL HOUSING",
          lineColor={95,95,95}),
        Text(extent={{58,12},{105,4}},textString="BATTERY STATUS / TEMPERATURE",
          lineColor={0,90,180}),
        Text(extent={{44,-91},{104,-84}},textString="SPACECRAFT THERMAL NETWORK",
          lineColor={170,45,35})
      }),
    Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>承担原始电源侧储能、充放电保护、电池端测量和敏感热节点建模</p><p><b>白箱实现：</b>采用Modelica 4.0.0 CellStack、连续双向电源路径、温度/SOC回差、双热容双热敏，以及由TCB 17/18直接驱动的两路电阻加热支路。</p><h4>配置与BMS</h4><p><b>任务级参数：</b>4S2P、8.5 Ah/cell，约14.8 V×17 Ah=252 Wh，初始SOC保持0.78。低于273.15 K锁存禁止充电，高于278.15 K恢复；SOC高于0.96停止充电，低于0.92恢复。禁充只限制太阳阵源侧剩余功率，不切断放电主路，也不在原始母线上设置虚假耗能源。</p><p><b>热路径：</b>17路加热器直接向电芯热容注热，18路直接向壳体热容注热；安装导热保留有限热隔离，不再先加热公共舱板。</p><h4>对外接口与能量路径</h4><p>sourcePower连接太阳阵与PCDU所在的原始电源域，正电流方向由电气连接方程统一确定；thermal把电芯、壳体和两路加热器的热量送入整星热网；mechanical提供电池箱质量与惯量；information同时承载BMS许可、TCB加热指令以及电压、电流、SOC和温度测量。电能路径为电芯堆—电流传感器—连续双向通路—接触电阻—原始母线，充电与放电共用同一物理支路。</p><h4>关键参数与工作行为</h4><p>cellData定义单体8.5 Ah容量、开路电压范围、内阻和SOC边界，Ns=4、Np=2形成约252 Wh的4S2P电池。initialSOC和两个初温只决定起始工况；useEOLCapacity用于寿命末期容量评估，不改变拓扑。温度与SOC回差分别控制是否允许太阳剩余功率充电，两路TCB状态则独立控制电芯和壳体加热器。</p><h4>结果查看与判读</h4><p>任务级分析优先查看cells.SOC、voltageSensor.v、currentSensor.i、thermistor31.T和thermistor32.T，并结合information.device.batteryChargeAllowed判断充电受限原因。比较正负电流前应以原始母线功率方向核对符号，不应把加热支路电流误认为电池净充电电流。</p><h4>建模边界</h4><p>模型保留SOC、内阻损耗、BMS回差和两节点热惯性，不展开单体不一致、均衡电路、倍率/温度相关老化、SEI增长或故障传播。它适合24 h总体能量闭合和热安全分析，不代替电芯级寿命与安全认证模型。</p></html>"));
end BatteryUnit;
