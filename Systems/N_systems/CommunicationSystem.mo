within OneSatSim.Systems.N_systems;
model CommunicationSystem "测控数传分系统"
  parameter OneSatSim.Scenarios.DesignConfigRecords.CommunicationDesignConfig designConfig "分系统硬件设计配置";
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent = {{-10, 90}, {10, 110}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent = {{-10, -110}, {10, -90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent = {{-112, -10}, {-92, 10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(origin={102,1},
extent={{-10,-10},{10,10}})));
  Components.RadioReceiverUnit ttc (config=designConfig.ttcReceiver)annotation(Placement(transformation(extent = {{-70, 25}, {-30, 60}})));
  Components.LowRateTelemetryTransmitterUnit baseband (config=designConfig.baseband)annotation(Placement(transformation(extent = {{20, 25}, {60, 60}})));
  Components.XBandTransmitterUnit xband (config=designConfig.xband)annotation(Placement(transformation(extent = {{-70, -55}, {-30, -15}})));
  Components.AntennaUnit antenna (config=designConfig.antenna)annotation(Placement(transformation(extent = {{20, -55}, {60, -20}})));
equation
  connect(power, ttc.power) annotation(Line(points = {{0, 100}, {-86, 100}, {-86, 42.5}, {-70, 42.5}}, color = {0, 0, 255}));
  connect(power, baseband.power) annotation(Line(points = {{0, 100}, {10, 100}, {10, 42.5}, {20, 42.5}}, color = {0, 0, 255}));
  connect(power, xband.power) annotation(Line(points = {{0, 100}, {-86, 100}, {-86, -35}, {-70, -35}}, color = {0, 0, 255}));
  connect(thermal, ttc.thermal) annotation(Line(points = {{0, -100}, {-94, -100}, {-94, 15}, {-50, 15}, {-50, 25}}, color = {191, 0, 0}));
  connect(thermal, baseband.thermal) annotation(Line(points = {{0, -100}, {92, -100}, {92, 15}, {40, 15}, {40, 25}}, color = {191, 0, 0}));
  connect(thermal, xband.thermal) annotation(Line(points = {{0, -100}, {-50, -100}, {-50, -55}}, color = {191, 0, 0}));
  connect(thermal, antenna.thermal) annotation(Line(points = {{0, -100}, {40, -100}, {40, -55}}, color = {191, 0, 0}));
  connect(mechanical, ttc.mechanical) annotation(Line(points = {{-102, 0}, {-92, 0}, {-92, 72}, {-50, 72}, {-50, 60}}, color = {95, 95, 95}, thickness = 0.5));
  connect(mechanical, baseband.mechanical) annotation(Line(points = {{-102, 0}, {-92, 0}, {-92, 72}, {40, 72}, {40, 60}}, color = {95, 95, 95}, thickness = 0.5));
  connect(mechanical, xband.mechanical) annotation(Line(points = {{-102, 0}, {-82, 0}, {-82, -8}, {-50, -8}, {-50, -15}}, color = {95, 95, 95}, thickness = 0.5));
  connect(mechanical, antenna.mechanical) annotation(Line(points = {{-102, 0}, {-82, 0}, {-82, -8}, {40, -8}, {40, -20}}, color = {95, 95, 95}, thickness = 0.5));
  connect(information, ttc.information) annotation(Line(origin={0,0},
points={{102,1},{88,1},{88,14},{-22,14},{-22,42.5},{-29.6,42.5}},
color={0,90,180}));
  connect(information, baseband.information) annotation(Line(origin={0,0},
points={{102,1},{88,1},{88,42.5},{60.4,42.5}},
color={0,90,180}));
  connect(information, xband.information) annotation(Line(origin={0,0},
points={{102,1},{88,1},{88,-68},{-22,-68},{-22,-29},{-29.6,-29}},
color={0,90,180}));
  connect(information, antenna.information) annotation(Line(origin={0,0},
points={{102,1},{88,1},{88,-37.5},{60.4,-37.5}},
color={0,90,180}));
  annotation(
    Icon(coordinateSystem(extent={{-110,-110},{110,110}},
grid={2,2}),graphics = {Rectangle(origin={0,1},
lineColor={30,90,145},
fillColor={235,244,250},
fillPattern=FillPattern.Solid,
extent={{-94,93},{94,-93}}), Rectangle(origin={-49,16},
lineColor={40,105,155},
fillColor={205,227,240},
fillPattern=FillPattern.Solid,
extent={{-21,32},{21,-32}}), Text(origin={-49,27},
lineColor={30,80,120},
extent={{-18,9},{18,-9}},
textString="TTC",
textColor={30,80,120}), Text(origin={-49,4},
lineColor={30,80,120},
extent={{-18,8},{18,-8}},
textString="RX",
textColor={30,80,120}), Rectangle(origin={0,16},
lineColor={40,105,155},
fillColor={220,235,245},
fillPattern=FillPattern.Solid,
extent={{-18,32},{18,-32}}), Line(origin={0,0},
points={{-12,28},{12,28}},
color={40,105,155},
thickness=1), Line(origin={0,0},
points={{-12,16},{12,16}},
color={40,105,155},
thickness=1), Line(origin={0,0},
points={{-12,4},{12,4}},
color={40,105,155},
thickness=1), Text(origin={0,-7},
lineColor={30,80,120},
extent={{-16,-5},{16,5}},
textString="BB",
textColor={30,80,120}), Rectangle(origin={43,16},
lineColor={40,105,155},
fillColor={190,218,236},
fillPattern=FillPattern.Solid,
extent={{-15,32},{15,-32}}), Text(origin={43,22},
lineColor={30,80,120},
extent={{-13,8},{13,-8}},
textString="X",
textColor={30,80,120}), Text(origin={43,2},
lineColor={30,80,120},
extent={{-13,8},{13,-8}},
textString="TX",
textColor={30,80,120}), Polygon(origin={0,0},
lineColor={30,90,145},
fillColor={150,195,220},
fillPattern=FillPattern.Solid,
points={{62,16},{78,30},{78,2},{62,16}}), Line(origin={0,0},
points={{76,16},{88,16}},
color={30,90,145},
thickness=1.2), Line(origin={0,0},
points={{80,16},{98,32}},
color={30,90,145},
thickness=1), Line(origin={0,0},
points={{80,16},{102,16}},
color={30,90,145},
thickness=1), Line(origin={0,0},
points={{80,16},{98,0}},
color={30,90,145},
thickness=1), Text(origin={0,-47},
lineColor={30,80,120},
extent={{-76,-11},{76,11}},
textString="COMMUNICATION",
textColor={30,80,120}), Text(origin={0,-75},
lineColor={70,95,115},
extent={{-72,-9},{72,9}},
textString="TTC / TM / X-BAND",
textColor={70,95,115})}),
    Diagram(
      coordinateSystem(extent = {{-110, -110}, {110, 110}}),
      graphics = {
        Rectangle(
          extent = {{-78, 68}, {70, 18}},
          lineColor = {110, 150, 175},
          fillColor = {245, 249, 252},
          fillPattern = FillPattern.Solid),
        Text(
          extent = {{-74, 67}, {66, 60}},
          lineColor = {55, 95, 125},
          textString = "TELECOMMAND & LOW-RATE TELEMETRY"),
        Rectangle(
          extent = {{-78, -10}, {70, -66}},
          lineColor = {110, 150, 175},
          fillColor = {245, 249, 252},
          fillPattern = FillPattern.Solid),
        Text(
          extent = {{-74, -11}, {66, -18}},
          lineColor = {55, 95, 125},
          textString = "HIGH-RATE DOWNLINK & RF FRONT END"),
        Text(
          extent = {{-108, 106}, {-78, 96}},
          lineColor = {0, 0, 255},
          textString = "POWER"),
        Text(
          extent = {{-108, -92}, {-76, -102}},
          lineColor = {191, 0, 0},
          textString = "THERMAL"),
        Text(
          extent = {{70, 8}, {108, -2}},
          lineColor = {0, 90, 180},
          textString = "DATA BUS")
      }),
    Documentation(info = "<html><h4>分系统职责</h4><p><b>系统角色：</b>集成测控接收、低速遥测基带、X波段数传发射和天线</p><p><b>1+4+8位置：</b>八个N-System之一；上接四个Overall，下接专业Components</p><h4>白箱组成与连接</h4><p><b>实现：</b>四个Components共享一组InformationPort并连接公共热/机械端；没有独立遥测数据旁路</p><p><b>内部设备：</b>ttc（RadioReceiverUnit）、baseband（LowRateTelemetryTransmitterUnit）、xband（XBandTransmitterUnit）、antenna（AntennaUnit）</p><p><b>对外端口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、information（InformationPort）</p><p><b>运行行为：</b>接收机报告测控状态；下行任务使能基带与X波段发射机，并从记录器读取载荷数据</p><h4>状态与遥测</h4><p><b>关键对象：</b>TTC/Baseband状态、X波段门控、读出率和通信热负载</p><p><b>关键状态：</b>接收/发射状态、PA与基带温度、载荷读出率</p><p><b>遥测关系：</b>OBC已形成的onboardTelemetry沿统一InformationPort到达通信设备并作为总体输出；地面站窗口改变任务/功耗，不门控星上工程量保持</p><p><b>建模约束：</b>本模型仅含connect语句；所有设备只保留一组信息、热和机械接口，适用时再增加电源或环境接口。</p></html>"
)
    );
end CommunicationSystem;
