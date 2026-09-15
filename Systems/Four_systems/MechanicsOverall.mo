within NISSA_12UCubeSat.Systems.Four_systems;
model MechanicsOverall "机械动力学总体"
  parameter NISSA_12UCubeSat.Scenarios.ScenarioConfig scenario "轨道、站点、目标和姿态场景";
  Foundation.Interfaces.MechanicalPort subsystem[8] annotation(Placement(transformation(extent={{-112,-10},{-92,10}})));
  Foundation.Interfaces.EnvironmentPort environment annotation(Placement(transformation(extent={{92,-10},{112,10}})));
  Foundation.Interfaces.ActiveMissionSelectionInput activeMissionSelection annotation(Placement(transformation(extent={{42,-112},{62,-92}})));
  outer Modelica.Mechanics.MultiBody.World world annotation(Placement(transformation(extent={{-75,35},{-55,55}})));
  Modelica.Mechanics.MultiBody.Joints.FreeMotionScalarInit freeMotion(use_angle=true,use_w=true,angle_1(fixed=true,start=scenario.initialConditions.roll),angle_2(fixed=true,start=scenario.initialConditions.pitch),angle_3(fixed=true,start=scenario.initialConditions.yaw),w_rel_b_1(fixed=true,start=scenario.initialConditions.wx),w_rel_b_2(fixed=true,start=scenario.initialConditions.wy),w_rel_b_3(fixed=true,start=scenario.initialConditions.wz)) annotation(Placement(transformation(extent={{-35,30},{-5,60}})));
  Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngles eulerSensor annotation(Placement(transformation(extent={{15,42},{45,72}})));
  Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngularVelocity rateSensor(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a) annotation(Placement(transformation(extent={{15,2},{45,32}})));
  Foundation.Models.OrbitalEnvironmentCore orbitEnvironment(
    orbit=scenario.orbit,
    groundStations=scenario.groundStations,
    imagingTargets=scenario.imagingTargets,
    targetPredictionHorizon=scenario.targetPredictionHorizon,
    earlyTargetPredictionHorizon=scenario.earlyTargetPredictionHorizon) annotation(Placement(transformation(extent={{55,-35},{85,-5}})));
equation
  connect(world.frame_b,freeMotion.frame_a) annotation(Line(points={{-55,45},{-35,45}},color={95,95,95},thickness=0.5));
  connect(freeMotion.frame_b,eulerSensor.frame_a) annotation(Line(points={{-5,45},{15,45},{15,57}},color={95,95,95},thickness=0.5));
  connect(freeMotion.frame_b,rateSensor.frame_a) annotation(Line(points={{-5,45},{5,45},{5,17},{15,17}},color={95,95,95},thickness=0.5));
  connect(freeMotion.frame_b,subsystem[1]) annotation(Line(points={{-5,45},{-45,45},{-45,0},{-102,0}},color={95,95,95},thickness=0.5));
  connect(freeMotion.frame_b,subsystem[2]) annotation(Line(points={{-5,45},{-42,45},{-42,0},{-102,0}},color={95,95,95},thickness=0.5));
  connect(freeMotion.frame_b,subsystem[3]) annotation(Line(points={{-5,45},{-39,45},{-39,0},{-102,0}},color={95,95,95},thickness=0.5));
  connect(freeMotion.frame_b,subsystem[4]) annotation(Line(points={{-5,45},{-36,45},{-36,0},{-102,0}},color={95,95,95},thickness=0.5));
  connect(freeMotion.frame_b,subsystem[5]) annotation(Line(points={{-5,45},{-33,45},{-33,0},{-102,0}},color={95,95,95},thickness=0.5));
  connect(freeMotion.frame_b,subsystem[6]) annotation(Line(points={{-5,45},{-30,45},{-30,0},{-102,0}},color={95,95,95},thickness=0.5));
  connect(freeMotion.frame_b,subsystem[7]) annotation(Line(points={{-5,45},{-27,45},{-27,0},{-102,0}},color={95,95,95},thickness=0.5));
  connect(freeMotion.frame_b,subsystem[8]) annotation(Line(points={{-5,45},{-24,45},{-24,0},{-102,0}},color={95,95,95},thickness=0.5));
  connect(eulerSensor.angles,orbitEnvironment.euler) annotation(Line(points={{46.5,57},{70,57},{70,-5}},color={0,0,127}));
  connect(rateSensor.w,orbitEnvironment.bodyRate) annotation(Line(points={{46.5,17},{64,17},{64,-5}},color={0,0,127}));
  connect(activeMissionSelection,orbitEnvironment.activeMissionSelection) annotation(Line(points={{52,-102},{52,-50},{70,-50},{70,-35}},color={75,105,145},thickness=0.5));
  connect(orbitEnvironment.environment,environment) annotation(Line(points={{85,-20},{102,-20},{102,0}},color={0,110,70}));
  annotation(Icon(graphics={Rectangle(extent={{-100,85},{100,-85}},lineColor={80,80,90},fillColor={235,235,240},fillPattern=FillPattern.Solid),Ellipse(extent={{-50,50},{50,-50}},lineColor={80,80,90}),Line(points={{-65,0},{65,0}},color={140,40,40},thickness=2),Line(points={{0,-65},{0,65}},color={40,120,60},thickness=2),Text(extent={{-92,-82},{92,-58}},textString="MECHANICS + ORBIT")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}}),graphics={Text(extent={{-94,80},{94,66}},textString="MSL自由刚体-绝对Euler/角速度-轨道几何")}),Documentation(info="<html><h4>功能定位</h4><p>机械动力学总体统一整星姿态刚体、执行机构反作用力矩和真实历元任务机会几何。</p><h4>物理实现</h4><p>外部World和FreeMotion承担整星姿态及执行机构反作用力矩传递；OrbitalEnvironmentCore读取离线生成的GCRS轨道、太阳方向和IERS地球定向，并实时计算目标与地面站几何。</p><h4>适用边界</h4><p>轨道平动与整星姿态动力学解耦；轨道不会接收推进或姿态反馈。仅通过ActiveMissionSelectionInput接收锁存目标和地面站编号。</p></html>"));
end MechanicsOverall;
