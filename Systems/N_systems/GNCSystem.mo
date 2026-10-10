within OneSatSim.Systems.N_systems;
model GNCSystem "姿轨控分系统"
  parameter OneSatSim.Scenarios.DesignConfigRecords.GncDesignConfig designConfig "分系统硬件设计配置";
  parameter OneSatSim.Scenarios.InitialConditionConfig initialConditions "场景初始条件";
  parameter OneSatSim.Foundation.Types.MassProperties massProperties "由活动机械刚体离线汇总的统一整星质量、质心与惯量" ;
  parameter OneSatSim.Foundation.Types.ImagingCapabilities imagingCapabilities
    "成像Capabilities；Shared imaging opportunity and AOCS pointing-dwell capability";
  final parameter OneSatSim.Foundation.Types.WheelGroupCapabilities wheelCapabilities(
    J={designConfig.wheelX.RotorInertia,designConfig.wheelY.RotorInertia,designConfig.wheelZ.RotorInertia,designConfig.wheelS.RotorInertia},
    maxTorque={designConfig.wheelX.MaxTorque,designConfig.wheelY.MaxTorque,designConfig.wheelZ.MaxTorque,designConfig.wheelS.MaxTorque},
    maxSpeed={designConfig.wheelX.SpeedLimit,designConfig.wheelY.SpeedLimit,designConfig.wheelZ.SpeedLimit,designConfig.wheelS.SpeedLimit},
    axes={{designConfig.wheelX.Axis_X,designConfig.wheelY.Axis_X,designConfig.wheelZ.Axis_X,designConfig.wheelS.Axis_X},
          {designConfig.wheelX.Axis_Y,designConfig.wheelY.Axis_Y,designConfig.wheelZ.Axis_Y,designConfig.wheelS.Axis_Y},
          {designConfig.wheelX.Axis_Z,designConfig.wheelY.Axis_Z,designConfig.wheelZ.Axis_Z,designConfig.wheelS.Axis_Z}})
    "飞轮Capabilities；Single derived physical capability for hardware, telemetry, control and unloading";
  final parameter Real wheelSpeedServoGain[4](each unit="N.m.s/rad")=
    {1.60e-4,1.55e-4,1.70e-4,1.50e-4}
    "飞轮速度Servo增益 [N.m.s/rad]；Single existing control-gain source for wheel servos and allocation inverse";
  Foundation.Interfaces.PowerPort power  "功率" annotation(Placement(transformation(origin={20,295},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={3.48,97.52},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Foundation.Interfaces.ThermalPort thermal  "热学" annotation(Placement(visible=true, transformation(origin={20,-315}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,-97}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(transformation(origin={-445,50},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={-100,1.3877},
extent={{-12,-12},{12,12}}),
iconVisible=true));
  Foundation.Interfaces.InformationPort information  "计算/接口量 information" annotation(Placement(transformation(origin={500,0},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={100.48,-1},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Foundation.Interfaces.EnvironmentPort environment  "外部环境接口或实例" annotation(Placement(transformation(origin={-445,-125},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={-100,-87.5},
extent={{-12,-12},{12,12}}),
iconVisible=true));
  Components.GNCComputerUnit computer(config=designConfig.computer,massProperties=massProperties,
    wheelCapabilities=wheelCapabilities,wheelSpeedServoGain=wheelSpeedServoGain,
    attitudeDwell_s=imagingCapabilities.attitudeDwell_s) 
     "姿轨控计算机组件实例" annotation(Placement(visible=true, transformation(origin={25,15}, extent={{-100,-100},{100,100}}, rotation=0)));
  Components.ReactionWheelXUnit wheelX(config=designConfig.wheelX,initialSpeed=initialConditions.wheelSpeed[1],
    wheelCapabilities=wheelCapabilities,wheelSpeedServoGain=wheelSpeedServoGain[1])  "X轴反作用飞轮组件实例" annotation(Placement(visible=true, transformation(origin={245,125}, extent={{-48,-48},{48,48}}, rotation=0)));
  Components.ReactionWheelYUnit wheelY(config=designConfig.wheelY,initialSpeed=initialConditions.wheelSpeed[2],
    wheelCapabilities=wheelCapabilities,wheelSpeedServoGain=wheelSpeedServoGain[2])  "Y轴反作用飞轮组件实例" annotation(Placement(visible=true, transformation(origin={385,125}, extent={{-48,-48},{48,48}}, rotation=0)));
  Components.ReactionWheelZUnit wheelZ(config=designConfig.wheelZ,initialSpeed=initialConditions.wheelSpeed[3],
    wheelCapabilities=wheelCapabilities,wheelSpeedServoGain=wheelSpeedServoGain[3])  "Z轴反作用飞轮组件实例" annotation(Placement(visible=true, transformation(origin={245,-40}, extent={{-48,-48},{48,48}}, rotation=0)));
  Components.ReactionWheelSUnit wheelS(config=designConfig.wheelS,initialSpeed=initialConditions.wheelSpeed[4],
    wheelCapabilities=wheelCapabilities,wheelSpeedServoGain=wheelSpeedServoGain[4])  "斜置反作用飞轮组件实例" annotation(Placement(visible=true, transformation(origin={385,-40}, extent={{-48,-48},{48,48}}, rotation=0)));
  Components.StarTrackerYUnit starY (config=designConfig.starY)  "Y向星敏感器组件实例" annotation(Placement(visible=true, transformation(origin={-345,180}, extent={{-45,-45},{45,45}}, rotation=0)));
  Components.StarTrackerZUnit starZ (config=designConfig.starZ)  "Z向星敏感器组件实例" annotation(Placement(visible=true, transformation(origin={-195,180}, extent={{-45,-45},{45,45}}, rotation=0)));
  Components.RateGyroUnit yh50 (config=designConfig.rateGyro)  "三轴角速率陀螺组件实例" annotation(Placement(visible=true, transformation(origin={-345,20}, extent={{-45,-45},{45,45}}, rotation=0)));
  Components.MEMSIMUUnit mems (config=designConfig.memsIMU)  "MEMS惯性测量组件实例" annotation(Placement(visible=true, transformation(origin={-195,20}, extent={{-45,-45},{45,45}}, rotation=0)));
  Components.MagnetometerUnit magnetometer (config=designConfig.magnetometer)  "三轴磁强计组件实例" annotation(Placement(visible=true, transformation(origin={-345,-145}, extent={{-45,-45},{45,45}}, rotation=0)));
  Components.SunSensorUnit sunSensor (config=designConfig.sunSensor)  "二维太阳敏感器组件实例" annotation(Placement(visible=true, transformation(origin={-195,-145}, extent={{-45,-45},{45,45}}, rotation=0)));
  Components.MagnetorquerUnit magnetorquer (config=designConfig.magnetorquer,wheelCapabilities=wheelCapabilities)  "三轴磁力矩器组件实例" annotation(Placement(visible=true, transformation(origin={280,-215}, extent={{-60,-60},{60,60}}, rotation=0)));
equation
  connect(power,computer.power) annotation(Line(points={{20,295},{78,295},{78,120},{25,120},{25,110}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power,wheelX.power) annotation(Line(points={{20,295},{78,295},{78,180.6},{245,180.6},{245,170.6}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power,wheelY.power) annotation(Line(points={{20,295},{78,295},{78,180.6},{385,180.6},{385,170.6}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power,wheelZ.power) annotation(Line(points={{20,295},{124,295},{124,15.6},{245,15.6},{245,5.6}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power,wheelS.power) annotation(Line(points={{20,295},{124,295},{124,15.6},{385,15.6},{385,5.6}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power,starY.power) annotation(Line(points={{20,295},{20,232.75},{-345,232.75},{-345,222.75}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power,starZ.power) annotation(Line(points={{20,295},{20,232.75},{-195,232.75},{-195,222.75}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power,yh50.power) annotation(Line(points={{20,295},{-144.95,295},{-144.95,72.75},{-345,72.75},{-345,62.75}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power,mems.power) annotation(Line(points={{20,295},{-144.95,295},{-144.95,72.75},{-195,72.75},{-195,62.75}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power,magnetometer.power) annotation(Line(points={{20,295},{-144.95,295},{-144.95,-92.25},{-345,-92.25},{-345,-102.25}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power,sunSensor.power) annotation(Line(points={{20,295},{-144.95,295},{-144.95,-92.25},{-195,-92.25},{-195,-102.25}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power,magnetorquer.power) annotation(Line(points={{20,295},{124,295},{124,-148},{280,-148},{280,-158}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,computer.thermal) annotation(Line(points={{20,-315},{25,-315},{25,-82}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,wheelX.thermal) annotation(Line(points={{20,-315},{124,-315},{124,68.44},{245,68.44},{245,78.44}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,wheelY.thermal) annotation(Line(points={{20,-315},{124,-315},{124,68.44},{385,68.44},{385,78.44}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,wheelZ.thermal) annotation(Line(points={{20,-315},{20,-96.56},{245,-96.56},{245,-86.56}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,wheelS.thermal) annotation(Line(points={{20,-315},{385,-315},{385,-86.56}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,starY.thermal) annotation(Line(points={{20,-315},{-245.05,-315},{-245.05,126.35},{-345,126.35},{-345,136.35}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,starZ.thermal) annotation(Line(points={{20,-315},{-144.95,-315},{-144.95,126.35},{-195,126.35},{-195,136.35}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,yh50.thermal) annotation(Line(points={{20,-315},{-245.05,-315},{-245.05,-33.65},{-345,-33.65},{-345,-23.65}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,mems.thermal) annotation(Line(points={{20,-315},{20,-96.56},{-195,-96.56},{-195,-23.65}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,magnetometer.thermal) annotation(Line(points={{20,-315},{-345,-315},{-345,-188.65}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,sunSensor.thermal) annotation(Line(points={{20,-315},{-195,-315},{-195,-188.65}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,magnetorquer.thermal) annotation(Line(points={{20,-315},{280,-315},{280,-273.2}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,computer.mechanical) annotation(Line(points={{-445,50},{-445,95},{-64,95}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,wheelX.mechanical) annotation(Line(points={{-445,50},{-445,125},{202.28,125}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,wheelY.mechanical) annotation(Line(points={{-445,50},{-445,-96.56},{332.28,-96.56},{332.28,125},{342.28,125}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,wheelZ.mechanical) annotation(Line(points={{-445,50},{-445,-92},{192.28,-92},{192.28,-40},{202.28,-40}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,wheelS.mechanical) annotation(Line(points={{-445,50},{-445,-96.56},{332.28,-96.56},{332.28,-40},{342.28,-40}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,starY.mechanical) annotation(Line(points={{-445,50},{-445,216},{-385.05,216}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,starZ.mechanical) annotation(Line(points={{-445,50},{-445,68.44},{-245.05,68.44},{-245.05,216},{-235.05,216}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,yh50.mechanical) annotation(Line(points={{-445,50},{-445,20},{-385.05,20}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,mems.mechanical) annotation(Line(points={{-445,50},{-445,68.44},{-245.05,68.44},{-245.05,56},{-235.05,56}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,magnetometer.mechanical) annotation(Line(points={{-445,50},{-445,-109},{-385.05,-109}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,sunSensor.mechanical) annotation(Line(points={{-445,50},{-445,-96.56},{-245.05,-96.56},{-245.05,-109},{-235.05,-109}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,magnetorquer.mechanical) annotation(Line(points={{-445,50},{-445,-215},{226.6,-215}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(environment,computer.environment) annotation(Line(points={{-445,-125},{-445,-65},{-64,-65}}, color={0,166,81}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(environment,mems.environment) annotation(Line(points={{-445,-125},{-445,-96.56},{-245.05,-96.56},{-245.05,-16},{-235.05,-16}}, color={0,166,81}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(environment,magnetometer.environment) annotation(Line(points={{-445,-125},{-445,-181},{-385.05,-181}}, color={0,166,81}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(environment,sunSensor.environment) annotation(Line(points={{-445,-125},{-445,-198.65},{-245.05,-198.65},{-245.05,-181},{-235.05,-181}}, color={0,166,81}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,computer.information) annotation(Line(points={{500,0},{500,15},{114,15}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,wheelX.information) annotation(Line(points={{500,0},{500,15.6},{297.72,15.6},{297.72,125},{287.72,125}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,wheelY.information) annotation(Line(points={{500,0},{500,125},{427.72,125}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,wheelZ.information) annotation(Line(points={{500,0},{500,15.6},{297.72,15.6},{297.72,-40},{287.72,-40}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,wheelS.information) annotation(Line(points={{500,0},{500,-40},{427.72,-40}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,starY.information) annotation(Line(points={{500,0},{500,242},{-294.95,242},{-294.95,180},{-304.95,180}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,starZ.information) annotation(Line(points={{500,0},{500,192},{-144.95,192},{-144.95,180},{-154.95,180}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,yh50.information) annotation(Line(points={{500,0},{500,-96.56},{-294.95,-96.56},{-294.95,20},{-304.95,20}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,mems.information) annotation(Line(points={{500,0},{500,-92},{-144.95,-92},{-144.95,20},{-154.95,20}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,magnetometer.information) annotation(Line(points={{500,0},{500,-96.56},{-294.95,-96.56},{-294.95,-145},{-304.95,-145}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,sunSensor.information) annotation(Line(points={{500,0},{500,-96.56},{-144.95,-96.56},{-144.95,-145},{-154.95,-145}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,magnetorquer.information) annotation(Line(points={{500,0},{500,-215},{333.4,-215}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>姿轨控分系统</h2><p><b>类路径：</b><code>OneSatSim.Systems.N_systems.GNCSystem</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>姿轨控分系统</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.SpacecraftSystem\">OneSatSim.Systems.SpacecraftSystem</a> 的 <code>gncSystem</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>power</code></td><td>Foundation.Interfaces.PowerPort</td><td>public</td><td>按声明/类型合同</td><td>功率</td></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr><tr><td><code>information</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr><tr><td><code>environment</code></td><td>Foundation.Interfaces.EnvironmentPort</td><td>public</td><td>按声明/类型合同</td><td>外部环境接口或实例</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>designConfig</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.GncDesignConfig</td><td>分系统硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>initialConditions</code></td><td>OneSatSim.Scenarios.InitialConditionConfig</td><td>场景初始条件</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>massProperties</code></td><td>OneSatSim.Foundation.Types.MassProperties</td><td>由活动机械刚体离线汇总的统一整星质量、质心与惯量</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>imagingCapabilities</code></td><td>OneSatSim.Foundation.Types.ImagingCapabilities</td><td>成像Capabilities；Shared imaging opportunity and AOCS pointing-dwell capability</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>wheelCapabilities</code></td><td>OneSatSim.Foundation.Types.WheelGroupCapabilities</td><td>飞轮Capabilities；Single derived physical capability for hardware, telemetry, control and unloading</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>wheelSpeedServoGain[4]</code></td><td>Real</td><td>飞轮速度Servo增益 [N.m.s/rad]；Single existing control-gain source for wheel servos and allocation inverse</td><td><code>= {1.60e-4,1.55e-4,1.70e-4,1.50e-4}</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>computer</code></td><td><a href=\"modelica://OneSatSim.Components.GNCComputerUnit\">OneSatSim.Components.GNCComputerUnit</a></td><td>姿轨控计算机组件实例</td></tr><tr><td><code>wheelX</code></td><td><a href=\"modelica://OneSatSim.Components.ReactionWheelXUnit\">OneSatSim.Components.ReactionWheelXUnit</a></td><td>X轴反作用飞轮组件实例</td></tr><tr><td><code>wheelY</code></td><td><a href=\"modelica://OneSatSim.Components.ReactionWheelYUnit\">OneSatSim.Components.ReactionWheelYUnit</a></td><td>Y轴反作用飞轮组件实例</td></tr><tr><td><code>wheelZ</code></td><td><a href=\"modelica://OneSatSim.Components.ReactionWheelZUnit\">OneSatSim.Components.ReactionWheelZUnit</a></td><td>Z轴反作用飞轮组件实例</td></tr><tr><td><code>wheelS</code></td><td><a href=\"modelica://OneSatSim.Components.ReactionWheelSUnit\">OneSatSim.Components.ReactionWheelSUnit</a></td><td>斜置反作用飞轮组件实例</td></tr><tr><td><code>starY</code></td><td><a href=\"modelica://OneSatSim.Components.StarTrackerYUnit\">OneSatSim.Components.StarTrackerYUnit</a></td><td>Y向星敏感器组件实例</td></tr><tr><td><code>starZ</code></td><td><a href=\"modelica://OneSatSim.Components.StarTrackerZUnit\">OneSatSim.Components.StarTrackerZUnit</a></td><td>Z向星敏感器组件实例</td></tr><tr><td><code>yh50</code></td><td><a href=\"modelica://OneSatSim.Components.RateGyroUnit\">OneSatSim.Components.RateGyroUnit</a></td><td>三轴角速率陀螺组件实例</td></tr><tr><td><code>mems</code></td><td><a href=\"modelica://OneSatSim.Components.MEMSIMUUnit\">OneSatSim.Components.MEMSIMUUnit</a></td><td>MEMS惯性测量组件实例</td></tr><tr><td><code>magnetometer</code></td><td><a href=\"modelica://OneSatSim.Components.MagnetometerUnit\">OneSatSim.Components.MagnetometerUnit</a></td><td>三轴磁强计组件实例</td></tr><tr><td><code>sunSensor</code></td><td><a href=\"modelica://OneSatSim.Components.SunSensorUnit\">OneSatSim.Components.SunSensorUnit</a></td><td>二维太阳敏感器组件实例</td></tr><tr><td><code>magnetorquer</code></td><td><a href=\"modelica://OneSatSim.Components.MagnetorquerUnit\">OneSatSim.Components.MagnetorquerUnit</a></td><td>三轴磁力矩器组件实例</td></tr></table><h3>使用边界</h3><p>本工程的轨道环境采用离线固化数据；任务、姿态、电热及信息边界按当前配置和接口使用。已有未完成任务目标与平台状态见根README，不由本次注释更新改写。</p></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Subsystem", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-45.97,15.857},{-22.804,21.005},{-12.937,12.854},{-36.103,7.706},{-45.97,15.857}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-45.97,15.857},{-36.103,7.706},{-36.103,-18.034},{-45.97,-9.883},{-45.97,15.857}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-36.103,7.706},{-12.937,12.854},{-12.937,-12.886},{-36.103,-18.034},{-36.103,7.706}}, lineColor={0,0,0}, fillColor={246,247,248}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{-45.97,7.277},{-36.103,-0.874},{-12.937,4.274}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-45.97,-1.303},{-36.103,-9.454},{-12.937,-4.306}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-34.24972,8.11784},{-34.24972,-17.62216}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-14.79028,12.44216},{-14.79028,-13.29784}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-45.97,15.857},{-36.103,-18.034}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-36.103,7.706},{-45.97,-9.883}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-36.103,7.706},{-12.937,-12.886}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-12.937,12.854},{-36.103,-18.034}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Ellipse(extent={{-33.529,12.854},{-26.665,18.431}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{-31.813,14.141},{-28.381,17.144}}, lineColor={0,0,0}, fillColor={223,233,238}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Ellipse(extent={{-46.6993,15.1277},{-45.2407,16.5863}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-46.33465,15.857},{-45.60535,15.857}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-36.8323,6.9767},{-35.3737,8.4353}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-36.46765,7.706},{-35.73835,7.706}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-13.6663,12.1247},{-12.2077,13.5833}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-13.30165,12.854},{-12.57235,12.854}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-46.6993,-10.6123},{-45.2407,-9.1537}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-46.33465,-9.883},{-45.60535,-9.883}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-36.8323,-18.7633},{-35.3737,-17.3047}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-36.46765,-18.034},{-35.73835,-18.034}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-13.6663,-13.6153},{-12.2077,-12.1567}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-13.30165,-12.886},{-12.57235,-12.886}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{2,-13.25},{19.55,-13.25}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{2,-13.25},{-7.126,-2.018}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{2,-13.25},{2,4.3}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-53.25,23.15},{-37,34.85},{-18.15,33.55},{-6.45,23.8}}, color={76,128,143}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{-61.7,1.05},{-59.1,-13.9},{-46.1,-24.3}}, color={76,128,143}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{-12.3,3},{2.65,11.45},{19.55,11.45}}, color={76,128,143}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-12.3,3},{8.5,29.65}}, color={113,122,132}, thickness=0.55, pattern=LinePattern.Dash),
      Ellipse(extent={{7.2,25.75},{15,33.55}}, lineColor={76,128,143}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, startAngle=0, endAngle=360),
      Rectangle(extent={{18.35,-30.91},{60.92,-27.47}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Rectangle(extent={{26.09,-27.9},{30.39,-23.17}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Rectangle(extent={{53.18,-27.9},{57.48,-23.17}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Ellipse(extent={{21.36,-24.89},{60.92,0.05}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, startAngle=0, endAngle=360),
      Ellipse(extent={{24.8,-22.74},{57.48,-2.53}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{30.39,-19.3},{51.89,-5.11}}, lineColor={0,0,0}, fillColor={234,240,244}, fillPattern=FillPattern.Solid, lineThickness=0.55, startAngle=0, endAngle=360),
      Ellipse(extent={{36.84,-16.29},{45.44,-8.55}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{39.42,-14.57},{42.86,-10.27}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{45.87,-12.42},{55.76,-12.42}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{44.484615,-10.291609},{51.477901,-6.338882}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{41.14,-9.41},{41.14,-3.82}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{37.795385,-10.291609},{30.802099,-6.338882}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{36.41,-12.42},{26.52,-12.42}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{37.795385,-14.548391},{30.802099,-18.501118}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{41.14,-15.43},{41.14,-21.02}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{44.484615,-14.548391},{51.477901,-18.501118}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{28.24,3.06},{36.41,6.07},{47.16,5.21},{54.47,2.2}}, color={76,128,143}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Ellipse(extent={{20.5,-30.05},{22.22,-28.33}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{20.93,-29.19},{21.79,-29.19}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{57.05,-30.05},{58.77,-28.33}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{57.48,-29.19},{58.34,-29.19}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{65.22,-24.03},{73.39,-24.03}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{65.22,-24.03},{60.9716,-18.8012}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{65.22,-24.03},{65.22,-15.86}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{60.49,-29.62},{70.38,-15}}, color={76,128,143}, thickness=1, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Text(extent={{62.21,-6.4},{72.96,2.63}}, textString="S", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Polygon(points={{45,49},{46.5,44.5},{51,43},{46.5,41.5},{45,37},{43.5,41.5},{39,43},{43.5,44.5},{45,49}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="GNC System", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-489,-359},{544,383}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-410,269},{-166.4,287}}, textString="Attitude and inertial sensing", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-100,164},{68,182}}, textString="Guidance and control", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{175,214},{418.6,232}}, textString="Wheels and magnetic unloading", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-477,338},{532,367}}, textString="GNC System", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-477,330},{532,330}}, color={215,220,226}, thickness=0.25)
    }));
end GNCSystem;