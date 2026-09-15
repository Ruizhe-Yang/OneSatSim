within OneSatSim.Components;
model EarthObservationCameraUnit "对地观测相机组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.EarthCameraComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance focalElectronicsResistance=config.FocalElectronicsResistance
    "焦面电子学负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.Resistance focalHeaterResistance=config.FocalHeaterResistance
    "焦面加热器电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity opticalBenchHeatCapacity=config.OpticalBenchHeatCapacity
    "光机结构热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity focalBoxHeatCapacity=config.FocalBoxHeatCapacity
    "焦面盒热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance opticalMountConductance=config.OpticalMountConductance
    "光机结构安装导热；Excel单位W/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance focalCouplingConductance=config.FocalCouplingConductance
    "焦面-光机耦合导热；Excel单位W/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance focalMountConductance=config.FocalMountConductance
    "焦面盒安装导热；Excel单位W/K，当前设计基线";
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
  parameter Modelica.Units.SI.Temperature initialOpticalBenchTemperature=304.35 "场景光机结构初温";
  parameter Modelica.Units.SI.Temperature initialFocalBoxTemperature=304.69 "场景焦面盒初温";
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}}),iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Basic.Conductor unused5Rail(G=0) annotation(Placement(transformation(extent={{54,76},{66,88}})));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0) annotation(Placement(transformation(extent={{78,76},{90,88}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  parameter Real rawImageSize(unit="1")=config.RawImageSize
    "星上压缩前的原始景数据量；数值单位：byte";
  parameter Real storedImageSize(unit="1")=config.StoredImageSize
    "最终存储的单景数据量；数值单位：byte，不重复保存原始副本";
  parameter Real nominalCaptureDuration(unit="s")=config.CaptureDuration;
  final parameter Real imagingDataRate(unit="1/s")=storedImageSize/nominalCaptureDuration
    "任务级参数：10 s内存储100 MB；数值单位：byte/s";
  Foundation.Interfaces.BooleanSignalReader imagingCommand annotation(Placement(transformation(extent={{-96,68},{-76,84}})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch exposureSwitch annotation(Placement(transformation(extent={{-78,40},{-58,60}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor cameraCurrent annotation(Placement(transformation(extent={{-48,40},{-28,60}})));
  Modelica.Electrical.Analog.Basic.Resistor focalElectronics(R=focalElectronicsResistance,useHeatPort=true) annotation(Placement(transformation(extent={{-18,40},{2,60}})));
  Modelica.Electrical.Analog.Basic.Conductor pulseBuffer(G=0) annotation(Placement(transformation(origin={20,20},extent={{-8,-8},{8,8}},rotation=270)));
  Foundation.Interfaces.BooleanSignalReader captureCommand annotation(Placement(transformation(extent={{20,66},{38,80}})));
  Foundation.Interfaces.IntegerSignalReader focalHeaterState
    "Focal-box heater ON below 0 degC and OFF above 5 degC" annotation(Placement(transformation(extent={{19,42},{37,58}})));
  Foundation.Calculations.EarthObservationCameraCalculation cameraCalculation(
    imagingDataRate=imagingDataRate,focalHeaterResistance=focalHeaterResistance)
    "About 4 W at the 12 V bus" annotation(Placement(transformation(extent={{44,18},{72,58}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor focalHeaterCurrent annotation(Placement(transformation(extent={{-28,76},{-8,96}})));
  Modelica.Electrical.Analog.Basic.VariableConductor focalHeater(useHeatPort=true) annotation(Placement(transformation(extent={{0,76},{20,96}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor opticalBench(
    C=opticalBenchHeatCapacity,T(start=initialOpticalBenchTemperature,fixed=false))
    "系统级等效: telescope barrel, secondary mirror and load-bearing structure"
    annotation(Placement(transformation(extent={{-35,-25},{-15,-5}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor focalBox(C=focalBoxHeatCapacity,T(start=initialFocalBoxTemperature,fixed=true)) "任务级参数 focal electronics initial work point" annotation(Placement(transformation(extent={{65,-25},{85,-5}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor opticalMount(G=opticalMountConductance)
    "Equivalent series conductance from optical structure to spacecraft deck"
    annotation(Placement(transformation(extent={{-35,-48},{-15,-32}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor focalCoupling(G=focalCouplingConductance)
    "Low-order focal-box to optical-bench coupling"
    annotation(Placement(transformation(extent={{20,-48},{40,-32}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor focalMount(G=focalMountConductance) "系统级 focal electronics isolation path" annotation(Placement(transformation(extent={{65,-62},{85,-48}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor t20 annotation(Placement(transformation(extent={{-85,-75},{-75,-65}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor t21 annotation(Placement(transformation(extent={{-70,-75},{-60,-65}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor t22 annotation(Placement(transformation(extent={{-55,-75},{-45,-65}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor t23 annotation(Placement(transformation(extent={{-40,-75},{-30,-65}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor t24 annotation(Placement(transformation(extent={{-25,-75},{-15,-65}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor t25 annotation(Placement(transformation(extent={{-10,-75},{0,-65}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor t26 annotation(Placement(transformation(extent={{5,-75},{15,-65}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor t27 annotation(Placement(transformation(extent={{20,-75},{30,-65}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor t28 annotation(Placement(transformation(extent={{35,-75},{45,-65}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor t29 annotation(Placement(transformation(extent={{50,-75},{60,-65}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor t30 annotation(Placement(transformation(extent={{65,-75},{75,-65}})));
  Modelica.Mechanics.MultiBody.Parts.Body telescopeBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-82,2},{-62,22}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[14] annotation(Placement(transformation(extent={{78,20},{86,28}})));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[1] annotation(Placement(transformation(extent={{78,0},{86,8}})));
equation
  connect(information.command.payloadPowerCommand,imagingCommand.u) annotation(Line(points={{100,0},{100,61.5},{-96,61.5},{-96,76}},color={255,0,255}));
  connect(information.command.earthObservationCaptureCommand,captureCommand.u) annotation(Line(points={{100,0},{94,0},{94,73},{20,73}},color={255,0,255}));
  connect(information.device.tcState[12],focalHeaterState.u) annotation(Line(points={{100,0},{100,9.5},{29.5,9.5},{29.5,50},{19,50}},color={255,127,0}));
  connect(imagingCommand.y,cameraCalculation.payloadPowered) annotation(Line(points={{-76,76},{-76,61.5},{44,61.5},{44,53}},color={255,0,255}));
  connect(captureCommand.y,cameraCalculation.captureCommand) annotation(Line(points={{38,73},{42,73},{42,45},{44,45}},color={255,0,255}));
  connect(focalHeaterState.y,cameraCalculation.focalHeaterState) annotation(Line(points={{37,50},{40,50},{40,29},{44,29}},color={255,127,0}));
  connect(power.p5,unused5Rail.p) annotation(Line(points={{0,100},{54,100},{54,82}},color={0,0,255}));
  connect(unused5Rail.n,power.n5) annotation(Line(points={{66,82},{66,100},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{78,100},{78,82}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{90,82},{90,100},{0,100}},color={0,0,255}));
  connect(imagingCommand.y,exposureSwitch.control) annotation(Line(points={{-76,76},{-68,76},{-68,62}},color={255,0,255}));
  connect(power.p12,exposureSwitch.p) annotation(Line(points={{0,100},{-49.5,100},{-49.5,50},{-78,50}},color={0,0,255}));
  connect(exposureSwitch.n,cameraCurrent.p) annotation(Line(points={{-58,50},{-48,50}},color={0,0,255}));
  connect(cameraCurrent.n,focalElectronics.p) annotation(Line(points={{-28,50},{-18,50}},color={0,0,255}));
  connect(focalElectronics.n,power.n12) annotation(Line(points={{2,50},{-1.5,50},{-1.5,100},{0,100}},color={0,0,255}));
  connect(pulseBuffer.p,power.p12) annotation(Line(points={{20,28},{3.5,28},{3.5,74.5},{-1.5,74.5},{-1.5,100},{0,100}},color={0,0,255}));
  connect(pulseBuffer.n,power.n12) annotation(Line(points={{20,12},{3.5,12},{3.5,74.5},{-1.5,74.5},{-1.5,100},{0,100}},color={0,0,255}));
  connect(cameraCurrent.i,informationRealBridge[1].u) annotation(Line(points={{-38,40},{-38,10.5},{78,10.5},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.pdCurrent[17]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(cameraCalculation.status,informationIntegerBridge[1].u) annotation(Line(points={{70.6,49},{78,49},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[1].y,information.device.cameraStatus) annotation(Line(points={{86,4},{94,4},{94,0},{100,0}},color={255,127,0}));
  connect(cameraCalculation.payloadWriteRate,informationRealBridge[2].u) annotation(Line(points={{70.6,41},{78,41},{78,24}},color={0,90,180}));
  connect(informationRealBridge[2].y,information.payload.earthCameraWriteRate) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,90,180}));
  connect(power.p12,focalHeaterCurrent.p) annotation(Line(points={{0,100},{0,94},{-28,94},{-28,86}},color={0,0,255}));
  connect(focalHeaterCurrent.n,focalHeater.p) annotation(Line(points={{-8,86},{0,86}},color={0,0,255}));
  connect(focalHeater.n,power.n12) annotation(Line(points={{20,86},{20,94},{0,94},{0,100}},color={0,0,255}));
  connect(cameraCalculation.focalHeaterConductance,focalHeater.G) annotation(Line(points={{70.6,29},{76,29},{76,110},{10,110},{10,98}},color={0,0,127}));
  connect(focalHeaterCurrent.i,informationRealBridge[3].u) annotation(Line(points={{-18,76},{-18,61.5},{78,61.5},{78,24}},color={0,0,127}));
  connect(informationRealBridge[3].y,information.device.tcCurrent[12]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(focalHeater.heatPort,focalBox.port) annotation(Line(points={{10,76},{10,-5},{75,-5}},color={191,0,0}));
  connect(focalElectronics.heatPort,focalBox.port) annotation(Line(points={{-8,40},{-8,-5},{75,-5}},color={191,0,0}));
  connect(opticalBench.port,opticalMount.port_a) annotation(Line(points={{-25,-25},{-25,-40},{-35,-40}},color={191,0,0}));
  connect(opticalMount.port_b,thermal) annotation(Line(points={{-15,-40},{-15,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(opticalBench.port,focalCoupling.port_a) annotation(Line(points={{-25,-25},{20,-25},{20,-40}},color={191,0,0}));
  connect(focalCoupling.port_b,focalBox.port) annotation(Line(points={{40,-40},{75,-40},{75,-25}},color={191,0,0}));
  connect(focalBox.port,focalMount.port_a) annotation(Line(points={{75,-25},{58,-25},{58,-55},{65,-55}},color={191,0,0}));
  connect(focalMount.port_b,thermal) annotation(Line(points={{85,-55},{85,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(opticalBench.port,t20.port) annotation(Line(points={{-25,-25},{-80,-25},{-80,-70},{-85,-70}},color={191,0,0}));
  connect(opticalBench.port,t21.port) annotation(Line(points={{-25,-25},{-65,-25},{-65,-70},{-70,-70}},color={191,0,0}));
  connect(opticalBench.port,t22.port) annotation(Line(points={{-25,-25},{-50,-25},{-50,-70},{-55,-70}},color={191,0,0}));
  connect(opticalBench.port,t23.port) annotation(Line(points={{-25,-25},{-35,-25},{-35,-70},{-40,-70}},color={191,0,0}));
  connect(opticalBench.port,t24.port) annotation(Line(points={{-25,-25},{-13.5,-25},{-13.5,-70},{-25,-70}},color={191,0,0}));
  connect(opticalBench.port,t25.port) annotation(Line(points={{-25,-25},{-5,-25},{-5,-70},{-10,-70}},color={191,0,0}));
  connect(opticalBench.port,t26.port) annotation(Line(points={{-25,-25},{10,-25},{10,-70},{5,-70}},color={191,0,0}));
  connect(opticalBench.port,t27.port) annotation(Line(points={{-25,-25},{18.5,-25},{18.5,-70},{20,-70}},color={191,0,0}));
  connect(opticalBench.port,t28.port) annotation(Line(points={{-25,-25},{40,-25},{40,-70},{35,-70}},color={191,0,0}));
  connect(opticalBench.port,t29.port) annotation(Line(points={{-25,-25},{55,-25},{55,-70},{50,-70}},color={191,0,0}));
  connect(focalBox.port,t30.port) annotation(Line(points={{75,-25},{63.5,-25},{63.5,-70},{65,-70}},color={191,0,0}));
  connect(t20.T,informationRealBridge[4].u) annotation(Line(points={{-75,-70},{-75,0.5},{76.5,0.5},{76.5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[4].y,information.device.thermistorTemperature[20]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(t21.T,informationRealBridge[5].u) annotation(Line(points={{-60,-70},{-60,10.5},{78,10.5},{78,24}},color={0,0,127}));
  connect(informationRealBridge[5].y,information.device.thermistorTemperature[21]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(t22.T,informationRealBridge[6].u) annotation(Line(points={{-45,-70},{-45,10.5},{78,10.5},{78,24}},color={0,0,127}));
  connect(informationRealBridge[6].y,information.device.thermistorTemperature[22]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(t23.T,informationRealBridge[7].u) annotation(Line(points={{-30,-70},{-30,-49.5},{63.5,-49.5},{63.5,16.5},{78,16.5},{78,24}},color={0,0,127}));
  connect(informationRealBridge[7].y,information.device.thermistorTemperature[23]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(t24.T,informationRealBridge[8].u) annotation(Line(points={{-15,-70},{-11.5,-70},{-11.5,10.5},{78,10.5},{78,24}},color={0,0,127}));
  connect(informationRealBridge[8].y,information.device.thermistorTemperature[24]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(t25.T,informationRealBridge[9].u) annotation(Line(points={{0,-70},{0,10.5},{78,10.5},{78,24}},color={0,0,127}));
  connect(informationRealBridge[9].y,information.device.thermistorTemperature[25]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(t26.T,informationRealBridge[10].u) annotation(Line(points={{15,-70},{15,10.5},{78,10.5},{78,24}},color={0,0,127}));
  connect(informationRealBridge[10].y,information.device.thermistorTemperature[26]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(t27.T,informationRealBridge[11].u) annotation(Line(points={{30,-70},{30,-49.5},{63.5,-49.5},{63.5,16.5},{78,16.5},{78,24}},color={0,0,127}));
  connect(informationRealBridge[11].y,information.device.thermistorTemperature[27]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(t28.T,informationRealBridge[12].u) annotation(Line(points={{45,-70},{45,16.5},{78,16.5},{78,24}},color={0,0,127}));
  connect(informationRealBridge[12].y,information.device.thermistorTemperature[28]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(t29.T,informationRealBridge[13].u) annotation(Line(points={{60,-70},{60,16.5},{78,16.5},{78,24}},color={0,0,127}));
  connect(informationRealBridge[13].y,information.device.thermistorTemperature[29]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(t30.T,informationRealBridge[14].u) annotation(Line(points={{75,-70},{87.5,-70},{87.5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[14].y,information.device.thermistorTemperature[30]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(telescopeBody.frame_a,mechanical) annotation(Line(points={{-82,12},{-94,12},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={60,75,105},fillColor={238,241,247},fillPattern=FillPattern.Solid),Polygon(points={{-70,45},{45,45},{75,0},{45,-45},{-70,-45},{-70,45}},fillColor={155,170,195},fillPattern=FillPattern.Solid),Ellipse(extent={{-45,30},{15,-30}},fillColor={30,40,65},fillPattern=FillPattern.Solid),Text(extent={{-92,-74},{92,-52}},textString="CAM / PD17 / T20-30")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Rectangle(extent={{-92,0},{92,-82}},lineColor={190,0,0},pattern=LinePattern.Dash),Text(extent={{-88,8},{88,-2}},textString="光机结构/焦面盒 两节点热等效")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>执行优先级任务中的成像动作，产生图像写入率并表示光机电热耦合</p><p><b>建模层级：</b>Components层设备级白箱；主要由Modelica 4.0.0标准库元件和图形连线组成</p><h4>实现与接口</h4><p><b>白箱实现：</b>用指令控制理想开关驱动焦面电子学负载；相机热模型降阶为光机结构与焦面盒两个物理节点，并保留原11路工程温度通道。</p><p><b>关键内部元件：</b>exposureSwitch、cameraCurrent、focalElectronics、opticalBench、focalBox、opticalMount、focalCoupling和11个TemperatureSensor。</p><p><b>对外接口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、information（InformationPort）</p><h4>工作行为与状态</h4><p><b>运行行为：</b>imaging指令有效时相机上电、状态置位并按imagingDataRate写入存储；焦面电子学损耗进入焦面盒，再与光机结构和公共舱板交换热量。</p><p><b>关键参数：</b>成像数据率、焦面负载、光机结构热容与导热、焦面盒热容与隔热。</p><p><b>关键状态：</b>开关状态、光机结构温度、焦面盒温度和设备状态。</p><p><b>物理域：</b>光机、电、热、机械、信息、业务数据</p><h4>信息与遥测关系</h4><p><b>数据路径：</b>相机状态进入Camera_status；T20至T29映射光机结构代表温度，T30映射焦面盒温度；图像速率进入PayloadDataPort而非直接作为工程遥测字段。</p><p><b>使用说明：</b>多个同温遥测通道表示安装在同一等效结构节点的物理传感器，不是额外热状态。设备测量与机器反馈均写入同一个InformationPort.device语义域。</p><p><b>系统级等效：</b>五节点相机热网络合并为两个守恒热容节点，保留总热容、焦面电子学热源、对公共舱板的热路径和原遥测通道，降低24 h任务仿真的热状态数。</p></html>"));
end EarthObservationCameraUnit;
