within OneSatSim.Components;
model XBandTransmitterUnit "X波段数传发射机组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.XbandComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance powerAmplifierResistance=config.PowerAmplifierResistance
    "功率放大器等效负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.Resistance outputMatchResistance=config.OutputMatchResistance
    "输出匹配串联损耗；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity paHeatCapacity=config.PAHeatCapacity
    "功放等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance radiatorConductance=config.RadiatorConductance
    "功放散热导热；Excel单位W/K，当前设计基线";
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
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}}),iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Basic.Conductor unused5Rail(G=0) annotation(Placement(transformation(extent={{42,76},{54,88}})));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0) annotation(Placement(transformation(extent={{66,76},{78,88}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  parameter Real nominalPayloadDataRate(unit="1/s")=config.NominalDataRate
    "任务级50 Mbps载荷下传速率；数值单位：byte/s";
  parameter Real highPerformancePayloadDataRate(unit="1/s")=config.HighPerformanceDataRate
    "可选150 Mbps高性能配置；数值单位：byte/s";
  parameter Boolean useHighPerformanceDataRate=config.UseHighPerformanceDataRate;
  final parameter Real payloadDataRate(unit="1/s")=if useHighPerformanceDataRate then highPerformancePayloadDataRate else nominalPayloadDataRate
    "当前载荷下传速率；数值单位：byte/s";
  Foundation.Interfaces.BooleanSignalReader communicationPowerCommandFromInformation
    annotation(Placement(transformation(extent={{-96,70},{-78,82}})));
  Foundation.Interfaces.BooleanSignalReader transmitCommandFromInformation
    annotation(Placement(transformation(extent={{-96,56},{-78,68}})));
  Foundation.Interfaces.BooleanSignalReader dataAvailableFromInformation
    annotation(Placement(transformation(extent={{-96,42},{-78,54}})));
  Foundation.Calculations.XBandTransmissionCalculation transmissionLogic(payloadDataRate=payloadDataRate)
    annotation(Placement(transformation(extent={{-58,64},{-34,86}})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch transmitEnable annotation(Placement(transformation(extent={{-75,38},{-55,58}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor paCurrent annotation(Placement(transformation(extent={{-45,38},{-25,58}})));
  Modelica.Electrical.Analog.Basic.Resistor powerAmplifier(R=powerAmplifierResistance,useHeatPort=true) annotation(Placement(transformation(extent={{-15,38},{5,58}})));
  Modelica.Electrical.Analog.Basic.Resistor outputMatch(R=outputMatchResistance) annotation(Placement(transformation(extent={{15,38},{35,58}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor paNode(C=paHeatCapacity,T(start=276.81,fixed=false)) annotation(Placement(transformation(extent={{-20,-42},{0,-22}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor radiatorPath(G=radiatorConductance) annotation(Placement(transformation(extent={{20,-40},{40,-24}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor transmitterTemperature annotation(Placement(transformation(extent={{50,-55},{70,-35}})));
  Modelica.Mechanics.MultiBody.Parts.Body transmitterBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-82,2},{-62,22}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[3] annotation(Placement(transformation(extent={{78,20},{86,28}})));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[1] annotation(Placement(transformation(extent={{78,0},{86,8}})));
equation
  connect(power.p5,unused5Rail.p) annotation(Line(points={{0,100},{0,94},{42,94},{42,82}},color={0,0,255}));
  connect(unused5Rail.n,power.n5) annotation(Line(points={{54,82},{54,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,82}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{78,82},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(information.command.communicationPowerCommand,communicationPowerCommandFromInformation.u) annotation(Line(points={{100,0},{100,29.5},{-76.5,29.5},{-76.5,76},{-96,76}},color={255,0,255}));
  connect(information.command.transmitCommand,transmitCommandFromInformation.u) annotation(Line(points={{100,0},{94,0},{94,62},{-96,62}},color={255,0,255}));
  connect(information.payload.dataAvailable,dataAvailableFromInformation.u) annotation(Line(points={{100,0},{100,29.5},{-96,29.5},{-96,48}},color={255,0,255}));
  connect(communicationPowerCommandFromInformation.y,transmissionLogic.communicationPowerCommand) annotation(Line(points={{-78,76},{-68,76},{-68,74},{-58,74},{-58,82}},color={255,0,255}));
  connect(transmitCommandFromInformation.y,transmissionLogic.transmitCommand) annotation(Line(points={{-78,62},{-69,62},{-69,67},{-58,67},{-58,75}},color={255,0,255}));
  connect(dataAvailableFromInformation.y,transmissionLogic.dataAvailable) annotation(Line(points={{-78,48},{-76.5,48},{-76.5,68},{-58,68}},color={255,0,255}));
  connect(transmissionLogic.supplyEnabled,transmitEnable.control) annotation(Line(points={{-33.2,82.15},{-25,82.15},{-25,64},{-65,64},{-65,60}},color={255,0,255}));
  connect(power.p12,transmitEnable.p) annotation(Line(points={{0,100},{0,94},{-75,94},{-75,48}},color={0,0,255}));
  connect(transmitEnable.n,paCurrent.p) annotation(Line(points={{-55,48},{-45,48}},color={0,0,255}));
  connect(paCurrent.n,powerAmplifier.p) annotation(Line(points={{-25,48},{-15,48}},color={0,0,255}));
  connect(powerAmplifier.n,outputMatch.p) annotation(Line(points={{5,48},{15,48}},color={0,0,255}));
  connect(outputMatch.n,power.n12) annotation(Line(points={{35,48},{35,94},{0,94},{0,100}},color={0,0,255}));
  connect(paCurrent.i,informationRealBridge[1].u) annotation(Line(points={{-35,38},{78,38},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.pdCurrent[3]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(transmissionLogic.payloadReadRate,informationRealBridge[2].u) annotation(Line(points={{-33.2,75},{78,75},{78,24}},color={0,90,180}));
  connect(informationRealBridge[2].y,information.payload.downlinkReadRate) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,90,180}));
  connect(transmissionLogic.transmitterStatus,informationIntegerBridge[1].u) annotation(Line(points={{-33.2,67.85},{78,67.85},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[1].y,information.device.transmitterStatus) annotation(Line(points={{86,4},{94,4},{94,0},{100,0}},color={255,127,0}));
  connect(powerAmplifier.heatPort,paNode.port) annotation(Line(points={{-5,38},{-5,-22},{-10,-22}},color={191,0,0}));
  connect(paNode.port,radiatorPath.port_a) annotation(Line(points={{-10,-42},{-10,-32},{20,-32}},color={191,0,0}));
  connect(paNode.port,transmitterTemperature.port) annotation(Line(points={{-10,-42},{42,-42},{42,-45},{50,-45}},color={191,0,0}));
  connect(transmitterTemperature.T,informationRealBridge[3].u) annotation(Line(points={{70,-45},{78,-45},{78,24}},color={0,0,127}));
  connect(informationRealBridge[3].y,information.device.transmitterTemperature) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(radiatorPath.port_b,thermal) annotation(Line(points={{40,-32},{40,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(transmitterBody.frame_a,mechanical) annotation(Line(points={{-82,12},{-94,12},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={15,85,150},fillColor={225,239,250},fillPattern=FillPattern.Solid),Polygon(points={{-65,38},{35,38},{72,0},{35,-38},{-65,-38},{-65,38}},fillColor={90,155,205},fillPattern=FillPattern.Solid),Line(points={{55,45},{80,65}},color={15,85,150},thickness=2),Line(points={{55,-45},{80,-65}},color={15,85,150},thickness=2),Text(extent={{-92,-74},{92,-52}},textString="X-BAND TM / PD3")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Text(extent={{-92,96},{92,86}},textString="信息字段 -> 显式转发 -> 发射门控 -> 电/热/数据响应")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>在地面站数传任务中读取载荷缓存并表示功率放大链路的电热状态。</p><h4>白箱信号路径</h4><p>communicationPowerCommand、transmitCommand和dataAvailable分别经过BooleanSignalReader进入XBandTransmissionCalculation；计算结果驱动供电开关、载荷读出率和发射机状态。PA电流与温度由标准传感器测得后进入统一信息接口。</p><h4>物理实现与边界</h4><p>理想供电开关、PA阻性负载、输出匹配损耗、电流传感、PA热容、散热导热和刚体组成设备级白箱。射频编码、调制和链路预算未在本组件展开。</p><h4>使用说明</h4><p>打开Diagram可沿“接口字段—Forward—Calculation—开关/数据输出—Sensor—Information”追踪完整因果链。</p><h4>接口与信息路径</h4><p>information同时接收通信上电、实际发射和缓存可读状态，并发布PA电流、发射机状态、载荷读出率和温度；power连接12 V功放支路，thermal连接PA散热节点，mechanical表示发射机安装质量。三项共享布尔量经BooleanSignalReader后进入XBandTransmissionCalculation。</p><h4>工作条件与能量路径</h4><p>通信上电命令决定供电使能；只有transmitCommand与dataAvailable同时有效时才从PayloadDataPort按6.25 MB/s标称速率读出。IdealClosingSwitch、电流传感器、PA等效电阻和输出匹配损耗形成直流功耗，全部损耗汇入paNode并经radiatorPath散热。</p><h4>结果查看与使用</h4><p>优先查看transmissionLogic.supplyEnabled、payloadReadRate、transmitterStatus、paCurrent.i和transmitterTemperature.T，并结合地面站机会、存储量与任务状态机判断发射事件。Real X-band Transmit计数应依据实际门控而非仅依据请求数。</p><h4>建模边界</h4><p>模型不展开编码、调制、射频增益、EIRP、天线方向图、链路余量、RSSI/SNR和协议字节；数据率为平均业务速率，适用于24 h存储闭合、电源和热分析。</p></html>"));
end XBandTransmitterUnit;
