within OneSatSim.Components;
model StarTrackerZUnit "Z向星敏感器组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.StarZComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance loadResistance=config.LoadResistance
    "starZ等效负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity heatCapacity=config.HeatCapacity
    "starZ等效热容；Excel单位J/K，当前设计基线";
  parameter Real thermalResistance(unit="K/W")=config.ThermalResistance
    "starZ安装热阻；Excel单位K/W，当前设计基线";
  parameter Modelica.Units.SI.Resistance emiResistance=config.EMIResistance
    "Z星敏EMI等效串联电阻；Excel单位Ω，当前设计基线";
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
  Modelica.Electrical.Analog.Sensors.CurrentSensor supplyCurrent annotation(Placement(transformation(extent={{-90,38},{-74,58}})));
  Modelica.Electrical.Analog.Basic.VariableConductor detectorLoad(useHeatPort=true) "系统级 task-gated star tracker Z load" annotation(Placement(transformation(extent={{-68,38},{-48,58}})));
  Modelica.Electrical.Analog.Basic.Resistor emiFilter(R=emiResistance) annotation(Placement(transformation(extent={{-38,38},{-18,58}})));
  Foundation.Interfaces.RealSignalReader quaternionInput[4] annotation(Placement(transformation(extent={{-42,66},{-26,78}})));
  Foundation.Interfaces.RealSignalReader bodyRateInput[3] annotation(Placement(transformation(extent={{-20,66},{-4,78}})));
  Foundation.Calculations.StarTrackerCalculation trackerCalculation(activeResistance=loadResistance)
    annotation(Placement(transformation(extent={{-12,34},{42,62}})));
  Modelica.Blocks.Sources.IntegerConstant packetType(k=3) annotation(Placement(transformation(extent={{70,42},{90,62}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor focalPlane(C=heatCapacity,T(start=288.15,fixed=false)) annotation(Placement(transformation(extent={{-35,-46},{-15,-26}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor isolator(R=thermalResistance) annotation(Placement(transformation(extent={{5,-44},{25,-28}})));
  Modelica.Mechanics.MultiBody.Parts.Body trackerBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-82,2},{-62,22}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[8] annotation(Placement(transformation(extent={{78,20},{86,28}})));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[2] annotation(Placement(transformation(extent={{78,0},{86,8}})));
equation
  connect(information.command.desiredControlMode,trackerCalculation.desiredControlMode) annotation(Line(points={{100,0},{100,9.5},{-12,9.5},{-12,58.5}},color={255,127,0}));
  connect(environment.quaternion,quaternionInput.u) annotation(Line(points={{-100,-52},{-42,-52},{-42,72}},color={0,0,127}));
  connect(environment.bodyRate,bodyRateInput.u) annotation(Line(points={{-100,-52},{-39.5,-52},{-39.5,64.5},{-20,64.5},{-20,72}},color={0,0,127}));
  connect(quaternionInput.y,trackerCalculation.quaternion) annotation(Line(points={{-26,72},{-26,59.5},{-12,59.5},{-12,49.4}},color={0,0,127}));
  connect(bodyRateInput.y,trackerCalculation.bodyRate) annotation(Line(points={{-4,72},{0,72},{0,41.7},{-12,41.7}},color={0,0,127}));
  connect(power.p12,unused12Rail.p) annotation(Line(points={{0,100},{0,94},{42,94},{42,82}},color={0,0,255}));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{54,82},{54,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,82}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{78,82},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p5,supplyCurrent.p) annotation(Line(points={{0,100},{0,94},{-90,94},{-90,48}},color={0,0,255}));
  connect(supplyCurrent.n,detectorLoad.p) annotation(Line(points={{-74,48},{-68,48}},color={0,0,255}));
  connect(trackerCalculation.loadConductance,detectorLoad.G) annotation(Line(points={{39.3,52.9},{48,52.9},{48,28},{-58,28},{-58,36}},color={0,0,127}));
  connect(supplyCurrent.i,informationRealBridge[1].u) annotation(Line(points={{-82,38},{-82,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.tcCurrent[13]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(detectorLoad.n,emiFilter.p) annotation(Line(points={{-48,48},{-38,48}},color={0,0,255}));
  connect(emiFilter.n,power.n5) annotation(Line(points={{-18,48},{-18,64.5},{0,64.5},{0,100}},color={0,0,255}));
  connect(trackerCalculation.measuredQuaternion[1],informationRealBridge[2].u) annotation(Line(points={{39.3,49.2},{39.3,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[2].y,information.device.starQuaternion[2,1]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(trackerCalculation.measuredQuaternion[2],informationRealBridge[3].u) annotation(Line(points={{39.3,49.2},{39.3,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[3].y,information.device.starQuaternion[2,2]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(trackerCalculation.measuredQuaternion[3],informationRealBridge[4].u) annotation(Line(points={{39.3,49.2},{39.3,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[4].y,information.device.starQuaternion[2,3]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(trackerCalculation.measuredQuaternion[4],informationRealBridge[5].u) annotation(Line(points={{39.3,49.2},{39.3,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[5].y,information.device.starQuaternion[2,4]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(trackerCalculation.measuredBodyRate[1],informationRealBridge[6].u) annotation(Line(points={{39.3,44.3},{39.3,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[6].y,information.device.starAngularVelocity[2,1]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(trackerCalculation.measuredBodyRate[2],informationRealBridge[7].u) annotation(Line(points={{39.3,44.3},{39.3,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[7].y,information.device.starAngularVelocity[2,2]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(trackerCalculation.measuredBodyRate[3],informationRealBridge[8].u) annotation(Line(points={{39.3,44.3},{39.3,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[8].y,information.device.starAngularVelocity[2,3]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(trackerCalculation.status,informationIntegerBridge[1].u) annotation(Line(points={{39.3,38.9},{78,38.9},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[1].y,information.device.starStatus[2]) annotation(Line(points={{86,4},{94,4},{94,0},{100,0}},color={255,127,0}));
  connect(packetType.y,informationIntegerBridge[2].u) annotation(Line(points={{91,52},{78,52},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[2].y,information.device.starPacketType[2]) annotation(Line(points={{86,4},{94,4},{94,0},{100,0}},color={255,127,0}));
  connect(detectorLoad.heatPort,focalPlane.port) annotation(Line(points={{-58,38},{-58,-26},{-25,-26}},color={191,0,0}));
  connect(focalPlane.port,isolator.port_a) annotation(Line(points={{-25,-46},{-25,-36},{5,-36}},color={191,0,0}));
  connect(isolator.port_b,thermal) annotation(Line(points={{25,-36},{25,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(trackerBody.frame_a,mechanical) annotation(Line(points={{-82,12},{-94,12},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={55,70,105},fillColor={237,241,247},fillPattern=FillPattern.Solid),Polygon(points={{-58,42},{22,42},{68,0},{22,-42},{-58,-42},{-58,42}},fillColor={130,150,185},fillPattern=FillPattern.Solid),Ellipse(extent={{-38,24},{10,-24}},fillColor={30,40,65},fillPattern=FillPattern.Solid),Text(extent={{-92,-74},{92,-52}},textString="STAR-Z / TYPE 1-2-3")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Text(extent={{-90,70},{90,58}},textString="EMI电感-焦面热隔离-类型3")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>提供Z向星敏四元数、角速度、设备状态与协议类型</p><p><b>建模层级：</b>Components层设备级白箱；主要由Modelica 4.0.0标准库元件和图形连线组成</p><h4>实现与接口</h4><p><b>白箱实现：</b>环境姿态经信号转发器进入星敏计算黑箱，检测器负载、EMI电感、焦平面热容、隔热安装和刚体组成</p><p><b>关键内部元件：</b>unused12Rail（Conductor）、unused33Rail（Conductor）、supplyCurrent（CurrentSensor）、detectorLoad（Resistor）、emiFilter（Resistor，任务级串联损耗等效）、quaternionInput（RealSignalReader）、bodyRateInput（RealSignalReader）、trackerCalculation（StarTrackerCalculation）、packetType（IntegerConstant）、focalPlane（HeatCapacitor）、isolator（ThermalResistor）、trackerBody（Body）</p><p><b>对外接口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、environment（EnvironmentPort）、information（InformationPort）</p><h4>工作行为与状态</h4><p><b>运行行为：</b>连续读取EnvironmentPort姿态；电感与隔热结构刻画和Y向星敏不同的器件特性</p><p><b>关键参数：</b>检测器负载、EMI电感、焦平面热容、隔热热阻和packetType</p><p><b>关键状态：</b>电感电流、焦平面温度、姿态测量和状态码</p><p><b>物理域：</b>姿态测量、电、热、机械、信息</p><h4>信息与遥测关系</h4><p><b>数据路径：</b>Z星敏四元数进入SAT-S2，StarTrackerZ_status输出可用状态</p><p><b>使用说明：</b>设备测量与机器反馈均写入同一个InformationPort.device语义域；不存在平行的传感器遥测接口。应从N-System画布下钻本组件，并结合总体公共电/热/机械网络解释结果。</p><p><b>系统级等效：</b>本设备原毫法级去耦电容和/或毫亨级EMI电感仅描述板级快速瞬态；24 h任务模型将其分别等效为直流开路去耦和0.05 ohm串联损耗，保留设备稳态电流、功率、热量、开关状态和全部遥测语义，不再要求IDA解析微秒至毫秒电气状态。</p></html>"));
end StarTrackerZUnit;
