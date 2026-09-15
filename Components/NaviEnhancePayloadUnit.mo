within OneSatSim.Components;
model NaviEnhancePayloadUnit "导航增强载荷组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.NaviEnhanceComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance activeResistance=config.ActiveResistance
    "导航增强激活负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.Resistance standbyResistance=config.StandbyResistance
    "导航增强待机负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity heatCapacity=config.HeatCapacity
    "导航增强处理器热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountConductance=config.MountConductance
    "导航增强安装导热；Excel单位W/K，当前设计基线";
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
  Modelica.Electrical.Analog.Basic.Conductor unused12Rail(G=0) annotation(Placement(transformation(extent={{42,76},{54,88}})));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0) annotation(Placement(transformation(extent={{66,76},{78,88}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor channelCurrent annotation(Placement(transformation(extent={{-72,38},{-52,58}})));
  Modelica.Electrical.Analog.Basic.VariableConductor processorLoad(useHeatPort=true) "系统级 task-gated 5 V payload load" annotation(Placement(transformation(extent={{-38,38},{-18,58}})));
  Foundation.Calculations.PointingModeEquipmentCalculation modeCalculation(
    activeResistance=activeResistance,standbyResistance=standbyResistance) annotation(Placement(transformation(extent={{-46,-12},{2,8}})));
  Modelica.Electrical.Analog.Basic.Conductor computeBuffer(G=0) annotation(Placement(transformation(origin={5,20},extent={{-8,-8},{8,8}},rotation=270)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor processorNode(C=heatCapacity,T(start=294.15,fixed=false)) annotation(Placement(transformation(extent={{-20,-44},{0,-24}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor deckPath(G=mountConductance) annotation(Placement(transformation(extent={{20,-42},{40,-26}})));
  Modelica.Mechanics.MultiBody.Parts.Body unitBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-82,2},{-62,22}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[1] annotation(Placement(transformation(extent={{78,20},{86,28}})));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[1] annotation(Placement(transformation(extent={{78,0},{86,8}})));
equation
  connect(information.command.desiredControlMode,modeCalculation.desiredControlMode) annotation(Line(points={{100,0},{94,0},{94,-2},{-46,-2}},color={255,127,0}));
  connect(power.p12,unused12Rail.p) annotation(Line(points={{0,100},{0,94},{42,94},{42,82}},color={0,0,255}));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{54,82},{54,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,82}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{78,82},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p5,channelCurrent.p) annotation(Line(points={{0,100},{0,94},{-72,94},{-72,48}},color={0,0,255}));
  connect(channelCurrent.n,processorLoad.p) annotation(Line(points={{-52,48},{-38,48}},color={0,0,255}));
  connect(modeCalculation.loadConductance,processorLoad.G) annotation(Line(points={{-0.4,-2},{-28,-2},{-28,36}},color={0,0,127}));
  connect(processorLoad.n,power.n5) annotation(Line(points={{-18,48},{-18,94},{0,94},{0,100}},color={0,0,255}));
  connect(computeBuffer.p,power.p5) annotation(Line(points={{5,28},{5,94},{0,94},{0,100}},color={0,0,255}));
  connect(computeBuffer.n,power.n5) annotation(Line(points={{5,12},{5,94},{0,94},{0,100}},color={0,0,255}));
  connect(channelCurrent.i,informationRealBridge[1].u) annotation(Line(points={{-62,38},{78,38},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.pdCurrent[4]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(modeCalculation.status,informationIntegerBridge[1].u) annotation(Line(points={{-0.4,-7.5},{78,-7.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[1].y,information.device.naviEnhanceStatus) annotation(Line(points={{86,4},{94,4},{94,0},{100,0}},color={255,127,0}));
  connect(processorLoad.heatPort,processorNode.port) annotation(Line(points={{-28,38},{-28,9.5},{3.5,9.5},{3.5,-24},{-10,-24}},color={191,0,0}));
  connect(processorNode.port,deckPath.port_a) annotation(Line(points={{-10,-44},{-10,-34},{20,-34}},color={191,0,0}));
  connect(deckPath.port_b,thermal) annotation(Line(points={{40,-34},{40,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(unitBody.frame_a,mechanical) annotation(Line(points={{-82,12},{-94,12},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={35,105,125},fillColor={228,243,246},fillPattern=FillPattern.Solid),Polygon(points={{-58,35},{5,55},{65,15},{48,-48},{-30,-52},{-58,35}},fillColor={115,185,195},fillPattern=FillPattern.Solid),Text(extent={{-92,-74},{92,-52}},textString="NAVI ENH / PD4 / A5")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Text(extent={{-90,75},{90,60}},textString="独立计算板-供电滤波-状态")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>表示常开型导航增强处理载荷的板级电热机械特性</p><p><b>建模层级：</b>Components层设备级白箱；主要由Modelica 4.0.0标准库元件和图形连线组成</p><h4>实现与接口</h4><p><b>白箱实现：</b>由5 V处理器负载、电流传感、计算缓冲电容、热容、导热和刚体构成</p><p><b>关键内部元件：</b>unused12Rail（Conductor）、unused33Rail（Conductor）、channelCurrent（CurrentSensor）、processorLoad（Resistor）、computeBuffer（Conductor，任务级去耦开路等效）、status（IntegerConstant）、processorNode（HeatCapacitor）、deckPath（ThermalConductor）、unitBody（Body）</p><p><b>对外接口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、information（InformationPort）</p><h4>工作行为与状态</h4><p><b>运行行为：</b>组件按固定可用状态运行，持续形成处理负载和热耗散</p><p><b>关键参数：</b>处理器负载、计算缓冲电容、处理器热容和安装导热</p><p><b>关键状态：</b>缓冲电压、处理器温度和设备状态</p><p><b>物理域：</b>电、热、机械、信息</p><h4>信息与遥测关系</h4><p><b>数据路径：</b>状态进入统一设备状态总线；主遥测六组未展开专用工程字段</p><p><b>使用说明：</b>设备测量与机器反馈均写入同一个InformationPort.device语义域；不存在平行的传感器遥测接口。应从N-System画布下钻本组件，并结合总体公共电/热/机械网络解释结果。</p><p><b>系统级等效：</b>本设备原毫法级去耦电容和/或毫亨级EMI电感仅描述板级快速瞬态；24 h任务模型将其分别等效为直流开路去耦和0.05 ohm串联损耗，保留设备稳态电流、功率、热量、开关状态和全部遥测语义，不再要求IDA解析微秒至毫秒电气状态。</p></html>"));
end NaviEnhancePayloadUnit;
