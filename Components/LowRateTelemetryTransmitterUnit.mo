within OneSatSim.Components;
model LowRateTelemetryTransmitterUnit "低速遥测基带组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.BasebandComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance fpgaLoadResistance=config.FPGALoadResistance
    "低速遥测基带负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity boardHeatCapacity=config.BoardHeatCapacity
    "基带板等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountConductance=config.MountConductance
    "基带安装导热；Excel单位W/K，当前设计基线";
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
  Modelica.Electrical.Analog.Sensors.CurrentSensor basebandCurrent annotation(Placement(transformation(extent={{-72,38},{-52,58}})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch txEnable annotation(Placement(transformation(extent={{-50,14},{-30,34}})));
  Modelica.Electrical.Analog.Basic.Resistor fpgaLoad(R=fpgaLoadResistance,useHeatPort=true) annotation(Placement(transformation(extent={{-38,38},{-18,58}})));
  Modelica.Electrical.Analog.Basic.Conductor fifoSupply(G=0) annotation(Placement(transformation(origin={5,18},extent={{-8,-8},{8,8}},rotation=270)));
  Foundation.Calculations.CommandStatusCalculation statusCalculation annotation(Placement(transformation(extent={{45,42},{65,62}})));
  Foundation.Interfaces.BooleanSignalReader downlinkEnable annotation(Placement(transformation(extent={{-48,64},{-28,80}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor board(C=boardHeatCapacity,T(start=295.15,fixed=false)) annotation(Placement(transformation(extent={{-20,-42},{0,-22}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor guide(G=mountConductance) annotation(Placement(transformation(extent={{20,-40},{40,-24}})));
  Modelica.Mechanics.MultiBody.Parts.Body basebandBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-82,2},{-62,22}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[1] annotation(Placement(transformation(extent={{78,20},{86,28}})));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[1] annotation(Placement(transformation(extent={{78,0},{86,8}})));
equation
  connect(information.command.communicationPowerCommand,downlinkEnable.u) annotation(Line(points={{100,0},{94,0},{94,72},{-48,72}},color={255,0,255}));
  connect(downlinkEnable.y,statusCalculation.command) annotation(Line(points={{-28,72},{40,72},{40,52},{45,52}},color={255,0,255}));
  connect(power.p12,unused12Rail.p) annotation(Line(points={{0,100},{0,94},{42,94},{42,82}},color={0,0,255}));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{54,82},{54,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,82}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{78,82},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p5,basebandCurrent.p) annotation(Line(points={{0,100},{0,94},{-72,94},{-72,48}},color={0,0,255}));
  connect(basebandCurrent.n,txEnable.p) annotation(Line(points={{-52,48},{-50,48},{-50,24}},color={0,0,255}));
  connect(txEnable.n,fpgaLoad.p) annotation(Line(points={{-30,24},{-38,24},{-38,48}},color={0,0,255}));
  connect(downlinkEnable.y,txEnable.control) annotation(Line(points={{-28,72},{-40,72},{-40,32}},color={255,0,255}));
  connect(fpgaLoad.n,power.n5) annotation(Line(points={{-18,48},{-18,94},{0,94},{0,100}},color={0,0,255}));
  connect(fifoSupply.p,power.p5) annotation(Line(points={{5,26},{5,94},{0,94},{0,100}},color={0,0,255}));
  connect(fifoSupply.n,power.n5) annotation(Line(points={{5,10},{5,94},{0,94},{0,100}},color={0,0,255}));
  connect(basebandCurrent.i,informationRealBridge[1].u) annotation(Line(points={{-62,38},{78,38},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.pdCurrent[2]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(statusCalculation.status,informationIntegerBridge[1].u) annotation(Line(points={{64,52},{78,52},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[1].y,information.device.basebandStatus) annotation(Line(points={{86,4},{94,4},{94,0},{100,0}},color={255,127,0}));
  connect(fpgaLoad.heatPort,board.port) annotation(Line(points={{-28,38},{-28,-22},{-10,-22}},color={191,0,0}));
  connect(board.port,guide.port_a) annotation(Line(points={{-10,-42},{-10,-32},{20,-32}},color={191,0,0}));
  connect(guide.port_b,thermal) annotation(Line(points={{40,-32},{40,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(basebandBody.frame_a,mechanical) annotation(Line(points={{-82,12},{-94,12},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={30,90,145},fillColor={228,241,250},fillPattern=FillPattern.Solid),Rectangle(extent={{-55,42},{55,-42}},fillColor={150,200,230},fillPattern=FillPattern.Solid),Line(points={{-40,20},{40,20},{40,-20},{-40,-20},{-40,20}},color={30,90,145}),Text(extent={{-92,-74},{92,-52}},textString="BASEBAND / PD2 / BBB-S0")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Text(extent={{-92,72},{92,60}},textString="FPGA-FIFO-基带状态")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>模拟测控数传基带在任务下行时的使能、功耗和设备状态</p><p><b>建模层级：</b>Components层设备级白箱；主要由Modelica 4.0.0标准库元件和图形连线组成</p><h4>实现与接口</h4><p><b>白箱实现：</b>下行指令驱动理想开关，FPGA阻性负载、FIFO电容、板级热容与导热形成白箱网络</p><p><b>关键内部元件：</b>unused12Rail（Conductor）、unused33Rail（Conductor）、basebandCurrent（CurrentSensor）、txEnable（IdealClosingSwitch）、fpgaLoad（Resistor）、fifoSupply（Conductor，任务级去耦开路等效）、statusCalculation（CommandStatusCalculation）、downlinkEnable（BooleanSignalReader）、board（HeatCapacitor）、guide（ThermalConductor）、basebandBody（Body）</p><p><b>对外接口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、information（InformationPort）</p><h4>工作行为与状态</h4><p><b>运行行为：</b>downlink有效时基带上电并报告工作状态；该组件不重复处理工程数据，而使用信息总线上OBC形成的连续遥测镜像</p><p><b>关键参数：</b>FPGA负载、FIFO供电电容、板热容和安装导热</p><p><b>关键状态：</b>FIFO电容电压、开关状态、板温和baseband状态</p><p><b>物理域：</b>电、热、机械、信息</p><h4>信息与遥测关系</h4><p><b>数据路径：</b>Baseband_status反映工作状态；工程字段内容由OBC状态库和连续遥测镜像产生</p><p><b>使用说明：</b>设备测量与机器反馈均写入同一个InformationPort.device语义域；不存在平行的传感器遥测接口。</p><p><b>系统级等效：</b>本设备原毫法级去耦电容和/或毫亨级EMI电感仅描述板级快速瞬态；24 h任务模型将其分别等效为直流开路去耦和0.05 ohm串联损耗，保留设备稳态电流、功率、热量、开关状态和全部遥测语义，不再要求IDA解析微秒至毫秒电气状态。</p><h4>命名与职责边界</h4><p>该类保留LowRateTelemetryTransmitterUnit历史名称，但当前实现是低速测控遥测基带处理与使能组件，不是包含射频功放、天线和完整链路预算的独立发射机。射频接收、X波段高速数传和天线分别由其他组件承担。</p><h4>信息与结果使用</h4><p>communicationPowerCommand经BooleanSignalReader控制基带供电，FPGA负载、电流传感、板级热容和安装导热给出电热响应；basebandStatus进入统一设备状态。应查看txEnable、basebandCurrent.i、board.T和statusCalculation.status，不应在此寻找工程遥测字段内容或X波段载荷读出率。</p></html>"));
end LowRateTelemetryTransmitterUnit;
