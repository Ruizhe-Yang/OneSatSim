within NISSA_12UCubeSat.Systems.N_systems;
model ThermalControlSystem "热控分系统"
  parameter NISSA_12UCubeSat.Scenarios.DesignConfigRecords.ThermalControlDesignConfig designConfig "分系统硬件设计配置";
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-112,-10},{-92,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{92,-10},{112,10}})));
  Components.ThermalControllerUnit controller (config=designConfig.controller)annotation(Placement(transformation(extent={{-78,-5},{-28,45}})));
  Components.HeaterRadiatorUnit heaters (config=designConfig.heaters)annotation(Placement(transformation(extent={{28,-5},{78,45}})));
equation
  connect(power,controller.power) annotation(Line(points={{0,100},{-90,100},{-90,22.5},{-78,22.5}},color={0,0,255}));
  connect(power,heaters.power) annotation(Line(points={{0,100},{90,100},{90,72},{14,72},{14,22.5},{28,22.5}},color={0,0,255}));
  connect(thermal,controller.thermal) annotation(Line(points={{0,-100},{-53,-100},{-53,-5}},color={191,0,0}));
  connect(thermal,heaters.thermal) annotation(Line(points={{0,-100},{53,-100},{53,-5}},color={191,0,0}));
  connect(mechanical,controller.mechanical) annotation(Line(points={{-102,0},{-94,0},{-94,66},{-53,66},{-53,45}},color={95,95,95},thickness=0.5));
  connect(mechanical,heaters.mechanical) annotation(Line(points={{-102,0},{-94,0},{-94,82},{53,82},{53,45}},color={95,95,95},thickness=0.5));
  connect(information,controller.information) annotation(Line(points={{102,0},{94,0},{94,-38},{-14,-38},{-14,20},{-28,20}},color={0,90,180}));
  connect(information,heaters.information) annotation(Line(points={{102,0},{94,0},{94,20},{78,20}},color={0,90,180}));
  annotation(
    Icon(
      coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),
      graphics={
        Rectangle(extent={{-96,82},{96,-82}},lineColor={190,70,40},
          fillColor={253,243,239},fillPattern=FillPattern.Solid),

        Rectangle(extent={{-72,48},{-22,-32}},lineColor={125,95,90},
          fillColor={247,247,247},fillPattern=FillPattern.Solid),
        Rectangle(extent={{-64,38},{-30,18}},lineColor={190,70,40},
          fillColor={242,205,192},fillPattern=FillPattern.Solid),
        Line(points={{-58,10},{-52,4},{-46,10},{-40,4},{-34,10}},
          color={190,70,40},thickness=1.0),
        Line(points={{-47,18},{-47,34}},color={125,95,90},thickness=0.5),
        Text(extent={{-69,-8},{-25,-24}},textString="TCB",
          lineColor={125,75,60}),

        Rectangle(extent={{12,48},{72,-32}},lineColor={190,70,40},
          fillColor={255,250,247},fillPattern=FillPattern.Solid),
        Line(points={{22,30},{30,22},{38,30},{46,22},{54,30},{62,22}},
          color={225,95,45},thickness=2),
        Line(points={{22,10},{30,2},{38,10},{46,2},{54,10},{62,2}},
          color={225,95,45},thickness=2),
        Line(points={{22,-10},{30,-18},{38,-10},{46,-18},{54,-10},{62,-18}},
          color={225,95,45},thickness=2),
        Line(points={{66,34},{66,-20}},color={135,135,135},thickness=1),
        Line(points={{70,34},{70,-20}},color={135,135,135},thickness=1),

        Line(points={{-20,8},{10,8}},color={190,70,40},thickness=1),
        Polygon(points={{10,8},{2,13},{2,3},{10,8}},
          lineColor={190,70,40},fillColor={190,70,40},
          fillPattern=FillPattern.Solid),

        Text(extent={{-88,-78},{88,-60}},textString="THERMAL CONTROL",
          lineColor={155,65,45})}),
    Diagram(
      coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),
      graphics={
        Rectangle(extent={{-92,58},{-12,-26}},lineColor={208,162,145},
          fillColor={254,248,246},fillPattern=FillPattern.Solid),
        Text(extent={{-90,57},{-14,47}},textString="THERMAL CONTROL & DECISION",
          lineColor={155,75,55}),
        Text(extent={{-88,-16},{-16,-24}},textString="Threshold / hysteresis control",
          lineColor={105,105,105}),

        Rectangle(extent={{12,58},{92,-26}},lineColor={224,174,135},
          fillColor={255,250,244},fillPattern=FillPattern.Solid),
        Text(extent={{14,57},{90,47}},textString="14-CHANNEL HEATER / RADIATOR NETWORK",
          lineColor={175,85,45}),
        Text(extent={{16,-16},{88,-24}},textString="Resistive heating and heat rejection",
          lineColor={105,105,105}),

        Text(extent={{-94,92},{-52,84}},textString="MECHANICAL MOUNT",
          lineColor={95,95,95}),
        Text(extent={{48,-86},{96,-78}},textString="COMMON THERMAL NETWORK",
          lineColor={170,45,35}),
        Text(extent={{50,-46},{103,-54}},textString="STATUS / COMMAND",
          lineColor={0,90,180})}),
    Documentation(info="<html><h4>分系统职责</h4><p><b>系统角色：</b>连接热控控制器与14路加热/散热执行网络</p><p><b>1+4+8位置：</b>八个N-System之一；上接四个Overall，下接专业Components</p><h4>白箱组成与连接</h4><p><b>实现：</b>ThermalControllerUnit和HeaterRadiatorUnit共享单组热、机械、信息端口，前者决策、后者执行</p><p><b>内部设备：</b>controller（ThermalControllerUnit）、heaters（HeaterRadiatorUnit）</p><p><b>对外端口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、information（InformationPort）</p><p><b>运行行为：</b>关键热敏驱动回差逻辑，实际通道状态控制电阻加热并影响公共热网</p><h4>状态与遥测</h4><p><b>关键对象：</b>14路回差、24路通道映射、加热功率和热端口</p><p><b>关键状态：</b>回差状态、开关状态、热控板和舱板温度</p><p><b>遥测关系：</b>TCB-S0集中呈现通道状态、电流、上下阈值与热敏温度</p><p><b>建模约束：</b>本模型仅含connect语句；所有设备只保留一组信息、热和机械接口，适用时再增加电源或环境接口。</p></html>"));
end ThermalControlSystem;
