within OneSatSim.Components;
model StarTrackerYUnit "Y向星敏感器组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.StarYComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance loadResistance=config.LoadResistance
    "starY等效负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity heatCapacity=config.HeatCapacity
    "starY等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountConductance=config.MountConductance
    "starY安装导热；Excel单位W/K，当前设计基线";
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
  parameter Integer availabilityStatus(min=0,max=1)=1
    "1表示主姿态基准有效，0表示任务级不可用测试状态";
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}}),iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Basic.Conductor unused12Rail(G=0) annotation(Placement(transformation(extent={{42,76},{54,88}})));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0) annotation(Placement(transformation(extent={{66,76},{78,88}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.EnvironmentPort environment annotation(Placement(transformation(extent={{-110,-62},{-90,-42}}),iconTransformation(extent={{-110,-62},{-90,-42}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor supplyCurrent annotation(Placement(transformation(extent={{-88,35},{-72,55}})));
  Modelica.Electrical.Analog.Basic.Resistor imagerLoad(R=loadResistance,useHeatPort=true) "系统级 nominal star tracker Y load" annotation(Placement(transformation(extent={{-65,35},{-45,55}})));
  Modelica.Electrical.Analog.Basic.Conductor supplyFilter(G=0) annotation(Placement(transformation(origin={-25,15},extent={{-8,-8},{8,8}},rotation=270)));
  Foundation.Interfaces.RealSignalReader q[4] annotation(Placement(transformation(extent={{-25,42},{-5,58}})));
  Foundation.Interfaces.RealSignalReader w[3] annotation(Placement(transformation(extent={{5,42},{25,58}})));
  Modelica.Blocks.Sources.IntegerConstant status(k=availabilityStatus) annotation(Placement(transformation(extent={{35,42},{55,62}})));
  Modelica.Blocks.Sources.IntegerConstant packetType(k=2) annotation(Placement(transformation(extent={{60,42},{80,62}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor opticalHead(C=heatCapacity,T(start=289.15,fixed=false)) annotation(Placement(transformation(extent={{-30,-45},{-10,-25}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor baffleMount(G=mountConductance) annotation(Placement(transformation(extent={{10,-43},{30,-27}})));
  Modelica.Mechanics.MultiBody.Parts.Body opticalBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-82,2},{-62,22}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[8] annotation(Placement(transformation(extent={{78,20},{86,28}})));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[2] annotation(Placement(transformation(extent={{78,0},{86,8}})));
equation
  connect(environment.quaternion,q.u) annotation(Line(points={{-100,-52},{-34.5,-52},{-34.5,50},{-25,50}},color={0,0,127}));
  connect(environment.bodyRate,w.u) annotation(Line(points={{-100,-52},{5,-52},{5,50}},color={0,0,127}));
  connect(power.p12,unused12Rail.p) annotation(Line(points={{0,100},{0,94},{42,94},{42,82}},color={0,0,255}));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{54,82},{54,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,82}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{78,82},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p5,supplyCurrent.p) annotation(Line(points={{0,100},{0,94},{-88,94},{-88,45}},color={0,0,255}));
  connect(supplyCurrent.n,imagerLoad.p) annotation(Line(points={{-72,45},{-65,45}},color={0,0,255}));
  connect(supplyCurrent.i,informationRealBridge[1].u) annotation(Line(points={{-80,35},{78,35},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.tcCurrent[14]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(imagerLoad.n,power.n5) annotation(Line(points={{-45,45},{-45,94},{0,94},{0,100}},color={0,0,255}));
  connect(supplyFilter.p,power.p5) annotation(Line(points={{-25,23},{-25,94},{0,94},{0,100}},color={0,0,255}));
  connect(supplyFilter.n,power.n5) annotation(Line(points={{-25,7},{-25,94},{0,94},{0,100}},color={0,0,255}));
  connect(q[1].y,informationRealBridge[2].u) annotation(Line(points={{-5,50},{-5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[2].y,information.device.starQuaternion[1,1]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(q[2].y,informationRealBridge[3].u) annotation(Line(points={{-5,50},{-5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[3].y,information.device.starQuaternion[1,2]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(q[3].y,informationRealBridge[4].u) annotation(Line(points={{-5,50},{-5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[4].y,information.device.starQuaternion[1,3]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(q[4].y,informationRealBridge[5].u) annotation(Line(points={{-5,50},{-5,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[5].y,information.device.starQuaternion[1,4]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(w[1].y,informationRealBridge[6].u) annotation(Line(points={{25,50},{25,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[6].y,information.device.starAngularVelocity[1,1]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(w[2].y,informationRealBridge[7].u) annotation(Line(points={{25,50},{25,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[7].y,information.device.starAngularVelocity[1,2]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(w[3].y,informationRealBridge[8].u) annotation(Line(points={{25,50},{25,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[8].y,information.device.starAngularVelocity[1,3]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(status.y,informationIntegerBridge[1].u) annotation(Line(points={{56,52},{56,4},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[1].y,information.device.starStatus[1]) annotation(Line(points={{86,4},{94,4},{94,0},{100,0}},color={255,127,0}));
  connect(packetType.y,informationIntegerBridge[2].u) annotation(Line(points={{81,52},{78,52},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[2].y,information.device.starPacketType[1]) annotation(Line(points={{86,4},{94,4},{94,0},{100,0}},color={255,127,0}));
  connect(imagerLoad.heatPort,opticalHead.port) annotation(Line(points={{-55,35},{-55,-25},{-20,-25}},color={191,0,0}));
  connect(opticalHead.port,baffleMount.port_a) annotation(Line(points={{-20,-45},{-20,-35},{10,-35}},color={191,0,0}));
  connect(baffleMount.port_b,thermal) annotation(Line(points={{30,-35},{30,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(opticalBody.frame_a,mechanical) annotation(Line(points={{-82,12},{-94,12},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={45,70,105},fillColor={236,240,246},fillPattern=FillPattern.Solid),Polygon(points={{-60,40},{20,40},{65,0},{20,-40},{-60,-40},{-60,40}},fillColor={120,145,180},fillPattern=FillPattern.Solid),Ellipse(extent={{-40,24},{8,-24}},fillColor={35,45,70},fillPattern=FillPattern.Solid),Text(extent={{-92,-74},{92,-52}},textString="STAR-Y / TYPE 1-2-3")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Text(extent={{-90,70},{90,58}},textString="光学头-电源滤波-四元数/角速度")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>提供Y向星敏四元数、角速度、设备状态与协议类型</p><p><b>建模层级：</b>Components层设备级白箱；主要由Modelica 4.0.0标准库元件和图形连线组成</p><h4>实现与接口</h4><p><b>白箱实现：</b>环境姿态映射到四元数和角速度表达式，配套成像器电负载、滤波电容、光学头热容和刚体</p><p><b>关键内部元件：</b>unused12Rail（Conductor）、unused33Rail（Conductor）、supplyCurrent（CurrentSensor）、imagerLoad（Resistor）、supplyFilter（Conductor，任务级去耦开路等效）、q（RealSignalReader）、w（RealSignalReader）、status（IntegerConstant）、packetType（IntegerConstant）、opticalHead（HeatCapacitor）、baffleMount（ThermalConductor）、opticalBody（Body）</p><p><b>对外接口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、environment（EnvironmentPort）、information（InformationPort）</p><h4>工作行为与状态</h4><p><b>运行行为：</b>连续读取EnvironmentPort姿态；设备状态和packetType作为信息状态输出</p><p><b>关键参数：</b>成像负载、供电滤波、光学热容、安装导热和packetType</p><p><b>关键状态：</b>滤波电压、光学头温度、姿态测量和状态码</p><p><b>物理域：</b>姿态测量、电、热、机械、信息</p><h4>信息与遥测关系</h4><p><b>数据路径：</b>Y星敏四元数进入SAT-S2，StarTrackerY_status输出可用状态</p><p><b>使用说明：</b>设备测量与机器反馈均写入同一个InformationPort.device语义域；不存在平行的传感器遥测接口。应从N-System画布下钻本组件，并结合总体公共电/热/机械网络解释结果。</p><p><b>系统级等效：</b>本设备原毫法级去耦电容和/或毫亨级EMI电感仅描述板级快速瞬态；24 h任务模型将其分别等效为直流开路去耦和0.05 ohm串联损耗，保留设备稳态电流、功率、热量、开关状态和全部遥测语义，不再要求IDA解析微秒至毫秒电气状态。</p></html>"));
end StarTrackerYUnit;
