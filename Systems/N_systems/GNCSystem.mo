within OneSatSim.Systems.N_systems;
model GNCSystem "姿轨控分系统"
  parameter OneSatSim.Scenarios.DesignConfigRecords.GncDesignConfig designConfig "分系统硬件设计配置";
  parameter OneSatSim.Scenarios.InitialConditionConfig initialConditions "场景初始条件";
  parameter OneSatSim.Foundation.Types.MassProperties massProperties;
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-112,-10},{-92,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{92,-10},{112,10}})));
  Foundation.Interfaces.EnvironmentPort environment annotation(Placement(transformation(extent={{-112,55},{-92,75}})));
  Components.GNCComputerUnit computer(config=designConfig.computer,massProperties=massProperties) annotation(Placement(transformation(extent={{-83,45},{-63,65}})));
  Components.ReactionWheelXUnit wheelX(config=designConfig.wheelX,initialSpeed=initialConditions.wheelSpeed[1]) annotation(Placement(transformation(extent={{-48,45},{-28,65}})));
  Components.ReactionWheelYUnit wheelY(config=designConfig.wheelY,initialSpeed=initialConditions.wheelSpeed[2]) annotation(Placement(transformation(extent={{-24,45},{-4,65}})));
  Components.ReactionWheelZUnit wheelZ(config=designConfig.wheelZ,initialSpeed=initialConditions.wheelSpeed[3]) annotation(Placement(transformation(extent={{0,45},{20,65}})));
  Components.ReactionWheelSUnit wheelS(config=designConfig.wheelS,initialSpeed=initialConditions.wheelSpeed[4]) annotation(Placement(transformation(extent={{24,45},{44,65}})));
  Components.StarTrackerYUnit starY (config=designConfig.starY)annotation(Placement(transformation(extent={{-84,-18},{-64,2}})));
  Components.StarTrackerZUnit starZ (config=designConfig.starZ)annotation(Placement(transformation(extent={{-56,-18},{-36,2}})));
  Components.RateGyroUnit yh50 (config=designConfig.rateGyro)annotation(Placement(transformation(extent={{-28,-18},{-8,2}})));
  Components.MEMSIMUUnit mems (config=designConfig.memsIMU)annotation(Placement(transformation(extent={{0,-18},{20,2}})));
  Components.MagnetometerUnit magnetometer (config=designConfig.magnetometer)annotation(Placement(transformation(extent={{28,-18},{48,2}})));
  Components.SunSensorUnit sunSensor (config=designConfig.sunSensor)annotation(Placement(transformation(extent={{56,-18},{76,2}})));
  Components.MagnetorquerUnit magnetorquer (config=designConfig.magnetorquer)annotation(Placement(transformation(extent={{55,45},{75,65}})));
equation
  connect(power,computer.power) annotation(Line(points={{0,100},{0,88},{-86,88},{-86,57},{-83,57}},color={0,0,255}));
  connect(power,wheelX.power) annotation(Line(points={{0,100},{0,88},{-51,88},{-51,57},{-48,57}},color={0,0,255}));
  connect(power,wheelY.power) annotation(Line(points={{0,100},{0,88},{-27,88},{-27,57},{-24,57}},color={0,0,255}));
  connect(power,wheelZ.power) annotation(Line(points={{0,100},{0,88},{-3,88},{-3,57},{0,57}},color={0,0,255}));
  connect(power,wheelS.power) annotation(Line(points={{0,100},{0,88},{21,88},{21,57},{24,57}},color={0,0,255}));
  connect(power,starY.power) annotation(Line(points={{0,100},{88,100},{88,22},{-87,22},{-87,-6},{-84,-6}},color={0,0,255}));
  connect(power,starZ.power) annotation(Line(points={{0,100},{88,100},{88,22},{-59,22},{-59,-6},{-56,-6}},color={0,0,255}));
  connect(power,yh50.power) annotation(Line(points={{0,100},{88,100},{88,22},{-31,22},{-31,-6},{-28,-6}},color={0,0,255}));
  connect(power,mems.power) annotation(Line(points={{0,100},{88,100},{88,22},{-3,22},{-3,-6},{0,-6}},color={0,0,255}));
  connect(power,magnetometer.power) annotation(Line(points={{0,100},{88,100},{88,22},{25,22},{25,-6},{28,-6}},color={0,0,255}));
  connect(power,sunSensor.power) annotation(Line(points={{0,100},{88,100},{88,22},{53,22},{53,-6},{56,-6}},color={0,0,255}));
  connect(power,magnetorquer.power) annotation(Line(points={{0,100},{0,88},{52,88},{52,57},{55,57}},color={0,0,255}));
  connect(thermal,computer.thermal) annotation(Line(points={{0,-100},{0,-88},{86,-88},{86,30},{-73,30},{-73,45}},color={191,0,0}));
  connect(thermal,wheelX.thermal) annotation(Line(points={{0,-100},{0,-88},{86,-88},{86,30},{-38,30},{-38,45}},color={191,0,0}));
  connect(thermal,wheelY.thermal) annotation(Line(points={{0,-100},{0,-88},{86,-88},{86,30},{-14,30},{-14,45}},color={191,0,0}));
  connect(thermal,wheelZ.thermal) annotation(Line(points={{0,-100},{0,-88},{86,-88},{86,30},{10,30},{10,45}},color={191,0,0}));
  connect(thermal,wheelS.thermal) annotation(Line(points={{0,-100},{0,-88},{86,-88},{86,30},{34,30},{34,45}},color={191,0,0}));
  connect(thermal,starY.thermal) annotation(Line(points={{0,-100},{0,-88},{86,-88},{86,-36},{-74,-36},{-74,-18}},color={191,0,0}));
  connect(thermal,starZ.thermal) annotation(Line(points={{0,-100},{0,-88},{86,-88},{86,-36},{-46,-36},{-46,-18}},color={191,0,0}));
  connect(thermal,yh50.thermal) annotation(Line(points={{0,-100},{0,-88},{86,-88},{86,-36},{-18,-36},{-18,-18}},color={191,0,0}));
  connect(thermal,mems.thermal) annotation(Line(points={{0,-100},{0,-88},{86,-88},{86,-36},{10,-36},{10,-18}},color={191,0,0}));
  connect(thermal,magnetometer.thermal) annotation(Line(points={{0,-100},{0,-88},{86,-88},{86,-36},{38,-36},{38,-18}},color={191,0,0}));
  connect(thermal,sunSensor.thermal) annotation(Line(points={{0,-100},{0,-88},{86,-88},{86,-36},{66,-36},{66,-18}},color={191,0,0}));
  connect(thermal,magnetorquer.thermal) annotation(Line(points={{0,-100},{0,-88},{86,-88},{86,30},{65,30},{65,45}},color={191,0,0}));
  connect(mechanical,computer.mechanical) annotation(Line(points={{-102,0},{-90,0},{-90,82},{-73,82},{-73,65}},color={95,95,95},thickness=0.5));
  connect(mechanical,wheelX.mechanical) annotation(Line(points={{-102,0},{-90,0},{-90,82},{-38,82},{-38,65}},color={95,95,95},thickness=0.5));
  connect(mechanical,wheelY.mechanical) annotation(Line(points={{-102,0},{-90,0},{-90,82},{-14,82},{-14,65}},color={95,95,95},thickness=0.5));
  connect(mechanical,wheelZ.mechanical) annotation(Line(points={{-102,0},{-90,0},{-90,82},{10,82},{10,65}},color={95,95,95},thickness=0.5));
  connect(mechanical,wheelS.mechanical) annotation(Line(points={{-102,0},{-90,0},{-90,82},{34,82},{34,65}},color={95,95,95},thickness=0.5));
  connect(mechanical,starY.mechanical) annotation(Line(points={{-102,0},{-90,0},{-90,18},{-74,18},{-74,2}},color={95,95,95},thickness=0.5));
  connect(mechanical,starZ.mechanical) annotation(Line(points={{-102,0},{-90,0},{-90,18},{-46,18},{-46,2}},color={95,95,95},thickness=0.5));
  connect(mechanical,yh50.mechanical) annotation(Line(points={{-102,0},{-90,0},{-90,18},{-18,18},{-18,2}},color={95,95,95},thickness=0.5));
  connect(mechanical,mems.mechanical) annotation(Line(points={{-102,0},{-90,0},{-90,18},{10,18},{10,2}},color={95,95,95},thickness=0.5));
  connect(mechanical,magnetometer.mechanical) annotation(Line(points={{-102,0},{-90,0},{-90,18},{38,18},{38,2}},color={95,95,95},thickness=0.5));
  connect(mechanical,sunSensor.mechanical) annotation(Line(points={{-102,0},{-90,0},{-90,18},{66,18},{66,2}},color={95,95,95},thickness=0.5));
  connect(mechanical,magnetorquer.mechanical) annotation(Line(points={{-102,0},{-90,0},{-90,82},{65,82},{65,65}},color={95,95,95},thickness=0.5));
  connect(environment,computer.environment) annotation(Line(points={{-102,65},{-92,65},{-92,50},{-83,50}},color={0,110,70}));
  connect(environment,starY.environment) annotation(Line(points={{-102,65},{-92,65},{-92,-46},{-87,-46},{-87,-13},{-84,-13}},color={0,110,70}));
  connect(environment,starZ.environment) annotation(Line(points={{-102,65},{-92,65},{-92,-46},{-59,-46},{-59,-13},{-56,-13}},color={0,110,70}));
  connect(environment,mems.environment) annotation(Line(points={{-102,65},{-92,65},{-92,-46},{-3,-46},{-3,-13},{0,-13}},color={0,110,70}));
  connect(environment,magnetometer.environment) annotation(Line(points={{-102,65},{-92,65},{-92,-46},{25,-46},{25,-13},{28,-13}},color={0,110,70}));
  connect(environment,sunSensor.environment) annotation(Line(points={{-102,65},{-92,65},{-92,-46},{53,-46},{53,-13},{56,-13}},color={0,110,70}));
  connect(information,computer.information) annotation(Line(points={{102,0},{90,0},{90,28},{-60,28},{-60,54},{-63,54}},color={0,90,180}));
  connect(information,wheelX.information) annotation(Line(points={{102,0},{90,0},{90,28},{-25,28},{-25,54},{-28,54}},color={0,90,180}));
  connect(information,wheelY.information) annotation(Line(points={{102,0},{90,0},{90,28},{-1,28},{-1,54},{-4,54}},color={0,90,180}));
  connect(information,wheelZ.information) annotation(Line(points={{102,0},{90,0},{90,28},{23,28},{23,54},{20,54}},color={0,90,180}));
  connect(information,wheelS.information) annotation(Line(points={{102,0},{90,0},{90,28},{47,28},{47,54},{44,54}},color={0,90,180}));
  connect(information,starY.information) annotation(Line(points={{102,0},{90,0},{90,-26},{-61,-26},{-61,-9},{-64,-9}},color={0,90,180}));
  connect(information,starZ.information) annotation(Line(points={{102,0},{90,0},{90,-26},{-33,-26},{-33,-9},{-36,-9}},color={0,90,180}));
  connect(information,yh50.information) annotation(Line(points={{102,0},{90,0},{90,-26},{-5,-26},{-5,-9},{-8,-9}},color={0,90,180}));
  connect(information,mems.information) annotation(Line(points={{102,0},{90,0},{90,-26},{23,-26},{23,-9},{20,-9}},color={0,90,180}));
  connect(information,magnetometer.information) annotation(Line(points={{102,0},{90,0},{90,-26},{51,-26},{51,-9},{48,-9}},color={0,90,180}));
  connect(information,sunSensor.information) annotation(Line(points={{102,0},{90,0},{90,-26},{79,-26},{79,-9},{76,-9}},color={0,90,180}));
  connect(information,magnetorquer.information) annotation(Line(points={{102,0},{90,0},{90,28},{78,28},{78,54},{75,54}},color={0,90,180}));
  annotation(
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}),graphics={
      Rectangle(extent={{-84,76},{84,-76}},lineColor={64,72,82},fillColor={242,245,248},fillPattern=FillPattern.Solid,lineThickness=0.75),
      Rectangle(extent={{-28,22},{28,-18}},lineColor={55,85,115},fillColor={218,230,240},fillPattern=FillPattern.Solid,lineThickness=0.75),
      Text(extent={{-24,12},{24,-8}},textString="GNC",textColor={40,65,90}),
      Ellipse(extent={{-68,55},{-38,25}},lineColor={75,85,95},fillColor={232,235,238},fillPattern=FillPattern.Solid),
      Ellipse(extent={{-60,47},{-46,33}},lineColor={75,85,95},fillColor={160,170,180},fillPattern=FillPattern.Solid),
      Ellipse(extent={{38,55},{68,25}},lineColor={75,85,95},fillColor={232,235,238},fillPattern=FillPattern.Solid),
      Ellipse(extent={{46,47},{60,33}},lineColor={75,85,95},fillColor={160,170,180},fillPattern=FillPattern.Solid),
      Ellipse(extent={{-68,-23},{-38,-53}},lineColor={75,85,95},fillColor={232,235,238},fillPattern=FillPattern.Solid),
      Ellipse(extent={{-60,-31},{-46,-45}},lineColor={75,85,95},fillColor={160,170,180},fillPattern=FillPattern.Solid),
      Ellipse(extent={{38,-23},{68,-53}},lineColor={75,85,95},fillColor={232,235,238},fillPattern=FillPattern.Solid),
      Ellipse(extent={{46,-31},{60,-45}},lineColor={75,85,95},fillColor={160,170,180},fillPattern=FillPattern.Solid),
      Text(extent={{-66,53},{-40,27}},textString="RW",textColor={65,72,82}),
      Text(extent={{40,53},{66,27}},textString="RW",textColor={65,72,82}),
      Text(extent={{-66,-25},{-40,-51}},textString="RW",textColor={65,72,82}),
      Text(extent={{40,-25},{66,-51}},textString="RW",textColor={65,72,82}),
      Polygon(points={{-15,55},{0,68},{15,55},{8,44},{-8,44},{-15,55}},lineColor={55,85,115},fillColor={205,220,232},fillPattern=FillPattern.Solid),
      Ellipse(extent={{-5,57},{5,47}},lineColor={55,85,115},fillColor={85,120,150},fillPattern=FillPattern.Solid),
      Text(extent={{-18,45},{18,35}},textString="ST",textColor={55,85,115}),
      Rectangle(extent={{-24,-60},{24,-68}},lineColor={100,80,55},fillColor={225,214,194},fillPattern=FillPattern.Solid),
      Line(points={{-20,-60},{-14,-68},{-8,-60},{-2,-68},{4,-60},{10,-68},{16,-60},{22,-68}},color={100,80,55}),
      Text(extent={{-20,-58},{20,-48}},textString="MTQ",textColor={100,80,55}),
      Line(points={{0,22},{0,34}},color={55,85,115},arrow={Arrow.None,Arrow.Filled}),
      Line(points={{28,2},{38,2}},color={55,85,115},arrow={Arrow.None,Arrow.Filled})}),
    Diagram(coordinateSystem(extent={{-110,-110},{110,110}}),graphics={
      Rectangle(extent={{-88,76},{-56,36}},lineColor={150,158,166},pattern=LinePattern.Dash),
      Text(extent={{-86,74},{-58,68}},textString="CONTROL PROCESSING",textColor={75,82,90}),
      Rectangle(extent={{-53,76},{82,36}},lineColor={150,158,166},pattern=LinePattern.Dash),
      Text(extent={{-51,74},{80,68}},textString="ACTUATION",textColor={75,82,90}),
      Rectangle(extent={{-88,12},{82,-30}},lineColor={150,158,166},pattern=LinePattern.Dash),
      Text(extent={{-86,10},{80,4}},textString="ATTITUDE SENSING",textColor={75,82,90})}),
    Documentation(info="<html><h4>分系统职责</h4><p><b>系统角色：</b>汇集姿态测量、控制计算、四台独立飞轮、磁力矩器和环境接口</p><p><b>1+4+8位置：</b>八个N-System之一；上接四个Overall，下接专业Components</p><h4>白箱组成与连接</h4><p><b>实现：</b>12个专业Components白箱经单组多领域端口连接；四台飞轮保持X/Y/Z/S独立个体</p><p><b>内部设备：</b>computer（GNCComputerUnit）、wheelX（ReactionWheelXUnit）、wheelY（ReactionWheelYUnit）、wheelZ（ReactionWheelZUnit）、wheelS（ReactionWheelSUnit）、starY（StarTrackerYUnit）、starZ（StarTrackerZUnit）、yh50（RateGyroUnit）、mems（MEMSIMUUnit）、magnetometer（MagnetometerUnit）、sunSensor（SunSensorUnit）、magnetorquer（MagnetorquerUnit）</p><p><b>对外端口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、information（InformationPort）、environment（EnvironmentPort）</p><p><b>运行行为：</b>环境姿态驱动星敏、陀螺、MEMS、磁强计和太阳敏；控制计算机给飞轮指令，执行机构机械反作用汇入总体</p><h4>状态与遥测</h4><p><b>关键对象：</b>姿态环境、四轮控制、星敏/陀螺/MEMS/磁强计/太阳敏测量</p><p><b>关键状态：</b>姿态测量、飞轮转速、控制器状态与设备温度</p><p><b>遥测关系：</b>所有传感器与执行机构状态经同一InformationPort进入SAT-S2及状态标志</p><p><b>建模约束：</b>本模型仅含connect语句；所有设备只保留一组信息、热和机械接口，适用时再增加电源或环境接口。</p></html>"));
end GNCSystem;
