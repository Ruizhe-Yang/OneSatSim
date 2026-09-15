within NISSA_12UCubeSat.Components;
model RadioReceiverUnit "测控接收机组件"
  parameter NISSA_12UCubeSat.Scenarios.DesignConfigRecords.TtcReceiverComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance receiverLoadResistance=config.ReceiverLoadResistance
    "测控接收机负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.Resistance rfChokeResistance=config.RFChokeResistance
    "射频串联等效损耗；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity heatCapacity=config.HeatCapacity
    "接收机等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountConductance=config.MountConductance
    "接收机安装导热；Excel单位W/K，当前设计基线";
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
  Modelica.Electrical.Analog.Basic.Resistor receiverLoad(R=receiverLoadResistance,useHeatPort=true) "任务级参数 TTC 5 V receive current about 24 mA" annotation(Placement(transformation(extent={{-65,38},{-45,58}})));
  Modelica.Electrical.Analog.Basic.Resistor rfChoke(R=rfChokeResistance) annotation(Placement(transformation(extent={{-30,38},{-10,58}})));
  Modelica.Electrical.Analog.Basic.Conductor demodFilter(G=0) annotation(Placement(transformation(origin={10,20},extent={{-8,-8},{8,8}},rotation=270)));
  Modelica.Blocks.Sources.IntegerConstant receiverStatus(k=1) annotation(Placement(transformation(extent={{45,42},{65,62}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor rfNode(C=heatCapacity,T(start=294.15,fixed=false)) annotation(Placement(transformation(extent={{-20,-42},{0,-22}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor chassis(G=mountConductance) annotation(Placement(transformation(extent={{20,-40},{40,-24}})));
  Modelica.Mechanics.MultiBody.Parts.Body receiverBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-82,2},{-62,22}})));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[1] annotation(Placement(transformation(extent={{78,0},{86,8}})));
equation
  connect(power.p12,unused12Rail.p) annotation(Line(points={{0,100},{0,94},{42,94},{42,82}},color={0,0,255}));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{54,82},{54,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,82}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{78,82},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p5,receiverLoad.p) annotation(Line(points={{0,100},{0,94},{-65,94},{-65,48}},color={0,0,255}));
  connect(receiverLoad.n,rfChoke.p) annotation(Line(points={{-45,48},{-30,48}},color={0,0,255}));
  connect(rfChoke.n,power.n5) annotation(Line(points={{-10,48},{-10,94},{0,94},{0,100}},color={0,0,255}));
  connect(demodFilter.p,power.p5) annotation(Line(points={{10,28},{10,94},{0,94},{0,100}},color={0,0,255}));
  connect(demodFilter.n,power.n5) annotation(Line(points={{10,12},{10,94},{0,94},{0,100}},color={0,0,255}));
  connect(receiverStatus.y,informationIntegerBridge[1].u) annotation(Line(points={{66,52},{78,52},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[1].y,information.device.ttcStatus) annotation(Line(points={{86,4},{94,4},{94,0},{100,0}},color={255,127,0}));
  connect(receiverLoad.heatPort,rfNode.port) annotation(Line(points={{-55,38},{-55,-22},{-10,-22}},color={191,0,0}));
  connect(rfNode.port,chassis.port_a) annotation(Line(points={{-10,-42},{-10,-32},{20,-32}},color={191,0,0}));
  connect(chassis.port_b,thermal) annotation(Line(points={{40,-32},{40,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(receiverBody.frame_a,mechanical) annotation(Line(points={{-82,12},{-94,12},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={25,95,150},fillColor={228,241,250},fillPattern=FillPattern.Solid),Ellipse(extent={{-65,55},{65,-55}},startAngle=-60,endAngle=60,closure=EllipseClosure.None,lineColor={25,95,150},lineThickness=2),Ellipse(extent={{-12,12},{12,-12}},fillColor={25,95,150},fillPattern=FillPattern.Solid),Text(extent={{-92,-74},{92,-52}},textString="TTC / TTC-S0")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Text(extent={{-90,72},{90,60}},textString="射频扼流-解调滤波-应答机状态")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>表示测控接收链路的稳态功耗、滤波、热耗散和设备可用状态</p><p><b>建模层级：</b>Components层设备级白箱；主要由Modelica 4.0.0标准库元件和图形连线组成</p><h4>实现与接口</h4><p><b>白箱实现：</b>由阻性接收负载、RF扼流电感、解调滤波电容、热容、机箱导热和刚体组成</p><p><b>关键内部元件：</b>unused12Rail（Conductor）、unused33Rail（Conductor）、receiverLoad（Resistor）、rfChoke（Resistor，任务级串联损耗等效）、demodFilter（Conductor，任务级去耦开路等效）、receiverStatus（IntegerConstant）、rfNode（HeatCapacitor）、chassis（ThermalConductor）、receiverBody（Body）</p><p><b>对外接口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、information（InformationPort）</p><h4>工作行为与状态</h4><p><b>运行行为：</b>接收机持续工作并向统一信息总线报告TTC状态，不在此模型中生成任务时序</p><p><b>关键参数：</b>接收负载、RF电感、解调电容和机箱热参数</p><p><b>关键状态：</b>电感电流、滤波电压、RF节点温度和TTC状态</p><p><b>物理域：</b>射频等效、电、热、机械、信息</p><h4>信息与遥测关系</h4><p><b>数据路径：</b>TTC_status进入星上工程遥测状态字段</p><p><b>使用说明：</b>设备测量与机器反馈均写入同一个InformationPort.device语义域；不存在平行的传感器遥测接口。应从N-System画布下钻本组件，并结合总体公共电/热/机械网络解释结果。</p><p><b>系统级等效：</b>本设备原毫法级去耦电容和/或毫亨级EMI电感仅描述板级快速瞬态；24 h任务模型将其分别等效为直流开路去耦和0.05 ohm串联损耗，保留设备稳态电流、功率、热量、开关状态和全部遥测语义，不再要求IDA解析微秒至毫秒电气状态。</p></html>"));
end RadioReceiverUnit;
