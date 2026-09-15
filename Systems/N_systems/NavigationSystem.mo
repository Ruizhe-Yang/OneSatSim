within OneSatSim.Systems.N_systems;
model NavigationSystem "导航分系统"
  parameter OneSatSim.Scenarios.DesignConfigRecords.NavigationDesignConfig designConfig "分系统硬件设计配置";
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-112,-10},{-92,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{92,-10},{112,10}})));
  Foundation.Interfaces.EnvironmentPort environment annotation(Placement(transformation(extent={{-112,55},{-92,75}})));
  Components.GPSReceiverUnit gnss (config=designConfig.gnss)annotation(Placement(transformation(extent={{-30,-25},{30,25}})));
equation
  connect(power,gnss.power) annotation(Line(points={{0,100},{-62,100},{-62,12.5},{-30,12.5}},color={0,0,255}));
  connect(thermal,gnss.thermal) annotation(Line(points={{0,-100},{0,-25}},color={191,0,0}));
  connect(mechanical,gnss.mechanical) annotation(Line(points={{-102,0},{-72,0},{-72,52},{0,52},{0,25}},color={95,95,95},thickness=0.5));
  connect(information,gnss.information) annotation(Line(points={{102,0},{30,0}},color={0,90,180}));
  connect(environment,gnss.environment) annotation(Line(points={{-102,65},{-82,65},{-82,-12.5},{-30,-12.5}},color={0,110,70}));
  annotation(
    Icon(
      coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),
      graphics={
        Rectangle(extent={{-96,82},{96,-82}},lineColor={35,100,125},
          fillColor={238,248,249},fillPattern=FillPattern.Solid),
        Rectangle(extent={{-18,56},{18,40}},lineColor={35,100,125},
          fillColor={90,166,177},fillPattern=FillPattern.Solid),
        Rectangle(extent={{-48,54},{-20,42}},lineColor={35,100,125},
          fillColor={201,229,233},fillPattern=FillPattern.Solid),
        Rectangle(extent={{20,54},{48,42}},lineColor={35,100,125},
          fillColor={201,229,233},fillPattern=FillPattern.Solid),
        Line(points={{0,40},{0,24}},color={35,100,125},thickness=0.75),
        Line(points={{-35,36},{-16,22}},color={80,145,155},thickness=0.5),
        Line(points={{35,36},{16,22}},color={80,145,155},thickness=0.5),
        Line(points={{-48,28},{-22,16}},color={80,145,155},thickness=0.5),
        Line(points={{48,28},{22,16}},color={80,145,155},thickness=0.5),
        Rectangle(extent={{-30,22},{30,-12}},lineColor={35,100,125},
          fillColor={255,255,255},fillPattern=FillPattern.Solid),
        Text(extent={{-26,16},{26,-6}},textString="GNSS",lineColor={35,100,125}),
        Ellipse(extent={{-24,-20},{24,-58}},lineColor={35,100,125},
          fillColor={224,241,244},fillPattern=FillPattern.Solid),
        Line(points={{-20,-39},{20,-39}},color={80,145,155}),
        Line(points={{0,-20},{0,-58}},color={80,145,155}),
        Ellipse(extent={{-4,-33},{4,-41}},lineColor={35,100,125},
          fillColor={35,100,125},fillPattern=FillPattern.Solid),
        Text(extent={{-88,-78},{88,-60}},textString="GNSS NAV",
          lineColor={35,100,125})}),
    Diagram(
      coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),
      graphics={
        Rectangle(extent={{-50,40},{50,-40}},lineColor={150,180,190},
          fillColor={247,251,252},fillPattern=FillPattern.Solid),
        Text(extent={{-50,48},{50,38}},textString="GNSS NAVIGATION RECEIVER",
          lineColor={45,95,115}),
        Text(extent={{-105,86},{-58,74}},textString="ORBIT / RF ENVIRONMENT",
          lineColor={0,110,70}),
        Text(extent={{56,18},{104,8}},textString="POSITION • VELOCITY • FIX",
          lineColor={0,90,180}),
        Text(extent={{-48,-48},{48,-58}},
          textString="Navigation state generation and onboard distribution",
          lineColor={95,95,95})}),
    Documentation(info="<html><h4>分系统职责</h4><p><b>系统角色：</b>由GNSS接收机形成轨道位置、速度和定位有效状态</p><p><b>1+4+8位置：</b>八个N-System之一；上接四个Overall，下接专业Components</p><h4>白箱组成与连接</h4><p><b>实现：</b>单个GPSReceiverUnit通过环境、信息、热和机械端口接入四个总体域</p><p><b>内部设备：</b>gnss（GPSReceiverUnit）</p><p><b>对外端口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、information（InformationPort）、environment（EnvironmentPort）</p><p><b>运行行为：</b>轨道环境为导航接收机提供位置速度，接收机转换为星上导航状态</p><h4>状态与遥测</h4><p><b>关键对象：</b>轨道位置速度、定位有效性和接收机板级负载</p><p><b>关键状态：</b>导航测量、定位状态和接收机温度</p><p><b>遥测关系：</b>GNSS position、velocity和fix经InformationPort进入SAT-S2与状态标志</p><p><b>建模约束：</b>本模型仅含connect语句；所有设备只保留一组信息、热和机械接口，适用时再增加电源或环境接口。</p></html>"));
end NavigationSystem;
