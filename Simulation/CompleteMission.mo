within OneSatSim.Simulation;
model CompleteMission "真实历元完整任务仿真入口"
  parameter OneSatSim.Scenarios.GeneratedScenario scenario=
    OneSatSim.Scenarios.GeneratedScenario()
    "由根目录DesignConfig.xlsx离线生成的任务场景与初始条件";
  parameter OneSatSim.Scenarios.GeneratedSpacecraftDesignConfig designConfig=
    OneSatSim.Scenarios.GeneratedSpacecraftDesignConfig()
    "由根目录DesignConfig.xlsx离线生成的整星硬件设计配置";
  OrbitalEnvironment orbitalEnvironment(orbit=scenario.orbit,
    groundStations=scenario.groundStations,imagingTargets=scenario.imagingTargets,
    targetPredictionHorizon=scenario.targetPredictionHorizon,
    earlyTargetPredictionHorizon=scenario.earlyTargetPredictionHorizon) 
     "轨道环境与几何装配实例" annotation(Placement(transformation(origin={-227,-3.6},
extent={{-65,-65},{65,65}})));
  Systems.SpacecraftSystem spacecraft(scenario=scenario,designConfig=designConfig)  "12U立方星总体系统实例" annotation(Placement(transformation(origin={-2,0},
extent={{-100,-100},{100,100}})));
  OnboardTelemetry onboardTelemetry  "只读星上工程遥测实例" annotation(Placement(transformation(origin={200,-6.5},
extent={{-55,-55},{55,55}})));
equation
  connect(orbitalEnvironment.environment,spacecraft.environment) annotation(Line(origin={0,0},
points={{-169.8,-1},{-90,-1}},
color={0,166,81},
thickness=0.5));
  connect(spacecraft.onboardTelemetry,onboardTelemetry.telemetry) annotation(Line(origin={0,0},
points={{86,-1},{149.4,-1}},
color={213,0,143},
thickness=0.5));
  annotation(experiment(StartTime=0.0,StopTime=86400.0,Interval=1.0,Tolerance=1e-07),
    Documentation(info="<html><h2>完整任务仿真</h2><p><b>类路径：</b><code>OneSatSim.Simulation.CompleteMission</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>以固化场景和整星硬件配置装配OrbitalEnvironment、SpacecraftSystem、OnboardTelemetry三个对象，连接环境与只读遥测。星务任务规划仍在星内执行。</p><h3>在工程中使用</h3><p>本类是项目声明的完整任务入口；直接加载根 package.mo 后选择本类。</p><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>scenario</code></td><td>OneSatSim.Scenarios.GeneratedScenario</td><td>由根目录DesignConfig.xlsx离线生成的任务场景与初始条件</td><td><code>= OneSatSim.Scenarios.GeneratedScenario()</code></td></tr><tr><td><code>designConfig</code></td><td>OneSatSim.Scenarios.GeneratedSpacecraftDesignConfig</td><td>由根目录DesignConfig.xlsx离线生成的整星硬件设计配置</td><td><code>= OneSatSim.Scenarios.GeneratedSpacecraftDesignConfig()</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>orbitalEnvironment</code></td><td><a href=\"modelica://OneSatSim.Simulation.OrbitalEnvironment\">OneSatSim.Simulation.OrbitalEnvironment</a></td><td>轨道环境与几何装配实例</td></tr><tr><td><code>spacecraft</code></td><td><a href=\"modelica://OneSatSim.Systems.SpacecraftSystem\">OneSatSim.Systems.SpacecraftSystem</a></td><td>12U立方星总体系统实例</td></tr><tr><td><code>onboardTelemetry</code></td><td><a href=\"modelica://OneSatSim.Simulation.OnboardTelemetry\">OneSatSim.Simulation.OnboardTelemetry</a></td><td>只读星上工程遥测实例</td></tr></table><h3>使用边界</h3><p>本工程的轨道环境采用离线固化数据；任务、姿态、电热及信息边界按当前配置和接口使用。已有未完成任务目标与平台状态见根README，不由本次注释更新改写。</p></html>"),
    __OpenModelica_commandLineOptions="--maxSizeLinearTearing=1000",
    __OpenModelica_simulationFlags(s="ida",idaLS="spgmr",jacobian="coloredNumerical"),
    __MWORKS(ContinueSimConfig(SaveContinueFile="false",SaveBeforeStop="false",NumberBeforeStop=1,FixedContinueInterval="false",ContinueIntervalLength=10,ContinueTimeVector)),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Simulation", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-48,25.1},{-10.2,33.5},{5.9,20.2},{-31.9,11.8},{-48,25.1}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-48,25.1},{-31.9,11.8},{-31.9,-30.2},{-48,-16.9},{-48,25.1}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-31.9,11.8},{5.9,20.2},{5.9,-21.8},{-31.9,-30.2},{-31.9,11.8}}, lineColor={0,0,0}, fillColor={246,247,248}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{-48,11.1},{-31.9,-2.2},{5.9,6.2}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-48,-2.9},{-31.9,-16.2},{5.9,-7.8}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-28.876,12.472},{-28.876,-29.528}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{2.876,19.528},{2.876,-22.472}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Polygon(points={{-29.1,9.7},{-22.8,11.1},{-22.8,1.3},{-29.1,-0.1},{-29.1,9.7}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{-29.1,-2.2},{-22.8,-0.8},{-22.8,-10.6},{-29.1,-12},{-29.1,-2.2}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{-29.1,-14.1},{-22.8,-12.7},{-22.8,-22.5},{-29.1,-23.9},{-29.1,-14.1}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{-21.05,11.485},{-14.75,12.885},{-14.75,3.085},{-21.05,1.685},{-21.05,11.485}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{-21.05,-0.415},{-14.75,0.985},{-14.75,-8.815},{-21.05,-10.215},{-21.05,-0.415}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{-21.05,-12.315},{-14.75,-10.915},{-14.75,-20.715},{-21.05,-22.115},{-21.05,-12.315}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{-13,13.27},{-6.7,14.67},{-6.7,4.87},{-13,3.47},{-13,13.27}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{-13,1.37},{-6.7,2.77},{-6.7,-7.03},{-13,-8.43},{-13,1.37}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{-13,-10.53},{-6.7,-9.13},{-6.7,-18.93},{-13,-20.33},{-13,-10.53}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{-4.95,15.055},{1.35,16.455},{1.35,6.655},{-4.95,5.255},{-4.95,15.055}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{-4.95,3.155},{1.35,4.555},{1.35,-5.245},{-4.95,-6.645},{-4.95,3.155}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{-4.95,-8.745},{1.35,-7.345},{1.35,-17.145},{-4.95,-18.545},{-4.95,-8.745}}, lineColor={0,0,0}, fillColor={218,234,245}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{-45.2,19.5},{-35.4,11.8},{-35.4,2.7},{-45.2,10.4},{-45.2,19.5}}, lineColor={0,0,0}, fillColor={230,240,247}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{-45.2,7.6},{-35.4,-0.1},{-35.4,-9.2},{-45.2,-1.5},{-45.2,7.6}}, lineColor={0,0,0}, fillColor={230,240,247}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Polygon(points={{-45.2,-4.3},{-35.4,-12},{-35.4,-21.1},{-45.2,-13.4},{-45.2,-4.3}}, lineColor={0,0,0}, fillColor={230,240,247}, fillPattern=FillPattern.Solid, lineThickness=0.35),
      Ellipse(extent={{-27.7,20.2},{-16.5,29.3}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{-24.9,22.3},{-19.3,27.2}}, lineColor={0,0,0}, fillColor={223,233,238}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Ellipse(extent={{-49.19,23.91},{-46.81,26.29}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-48.595,25.1},{-47.405,25.1}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-33.09,10.61},{-30.71,12.99}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-32.495,11.8},{-31.305,11.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{4.71,19.01},{7.09,21.39}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{5.305,20.2},{6.495,20.2}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-49.19,-18.09},{-46.81,-15.71}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-48.595,-16.9},{-47.405,-16.9}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-33.09,-31.39},{-30.71,-29.01}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-32.495,-30.2},{-31.305,-30.2}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{4.71,-22.99},{7.09,-20.61}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{5.305,-21.8},{6.495,-21.8}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{25.9,-4.26},{50.74,20.58}}, lineColor={0,0,0}, fillColor={239,246,250}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{33.352,-4.26},{43.288,20.58}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Ellipse(extent={{25.9,3.813},{50.74,12.507}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Line(points={{25.9,8.16},{50.74,8.16}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{38.32,-4.26},{38.32,20.58}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{11.18,-6.56},{70.98,30.24}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.7, startAngle=0, endAngle=360),
      Rectangle(extent={{60.86,19.66},{65.46,24.26}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Rectangle(extent={{57.18,20.12},{60.4,23.8}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{65.92,20.12},{69.14,23.8}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{63.16,19.66},{43.38,15.06}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Line(points={{63.16,19.66},{48.9,3.56}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Ellipse(extent={{42,13.68},{44.76,16.44}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Ellipse(extent={{47.52,2.18},{50.28,4.94}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Complete Mission", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-318,-238},{408,182}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-306,137},{396,166}}, textString="Complete Mission | 2026-10-01 UTC", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-306,129},{396,129}}, color={215,220,226}, thickness=0.25)
    }));
end CompleteMission;