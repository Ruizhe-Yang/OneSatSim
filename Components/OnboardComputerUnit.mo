within OneSatSim.Components;
model OnboardComputerUnit "星务计算机与遥测处理组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.ObcComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance processorLoadResistance=config.ProcessorLoadResistance
    "OBC处理器等效负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity cpuHeatCapacity=config.CPUHeatCapacity
    "CPU等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity boardHeatCapacity=config.BoardHeatCapacity
    "OBC板等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance cpuBoardConductance=config.CPUBoardConductance
    "CPU-板导热；Excel单位W/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance boardMountConductance=config.BoardMountConductance
    "OBC安装导热；Excel单位W/K，当前设计基线";
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
  parameter Boolean operationalSnapshotStart=true
    "场景是否从在轨运行快照启动";
  parameter Modelica.Units.SI.Temperature initialCpuTemperature=296.15 "场景CPU初温";
  parameter Modelica.Units.SI.Temperature initialBoardTemperature=294.15 "场景板卡初温";
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}}),iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Basic.Conductor unused12Rail(G=0) annotation(Placement(transformation(extent={{42,76},{54,88}})));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0) annotation(Placement(transformation(extent={{66,76},{78,88}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.EnvironmentPort environment annotation(Placement(transformation(extent={{-110,-62},{-90,-42}}),iconTransformation(extent={{-110,-62},{-90,-42}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,15},{110,35}}),iconTransformation(extent={{90,15},{110,35}})));
  Foundation.Interfaces.ActiveMissionSelectionOutput activeMissionSelection annotation(Placement(transformation(extent={{90,-35},{110,-15}}),iconTransformation(extent={{90,-35},{110,-15}})));
  OneSatSim.Components.MissionControlUnit missionControl(
    operationalSnapshotStart=operationalSnapshotStart) annotation(Placement(transformation(extent={{-88,22},{-44,58}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation(Placement(transformation(extent={{-72,-4},{-52,16}})));
  Modelica.Electrical.Analog.Basic.Resistor cpuLoad(R=processorLoadResistance,useHeatPort=true) "系统级 nominal OBC 5 V work point" annotation(Placement(transformation(extent={{-40,-4},{-20,16}})));
  Modelica.Electrical.Analog.Basic.Conductor localDecoupling(G=0) annotation(Placement(transformation(origin={-5,-18},extent={{-8,-8},{8,8}},rotation=270)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cpuNode(C=cpuHeatCapacity,T(start=initialCpuTemperature,fixed=false)) annotation(Placement(transformation(extent={{-35,-55},{-15,-35}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor boardNode(C=boardHeatCapacity,T(start=initialBoardTemperature,fixed=false)) annotation(Placement(transformation(extent={{5,-55},{25,-35}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor cpuBoard(G=cpuBoardConductance) annotation(Placement(transformation(extent={{14,-28},{34,-14}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor boardMount(G=boardMountConductance) annotation(Placement(transformation(extent={{35,-52},{55,-38}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor cpuTemperature annotation(Placement(transformation(extent={{-35,-80},{-15,-60}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor boardTemperature annotation(Placement(transformation(extent={{5,-80},{25,-60}})));
  Modelica.Blocks.Sources.IntegerConstant noCommandError(k=0) annotation(Placement(transformation(extent={{55,-82},{75,-62}})));
  Modelica.Blocks.Sources.IntegerConstant watchdog(k=0) annotation(Placement(transformation(extent={{55,-58},{75,-38}})));
  Modelica.Mechanics.MultiBody.Parts.Body obcBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-82,-42},{-62,-22}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[2] annotation(Placement(transformation(extent={{78,20},{86,28}})));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[2] annotation(Placement(transformation(extent={{78,0},{86,8}})));
equation
  connect(power.p12,unused12Rail.p) annotation(Line(points={{0,100},{0,94},{42,94},{42,82}},color={0,0,255}));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{54,82},{54,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,82}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{78,82},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(environment,missionControl.environment) annotation(Line(points={{-100,-52},{-88,-52},{-88,51.7}},color={0,110,70}));
  connect(information.device,missionControl.device) annotation(Line(points={{100,25},{94,25},{94,43.6},{-88,43.6}},color={20,100,155},thickness=0.5));
  connect(information.payload,missionControl.payload) annotation(Line(points={{100,25},{94,25},{94,35.5},{-88,35.5}},color={120,90,35},thickness=0.5));
  connect(missionControl.command,information.command) annotation(Line(points={{-44,48.1},{94,48.1},{94,25},{100,25}},color={120,70,150},thickness=0.5));
  connect(missionControl.status,information.commandStatus) annotation(Line(points={{-44,31.9},{94,31.9},{94,25},{100,25}},color={155,85,20},thickness=0.5));
  connect(missionControl.activeMissionSelection,activeMissionSelection) annotation(Line(points={{-44,39},{88.5,39},{88.5,-25},{100,-25}},color={75,105,145},thickness=0.5));
  connect(power.p5,currentSensor.p) annotation(Line(points={{0,100},{0,17.5},{-72,17.5},{-72,6}},color={0,0,255}));
  connect(currentSensor.n,cpuLoad.p) annotation(Line(points={{-52,6},{-40,6}},color={0,0,255}));
  connect(cpuLoad.n,power.n5) annotation(Line(points={{-20,6},{-20,94},{0,94},{0,100}},color={0,0,255}));
  connect(localDecoupling.p,power.p5) annotation(Line(points={{-5,-10},{-5,94},{0,94},{0,100}},color={0,0,255}));
  connect(localDecoupling.n,power.n5) annotation(Line(points={{-5,-26},{-5,94},{0,94},{0,100}},color={0,0,255}));
  connect(cpuLoad.heatPort,cpuNode.port) annotation(Line(points={{-30,-4},{-30,-35},{-25,-35}},color={191,0,0}));
  connect(cpuNode.port,cpuBoard.port_a) annotation(Line(points={{-25,-55},{-25,-27.5},{14,-27.5},{14,-21}},color={191,0,0}));
  connect(cpuBoard.port_b,boardNode.port) annotation(Line(points={{34,-21},{15,-21},{15,-55}},color={191,0,0}));
  connect(boardNode.port,boardMount.port_a) annotation(Line(points={{15,-55},{15,-45},{35,-45}},color={191,0,0}));
  connect(boardMount.port_b,thermal) annotation(Line(points={{55,-45},{55,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(cpuNode.port,cpuTemperature.port) annotation(Line(points={{-25,-55},{-25,-70},{-35,-70}},color={191,0,0}));
  connect(boardNode.port,boardTemperature.port) annotation(Line(points={{15,-55},{15,-70},{5,-70}},color={191,0,0}));
  connect(cpuTemperature.T,informationRealBridge[1].u) annotation(Line(points={{-15,-70},{3.5,-70},{3.5,-29.5},{76.5,-29.5},{76.5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.cpuTemperature) annotation(Line(points={{86,24},{94,24},{94,25},{100,25}},color={0,0,127}));
  connect(boardTemperature.T,informationRealBridge[2].u) annotation(Line(points={{25,-70},{25,-59.5},{76.5,-59.5},{76.5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[2].y,information.device.boardTemperature) annotation(Line(points={{86,24},{94,24},{94,25},{100,25}},color={0,0,127}));
  connect(noCommandError.y,informationIntegerBridge[1].u) annotation(Line(points={{76,-72},{78,-72},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[1].y,information.device.commandErrorCount) annotation(Line(points={{86,4},{94,4},{94,25},{100,25}},color={255,127,0}));
  connect(watchdog.y,informationIntegerBridge[2].u) annotation(Line(points={{76,-48},{78,-48},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[2].y,information.device.watchdogCount) annotation(Line(points={{86,4},{94,4},{94,25},{100,25}},color={255,127,0}));
  connect(obcBody.frame_a,mechanical) annotation(Line(points={{-82,-32},{-94,-32},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={20,90,145},fillColor={226,240,250},fillPattern=FillPattern.Solid),Rectangle(extent={{-55,45},{55,-35}},lineColor={20,90,145},fillColor={155,205,235},fillPattern=FillPattern.Solid),Rectangle(extent={{-36,26},{36,-16}},fillColor={60,130,180},fillPattern=FillPattern.Solid),Text(extent={{-92,-75},{92,-52}},textString="OBC / MISSION CONTROL")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Rectangle(extent={{-82,68},{84,18}},lineColor={0,90,180},pattern=LinePattern.Dash),Text(extent={{-78,76},{74,65}},textString="任务控制与CPU电热白箱")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>承担任务时序、指令生成以及OBC自身电热状态测量。</p><p><b>建模层级：</b>Components层设备级白箱；由MissionControlUnit和Modelica 4.0.0标准库元件连接组成。</p><h4>实现与接口</h4><p><b>白箱实现：</b>MissionControlUnit直接读取统一InformationPort中的设备/载荷状态并发布命令；CPU负载、双热节点与传感器描述OBC物理工作状态。</p><p><b>关键内部元件：</b>missionControl、currentSensor、cpuLoad、cpuNode、boardNode及两个TemperatureSensor。</p><p><b>对外接口：</b>power、thermal、mechanical、environment、information。</p><h4>工作行为与状态</h4><p><b>运行行为：</b>任务核心依据轨道环境、资源和设备反馈产生模式与指令；OBC电流及CPU/板温直接写入统一设备状态总线。</p><p><b>关键状态：</b>任务模式、CPU温度、板温和OBC电流。</p><h4>信息与遥测关系</h4><p><b>数据路径：</b>所有N-System只在同一个InformationPort.device/payload网络交换状态；工程遥测由SpacecraftSystem中的EngineeringTelemetryObserver只读观察该网络后形成，不再维护并行状态数据库或遥测镜像。</p><p><b>系统级等效：</b>板级快速去耦等效为直流开路，保留稳态功率、热量、控制与遥测语义。</p></html>"
));
end OnboardComputerUnit;
