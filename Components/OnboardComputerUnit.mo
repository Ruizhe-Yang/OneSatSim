within OneSatSim.Components;
model OnboardComputerUnit "星务计算机与遥测处理组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.ObcComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter OneSatSim.Foundation.Types.ImagingCapabilities imagingCapabilities
    "成像Capabilities；Earth-camera capability passed to mission control";
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
  Foundation.Interfaces.PowerPort power  "功率" annotation(Placement(visible=true, transformation(origin={-360,230}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,95}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Conductor unused12Rail(G=0)  "计算/接口量 unused12Rail" annotation(Placement(visible=true, transformation(origin={-290,320}, extent={{-20,-20},{20,20}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0)  "计算/接口量 unused33Rail" annotation(Placement(visible=true, transformation(origin={-200,320}, extent={{-20,-20},{20,20}}, rotation=0)));
  Foundation.Interfaces.ThermalPort thermal  "热学" annotation(Placement(visible=true, transformation(origin={385,-155}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,-97}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(visible=true, transformation(origin={-360,-270}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-12,-12},{12,12}}, rotation=0)));
  Foundation.Interfaces.EnvironmentPort environment  "外部环境接口或实例" annotation(Placement(visible=true, transformation(origin={-360,75}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-12,-12},{12,12}}, rotation=0)));
  Foundation.Interfaces.InformationPort information  "计算/接口量 information" annotation(Placement(visible=true, transformation(origin={385,100}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-12,-12},{12,12}}, rotation=0)));
  Foundation.Interfaces.ActiveMissionSelectionOutput activeMissionSelection  "来自OBC的任务对象锁存索引" annotation(Placement(visible=true, transformation(origin={385,-20}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Components.MissionControlUnit missionControl(
    operationalSnapshotStart=operationalSnapshotStart,
    imagingCapabilities=imagingCapabilities)  "星务任务与指令控制组件实例" annotation(Placement(visible=true, transformation(origin={-10,60}, extent={{-80,-80},{80,80}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor cpuLoad(R=processorLoadResistance,useHeatPort=true) "系统级 nominal OBC 5 V work point" annotation(Placement(visible=true, transformation(origin={-80,245}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Conductor localDecoupling(G=0)  "计算/接口量 localDecoupling" annotation(Placement(visible=true, transformation(origin={50,245}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cpuNode(C=cpuHeatCapacity,T(start=initialCpuTemperature,fixed=false))  "计算/接口量 cpuNode" annotation(Placement(visible=true, transformation(origin={-170,-125}, extent={{-30,-30},{30,30}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor boardNode(C=boardHeatCapacity,T(start=initialBoardTemperature,fixed=false))  "计算/接口量 boardNode" annotation(Placement(visible=true, transformation(origin={85,-125}, extent={{-30,-30},{30,30}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor cpuBoard(G=cpuBoardConductance)  "计算/接口量 cpuBoard" annotation(Placement(visible=true, transformation(origin={-40,-155}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor boardMount(G=boardMountConductance)  "计算/接口量 boardMount" annotation(Placement(visible=true, transformation(origin={220,-155}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor cpuTemperature  "cpu温度" annotation(Placement(visible=true, transformation(origin={-90,-245}, extent={{-22,-22},{22,22}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor boardTemperature  "board温度" annotation(Placement(visible=true, transformation(origin={100,-245}, extent={{-22,-22},{22,22}}, rotation=0)));
  Modelica.Blocks.Sources.IntegerConstant noCommandError(k=0)  "no指令误差" annotation(Placement(visible=true, transformation(origin={100,-365}, extent={{-22,-22},{22,22}}, rotation=0)));
  Modelica.Blocks.Sources.IntegerConstant watchdog(k=0)  "计算/接口量 watchdog" annotation(Placement(visible=true, transformation(origin={-40,-365}, extent={{-22,-22},{22,22}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.Body obcBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ)  "obc本体" annotation(Placement(visible=true, transformation(origin={-260,-270}, extent={{-30,-30},{30,30}}, rotation=0)));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[2]  "实数因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={255,-265}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[2]  "整数因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={255,-390}, extent={{-16,-16},{16,16}}, rotation=0)));
equation
  connect(power.p12,unused12Rail.p) annotation(Line(points={{-360,230},{-360,320},{-310,320}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{-270,320},{-260,320},{-260,230},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{-360,230},{-260,230},{-260,320},{-220,320}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{-180,320},{-170,320},{-170,279},{-360,279},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(environment,missionControl.environment) annotation(Line(points={{-360,75},{-360,124},{-81.2,124}}, color={0,166,81}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information.device,missionControl.device) annotation(Line(points={{385,100},{385,124},{61.2,124}}, color={0,137,123}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information.payload,missionControl.payload) annotation(Line(points={{385,100},{385,98.4},{61.2,98.4}}, color={0,82,204}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(missionControl.command,information.command) annotation(Line(points={{61.2,72.8},{385,72.8},{385,100}}, color={117,0,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(missionControl.status,information.commandStatus) annotation(Line(points={{61.2,47.2},{385,47.2},{385,100}}, color={0,145,234}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(missionControl.activeMissionSelection,activeMissionSelection) annotation(Line(points={{61.2,21.6},{385,21.6},{385,-20}}, color={255,109,0}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p5,cpuLoad.p) annotation(Line(points={{-360,230},{-100,230}},color={0,0,255},thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(cpuLoad.n,power.n5) annotation(Line(points={{-56,245},{-46,245},{-46,211},{-360,211},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(localDecoupling.p,power.p5) annotation(Line(points={{26,245},{16,245},{16,211},{-360,211},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(localDecoupling.n,power.n5) annotation(Line(points={{74,245},{84,245},{84,211},{-360,211},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(cpuLoad.heatPort,cpuNode.port) annotation(Line(points={{-80,221},{-80,211},{-335,211},{-335,-165},{-170,-165},{-170,-155}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(cpuNode.port,cpuBoard.port_a) annotation(Line(points={{-170,-155},{-170,-165},{-74,-165},{-74,-155},{-64,-155}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(cpuBoard.port_b,boardNode.port) annotation(Line(points={{-16,-155},{-6,-155},{-6,-165},{85,-165},{85,-155}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(boardNode.port,boardMount.port_a) annotation(Line(points={{85,-155},{85,-165},{186,-165},{186,-155},{196,-155}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(boardMount.port_b,thermal) annotation(Line(points={{244,-155},{385,-155}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(cpuNode.port,cpuTemperature.port) annotation(Line(points={{-170,-155},{-170,-245},{-112,-245}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(boardNode.port,boardTemperature.port) annotation(Line(points={{85,-155},{85,-165},{68,-165},{68,-245},{78,-245}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(cpuTemperature.T,informationRealBridge[1].u) annotation(Line(points={{-65.8,-245},{-55.8,-245},{-55.8,-277},{207.62,-277},{207.62,-265},{240.76,-265}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[1].y,information.device.cpuTemperature) annotation(Line(points={{269.24,-265},{385,-265},{385,100}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(boardTemperature.T,informationRealBridge[2].u) annotation(Line(points={{124.2,-245},{207.62,-245},{207.62,-265},{240.76,-265}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[2].y,information.device.boardTemperature) annotation(Line(points={{269.24,-265},{385,-265},{385,100}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(noCommandError.y,informationIntegerBridge[1].u) annotation(Line(points={{100,-365},{100,-390},{240.76,-390}}, color={255,127,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationIntegerBridge[1].y,information.device.commandErrorCount) annotation(Line(points={{269.24,-390},{385,-390},{385,100}}, color={255,127,0}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(watchdog.y,informationIntegerBridge[2].u) annotation(Line(points={{-40,-365},{-40,-390},{240.76,-390}}, color={255,127,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationIntegerBridge[2].y,information.device.watchdogCount) annotation(Line(points={{269.24,-390},{385,-390},{385,100}}, color={255,127,0}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(obcBody.frame_a,mechanical) annotation(Line(points={{-290,-270},{-360,-270}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>星务计算机与遥测处理组件</h2><p><b>类路径：</b><code>OneSatSim.Components.OnboardComputerUnit</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>星务计算机与遥测处理组件</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.N_systems.DataHandlingSystem\">OneSatSim.Systems.N_systems.DataHandlingSystem</a> 的 <code>obc</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>power</code></td><td>Foundation.Interfaces.PowerPort</td><td>public</td><td>按声明/类型合同</td><td>功率</td></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr><tr><td><code>environment</code></td><td>Foundation.Interfaces.EnvironmentPort</td><td>public</td><td>按声明/类型合同</td><td>外部环境接口或实例</td></tr><tr><td><code>information</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr><tr><td><code>activeMissionSelection</code></td><td>Foundation.Interfaces.ActiveMissionSelectionOutput</td><td>public</td><td>按声明/类型合同</td><td>来自OBC的任务对象锁存索引</td></tr><tr><td><code>informationRealBridge[2]</code></td><td>Foundation.Interfaces.RealSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>实数因果输出到可扩展信息总线的无状态恒等桥实例</td></tr><tr><td><code>informationIntegerBridge[2]</code></td><td>Foundation.Interfaces.IntegerSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>整数因果输出到可扩展信息总线的无状态恒等桥实例</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>config</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.ObcComponentConfig</td><td>由所属N-System传入的硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>imagingCapabilities</code></td><td>OneSatSim.Foundation.Types.ImagingCapabilities</td><td>成像Capabilities；Earth-camera capability passed to mission control</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>processorLoadResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>OBC处理器等效负载电阻；Excel单位Ω，当前设计基线</td><td><code>=config.ProcessorLoadResistance</code></td></tr><tr><td><code>cpuHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>CPU等效热容；Excel单位J/K，当前设计基线</td><td><code>=config.CPUHeatCapacity</code></td></tr><tr><td><code>boardHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>OBC板等效热容；Excel单位J/K，当前设计基线</td><td><code>=config.BoardHeatCapacity</code></td></tr><tr><td><code>cpuBoardConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>CPU-板导热；Excel单位W/K，当前设计基线</td><td><code>=config.CPUBoardConductance</code></td></tr><tr><td><code>boardMountConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>OBC安装导热；Excel单位W/K，当前设计基线</td><td><code>=config.BoardMountConductance</code></td></tr><tr><td><code>mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel单位kg，当前设计基线</td><td><code>=config.Mass</code></td></tr><tr><td><code>rcm_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel单位m，当前设计基线</td><td><code>=config.RCM_X</code></td></tr><tr><td><code>rcm_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel单位m，当前设计基线</td><td><code>=config.RCM_Y</code></td></tr><tr><td><code>rcm_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel单位m，当前设计基线</td><td><code>=config.RCM_Z</code></td></tr><tr><td><code>inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_XX</code></td></tr><tr><td><code>inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_YY</code></td></tr><tr><td><code>inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_ZZ</code></td></tr><tr><td><code>operationalSnapshotStart</code></td><td>Boolean</td><td>场景是否从在轨运行快照启动</td><td><code>=true</code></td></tr><tr><td><code>initialCpuTemperature</code></td><td>Modelica.Units.SI.Temperature</td><td>场景CPU初温</td><td><code>=296.15</code></td></tr><tr><td><code>initialBoardTemperature</code></td><td>Modelica.Units.SI.Temperature</td><td>场景板卡初温</td><td><code>=294.15</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>unused12Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused12Rail</td></tr><tr><td><code>unused33Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused33Rail</td></tr><tr><td><code>missionControl</code></td><td><a href=\"modelica://OneSatSim.Components.MissionControlUnit\">OneSatSim.Components.MissionControlUnit</a></td><td>星务任务与指令控制组件实例</td></tr><tr><td><code>cpuLoad</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Resistor\">Modelica.Electrical.Analog.Basic.Resistor</a></td><td>系统级 nominal OBC 5 V work point</td></tr><tr><td><code>localDecoupling</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 localDecoupling</td></tr><tr><td><code>cpuNode</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a></td><td>计算/接口量 cpuNode</td></tr><tr><td><code>boardNode</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a></td><td>计算/接口量 boardNode</td></tr><tr><td><code>cpuBoard</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">Modelica.Thermal.HeatTransfer.Components.ThermalConductor</a></td><td>计算/接口量 cpuBoard</td></tr><tr><td><code>boardMount</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">Modelica.Thermal.HeatTransfer.Components.ThermalConductor</a></td><td>计算/接口量 boardMount</td></tr><tr><td><code>cpuTemperature</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor\">Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor</a></td><td>cpu温度</td></tr><tr><td><code>boardTemperature</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor\">Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor</a></td><td>board温度</td></tr><tr><td><code>noCommandError</code></td><td><a href=\"modelica://Modelica.Blocks.Sources.IntegerConstant\">Modelica.Blocks.Sources.IntegerConstant</a></td><td>no指令误差</td></tr><tr><td><code>watchdog</code></td><td><a href=\"modelica://Modelica.Blocks.Sources.IntegerConstant\">Modelica.Blocks.Sources.IntegerConstant</a></td><td>计算/接口量 watchdog</td></tr><tr><td><code>obcBody</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">Modelica.Mechanics.MultiBody.Parts.Body</a></td><td>obc本体</td></tr></table></html>"
),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={83,131,109}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Avionics", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-53,-38},{53,40}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Rectangle(extent={{-27,-20},{18,25}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Rectangle(extent={{-20,-13},{11,18}}, lineColor={0,0,0}, fillColor={234,240,245}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-36,-14},{-27,-14}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{18,-14},{27,-14}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-19,-20},{-19,-29}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-19,25},{-19,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-36,-3},{-27,-3}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{18,-3},{27,-3}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-8,-20},{-8,-29}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-8,25},{-8,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-36,8},{-27,8}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{18,8},{27,8}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{3,-20},{3,-29}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{3,25},{3,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-36,19},{-27,19}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{18,19},{27,19}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{14,-20},{14,-29}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{14,25},{14,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Ellipse(extent={{-47.8,-32.8},{-44.2,-29.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-46.9,-31},{-45.1,-31}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{44.2,-32.8},{47.8,-29.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{45.1,-31},{46.9,-31}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-47.8,31.2},{-44.2,34.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-46.9,33},{-45.1,33}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{44.2,31.2},{47.8,34.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{45.1,33},{46.9,33}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{33,15},{44,29}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{33,-5},{44,7}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{33,-25},{44,-13}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-16,7},{-7,7},{-7,-2},{3,-2},{3,7}}, color={83,131,109}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-16,-7},{4,-7}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Onboard Computer", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-404,-470},{429,462}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-295,169},{-51.4,187}}, textString="Functional core and telemetry", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-330,374},{-229.2,392}}, textString="Power supply", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-325,-58},{-157,-40}}, textString="Thermal and mounting", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-392,417},{417,446}}, textString="Onboard computer: mission control and board support", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-392,409},{417,409}}, color={215,220,226}, thickness=0.25)
    }));
end OnboardComputerUnit;