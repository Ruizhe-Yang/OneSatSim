within NISSA_12UCubeSat.Components;
model MagnetometerUnit "三轴磁强计组件"
  parameter NISSA_12UCubeSat.Scenarios.DesignConfigRecords.MagnetometerComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance loadResistance=config.LoadResistance
    "magnetometer等效负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity heatCapacity=config.HeatCapacity
    "magnetometer等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountConductance=config.MountConductance
    "magnetometer安装导热；Excel单位W/K，当前设计基线";
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
  import SI=Modelica.Units.SI;
  parameter SI.Length earthRadius=6378137 "地球参考半径";
  parameter SI.Time magneticFieldPeriod=5730 "轨道磁场近似周期";
  parameter SI.MagneticFluxDensity fieldXAmplitude=2.7e-5 "X轴磁场基准幅值";
  parameter SI.MagneticFluxDensity fieldYAmplitude=1.1e-5 "Y轴磁场基准幅值";
  parameter SI.MagneticFluxDensity fieldZAmplitude=-3.4e-5 "Z轴磁场基准幅值";
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}}),iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Basic.Conductor unused12Rail(G=0) annotation(Placement(transformation(extent={{42,76},{54,88}})));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0) annotation(Placement(transformation(extent={{66,76},{78,88}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.EnvironmentPort environment annotation(Placement(transformation(extent={{-110,-62},{-90,-42}}),iconTransformation(extent={{-110,-62},{-90,-42}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor supplyCurrent annotation(Placement(transformation(extent={{-88,10},{-72,30}})));
  Foundation.Interfaces.RealSignalReader altitudeInput annotation(Placement(transformation(extent={{-48,66},{-28,80}})));
  Foundation.Calculations.MagnetometerCalculation fieldCalculation(
    earthRadius=earthRadius,magneticFieldPeriod=magneticFieldPeriod,
    fieldXAmplitude=fieldXAmplitude,fieldYAmplitude=fieldYAmplitude,fieldZAmplitude=fieldZAmplitude)
    annotation(Placement(transformation(extent={{-20,42},{20,62}})));
  Modelica.Electrical.Analog.Basic.Resistor bridgeLoad(R=loadResistance,useHeatPort=true) "系统级 nominal magnetometer load" annotation(Placement(transformation(extent={{-70,10},{-50,30}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor sensorNode(C=heatCapacity,T(start=290.15,fixed=false)) annotation(Placement(transformation(extent={{-25,-45},{-5,-25}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor boom(G=mountConductance) annotation(Placement(transformation(extent={{15,-43},{35,-27}})));
  Modelica.Mechanics.MultiBody.Parts.Body sensorBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-82,-26},{-62,-6}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[4] annotation(Placement(transformation(extent={{78,20},{86,28}})));
equation
  connect(environment.instantaneousAltitude,altitudeInput.u) annotation(Line(points={{-100,-52},{-48,-52},{-48,73}},color={0,0,127}));
  connect(altitudeInput.y,fieldCalculation.instantaneousAltitude) annotation(Line(points={{-28,73},{-24,73},{-24,52},{-20,52}},color={0,0,127}));
  connect(power.p12,unused12Rail.p) annotation(Line(points={{0,100},{0,94},{42,94},{42,82}},color={0,0,255}));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{54,82},{54,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,82}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{78,82},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(fieldCalculation.magneticField[1],informationRealBridge[1].u) annotation(Line(points={{19,52},{78,52},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.magneticField[1]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(fieldCalculation.magneticField[2],informationRealBridge[2].u) annotation(Line(points={{19,52},{78,52},{78,24}},color={0,0,127}));
  connect(informationRealBridge[2].y,information.device.magneticField[2]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(fieldCalculation.magneticField[3],informationRealBridge[3].u) annotation(Line(points={{19,52},{78,52},{78,24}},color={0,0,127}));
  connect(informationRealBridge[3].y,information.device.magneticField[3]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(power.p5,supplyCurrent.p) annotation(Line(points={{0,100},{0,94},{-88,94},{-88,20}},color={0,0,255}));
  connect(supplyCurrent.n,bridgeLoad.p) annotation(Line(points={{-72,20},{-70,20}},color={0,0,255}));
  connect(supplyCurrent.i,informationRealBridge[4].u) annotation(Line(points={{-80,10},{78,10},{78,24}},color={0,0,127}));
  connect(informationRealBridge[4].y,information.device.tcCurrent[15]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(bridgeLoad.n,power.n5) annotation(Line(points={{-50,20},{-50,94},{0,94},{0,100}},color={0,0,255}));
  connect(bridgeLoad.heatPort,sensorNode.port) annotation(Line(points={{-60,10},{-60,-25},{-15,-25}},color={191,0,0}));
  connect(sensorNode.port,boom.port_a) annotation(Line(points={{-15,-45},{-15,-35},{15,-35}},color={191,0,0}));
  connect(boom.port_b,thermal) annotation(Line(points={{35,-35},{35,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(sensorBody.frame_a,mechanical) annotation(Line(points={{-82,-16},{-94,-16},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={90,60,120},fillColor={241,234,247},fillPattern=FillPattern.Solid),Ellipse(extent={{-45,45},{45,-45}},lineColor={90,60,120}),Line(points={{-65,0},{65,0}},color={90,60,120}),Line(points={{0,-65},{0,65}},color={90,60,120}),Text(extent={{-92,-74},{92,-52}},textString="MAG / TC15")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Text(extent={{-90,70},{90,58}},textString="轨道偶极场近似-三轴量化")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>从轨道环境构造三轴磁场测量并刻画传感桥路功耗与安装特性</p><p><b>建模层级：</b>Components层设备级白箱；主要由Modelica 4.0.0标准库元件和图形连线组成</p><h4>实现与接口</h4><p><b>白箱实现：</b>MagnetometerCalculation生成三轴磁场分量，桥路电阻、电流传感、热容、支杆导热和刚体构成器件模型</p><p><b>关键内部元件：</b>unused12Rail（Conductor）、unused33Rail（Conductor）、supplyCurrent（CurrentSensor）、altitudeInput（RealSignalReader）、fieldCalculation（MagnetometerCalculation）、bridgeLoad（Resistor）、sensorNode（HeatCapacitor）、boom（ThermalConductor）、sensorBody（Body）</p><p><b>对外接口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、environment（EnvironmentPort）、information（InformationPort）</p><h4>工作行为与状态</h4><p><b>运行行为：</b>测量随轨道相位和姿态环境变化；桥路持续取电，热量经支杆传至公共结构</p><p><b>关键参数：</b>桥路负载、传感头热容和支杆导热</p><p><b>关键状态：</b>传感头温度、电流及三轴测量</p><p><b>物理域：</b>磁、导航、电、热、机械、信息</p><h4>信息与遥测关系</h4><p><b>数据路径：</b>三轴磁场以Gauss工程量进入SAT-S2，原始状态保存在DeviceStatusBus</p><p><b>使用说明：</b>设备测量与机器反馈均写入同一个InformationPort.device语义域；不存在平行的传感器遥测接口。应从N-System画布下钻本组件，并结合总体公共电/热/机械网络解释结果。</p></html>"));
end MagnetometerUnit;
