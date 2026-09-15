within OneSatSim.Components;
model GPSReceiverUnit "GNSS接收机组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.GnssComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance rfDigitalLoadResistance=config.RFDigitalLoadResistance
    "GNSS射频/数字负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity heatCapacity=config.HeatCapacity
    "GNSS接收机热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountConductance=config.MountConductance
    "GNSS安装导热；Excel单位W/K，当前设计基线";
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
  Modelica.Electrical.Analog.Basic.Conductor unused12Rail(G=0) annotation(Placement(transformation(extent={{30,76},{42,88}})));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0) annotation(Placement(transformation(extent={{78,76},{90,88}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.EnvironmentPort environment annotation(Placement(transformation(extent={{-110,-62},{-90,-42}}),iconTransformation(extent={{-110,-62},{-90,-42}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor receiverCurrent annotation(Placement(transformation(extent={{-75,35},{-55,55}})));
  Modelica.Electrical.Analog.Basic.Resistor rfDigitalLoad(R=rfDigitalLoadResistance,useHeatPort=true) "系统级 nominal 5 V GNSS load" annotation(Placement(transformation(extent={{-42,35},{-22,55}})));
  Modelica.Electrical.Analog.Basic.Conductor holdUp(G=0) annotation(Placement(transformation(origin={-42,5},extent={{-8,-8},{8,8}},rotation=270)));
  Foundation.Interfaces.RealSignalReader ecefPosition[3] annotation(Placement(transformation(extent={{-5,42},{20,58}})));
  Foundation.Interfaces.RealSignalReader ecefVelocity[3] annotation(Placement(transformation(extent={{28,42},{53,58}})));
  Foundation.Interfaces.BooleanSignalReader eclipseCondition annotation(Placement(transformation(extent={{56,66},{72,78}})));
  Foundation.Calculations.GNSSFixCalculation fixCalculation annotation(Placement(transformation(extent={{62,42},{82,62}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor receiverNode(C=heatCapacity,T(start=296.15,fixed=false)) annotation(Placement(transformation(extent={{-25,-45},{-5,-25}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor baseplate(G=mountConductance) annotation(Placement(transformation(extent={{15,-43},{35,-27}})));
  Modelica.Mechanics.MultiBody.Parts.Body boardBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-82,2},{-62,22}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[7] annotation(Placement(transformation(extent={{78,20},{86,28}})));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[1] annotation(Placement(transformation(extent={{78,0},{86,8}})));
equation
  connect(environment.eclipse,eclipseCondition.u) annotation(Line(points={{-100,-52},{56,-52},{56,72}},color={255,0,255}));
  connect(eclipseCondition.y,fixCalculation.eclipse) annotation(Line(points={{72,72},{76,72},{76,64},{60,64},{60,52},{62,52}},color={255,0,255}));
  connect(environment.position,ecefPosition.u) annotation(Line(points={{-100,-52},{-100,-23.5},{-5,-23.5},{-5,50}},color={0,0,127}));
  connect(environment.velocity,ecefVelocity.u) annotation(Line(points={{-100,-52},{-100,-23.5},{28,-23.5},{28,50}},color={0,0,127}));
  connect(power.p12,unused12Rail.p) annotation(Line(points={{0,100},{0,94},{30,94},{30,82}},color={0,0,255}));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{42,82},{42,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{0,94},{78,94},{78,82}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{90,82},{90,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p5,receiverCurrent.p) annotation(Line(points={{0,100},{0,94},{-75,94},{-75,45}},color={0,0,255}));
  connect(receiverCurrent.n,rfDigitalLoad.p) annotation(Line(points={{-55,45},{-42,45}},color={0,0,255}));
  connect(rfDigitalLoad.n,power.n5) annotation(Line(points={{-22,45},{-22,94},{0,94},{0,100}},color={0,0,255}));
  connect(holdUp.p,power.p5) annotation(Line(points={{-42,13},{-42,94},{0,94},{0,100}},color={0,0,255}));
  connect(holdUp.n,power.n5) annotation(Line(points={{-42,-3},{-42,94},{0,94},{0,100}},color={0,0,255}));
  connect(receiverCurrent.i,informationRealBridge[1].u) annotation(Line(points={{-65,35},{78,35},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.pdCurrent[8]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(ecefPosition[1].y,informationRealBridge[2].u) annotation(Line(points={{20,50},{20,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[2].y,information.device.gnssPosition[1]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(ecefPosition[2].y,informationRealBridge[3].u) annotation(Line(points={{20,50},{20,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[3].y,information.device.gnssPosition[2]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(ecefPosition[3].y,informationRealBridge[4].u) annotation(Line(points={{20,50},{20,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[4].y,information.device.gnssPosition[3]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(ecefVelocity[1].y,informationRealBridge[5].u) annotation(Line(points={{53,50},{53,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[5].y,information.device.gnssVelocity[1]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(ecefVelocity[2].y,informationRealBridge[6].u) annotation(Line(points={{53,50},{53,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[6].y,information.device.gnssVelocity[2]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(ecefVelocity[3].y,informationRealBridge[7].u) annotation(Line(points={{53,50},{53,24},{78,24}},color={0,0,127}));
  connect(informationRealBridge[7].y,information.device.gnssVelocity[3]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(fixCalculation.fixStatus,informationIntegerBridge[1].u) annotation(Line(points={{81,52},{78,52},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[1].y,information.device.gnssFix) annotation(Line(points={{86,4},{94,4},{94,0},{100,0}},color={255,127,0}));
  connect(rfDigitalLoad.heatPort,receiverNode.port) annotation(Line(points={{-32,35},{-32,-25},{-15,-25}},color={191,0,0}));
  connect(receiverNode.port,baseplate.port_a) annotation(Line(points={{-15,-45},{-15,-35},{15,-35}},color={191,0,0}));
  connect(baseplate.port_b,thermal) annotation(Line(points={{35,-35},{35,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(boardBody.frame_a,mechanical) annotation(Line(points={{-82,12},{-94,12},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={30,100,135},fillColor={228,243,247},fillPattern=FillPattern.Solid),Ellipse(extent={{-48,48},{48,-48}},lineColor={30,100,135}),Polygon(points={{0,38},{-34,-30},{34,-30},{0,38}},fillColor={80,170,185},fillPattern=FillPattern.Solid),Text(extent={{-92,-74},{92,-52}},textString="GNSS / PD8 / ECEF")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Text(extent={{-90,72},{90,60}},textString="RF负载-保持电容-ECEF状态")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>将轨道环境中的位置速度转换为星上导航测量并提供定位有效标志。</p><h4>白箱信号路径</h4><p>EnvironmentPort中的位置和速度分别经过显式RealSignalReader进入GNSS设备信息域；定位状态由日影条件形成。供电、热和机械路径均由Modelica 4.0.0标准元件连接组成。</p><h4>信息与遥测关系</h4><p>位置、速度与定位标志进入SAT-S2和GNSS_fix字段，通过统一信息接口进入OBC遥测链路，不存在并行传感器接口。</p><h4>命名与功能边界</h4><p>文件和class保留历史名称GPSReceiverUnit，以避免公开类路径和工具引用发生不必要变化；当前物理语义是通用GNSS接收机，不限定单一星座。上层实例名gnss、内部GNSSFixCalculation和遥测字段均按GNSS理解。</p><h4>接口与内部路径</h4><p>environment提供轨道位置、速度和日影条件，Real/Boolean SignalReader把共享量交给定位有效性计算；power表示5 V射频数字负载，thermal和mechanical表示板卡热惯性与安装质量，information发布位置、速度、fix和设备电流/温度状态。</p><h4>结果查看与使用</h4><p>优先查看ecefPosition.y、ecefVelocity.y、fixCalculation.fixValid、supplyCurrent.i和receiverNode.T，并通过SAT-S2相关字段观察星务侧结果。当前position/velocity沿用环境核心坐标语义，若与地固实测比较必须先确认参考系、历元和单位。</p><h4>建模边界</h4><p>GNSSFixCalculation只给出任务级有效性，不模拟卫星星座几何、可见星数、伪距、钟差、电离层、多路径、接收机捕获和导航滤波。适合总体导航状态与电热负载，不适合定位精度认证。</p></html>"));
end GPSReceiverUnit;
