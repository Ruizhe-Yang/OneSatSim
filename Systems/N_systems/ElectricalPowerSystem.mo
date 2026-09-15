within OneSatSim.Systems.N_systems;
model ElectricalPowerSystem "电源分系统"
  parameter OneSatSim.Scenarios.DesignConfigRecords.EpsDesignConfig designConfig "分系统硬件设计配置";
  parameter OneSatSim.Scenarios.InitialConditionConfig initialConditions "场景初始条件";
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent = {{-10, 90}, {10, 110}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent = {{-10, -110}, {10, -90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent = {{-112, -10}, {-92, 10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent = {{92, -10}, {112, 10}})));
  Foundation.Interfaces.EnvironmentPort environment annotation(Placement(transformation(extent = {{-112, 55}, {-92, 75}})));
  Components.BodyMountedSolarArrayPlusXUnit solarArrayPlusX (config=designConfig.solarArrayPlusX)annotation(Placement(transformation(extent = {{-88, 34}, {-58, 64}})));
  Components.BodyMountedSolarArrayPlusYUnit solarArrayPlusY (config=designConfig.solarArrayPlusY)annotation(Placement(transformation(extent = {{-48, 34}, {-18, 64}})));
  Components.BodyMountedSolarArrayMinusXUnit solarArrayMinusX (config=designConfig.solarArrayMinusX)annotation(Placement(transformation(extent = {{-8, 34}, {22, 64}})));
  Components.BatteryUnit battery(config=designConfig.battery,initialSOC=initialConditions.batterySOC,initialCellTemperature=initialConditions.batteryCellTemperature,initialEnclosureTemperature=initialConditions.batteryEnclosureTemperature) annotation(Placement(transformation(extent = {{-55, -48}, {-20, -13}})));
  Components.PowerConditioningUnit pcdu(config=designConfig.pcdu,initialBoardTemperature=initialConditions.pcduBoardTemperature) annotation(Placement(transformation(extent = {{20, -48}, {60, -8}})));
protected
  Modelica.Electrical.Analog.Sensors.CurrentSensor sourceBusCurrent
    "Source-side current from solar-array/battery raw bus into PCDU; not regulated 12 V load-bus telemetry" annotation(Placement(transformation(extent = {{30, 55}, {50, 75}})));
equation
  connect(solarArrayPlusX.sourcePower,solarArrayPlusY.sourcePower) annotation(Line(points={{-58,49},{-18,49}},color={0,0,255}));
  connect(solarArrayPlusY.sourcePower,solarArrayMinusX.sourcePower) annotation(Line(points={{-18,49},{22,49}},color={0,0,255}));
  connect(solarArrayMinusX.sourcePower,battery.sourcePower) annotation(Line(points={{22,49},{28,49},{28,-60},{-62,-60},{-62,-30.5},{-55,-30.5}},color={0,0,255}));
  connect(power, pcdu.regulatedPower) annotation(Line(points = {{0, 100}, {92, 100}, {92, -56}, {14, -56}, {14, -28}, {20, -28}}, color = {0, 0, 255}));
  connect(battery.sourcePower.p,sourceBusCurrent.p) annotation(Line(points={{-55,-30.5},{-62,-30.5},{-62,75},{24,75},{24,65},{30,65}},color={0,0,255}));
  connect(sourceBusCurrent.n, pcdu.rawSource.p) annotation(Line(points = {{50, 65}, {54, 65}, {54, 30}, {76, 30}, {76, -15}, {60, -15}}, color = {0, 0, 255}));
  connect(battery.sourcePower.n,pcdu.rawSource.n) annotation(Line(points={{-55,-30.5},{-62,-30.5},{-62,78},{80,78},{80,36},{70,36},{70,-15},{60,-15}},color={0,0,255}));
  connect(thermal, solarArrayPlusX.thermal) annotation(Line(points = {{0, -100}, {-96, -100}, {-96, 28}, {-73, 28}, {-73, 34}}, color = {191, 0, 0}));
  connect(thermal, solarArrayPlusY.thermal) annotation(Line(points = {{0, -100}, {-56, -100}, {-56, 24}, {-33, 24}, {-33, 34}}, color = {191, 0, 0}));
  connect(thermal, solarArrayMinusX.thermal) annotation(Line(points = {{0, -100}, {12, -100}, {12, 20}, {7, 20}, {7, 34}}, color = {191, 0, 0}));
  connect(thermal, battery.thermal) annotation(Line(points = {{0, -100}, {-37.5, -100}, {-37.5, -48}}, color = {191, 0, 0}));
  connect(thermal, pcdu.thermal) annotation(Line(points = {{0, -100}, {40, -100}, {40, -48}}, color = {191, 0, 0}));
  connect(mechanical, solarArrayPlusX.mechanical) annotation(Line(points = {{-102, 0}, {-98, 0}, {-98, 90}, {-73, 90}, {-73, 64}}, color = {95, 95, 95}, thickness = 0.5));
  connect(mechanical, solarArrayPlusY.mechanical) annotation(Line(points = {{-102, 0}, {-98, 0}, {-98, 90}, {-33, 90}, {-33, 64}}, color = {95, 95, 95}, thickness = 0.5));
  connect(mechanical, solarArrayMinusX.mechanical) annotation(Line(points = {{-102, 0}, {-98, 0}, {-98, 90}, {7, 90}, {7, 64}}, color = {95, 95, 95}, thickness = 0.5));
  connect(mechanical, battery.mechanical) annotation(Line(points = {{-102, 0}, {-94, 0}, {-37.5, 0}, {-37.5, -13}}, color = {95, 95, 95}, thickness = 0.5));
  connect(mechanical, pcdu.mechanical) annotation(Line(points = {{-102, 0}, {-94, 0}, {-94, 8}, {40, 8}, {40, -8}}, color = {95, 95, 95}, thickness = 0.5));
  connect(environment, solarArrayPlusX.environment) annotation(Line(points = {{-102, 65}, {-96, 65}, {-96, 74}, {-94, 74}, {-94, 56.5}, {-88, 56.5}}, color = {0, 110, 70}));
  connect(environment, solarArrayPlusY.environment) annotation(Line(points = {{-102, 65}, {-96, 65}, {-96, 74}, {-54, 74}, {-54, 56.5}, {-48, 56.5}}, color = {0, 110, 70}));
  connect(environment, solarArrayMinusX.environment) annotation(Line(points = {{-102, 65}, {-96, 65}, {-96, 74}, {-14, 74}, {-14, 56.5}, {-8, 56.5}}, color = {0, 110, 70}));
  connect(information, solarArrayPlusX.information) annotation(Line(points = {{102, 0}, {94, 0}, {94, 12}, {-94, 12}, {-94, 41.5}, {-88, 41.5}}, color = {0, 90, 180}));
  connect(information, solarArrayPlusY.information) annotation(Line(points = {{102, 0}, {94, 0}, {94, 12}, {-54, 12}, {-54, 41.5}, {-48, 41.5}}, color = {0, 90, 180}));
  connect(information, solarArrayMinusX.information) annotation(Line(points = {{102, 0}, {94, 0}, {94, 12}, {-14, 12}, {-14, 41.5}, {-8, 41.5}}, color = {0, 90, 180}));
  connect(information, battery.information) annotation(Line(points = {{102, 0}, {94, 0}, {94, -62}, {-14, -62}, {-14, -30.5}, {-20, -30.5}}, color = {0, 90, 180}));
  connect(information, pcdu.information) annotation(Line(points = {{102, 0}, {94, 0}, {94, -28}, {60, -28}}, color = {0, 90, 180}));
  annotation(
    Icon(
      coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true),
      graphics = {
        Rectangle(extent = {{-96, 84}, {96, -84}}, lineColor = {35, 85, 145},
          fillColor = {241, 247, 253}, fillPattern = FillPattern.Solid),

        Rectangle(extent = {{-82, 50}, {-42, 14}}, lineColor = {35, 85, 145},
          fillColor = {70, 125, 185}, fillPattern = FillPattern.Solid),
        Rectangle(extent = {{-34, 50}, {6, 14}}, lineColor = {35, 85, 145},
          fillColor = {70, 125, 185}, fillPattern = FillPattern.Solid),
        Rectangle(extent = {{14, 50}, {54, 14}}, lineColor = {35, 85, 145},
          fillColor = {70, 125, 185}, fillPattern = FillPattern.Solid),
        Line(points = {{-69, 50}, {-69, 14}}, color = {220, 235, 250}, thickness = 0.5),
        Line(points = {{-55, 50}, {-55, 14}}, color = {220, 235, 250}, thickness = 0.5),
        Line(points = {{-21, 50}, {-21, 14}}, color = {220, 235, 250}, thickness = 0.5),
        Line(points = {{-7, 50}, {-7, 14}}, color = {220, 235, 250}, thickness = 0.5),
        Line(points = {{27, 50}, {27, 14}}, color = {220, 235, 250}, thickness = 0.5),
        Line(points = {{41, 50}, {41, 14}}, color = {220, 235, 250}, thickness = 0.5),

        Rectangle(extent = {{-60, -8}, {-18, -48}}, lineColor = {80, 120, 70},
          fillColor = {210, 235, 200}, fillPattern = FillPattern.Solid),
        Rectangle(extent = {{-16, -20}, {-10, -36}}, lineColor = {80, 120, 70},
          fillColor = {80, 120, 70}, fillPattern = FillPattern.Solid),
        Text(extent = {{-56, -17}, {-22, -39}}, textString = "BAT",
          lineColor = {65, 105, 60}),

        Rectangle(extent = {{20, -8}, {66, -48}}, lineColor = {185, 115, 45},
          fillColor = {250, 226, 190}, fillPattern = FillPattern.Solid),
        Line(points = {{30, -18}, {56, -18}, {56, -38}, {30, -38}, {30, -18}},
          color = {185, 115, 45}, thickness = 0.8),
        Polygon(points = {{38, -14}, {50, -28}, {43, -28}, {50, -42},
          {34, -25}, {41, -25}, {38, -14}}, lineColor = {185, 115, 45},
          fillColor = {225, 155, 60}, fillPattern = FillPattern.Solid),

        Line(points = {{54, 32}, {76, 32}, {76, -28}, {66, -28}},
          color = {0, 0, 180}, thickness = 1),
        Ellipse(extent = {{70, 26}, {82, 38}}, lineColor = {0, 0, 180},
          fillColor = {225, 235, 250}, fillPattern = FillPattern.Solid),

        Text(extent = {{-88, -79}, {88, -59}}, textString = "ELECTRICAL POWER",
          lineColor = {35, 85, 145})
      }),
    Diagram(
      coordinateSystem(extent = {{-110, -110}, {110, 110}}, preserveAspectRatio = true),
      graphics = {
        Rectangle(extent = {{-94, 70}, {28, 30}}, lineColor = {150, 180, 215},
          fillColor = {247, 251, 255}, fillPattern = FillPattern.Solid),
        Text(extent = {{-92, 69}, {26, 62}}, textString = "SOLAR GENERATION — +X / +Y / -X BODY FACES",
          lineColor = {35, 85, 145}),

        Rectangle(extent = {{26, 92}, {92, 48}}, lineColor = {150, 180, 215},
          fillColor = {248, 251, 255}, fillPattern = FillPattern.Solid),
        Text(extent = {{28, 91}, {90, 84}}, textString = "SOURCE BUS & 12 V SENSING",
          lineColor = {35, 85, 145}),

        Rectangle(extent = {{-62, -54}, {-13, -7}}, lineColor = {165, 195, 150},
          fillColor = {249, 253, 247}, fillPattern = FillPattern.Solid),
        Text(extent = {{-60, -8}, {-15, -15}}, textString = "ENERGY STORAGE",
          lineColor = {70, 115, 65}),

        Rectangle(extent = {{14, -54}, {70, -4}}, lineColor = {220, 175, 120},
          fillColor = {255, 251, 245}, fillPattern = FillPattern.Solid),
        Text(extent = {{16, -5}, {68, -12}}, textString = "POWER CONDITIONING & DISTRIBUTION",
          lineColor = {165, 95, 35}),

        Text(extent = {{-98, 94}, {-53, 86}}, textString = "MECHANICAL MOUNT",
          lineColor = {95, 95, 95}),
        Text(extent = {{-98, 80}, {-57, 73}}, textString = "SOLAR ENVIRONMENT",
          lineColor = {0, 110, 70}),
        Text(extent = {{55, 9}, {104, 2}}, textString = "STATUS / TELEMETRY",
          lineColor = {0, 90, 180}),
        Text(extent = {{45, -91}, {101, -84}}, textString = "COMMON THERMAL NETWORK",
          lineColor = {170, 45, 35})
      }),
    Documentation(info = "<html><h4>分系统职责</h4><p>连接分别安装在+X、+Y、-X三个卫星外表面的体装太阳阵、电池、功率调节单元与总体电气母线，是八个N-System之一。</p><h4>白箱组成与连接</h4><p>五个Components白箱通过SourcePowerPort、PowerPort、ThermalPort、MechanicalPort、InformationPort和EnvironmentPort连接；本模型equation区仅含带Line annotation的connect。</p><h4>两种电流截面</h4><p>sourceBusCurrent位于体装太阳阵/电池原始汇流端到PCDU rawSource之间，仅表示约14至17 V源端电流。它不等于遥测busCurrent[1]；后者由PCDU内部loadBus12Current测量，表示regulated 12 V load-bus total current。</p><h4>外部接口</h4><p>本N-System对外只有一个三轨PowerPort power；原始SourcePowerPort仅在分系统内部互联，不是八个N-System共享负载母线。</p><h4>状态与遥测</h4><p>三面体装太阳阵发电、电池SOC、三路母线和PDB配电状态只经统一InformationPort进入信息总体，最终由总体Observer形成工程遥测。</p></html>"
    ));
end ElectricalPowerSystem;
