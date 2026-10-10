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
    "电池EOLCapacityFactor；Capacity multiplier used only when EOL validation is selected";
  parameter Boolean useEOLCapacity=config.UseEOLCapacity
    "配置项 useEOLCapacity；false keeps the current approximately 252 Wh BOL battery";
  parameter Modelica.Electrical.Batteries.ParameterRecords.CellData cellData(
    Qnom=cellCapacity,OCVmax=cellOCVMax,OCVmin=cellOCVMin,Ri=cellInternalResistance,SOCmin=cellSOCMin,SOCmax=cellSOCMax,Idis=0)
    "任务级参数: 8.5 Ah per parallel cell";
  parameter Real initialSOC(min=0,max=1)=0.78 "场景初始SOC";
  parameter Modelica.Units.SI.Temperature initialCellTemperature=287.15 "场景电芯初温";
  parameter Modelica.Units.SI.Temperature initialEnclosureTemperature=289.15 "场景壳体初温";
  parameter Modelica.Units.SI.Resistance batteryHeaterResistance=config.HeaterResistance
    "电池HeaterResistance [Ohm]；Two direct 14..17 V heater branches, about 2 W each at nominal source voltage";
  Foundation.Interfaces.SourcePowerPort sourcePower  "源功率" annotation(Placement(visible=true, transformation(origin={430,260}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,95}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.ThermalPort thermal  "热学" annotation(Placement(visible=true, transformation(origin={410,-345}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,-97}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(visible=true, transformation(origin={-480,-210}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.InformationPort information  "计算/接口量 information" annotation(Placement(visible=true, transformation(origin={565,-20}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Models.BatteryCellStackCore cells(Ns=seriesCellCount,Np=parallelCellCount,cellData=cellData,initialSOC=initialSOC)  "带公开荷电状态接口的电池组实例" annotation(Placement(visible=true, transformation(origin={-320,240}, extent={{-72,-72},{72,72}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor  "电流传感器" annotation(Placement(visible=true, transformation(origin={-150,275}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.VariableConductor chargeEnable(useHeatPort=false)
    "计算/接口量 chargeEnable；BMS-controlled average-value bidirectional battery path" annotation(Placement(visible=true, transformation(origin={-25,275}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor contact(R=contactResistance,useHeatPort=true)  "计算/接口量 contact" annotation(Placement(visible=true, transformation(origin={110,275}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor  "电压传感器" annotation(Placement(visible=true, transformation(origin={300,155}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Blocks.Continuous.LimIntegrator bmsCoulombCounter(
    final k=-1/(parallelCellCount*cellData.Qnom),
    outMax=1-1e-9,outMin=1e-9,
    final initType=Modelica.Blocks.Types.Init.NoInit,
    y(start=initialSOC,fixed=true))
    "计算/接口量 bmsCoulombCounter；BMS estimate from the measured discharge-positive external battery current; never reads physical cells.SOC at runtime" 
    annotation(Placement(visible=true, transformation(origin={-140,155}, extent={{-42,-42},{42,42}}, rotation=0)));
  Modelica.Blocks.Sources.Constant chargeTemperatureReference(k=275.65)
    "charge温度Reference；Midpoint of 273.15/278.15 K BMS hysteresis" annotation(Placement(visible=true, transformation(origin={-300,-50}, extent={{-20,-20},{20,20}}, rotation=0)));
  Modelica.Blocks.Logical.OnOffController coldChargeInhibit(
    bandwidth=5,pre_y_start=initialCellTemperature < 273.15)
    "计算/接口量 coldChargeInhibit；true below 273.15 K; false above 278.15 K" annotation(Placement(visible=true, transformation(origin={-160,-90}, extent={{-28,-28},{28,28}}, rotation=0)));
  Modelica.Blocks.Logical.Not chargePermission  "计算/接口量 chargePermission" annotation(Placement(visible=true, transformation(origin={-35,-90}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Blocks.Sources.Constant chargeSOCReference(k=0.94)
    "计算/接口量 chargeSOCReference；Midpoint of 0.92/0.96 SOC charge hysteresis" annotation(Placement(visible=true, transformation(origin={-250,80}, extent={{-20,-20},{20,20}}, rotation=0)));
  Modelica.Blocks.Logical.OnOffController socChargePermission(
    bandwidth=0.04,pre_y_start=initialSOC < 0.96)
    "计算/接口量 socChargePermission；true below SOC 0.92; false above SOC 0.96" annotation(Placement(visible=true, transformation(origin={-110,50}, extent={{-28,-28},{28,28}}, rotation=0)));
  Modelica.Blocks.Logical.And overallChargePermission
    "计算/接口量 overallChargePermission；Charging requires both temperature and SOC permission" annotation(Placement(visible=true, transformation(origin={100,-10}, extent={{-30,-30},{30,30}}, rotation=0)));
  Modelica.Blocks.Sources.Constant batteryPathConductance(k=1e4)
    "电池PathConductance；Continuous average battery path; charge protection acts by MPPT surplus curtailment without topology switching" 
    annotation(Placement(visible=true, transformation(origin={-25,360}, extent={{-22,-22},{22,22}}, rotation=0)));
  Foundation.Interfaces.IntegerSignalReader batteryHeaterState[2]
    "可扩展总线整数信号到因果计算端口的无状态恒等读取器实例；TCB channels 17/18 directly heat cell core and enclosure" annotation(Placement(visible=true, transformation(origin={175,-150}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Calculations.HeaterChannelCalculation batteryHeaterCalculation[2](
    each heaterResistance=batteryHeaterResistance)  "单路加热器指令与平均电导计算实例" annotation(Placement(visible=true, transformation(origin={310,-150}, extent={{-22,-22},{22,22}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor batteryHeaterCurrent[2] 
     "电池Heater电流" annotation(Placement(visible=true, transformation(origin={270,260}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.VariableConductor batteryHeater[2](each useHeatPort=true) 
     "电池Heater" annotation(Placement(visible=true, transformation(origin={310,15}, extent={{-26,-26},{26,26}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cellThermalMass(C=cellHeatCapacity,T(start=initialCellTemperature,fixed=true)) "任务级参数 battery thermistor 31 initial work point" annotation(Placement(visible=true, transformation(origin={-110,-305}, extent={{-30,-30},{30,30}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor enclosureThermalMass(C=enclosureHeatCapacity,T(start=initialEnclosureTemperature,fixed=true)) "任务级参数 battery thermistor 32 initial work point" annotation(Placement(visible=true, transformation(origin={150,-305}, extent={{-30,-30},{30,30}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor internalPath(G=internalThermalConductance)  "计算/接口量 internalPath" annotation(Placement(visible=true, transformation(origin={20,-335}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor mountPath(G=mountThermalConductance)
    "任务级参数: insulated battery tray while retaining finite conductive rejection" annotation(Placement(visible=true, transformation(origin={290,-345}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor thermistor31  "计算/接口量 thermistor31" annotation(Placement(visible=true, transformation(origin={-20,-235}, extent={{-22,-22},{22,22}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor thermistor32  "计算/接口量 thermistor32" annotation(Placement(visible=true, transformation(origin={140,-235}, extent={{-22,-22},{22,22}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.Body housing(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ)  "计算/接口量 housing" annotation(Placement(visible=true, transformation(origin={-390,-210}, extent={{-30,-30},{30,30}}, rotation=0)));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[7]  "实数因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={445,30}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.BooleanSignalBridge informationBooleanBridge[1]  "布尔因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={430,-100}, extent={{-16,-16},{16,16}}, rotation=0)));
equation
  connect(currentSensor.i,bmsCoulombCounter.u) annotation(Line(points={{-150,248.6},{-150,238.6},{-200.4,238.6},{-200.4,155},{-190.4,155}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information.device.tcState[17],batteryHeaterState[1].u) annotation(Line(points={{565,-20},{565,-56},{127.62,-56},{127.62,-150},{160.76,-150}}, color={255,127,0}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information.device.tcState[18],batteryHeaterState[2].u) annotation(Line(points={{565,-20},{565,-56},{127.62,-56},{127.62,-150},{160.76,-150}}, color={255,127,0}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(batteryHeaterState.y,batteryHeaterCalculation.controlState) annotation(Line(points={{189.24,-150},{290.42,-150}}, color={255,127,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(cells.p,currentSensor.p) annotation(Line(points={{-377.6,308.4},{-377.6,318.4},{-184,318.4},{-184,275},{-174,275}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(currentSensor.n,chargeEnable.p) annotation(Line(points={{-126,275},{-49,275}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(chargeEnable.n,contact.p) annotation(Line(points={{-1,275},{86,275}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(contact.n,sourcePower.p) annotation(Line(points={{134,275},{144,275},{144,294},{430,294},{430,260}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(cells.n,sourcePower.n) annotation(Line(points={{-262.4,308.4},{-262.4,318.4},{430,318.4},{430,260}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(voltageSensor.p,sourcePower.p) annotation(Line(points={{276,155},{266,155},{266,189},{430,189},{430,260}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(voltageSensor.n,sourcePower.n) annotation(Line(points={{324,155},{430,155},{430,260}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(cells.heatPort,cellThermalMass.port) annotation(Line(points={{-320,170.16},{-320,160.16},{-220,160.16},{-220,-345},{-110,-345},{-110,-335}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(contact.heatPort,cellThermalMass.port) annotation(Line(points={{110,251},{110,241},{-215,241},{-215,-345},{-110,-345},{-110,-335}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(cellThermalMass.port,internalPath.port_a) annotation(Line(points={{-110,-335},{-110,-345},{-14,-345},{-14,-335},{-4,-335}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(internalPath.port_b,enclosureThermalMass.port) annotation(Line(points={{44,-335},{54,-335},{54,-345},{150,-345},{150,-335}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(enclosureThermalMass.port,mountPath.port_a) annotation(Line(points={{150,-335},{150,-345},{266,-345}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mountPath.port_b,thermal) annotation(Line(points={{314,-345},{410,-345}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(cellThermalMass.port,thermistor31.port) annotation(Line(points={{-110,-335},{-110,-345},{-52,-345},{-52,-235},{-42,-235}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(enclosureThermalMass.port,thermistor32.port) annotation(Line(points={{150,-335},{150,-345},{108,-345},{108,-235},{118,-235}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermistor31.T,informationRealBridge[1].u) annotation(Line(points={{4.2,-235},{110,-235},{110,-50},{397.62,-50},{397.62,30},{430.76,30}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[1].y,information.device.thermistorTemperature[31]) annotation(Line(points={{459.24,30},{565,30},{565,-20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermistor32.T,informationRealBridge[2].u) annotation(Line(points={{164.2,-235},{382.62,-235},{382.62,30},{430.76,30}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[2].y,information.device.thermistorTemperature[32]) annotation(Line(points={{459.24,30},{565,30},{565,-20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(currentSensor.i,informationRealBridge[3].u) annotation(Line(points={{-150,248.6},{-150,207},{397.62,207},{397.62,30},{430.76,30}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[3].y,information.device.pdCurrent[22]) annotation(Line(points={{459.24,30},{565,30},{565,-20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(voltageSensor.v,informationRealBridge[4].u) annotation(Line(points={{300,128.6},{300,118.6},{346,118.6},{346,30},{430.76,30}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[4].y,information.device.batteryVoltage) annotation(Line(points={{459.24,30},{565,30},{565,-20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(bmsCoulombCounter.y,informationRealBridge[5].u) annotation(Line(points={{-93.8,155},{-83.8,155},{-83.8,88},{397.62,88},{397.62,30},{430.76,30}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[5].y,information.device.batterySOC) annotation(Line(points={{459.24,30},{565,30},{565,-20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermistor31.T,coldChargeInhibit.u) annotation(Line(points={{4.2,-235},{14.2,-235},{14.2,-191},{-215,-191},{-215,-106.8},{-193.6,-106.8}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(chargeTemperatureReference.y,coldChargeInhibit.reference) annotation(Line(points={{-278,-50},{-220,-50},{-220,-73.2},{-193.6,-73.2}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(coldChargeInhibit.y,chargePermission.u) annotation(Line(points={{-129.2,-90},{-63.8,-90}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(bmsCoulombCounter.y,socChargePermission.u) annotation(Line(points={{-93.8,155},{-83.8,155},{-83.8,88},{-153.6,88},{-153.6,33.2},{-143.6,33.2}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(chargeSOCReference.y,socChargePermission.reference) annotation(Line(points={{-228,80},{-215,80},{-215,66.8},{-143.6,66.8}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(chargePermission.y,overallChargePermission.u1) annotation(Line(points={{-8.6,-90},{54,-90},{54,-10},{64,-10}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(socChargePermission.y,overallChargePermission.u2) annotation(Line(points={{-79.2,50},{54,50},{54,-34},{64,-34}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(batteryPathConductance.y,chargeEnable.G) annotation(Line(points={{-0.8,360},{9.2,360},{9.2,318.4},{-25,318.4},{-25,303.8}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(overallChargePermission.y,informationBooleanBridge[1].u) annotation(Line(points={{133,-10},{143,-10},{143,-21},{382.62,-21},{382.62,-100},{415.76,-100}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationBooleanBridge[1].y,information.device.batteryChargeAllowed) annotation(Line(points={{444.24,-100},{565,-100},{565,-20}}, color={255,0,255}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(batteryHeaterCalculation.conductance,batteryHeater.G) annotation(Line(points={{363.4,-198},{373.4,-198},{373.4,56.2},{310,56.2},{310,46.2}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(sourcePower.p,batteryHeaterCurrent[1].p) annotation(Line(points={{430,260},{430,226},{236,226},{236,260},{246,260}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(sourcePower.p,batteryHeaterCurrent[2].p) annotation(Line(points={{430,260},{430,226},{236,226},{236,260},{246,260}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(batteryHeaterCurrent.n,batteryHeater.p) annotation(Line(points={{294,260},{304,260},{304,189},{266,189},{266,15},{284,15}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(batteryHeater[1].n,sourcePower.n) annotation(Line(points={{336,15},{346,15},{346,79.9},{430,79.9},{430,260}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(batteryHeater[2].n,sourcePower.n) annotation(Line(points={{336,15},{346,15},{346,79.9},{430,79.9},{430,260}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(batteryHeater[1].heatPort,cellThermalMass.port) annotation(Line(points={{310,-11},{310,-21},{222.38,-21},{222.38,-267},{-72,-267},{-72,-345},{-110,-345},{-110,-335}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(batteryHeater[2].heatPort,enclosureThermalMass.port) annotation(Line(points={{310,-11},{310,-21},{222.38,-21},{222.38,-345},{150,-345},{150,-335}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(batteryHeaterCurrent[1].i,informationRealBridge[6].u) annotation(Line(points={{270,233.6},{270,189},{397.62,189},{397.62,30},{430.76,30}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[6].y,information.device.tcCurrent[17]) annotation(Line(points={{459.24,30},{565,30},{565,-20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(batteryHeaterCurrent[2].i,informationRealBridge[7].u) annotation(Line(points={{270,233.6},{270,189},{397.62,189},{397.62,30},{430.76,30}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[7].y,information.device.tcCurrent[18]) annotation(Line(points={{459.24,30},{565,30},{565,-20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(housing.frame_a,mechanical) annotation(Line(points={{-420,-210},{-480,-210}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>四串两并锂离子电池组件</h2><p><b>类路径：</b><code>OneSatSim.Components.BatteryUnit</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>四串两并锂离子电池组件</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.N_systems.ElectricalPowerSystem\">OneSatSim.Systems.N_systems.ElectricalPowerSystem</a> 的 <code>battery</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>sourcePower</code></td><td>Foundation.Interfaces.SourcePowerPort</td><td>public</td><td>按声明/类型合同</td><td>源功率</td></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr><tr><td><code>information</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr><tr><td><code>batteryHeaterState[2]</code></td><td>Foundation.Interfaces.IntegerSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线整数信号到因果计算端口的无状态恒等读取器实例；TCB channels 17/18 directly heat cell core and enclosure</td></tr><tr><td><code>informationRealBridge[7]</code></td><td>Foundation.Interfaces.RealSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>实数因果输出到可扩展信息总线的无状态恒等桥实例</td></tr><tr><td><code>informationBooleanBridge[1]</code></td><td>Foundation.Interfaces.BooleanSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>布尔因果输出到可扩展信息总线的无状态恒等桥实例</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>config</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.BatteryComponentConfig</td><td>由所属N-System传入的硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>seriesCellCount</code></td><td>Integer</td><td>串联电芯数；Excel单位1，当前设计基线</td><td><code>=config.SeriesCellCount</code></td></tr><tr><td><code>parallelCellCount</code></td><td>Integer</td><td>并联支路数；Excel单位1，当前设计基线</td><td><code>=config.ParallelCellCount</code></td></tr><tr><td><code>cellCapacity</code></td><td>Modelica.Units.SI.ElectricCharge</td><td>单并支路电芯容量；Excel单位Ah，当前设计基线</td><td><code>=config.CellCapacity_Ah*(if useEOLCapacity then batteryEOLCapacityFactor else 1)</code></td></tr><tr><td><code>cellOCVMax</code></td><td>Modelica.Units.SI.Voltage</td><td>单体最高开路电压；Excel单位V，当前设计基线</td><td><code>=config.CellOCVMax</code></td></tr><tr><td><code>cellOCVMin</code></td><td>Modelica.Units.SI.Voltage</td><td>单体最低开路电压；Excel单位V，当前设计基线</td><td><code>=config.CellOCVMin</code></td></tr><tr><td><code>cellInternalResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>单体内阻；Excel单位Ω，当前设计基线</td><td><code>=config.CellInternalResistance</code></td></tr><tr><td><code>cellSOCMin</code></td><td>Real</td><td>电芯模型SOC下界；Excel单位1，当前设计基线</td><td><code>=config.CellSOCMin</code></td></tr><tr><td><code>cellSOCMax</code></td><td>Real</td><td>电芯模型SOC上界；Excel单位1，当前设计基线</td><td><code>=config.CellSOCMax</code></td></tr><tr><td><code>contactResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>电池主路径接触电阻；Excel单位Ω，当前设计基线</td><td><code>=config.ContactResistance</code></td></tr><tr><td><code>cellHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>电芯等效热容；Excel单位J/K，当前设计基线</td><td><code>=config.CellHeatCapacity</code></td></tr><tr><td><code>enclosureHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>电池壳体等效热容；Excel单位J/K，当前设计基线</td><td><code>=config.EnclosureHeatCapacity</code></td></tr><tr><td><code>internalThermalConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>电芯-壳体导热；Excel单位W/K，当前设计基线</td><td><code>=config.InternalThermalConductance</code></td></tr><tr><td><code>mountThermalConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>电池安装导热；Excel单位W/K，当前设计基线</td><td><code>=config.MountThermalConductance</code></td></tr><tr><td><code>mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel单位kg，当前设计基线</td><td><code>=config.Mass</code></td></tr><tr><td><code>rcm_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel单位m，当前设计基线</td><td><code>=config.RCM_X</code></td></tr><tr><td><code>rcm_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel单位m，当前设计基线</td><td><code>=config.RCM_Y</code></td></tr><tr><td><code>rcm_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel单位m，当前设计基线</td><td><code>=config.RCM_Z</code></td></tr><tr><td><code>inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_XX</code></td></tr><tr><td><code>inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_YY</code></td></tr><tr><td><code>inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_ZZ</code></td></tr><tr><td><code>batteryEOLCapacityFactor</code></td><td>Real</td><td>电池EOLCapacityFactor；Capacity multiplier used only when EOL validation is selected</td><td><code>=config.EOLCapacityFactor</code></td></tr><tr><td><code>useEOLCapacity</code></td><td>Boolean</td><td>配置项 useEOLCapacity；false keeps the current approximately 252 Wh BOL battery</td><td><code>=config.UseEOLCapacity</code></td></tr><tr><td><code>cellData</code></td><td>Modelica.Electrical.Batteries.ParameterRecords.CellData</td><td>任务级参数: 8.5 Ah per parallel cell</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>initialSOC</code></td><td>Real</td><td>场景初始SOC</td><td><code>=0.78</code></td></tr><tr><td><code>initialCellTemperature</code></td><td>Modelica.Units.SI.Temperature</td><td>场景电芯初温</td><td><code>=287.15</code></td></tr><tr><td><code>initialEnclosureTemperature</code></td><td>Modelica.Units.SI.Temperature</td><td>场景壳体初温</td><td><code>=289.15</code></td></tr><tr><td><code>batteryHeaterResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>电池HeaterResistance [Ohm]；Two direct 14..17 V heater branches, about 2 W each at nominal source voltage</td><td><code>=config.HeaterResistance</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>cells</code></td><td><a href=\"modelica://OneSatSim.Foundation.Models.BatteryCellStackCore\">OneSatSim.Foundation.Models.BatteryCellStackCore</a></td><td>带公开荷电状态接口的电池组实例</td></tr><tr><td><code>currentSensor</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Sensors.CurrentSensor\">Modelica.Electrical.Analog.Sensors.CurrentSensor</a></td><td>电流传感器</td></tr><tr><td><code>chargeEnable</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.VariableConductor\">Modelica.Electrical.Analog.Basic.VariableConductor</a></td><td>计算/接口量 chargeEnable；BMS-controlled average-value bidirectional battery path</td></tr><tr><td><code>contact</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Resistor\">Modelica.Electrical.Analog.Basic.Resistor</a></td><td>计算/接口量 contact</td></tr><tr><td><code>voltageSensor</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Sensors.VoltageSensor\">Modelica.Electrical.Analog.Sensors.VoltageSensor</a></td><td>电压传感器</td></tr><tr><td><code>bmsCoulombCounter</code></td><td><a href=\"modelica://Modelica.Blocks.Continuous.LimIntegrator\">Modelica.Blocks.Continuous.LimIntegrator</a></td><td>计算/接口量 bmsCoulombCounter；BMS estimate from the measured discharge-positive external battery current; never reads physical cells.SOC at runtime</td></tr><tr><td><code>chargeTemperatureReference</code></td><td><a href=\"modelica://Modelica.Blocks.Sources.Constant\">Modelica.Blocks.Sources.Constant</a></td><td>charge温度Reference；Midpoint of 273.15/278.15 K BMS hysteresis</td></tr><tr><td><code>coldChargeInhibit</code></td><td><a href=\"modelica://Modelica.Blocks.Logical.OnOffController\">Modelica.Blocks.Logical.OnOffController</a></td><td>计算/接口量 coldChargeInhibit；true below 273.15 K; false above 278.15 K</td></tr><tr><td><code>chargePermission</code></td><td><a href=\"modelica://Modelica.Blocks.Logical.Not\">Modelica.Blocks.Logical.Not</a></td><td>计算/接口量 chargePermission</td></tr><tr><td><code>chargeSOCReference</code></td><td><a href=\"modelica://Modelica.Blocks.Sources.Constant\">Modelica.Blocks.Sources.Constant</a></td><td>计算/接口量 chargeSOCReference；Midpoint of 0.92/0.96 SOC charge hysteresis</td></tr><tr><td><code>socChargePermission</code></td><td><a href=\"modelica://Modelica.Blocks.Logical.OnOffController\">Modelica.Blocks.Logical.OnOffController</a></td><td>计算/接口量 socChargePermission；true below SOC 0.92; false above SOC 0.96</td></tr><tr><td><code>overallChargePermission</code></td><td><a href=\"modelica://Modelica.Blocks.Logical.And\">Modelica.Blocks.Logical.And</a></td><td>计算/接口量 overallChargePermission；Charging requires both temperature and SOC permission</td></tr><tr><td><code>batteryPathConductance</code></td><td><a href=\"modelica://Modelica.Blocks.Sources.Constant\">Modelica.Blocks.Sources.Constant</a></td><td>电池PathConductance；Continuous average battery path; charge protection acts by MPPT surplus curtailment without topology switching</td></tr><tr><td><code>batteryHeaterCalculation[2]</code></td><td><a href=\"modelica://OneSatSim.Foundation.Calculations.HeaterChannelCalculation\">OneSatSim.Foundation.Calculations.HeaterChannelCalculation</a></td><td>单路加热器指令与平均电导计算实例</td></tr><tr><td><code>batteryHeaterCurrent[2]</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Sensors.CurrentSensor\">Modelica.Electrical.Analog.Sensors.CurrentSensor</a></td><td>电池Heater电流</td></tr><tr><td><code>batteryHeater[2]</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.VariableConductor\">Modelica.Electrical.Analog.Basic.VariableConductor</a></td><td>电池Heater</td></tr><tr><td><code>cellThermalMass</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a></td><td>任务级参数 battery thermistor 31 initial work point</td></tr><tr><td><code>enclosureThermalMass</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a></td><td>任务级参数 battery thermistor 32 initial work point</td></tr><tr><td><code>internalPath</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">Modelica.Thermal.HeatTransfer.Components.ThermalConductor</a></td><td>计算/接口量 internalPath</td></tr><tr><td><code>mountPath</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">Modelica.Thermal.HeatTransfer.Components.ThermalConductor</a></td><td>任务级参数: insulated battery tray while retaining finite conductive rejection</td></tr><tr><td><code>thermistor31</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor\">Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor</a></td><td>计算/接口量 thermistor31</td></tr><tr><td><code>thermistor32</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor\">Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor</a></td><td>计算/接口量 thermistor32</td></tr><tr><td><code>housing</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">Modelica.Mechanics.MultiBody.Parts.Body</a></td><td>计算/接口量 housing</td></tr></table></html>"
),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={77,126,172}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Power unit", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-57,-32},{53,35}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Rectangle(extent={{-48,-20},{-30,3}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{-42,3},{-36,6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-43,-4},{-35,-4}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-39,-8},{-39,0}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{-23,-20},{-5,3}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{-17,3},{-11,6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-18,-4},{-10,-4}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-14,-8},{-14,0}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{2,-20},{20,3}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{8,3},{14,6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{7,-4},{15,-4}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{11,-8},{11,0}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{27,-20},{45,3}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{33,3},{39,6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{32,-4},{40,-4}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{36,-8},{36,0}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-48,-23},{45,-23}}, color={77,126,172}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{-48,9},{-30,32}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{-42,32},{-36,35}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-43,25},{-35,25}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-39,21},{-39,29}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{-23,9},{-5,32}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{-17,32},{-11,35}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-18,25},{-10,25}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-14,21},{-14,29}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{2,9},{20,32}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{8,32},{14,35}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{7,25},{15,25}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{11,21},{11,29}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{27,9},{45,32}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{33,32},{39,35}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{32,25},{40,25}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{36,21},{36,29}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-48,6},{45,6}}, color={77,126,172}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-62,19},{-72,19},{-72,-19},{-62,-19}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{56,19},{68,19}}, color={77,126,172}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{56,-18},{68,-18}}, color={77,126,172}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{61,26},{68,26}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{64,23},{64,29}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-46,-42},{-36,-42},{-32,-36},{-24,-47},{-16,-36},{-8,-47},{0,-36},{8,-42},{21,-42}}, color={196,94,56}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Battery Pack 4S2P", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-524,-407},{609,497}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-420,409},{-252,427}}, textString="Battery current path", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-415,116},{-297.4,134}}, textString="BMS permission", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-205,-181},{97.4,-163}}, textString="Heaters and two-node thermal network", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-512,452},{597,481}}, textString="Battery: storage, BMS and thermal control", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-512,444},{597,444}}, color={215,220,226}, thickness=0.25)
    }));
end BatteryUnit;