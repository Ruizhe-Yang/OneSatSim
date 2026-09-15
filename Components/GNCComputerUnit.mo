within NISSA_12UCubeSat.Components;
model GNCComputerUnit "姿轨控计算机组件"
  parameter NISSA_12UCubeSat.Scenarios.DesignConfigRecords.ComputerComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance processorLoadResistance=config.ProcessorLoadResistance
    "GNC计算机负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity heatCapacity=config.HeatCapacity
    "GNC计算机热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountConductance=config.MountConductance
    "GNC计算机安装导热；Excel单位W/K，当前设计基线";
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
  parameter NISSA_12UCubeSat.Foundation.Types.MassProperties massProperties;
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}}),iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Basic.Conductor unused12Rail(G=0) annotation(Placement(transformation(extent={{42,76},{54,88}})));
  Modelica.Electrical.Analog.Basic.Conductor unused5Rail(G=0) annotation(Placement(transformation(extent={{66,76},{78,88}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.EnvironmentPort environment annotation(Placement(transformation(extent={{-110,-62},{-90,-42}}),iconTransformation(extent={{-110,-62},{-90,-42}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  Foundation.Models.EquivalentAOCSCore controlLaw(massProperties=massProperties) annotation(Placement(transformation(extent={{5,20},{45,60}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation(Placement(transformation(extent={{-70,35},{-50,55}})));
  Modelica.Electrical.Analog.Basic.Resistor processorLoad(R=processorLoadResistance,useHeatPort=true) "系统级 share of 3.3 V bus load" annotation(Placement(transformation(extent={{-38,35},{-18,55}})));
  Modelica.Electrical.Analog.Basic.Conductor decoupling(G=0) annotation(Placement(transformation(origin={-42,5},extent={{-8,-8},{8,8}},rotation=270)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor electronics(C=heatCapacity,T(start=294.15,fixed=false)) annotation(Placement(transformation(extent={{-25,-45},{-5,-25}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor baseplate(G=mountConductance) annotation(Placement(transformation(extent={{15,-43},{35,-27}})));
  Modelica.Mechanics.MultiBody.Parts.Body unitBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-82,2},{-62,22}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[1] annotation(Placement(transformation(extent={{78,20},{86,28}})));
equation
  connect(power.p12,unused12Rail.p) annotation(Line(points={{0,100},{0,94},{42,94},{42,82}},color={0,0,255}));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{54,82},{54,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p5,unused5Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,82}},color={0,0,255}));
  connect(unused5Rail.n,power.n5) annotation(Line(points={{78,82},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(environment,controlLaw.environment) annotation(Line(points={{-100,-52},{5,-52},{5,40}},color={0,110,70}));
  connect(information,controlLaw.information) annotation(Line(points={{100,0},{94,0},{94,40},{45,40}},color={0,90,180}));
  connect(power.p33,currentSensor.p) annotation(Line(points={{0,100},{0,94},{-70,94},{-70,45}},color={0,0,255}));
  connect(currentSensor.n,processorLoad.p) annotation(Line(points={{-50,45},{-38,45}},color={0,0,255}));
  connect(processorLoad.n,power.n33) annotation(Line(points={{-18,45},{-18,94},{0,94},{0,100}},color={0,0,255}));
  connect(decoupling.p,power.p33) annotation(Line(points={{-42,13},{-42,94},{0,94},{0,100}},color={0,0,255}));
  connect(decoupling.n,power.n33) annotation(Line(points={{-42,-3},{-42,94},{0,94},{0,100}},color={0,0,255}));
  connect(currentSensor.i,informationRealBridge[1].u) annotation(Line(points={{-60,35},{-60,18.5},{78,18.5},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.pdCurrent[21]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(processorLoad.heatPort,electronics.port) annotation(Line(points={{-28,35},{-28,-25},{-15,-25}},color={191,0,0}));
  connect(electronics.port,baseplate.port_a) annotation(Line(points={{-15,-45},{-15,-35},{15,-35}},color={191,0,0}));
  connect(baseplate.port_b,thermal) annotation(Line(points={{35,-35},{35,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(unitBody.frame_a,mechanical) annotation(Line(points={{-82,12},{-94,12},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={90,65,135},fillColor={239,233,248},fillPattern=FillPattern.Solid),Rectangle(extent={{-55,42},{55,-38}},fillColor={185,165,215},fillPattern=FillPattern.Solid),Line(points={{-38,0},{38,0}},color={90,65,135}),Line(points={{0,-28},{0,28}},color={90,65,135}),Text(extent={{-92,-74},{92,-52}},textString="GNC CPU / PD21")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Rectangle(extent={{-82,65},{55,12}},lineColor={100,70,150},pattern=LinePattern.Dash),Text(extent={{-78,73},{58,62}},textString="等效AOCS假设与计算机负载")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>汇集环境和星上信息，运行等效姿态闭环并给四台飞轮生成速度指令</p><p><b>建模层级：</b>Components层设备级白箱；主要由Modelica 4.0.0标准库元件和图形连线组成</p><h4>实现与接口</h4><p><b>白箱实现：</b>内部连接EquivalentAOCSCore、3.3 V处理器负载、去耦电容、电子学热节点和安装刚体</p><p><b>关键内部元件：</b>unused12Rail（Conductor）、unused5Rail（Conductor）、controlLaw（EquivalentAOCSCore）、currentSensor（CurrentSensor）、processorLoad（Resistor）、decoupling（Conductor，任务级去耦开路等效）、electronics（HeatCapacitor）、baseplate（ThermalConductor）、unitBody（Body）</p><p><b>对外接口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、environment（EnvironmentPort）、information（InformationPort）</p><h4>工作行为与状态</h4><p><b>运行行为：</b>任务模式与环境姿态共同决定四通道飞轮命令；处理器负载形成电流和热耗散，状态经统一信息接口发布</p><p><b>关键参数：</b>处理器等效负载、局部去耦、电子学热容、安装导热和等效控制增益</p><p><b>关键状态：</b>去耦电压、电子学温度及等效控制器连续量</p><p><b>物理域：</b>控制、电、热、机械、信息</p><h4>信息与遥测关系</h4><p><b>数据路径：</b>飞轮命令本身是OBC内部指令；执行结果由各飞轮速度、电流与状态形成SAT-S2及设备状态量</p><p><b>使用说明：</b>设备测量与机器反馈均写入同一个InformationPort.device语义域；不存在平行的传感器遥测接口。应从N-System画布下钻本组件，并结合总体公共电/热/机械网络解释结果。</p><p><b>系统级等效：</b>本设备原毫法级去耦电容和/或毫亨级EMI电感仅描述板级快速瞬态；24 h任务模型将其分别等效为直流开路去耦和0.05 ohm串联损耗，保留设备稳态电流、功率、热量、开关状态和全部遥测语义，不再要求IDA解析微秒至毫秒电气状态。</p></html>"));
end GNCComputerUnit;
