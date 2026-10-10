within OneSatSim.Systems.N_systems;
model ElectricalPowerSystem "电源分系统"
  parameter OneSatSim.Scenarios.DesignConfigRecords.EpsDesignConfig designConfig "分系统硬件设计配置";
  parameter OneSatSim.Scenarios.InitialConditionConfig initialConditions "场景初始条件";
  Foundation.Interfaces.PowerPort power  "功率" annotation(Placement(transformation(origin={245,215},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={7.5,98.48},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Foundation.Interfaces.ThermalPort thermal  "热学" annotation(Placement(transformation(origin={15,-235},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={6.10623e-16,-99.52},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(transformation(origin={-385,80},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={-100,2.2},
extent={{-12,-12},{12,12}}),
iconVisible=true));
  Foundation.Interfaces.InformationPort information  "计算/接口量 information" annotation(Placement(transformation(origin={335,15},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={100.48,1.3},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Foundation.Interfaces.EnvironmentPort environment  "外部环境接口或实例" annotation(Placement(transformation(origin={-385,-95},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={-100,-85},
extent={{-12,-12},{12,12}}),
iconVisible=true));
  Components.BodyMountedSolarArrayPlusXUnit solarArrayPlusX (config=designConfig.solarArrayPlusX)  "+X长侧面体装太阳电池组件实例" annotation(Placement(visible=true, transformation(origin={-285,190}, extent={{-50,-50},{50,50}}, rotation=0)));
  Components.BodyMountedSolarArrayPlusYUnit solarArrayPlusY (config=designConfig.solarArrayPlusY)  "+Y长侧面体装双串太阳电池组件实例" annotation(Placement(visible=true, transformation(origin={-285,35}, extent={{-50,-50},{50,50}}, rotation=0)));
  Components.BodyMountedSolarArrayMinusXUnit solarArrayMinusX (config=designConfig.solarArrayMinusX)  "-X长侧面体装太阳电池组件实例" annotation(Placement(visible=true, transformation(origin={-285,-120}, extent={{-50,-50},{50,50}}, rotation=0)));
  Components.BatteryUnit battery(config=designConfig.battery,initialSOC=initialConditions.batterySOC,initialCellTemperature=initialConditions.batteryCellTemperature,initialEnclosureTemperature=initialConditions.batteryEnclosureTemperature)  "四串两并锂离子电池组件实例" annotation(Placement(visible=true, transformation(origin={-90,-95}, extent={{-65,-65},{65,65}}, rotation=0)));
  Components.PowerConditioningUnit pcdu(config=designConfig.pcdu,
    solarNetDeliveryEfficiency={designConfig.solarArrayPlusX.MPPTDeliveryEfficiency,
      designConfig.solarArrayPlusY.MPPTDeliveryEfficiency,
      designConfig.solarArrayMinusX.MPPTDeliveryEfficiency},
    initialBoardTemperature=initialConditions.pcduBoardTemperature)  "电源调节与配电组件实例" annotation(Placement(visible=true, transformation(origin={150,40}, extent={{-90,-90},{90,90}}, rotation=0)));

equation
  connect(solarArrayPlusX.sourcePower,solarArrayPlusY.sourcePower) annotation(Line(points={{-285,237.5},{-285,247.5},{-339.5,247.5},{-339.5,92.5},{-285,92.5},{-285,82.5}}, color={232,93,4}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(solarArrayPlusY.sourcePower,solarArrayMinusX.sourcePower) annotation(Line(points={{-285,82.5},{-285,92.5},{-230.5,92.5},{-230.5,-62.5},{-285,-62.5},{-285,-72.5}}, color={232,93,4}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(solarArrayMinusX.sourcePower,battery.sourcePower) annotation(Line(points={{-285,-72.5},{-285,-23.25},{-90,-23.25},{-90,-33.25}}, color={232,93,4}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power,pcdu.regulatedPower) annotation(Line(points={{245,215},{319,215},{319,135.5},{222,135.5},{222,125.5}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(battery.sourcePower.p,pcdu.rawSource.p) annotation(Line(points={{-360,230},{-100,230}},color={0,0,255},thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(battery.sourcePower.n,pcdu.rawSource.n) annotation(Line(points={{-90,-33.25},{-90,-23.25},{-31,-23.25},{-31,135.5},{78,135.5},{78,125.5}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,solarArrayPlusX.thermal) annotation(Line(points={{15,-235},{-230.5,-235},{-230.5,131.5},{-285,131.5},{-285,141.5}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,solarArrayPlusY.thermal) annotation(Line(points={{15,-235},{-230.5,-235},{-230.5,-23.5},{-285,-23.5},{-285,-13.5}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,solarArrayMinusX.thermal) annotation(Line(points={{15,-235},{-285,-235},{-285,-168.5}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,battery.thermal) annotation(Line(points={{15,-235},{-90,-235},{-90,-158.05}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,pcdu.thermal) annotation(Line(points={{15,-235},{150,-235},{150,-47.3}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,solarArrayPlusX.mechanical) annotation(Line(points={{-385,80},{-339.5,80},{-339.5,230},{-329.5,230}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,solarArrayPlusY.mechanical) annotation(Line(points={{-385,80},{-385,75},{-329.5,75}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,solarArrayMinusX.mechanical) annotation(Line(points={{-385,80},{-385,-80},{-329.5,-80}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,battery.mechanical) annotation(Line(points={{-385,80},{-385,-62.5},{-157.85,-62.5},{-157.85,-95},{-147.85,-95}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,pcdu.mechanical) annotation(Line(points={{-385,80},{-385,92.5},{59.9,92.5},{59.9,40},{69.9,40}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(environment,solarArrayPlusX.environment) annotation(Line(points={{-385,-95},{-385,150},{-329.5,150}}, color={0,166,81}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(environment,solarArrayPlusY.environment) annotation(Line(points={{-385,-95},{-385,-5},{-329.5,-5}}, color={0,166,81}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(environment,solarArrayMinusX.environment) annotation(Line(points={{-385,-95},{-385,-160},{-329.5,-160}}, color={0,166,81}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,solarArrayPlusX.information) annotation(Line(points={{335,15},{335,164},{-230.5,164},{-230.5,190},{-240.5,190}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,solarArrayPlusY.information) annotation(Line(points={{335,15},{335,164},{-230.5,164},{-230.5,35},{-240.5,35}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,solarArrayMinusX.information) annotation(Line(points={{335,15},{335,-168.05},{-230.5,-168.05},{-230.5,-120},{-240.5,-120}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,battery.information) annotation(Line(points={{335,15},{335,-95},{-32.15,-95}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,pcdu.information) annotation(Line(points={{335,15},{335,112},{230.1,112}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info = "<html><h2>电源分系统</h2><p><b>类路径：</b><code>OneSatSim.Systems.N_systems.ElectricalPowerSystem</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>电源分系统</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.SpacecraftSystem\">OneSatSim.Systems.SpacecraftSystem</a> 的 <code>electricalPowerSystem</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>power</code></td><td>Foundation.Interfaces.PowerPort</td><td>public</td><td>按声明/类型合同</td><td>功率</td></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr><tr><td><code>information</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr><tr><td><code>environment</code></td><td>Foundation.Interfaces.EnvironmentPort</td><td>public</td><td>按声明/类型合同</td><td>外部环境接口或实例</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>designConfig</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.EpsDesignConfig</td><td>分系统硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>initialConditions</code></td><td>OneSatSim.Scenarios.InitialConditionConfig</td><td>场景初始条件</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>solarArrayPlusX</code></td><td><a href=\"modelica://OneSatSim.Components.BodyMountedSolarArrayPlusXUnit\">OneSatSim.Components.BodyMountedSolarArrayPlusXUnit</a></td><td>+X长侧面体装太阳电池组件实例</td></tr><tr><td><code>solarArrayPlusY</code></td><td><a href=\"modelica://OneSatSim.Components.BodyMountedSolarArrayPlusYUnit\">OneSatSim.Components.BodyMountedSolarArrayPlusYUnit</a></td><td>+Y长侧面体装双串太阳电池组件实例</td></tr><tr><td><code>solarArrayMinusX</code></td><td><a href=\"modelica://OneSatSim.Components.BodyMountedSolarArrayMinusXUnit\">OneSatSim.Components.BodyMountedSolarArrayMinusXUnit</a></td><td>-X长侧面体装太阳电池组件实例</td></tr><tr><td><code>battery</code></td><td><a href=\"modelica://OneSatSim.Components.BatteryUnit\">OneSatSim.Components.BatteryUnit</a></td><td>四串两并锂离子电池组件实例</td></tr><tr><td><code>pcdu</code></td><td><a href=\"modelica://OneSatSim.Components.PowerConditioningUnit\">OneSatSim.Components.PowerConditioningUnit</a></td><td>电源调节与配电组件实例</td></tr></table><h3>使用边界</h3><p>本工程的轨道环境采用离线固化数据；任务、姿态、电热及信息边界按当前配置和接口使用。已有未完成任务目标与平台状态见根README，不由本次注释更新改写。</p></html>"
    ),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={77,126,172}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Subsystem", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-57.6,-20},{-19.8,30.4}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Rectangle(extent={{-55.2,-17.6},{-47.85,-11}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-54,-16.4},{-49.05,-12.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-55.2,-9.8},{-47.85,-3.2}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-54,-8.6},{-49.05,-4.4}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-55.2,-2},{-47.85,4.6}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-54,-0.8},{-49.05,3.4}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-55.2,5.8},{-47.85,12.4}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-54,7},{-49.05,11.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-55.2,13.6},{-47.85,20.2}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-54,14.8},{-49.05,19}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-55.2,21.4},{-47.85,28}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-54,22.6},{-49.05,26.8}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-46.65,-17.6},{-39.3,-11}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-45.45,-16.4},{-40.5,-12.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-46.65,-9.8},{-39.3,-3.2}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-45.45,-8.6},{-40.5,-4.4}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-46.65,-2},{-39.3,4.6}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-45.45,-0.8},{-40.5,3.4}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-46.65,5.8},{-39.3,12.4}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-45.45,7},{-40.5,11.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-46.65,13.6},{-39.3,20.2}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-45.45,14.8},{-40.5,19}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-46.65,21.4},{-39.3,28}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-45.45,22.6},{-40.5,26.8}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-38.1,-17.6},{-30.75,-11}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-36.9,-16.4},{-31.95,-12.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-38.1,-9.8},{-30.75,-3.2}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-36.9,-8.6},{-31.95,-4.4}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-38.1,-2},{-30.75,4.6}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-36.9,-0.8},{-31.95,3.4}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-38.1,5.8},{-30.75,12.4}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-36.9,7},{-31.95,11.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-38.1,13.6},{-30.75,20.2}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-36.9,14.8},{-31.95,19}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-38.1,21.4},{-30.75,28}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-36.9,22.6},{-31.95,26.8}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-29.55,-17.6},{-22.2,-11}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-28.35,-16.4},{-23.4,-12.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-29.55,-9.8},{-22.2,-3.2}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-28.35,-8.6},{-23.4,-4.4}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-29.55,-2},{-22.2,4.6}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-28.35,-0.8},{-23.4,3.4}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-29.55,5.8},{-22.2,12.4}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-28.35,7},{-23.4,11.2}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-29.55,13.6},{-22.2,20.2}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-28.35,14.8},{-23.4,19}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Rectangle(extent={{-29.55,21.4},{-22.2,28}}, lineColor={0,0,0}, fillColor={225,238,246}, fillPattern=FillPattern.Solid, lineThickness=0.38, radius=0),
      Line(points={{-28.35,22.6},{-23.4,26.8}}, color={113,122,132}, thickness=0.2, pattern=LinePattern.Solid),
      Ellipse(extent={{-2.4,21.4},{6,29.8}}, lineColor={0,0,0}, fillColor={255,246,210}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Line(points={{7.8,25.6},{10.8,25.6}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{6.042641,29.842641},{8.163961,31.963961}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{1.8,31.6},{1.8,34.6}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-2.442641,29.842641},{-4.563961,31.963961}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-4.2,25.6},{-7.2,25.6}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-2.442641,21.357359},{-4.563961,19.236039}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{1.8,19.6},{1.8,16.6}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{6.042641,21.357359},{8.163961,19.236039}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-4.2,19.6},{-19.8,9.4}}, color={212,109,62}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-0.6,14.8},{-18.6,3.4}}, color={212,109,62}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-39,-21.2},{-39,-24.8},{-11.4,-24.8},{-11.4,-10.4}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid),
      Polygon(points={{-15,-10.4},{-7.8,-10.4},{-11.4,-4.4},{-15,-10.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6),
      Line(points={{-15,-4.4},{-7.8,-4.4}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-11.4,-4.4},{-11.4,1.6},{6.6,1.6}}, color={77,126,172}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Text(extent={{-8.4,-20.6},{10.2,-9.2}}, textString="+X", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Rectangle(extent={{16.2,-32.8},{60.2,-6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Rectangle(extent={{19.8,-28},{27,-18.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{22.2,-18.8},{24.6,-17.6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{21.8,-21.6},{25,-21.6}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{23.4,-23.2},{23.4,-20}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{29.8,-28},{37,-18.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{32.2,-18.8},{34.6,-17.6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{31.8,-21.6},{35,-21.6}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{33.4,-23.2},{33.4,-20}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{39.8,-28},{47,-18.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{42.2,-18.8},{44.6,-17.6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{41.8,-21.6},{45,-21.6}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{43.4,-23.2},{43.4,-20}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{49.8,-28},{57,-18.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{52.2,-18.8},{54.6,-17.6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{51.8,-21.6},{55,-21.6}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{53.4,-23.2},{53.4,-20}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{19.8,-29.2},{57,-29.2}}, color={77,126,172}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{19.8,-16.4},{27,-7.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{22.2,-7.2},{24.6,-6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{21.8,-10},{25,-10}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{23.4,-11.6},{23.4,-8.4}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{29.8,-16.4},{37,-7.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{32.2,-7.2},{34.6,-6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{31.8,-10},{35,-10}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{33.4,-11.6},{33.4,-8.4}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{39.8,-16.4},{47,-7.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{42.2,-7.2},{44.6,-6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{41.8,-10},{45,-10}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{43.4,-11.6},{43.4,-8.4}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{49.8,-16.4},{57,-7.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=1),
      Rectangle(extent={{52.2,-7.2},{54.6,-6}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{51.8,-10},{55,-10}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{53.4,-11.6},{53.4,-8.4}}, color={77,126,172}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{19.8,-17.6},{57,-17.6}}, color={77,126,172}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{14.2,-12.4},{10.2,-12.4},{10.2,-27.6},{14.2,-27.6}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{61.4,-12.4},{66.2,-12.4}}, color={77,126,172}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{61.4,-27.2},{66.2,-27.2}}, color={77,126,172}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{63.4,-9.6},{66.2,-9.6}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{64.6,-10.8},{64.6,-8.4}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{20.6,-36.8},{24.6,-36.8},{26.2,-34.4},{29.4,-38.8},{32.6,-34.4},{35.8,-38.8},{39,-34.4},{42.2,-36.8},{47.4,-36.8}}, color={196,94,56}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{25.55,17.5},{55.65,39.9}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Line(points={{27.3,19.6},{53.55,37.45}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{29.4,35},{37.45,35}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{29.4,32.55},{37.45,32.55}}, color={77,126,172}, thickness=0.5, pattern=LinePattern.Dash),
      Line(points={{43.4,24.85},{51.8,24.85}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{43.4,22.4},{51.8,22.4}}, color={77,126,172}, thickness=0.5, pattern=LinePattern.Dash),
      Line(points={{16.8,35},{25.55,35}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{16.8,21},{25.55,21}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{55.65,35},{66.85,35}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{55.65,21},{66.85,21}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{37.45,16.1},{37.45,12.6},{42,14.35},{46.55,11.2},{51.1,14}}, color={196,94,56}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Electrical Power System", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-429,-279},{379,362}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-350,274},{-156.8,292}}, textString="Body-mounted generation", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-165,199},{19.8,217}}, textString="Source bus and storage", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{15,174},{309,192}}, textString="Power conditioning and distribution", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-417,317},{367,346}}, textString="Electrical Power System", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-417,309},{367,309}}, color={215,220,226}, thickness=0.25)
    }));
end ElectricalPowerSystem;