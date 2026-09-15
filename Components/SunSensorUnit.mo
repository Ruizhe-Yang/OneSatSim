within OneSatSim.Components;
model SunSensorUnit "二维太阳敏感器组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.SunSensorComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance loadResistance=config.LoadResistance
    "sunSensor等效负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity heatCapacity=config.HeatCapacity
    "sunSensor等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountConductance=config.MountConductance
    "sunSensor安装导热；Excel单位W/K，当前设计基线";
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
  Foundation.Interfaces.EnvironmentPort environment annotation(Placement(transformation(extent={{-110,-62},{-90,-42}}),iconTransformation(extent={{-110,-62},{-90,-42}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  Foundation.Interfaces.RealSignalReader sunVectorInput[3] annotation(Placement(transformation(extent={{-54,66},{-34,80}})));
  Foundation.Calculations.SunSensorCalculation angleCalculation annotation(Placement(transformation(extent={{-25,42},{25,60}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation(Placement(transformation(extent={{-72,10},{-52,30}})));
  Modelica.Electrical.Analog.Basic.Resistor quadrantLoad(R=loadResistance,useHeatPort=true) "任务级参数 33 mA supply work point" annotation(Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor head(C=heatCapacity,T(start=292.15,fixed=false)) annotation(Placement(transformation(extent={{-25,-45},{-5,-25}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor mount(G=mountConductance) annotation(Placement(transformation(extent={{15,-43},{35,-27}})));
  Modelica.Mechanics.MultiBody.Parts.Body headBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-82,-26},{-62,-6}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[3] annotation(Placement(transformation(extent={{78,20},{86,28}})));
equation
  connect(environment.sunVectorBody,sunVectorInput.u) annotation(Line(points={{-100,-52},{-83.5,-52},{-83.5,73},{-54,73}},color={0,0,127}));
  connect(sunVectorInput.y,angleCalculation.sunVectorBody) annotation(Line(points={{-34,73},{-30,73},{-30,51},{-25,51}},color={0,0,127}));
  connect(power.p12,unused12Rail.p) annotation(Line(points={{0,100},{0,94},{42,94},{42,82}},color={0,0,255}));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{54,82},{54,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,82}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{78,82},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(angleCalculation.alpha,informationRealBridge[1].u) annotation(Line(points={{22.5,54.15},{78,54.15},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.sunAngle[1]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(angleCalculation.beta,informationRealBridge[2].u) annotation(Line(points={{22.5,47.85},{78,47.85},{78,24}},color={0,0,127}));
  connect(informationRealBridge[2].y,information.device.sunAngle[2]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(power.p5,currentSensor.p) annotation(Line(points={{0,100},{0,94},{-72,94},{-72,20}},color={0,0,255}));
  connect(currentSensor.n,quadrantLoad.p) annotation(Line(points={{-52,20},{-40,20}},color={0,0,255}));
  connect(quadrantLoad.n,power.n5) annotation(Line(points={{-20,20},{-26.5,20},{-26.5,100},{0,100}},color={0,0,255}));
  connect(currentSensor.i,informationRealBridge[3].u) annotation(Line(points={{-62,10},{78,10},{78,24}},color={0,0,127}));
  connect(informationRealBridge[3].y,information.device.pdCurrent[12]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(quadrantLoad.heatPort,head.port) annotation(Line(points={{-30,10},{-30,-25},{-15,-25}},color={191,0,0}));
  connect(head.port,mount.port_a) annotation(Line(points={{-15,-45},{-15,-35},{15,-35}},color={191,0,0}));
  connect(mount.port_b,thermal) annotation(Line(points={{35,-35},{35,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(headBody.frame_a,mechanical) annotation(Line(points={{-82,-16},{-94,-16},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={210,125,0},fillColor={252,242,215},fillPattern=FillPattern.Solid),Ellipse(extent={{-45,45},{45,-45}},fillColor={245,185,35},fillPattern=FillPattern.Solid),Line(points={{-65,0},{65,0}},color={150,90,0}),Line(points={{0,-65},{0,65}},color={150,90,0}),Text(extent={{-92,-74},{92,-52}},textString="SUN α/β / PD12")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Text(extent={{-90,70},{90,58}},textString="体坐标太阳向量到α/β角")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>把体坐标太阳向量转换为水平/俯仰太阳角并刻画象限探测器负载</p><p><b>建模层级：</b>Components层设备级白箱；主要由Modelica 4.0.0标准库元件和图形连线组成</p><h4>实现与接口</h4><p><b>白箱实现：</b>SunSensorCalculation计算alpha/beta，配套电流传感、象限负载、传感头热容、安装导热和刚体</p><p><b>关键内部元件：</b>unused12Rail（Conductor）、unused33Rail（Conductor）、sunVectorInput（RealSignalReader）、angleCalculation（SunSensorCalculation）、currentSensor（CurrentSensor）、quadrantLoad（Resistor）、head（HeatCapacitor）、mount（ThermalConductor）、headBody（Body）</p><p><b>对外接口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、environment（EnvironmentPort）、information（InformationPort）</p><h4>工作行为与状态</h4><p><b>运行行为：</b>太阳角连续随环境姿态变化；阴影状态由环境端独立给出</p><p><b>关键参数：</b>角度变换、象限负载、传感头热容和安装导热</p><p><b>关键状态：</b>太阳角、传感器电流和头部温度</p><p><b>物理域：</b>光学姿态测量、电、热、机械、环境、信息</p><h4>信息与遥测关系</h4><p><b>数据路径：</b>alpha/beta转换为度后进入SAT-S2_sunAngle_deg</p><p><b>使用说明：</b>设备测量与机器反馈均写入同一个InformationPort.device语义域；不存在平行的传感器遥测接口。应从N-System画布下钻本组件，并结合总体公共电/热/机械网络解释结果。</p></html>"));
end SunSensorUnit;
