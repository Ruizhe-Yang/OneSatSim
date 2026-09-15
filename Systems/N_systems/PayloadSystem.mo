within NISSA_12UCubeSat.Systems.N_systems;
model PayloadSystem "载荷分系统"
  parameter NISSA_12UCubeSat.Scenarios.DesignConfigRecords.PayloadDesignConfig designConfig "分系统硬件设计配置";
  parameter NISSA_12UCubeSat.Scenarios.InitialConditionConfig initialConditions "场景初始条件";
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-112,-10},{-92,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{92,-10},{112,10}})));
  Components.EarthObservationCameraUnit earthCamera(config=designConfig.earthCamera,
    initialOpticalBenchTemperature=initialConditions.cameraOpticalBenchTemperature,
    initialFocalBoxTemperature=initialConditions.cameraFocalBoxTemperature) annotation(Placement(transformation(extent={{-65,20},{-25,60}})));
  Components.SelfieCameraUnit selfieCamera (config=designConfig.selfieCamera)annotation(Placement(transformation(extent={{25,20},{65,60}})));
  Components.NaviEnhancePayloadUnit naviEnhance (config=designConfig.naviEnhance)annotation(Placement(transformation(extent={{-80,-65},{-40,-25}})));
  Components.SpaceTimePayloadUnit spaceTime (config=designConfig.spaceTime)annotation(Placement(transformation(extent={{-20,-65},{20,-25}})));
  Components.FotonAmurPayloadUnit fotonAmur (config=designConfig.fotonAmur)annotation(Placement(transformation(extent={{40,-65},{80,-25}})));
equation
  connect(power,earthCamera.power) annotation(Line(points={{0,100},{-90,100},{-90,40},{-65,40}},color={0,0,255}));
  connect(power,selfieCamera.power) annotation(Line(points={{0,100},{15,100},{15,40},{25,40}},color={0,0,255}));
  connect(power,naviEnhance.power) annotation(Line(points={{0,100},{-92,100},{-92,-45},{-80,-45}},color={0,0,255}));
  connect(power,spaceTime.power) annotation(Line(points={{0,100},{-10,100},{-10,-12},{-30,-12},{-30,-45},{-20,-45}},color={0,0,255}));
  connect(power,fotonAmur.power) annotation(Line(points={{0,100},{10,100},{10,-8},{30,-8},{30,-45},{40,-45}},color={0,0,255}));
  connect(thermal,earthCamera.thermal) annotation(Line(points={{0,-100},{-30,-100},{-30,10},{-45,10},{-45,20}},color={191,0,0}));
  connect(thermal,selfieCamera.thermal) annotation(Line(points={{0,-100},{30,-100},{30,10},{45,10},{45,20}},color={191,0,0}));
  connect(thermal,naviEnhance.thermal) annotation(Line(points={{0,-100},{-60,-100},{-60,-65}},color={191,0,0}));
  connect(thermal,spaceTime.thermal) annotation(Line(points={{0,-100},{0,-65}},color={191,0,0}));
  connect(thermal,fotonAmur.thermal) annotation(Line(points={{0,-100},{60,-100},{60,-65}},color={191,0,0}));
  connect(mechanical,earthCamera.mechanical) annotation(Line(points={{-102,0},{-96,0},{-96,68},{-45,68},{-45,60}},color={95,95,95},thickness=0.5));
  connect(mechanical,selfieCamera.mechanical) annotation(Line(points={{-102,0},{-94,0},{-94,72},{45,72},{45,60}},color={95,95,95},thickness=0.5));
  connect(mechanical,naviEnhance.mechanical) annotation(Line(points={{-102,0},{-94,0},{-94,-14},{-60,-14},{-60,-25}},color={95,95,95},thickness=0.5));
  connect(mechanical,spaceTime.mechanical) annotation(Line(points={{-102,0},{-92,0},{-92,-8},{0,-8},{0,-25}},color={95,95,95},thickness=0.5));
  connect(mechanical,fotonAmur.mechanical) annotation(Line(points={{-102,0},{-90,0},{-90,-4},{60,-4},{60,-25}},color={95,95,95},thickness=0.5));
  connect(information,earthCamera.information) annotation(Line(points={{102,0},{96,0},{96,68},{-15,68},{-15,40},{-25,40}},color={0,90,180}));
  connect(information,selfieCamera.information) annotation(Line(points={{102,0},{94,0},{94,40},{65,40}},color={0,90,180}));
  connect(information,naviEnhance.information) annotation(Line(points={{102,0},{98,0},{98,-78},{-30,-78},{-30,-45},{-40,-45}},color={0,90,180}));
  connect(information,spaceTime.information) annotation(Line(points={{102,0},{96,0},{96,-74},{30,-74},{30,-45},{20,-45}},color={0,90,180}));
  connect(information,fotonAmur.information) annotation(Line(points={{102,0},{94,0},{94,-45},{80,-45}},color={0,90,180}));
  annotation(
    Icon(
      coordinateSystem(extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(extent={{-86,72},{86,-72}},lineColor={75,75,75},fillColor={245,245,242},fillPattern=FillPattern.Solid),
        Rectangle(extent={{-76,54},{-8,-34}},lineColor={85,85,85},fillColor={224,228,232},fillPattern=FillPattern.Solid),
        Ellipse(extent={{-64,38},{-20,-6}},lineColor={55,65,80},fillColor={75,90,110},fillPattern=FillPattern.Solid),
        Ellipse(extent={{-55,29},{-29,3}},lineColor={205,215,225},fillColor={35,45,60},fillPattern=FillPattern.Solid),
        Ellipse(extent={{-48,22},{-36,10}},lineColor={210,225,235},fillColor={130,160,185},fillPattern=FillPattern.Solid),
        Rectangle(extent={{10,52},{70,28}},lineColor={110,100,80},fillColor={226,218,198},fillPattern=FillPattern.Solid),
        Rectangle(extent={{10,16},{70,-8}},lineColor={110,100,80},fillColor={226,218,198},fillPattern=FillPattern.Solid),
        Rectangle(extent={{10,-20},{70,-44}},lineColor={110,100,80},fillColor={226,218,198},fillPattern=FillPattern.Solid),
        Text(extent={{16,48},{64,32}},textString="NAV",lineColor={70,65,55}),
        Text(extent={{16,12},{64,-4}},textString="SPACE-TIME",lineColor={70,65,55}),
        Text(extent={{16,-24},{64,-40}},textString="FOTON-AMUR",lineColor={70,65,55}),
        Line(points={{-8,10},{10,40}},color={95,95,95},thickness=0.5),
        Line(points={{-8,10},{10,4}},color={95,95,95},thickness=0.5),
        Line(points={{-8,10},{10,-32}},color={95,95,95},thickness=0.5),
        Text(extent={{-78,-66},{78,-48}},textString="PAYLOAD SYSTEM",lineColor={55,55,55})
      }),
    Diagram(
      coordinateSystem(extent={{-110,-110},{110,110}}),
      graphics={
        Rectangle(extent={{-88,78},{88,8}},lineColor={170,176,184},fillColor={247,249,250},fillPattern=FillPattern.Solid,radius=4),
        Text(extent={{-82,76},{82,64}},textString="OPTICAL IMAGING PAYLOADS",lineColor={75,85,95}),
        Rectangle(extent={{-88,-12},{88,-82}},lineColor={188,180,160},fillColor={250,248,243},fillPattern=FillPattern.Solid,radius=4),
        Text(extent={{-82,-13},{82,-21}},textString="SCIENCE & TECHNOLOGY PAYLOADS",lineColor={95,85,65})
      }),
    Documentation(info="<html><h4>分系统职责</h4><p><b>系统角色：</b>集成对地相机、自拍相机和三类科学/技术载荷</p><p><b>1+4+8位置：</b>八个N-System之一；上接四个Overall，下接专业Components</p><h4>白箱组成与连接</h4><p><b>实现：</b>五个独立Components共享单组热、机械和信息端口；相机业务数据经PayloadDataPort语义域汇入统一信息接口</p><p><b>内部设备：</b>earthCamera（EarthObservationCameraUnit）、selfieCamera（SelfieCameraUnit）、naviEnhance（NaviEnhancePayloadUnit）、spaceTime（SpaceTimePayloadUnit）、fotonAmur（FotonAmurPayloadUnit）</p><p><b>对外端口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、information（InformationPort）</p><p><b>运行行为：</b>对地成像指令只驱动Earth camera并累计对应业务数据；Selfie camera保留独立指令通道，默认任务表不误触发。其他载荷维持各自电热工作特性。</p><h4>状态与遥测</h4><p><b>关键对象：</b>相机任务门控、图像写入率、关键温度和载荷状态</p><p><b>关键状态：</b>相机开关、载荷温度和业务数据率</p><p><b>遥测关系：</b>相机状态和关键热敏进入主工程包；未展开字段的载荷仍保留设备状态但不伪造工程字段</p><p><b>建模约束：</b>本模型仅含connect语句；所有设备只保留一组信息、热和机械接口，适用时再增加电源或环境接口。</p></html>"));
end PayloadSystem;
