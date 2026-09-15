within OneSatSim.Systems.N_systems;
model DataHandlingSystem "数管分系统"
  parameter OneSatSim.Scenarios.DesignConfigRecords.DataHandlingDesignConfig designConfig "分系统硬件设计配置";
  parameter OneSatSim.Scenarios.InitialConditionConfig initialConditions "场景初始条件";
  parameter Boolean operationalSnapshotStart=true "从正常在轨快照启动任务控制";
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-112,-10},{-92,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{92,-10},{112,10}})));
  Foundation.Interfaces.EnvironmentPort environment annotation(Placement(transformation(extent={{-112,55},{-92,75}})));
  Foundation.Interfaces.ActiveMissionSelectionOutput activeMissionSelection annotation(Placement(transformation(extent={{92,-55},{112,-35}})));
  Components.OnboardComputerUnit obc(config=designConfig.obc,
    operationalSnapshotStart=operationalSnapshotStart,
    initialCpuTemperature=initialConditions.obcCpuTemperature,
    initialBoardTemperature=initialConditions.obcBoardTemperature) annotation(Placement(transformation(extent={{-55,5},{-5,55}})));
  Components.DataRecorderUnit recorder(config=designConfig.recorder,initialStoredBytes=initialConditions.dataRecorderStoredBytes) annotation(Placement(transformation(extent={{20,5},{70,55}})));
equation
  connect(power,obc.power) annotation(Line(points={{0,100},{82,100},{82,37.5},{-55,37.5}},color={0,0,255}));
  connect(power,recorder.power) annotation(Line(points={{0,100},{82,100},{82,37.5},{20,37.5}},color={0,0,255}));
  connect(thermal,obc.thermal) annotation(Line(points={{0,-100},{-30,-100},{-30,5}},color={191,0,0}));
  connect(thermal,recorder.thermal) annotation(Line(points={{0,-100},{45,-100},{45,5}},color={191,0,0}));
  connect(mechanical,obc.mechanical) annotation(Line(points={{-102,0},{-82,0},{-82,67},{-30,67},{-30,55}},color={95,95,95},thickness=0.5));
  connect(mechanical,recorder.mechanical) annotation(Line(points={{-102,0},{-82,0},{-82,67},{45,67},{45,55}},color={95,95,95},thickness=0.5));
  connect(information,obc.information) annotation(Line(points={{102,0},{82,0},{82,30},{-5,30}},color={0,90,180}));
  connect(information,recorder.information) annotation(Line(points={{102,0},{82,0},{82,30},{70,30}},color={0,90,180}));
  connect(environment,obc.environment) annotation(Line(points={{-102,65},{-82,65},{-82,16.25},{-55,16.25}},color={0,110,70}));
  connect(obc.activeMissionSelection,activeMissionSelection) annotation(Line(points={{-5,21},{82,21},{82,-45},{102,-45}},color={75,105,145},thickness=0.5));
  annotation(Icon(graphics={Rectangle(extent={{-100,85},{100,-85}},lineColor={25,85,145},fillColor={228,240,250},fillPattern=FillPattern.Solid),Rectangle(extent={{-65,40},{-10,-35}},fillColor={130,185,220},fillPattern=FillPattern.Solid),Ellipse(extent={{15,40},{70,10}},fillColor={105,155,205},fillPattern=FillPattern.Solid),Rectangle(extent={{15,25},{70,-35}},fillColor={190,215,235},fillPattern=FillPattern.Solid),Text(extent={{-92,-82},{92,-58}},textString="OBC + STORAGE")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}}),graphics={Text(extent={{-90,76},{90,62}},textString="任务/状态/工程遥测与数据存储")}),Documentation(info="<html><h4>分系统职责</h4><p><b>系统角色：</b>集成星务计算机和数据记录器，完成任务、状态数据库、遥测处理和业务数据存储</p><p><b>1+4+8位置：</b>八个N-System之一；上接四个Overall，下接专业Components</p><h4>白箱组成与连接</h4><p><b>实现：</b>OnboardComputerUnit与DataRecorderUnit通过同一InformationPort共享指令、设备状态、业务数据和星上工程遥测</p><p><b>内部设备：</b>obc（OnboardComputerUnit）、recorder（DataRecorderUnit）</p><p><b>对外端口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、information（InformationPort）、environment（EnvironmentPort）</p><p><b>运行行为：</b>OBC生成任务指令与工程遥测；记录器对相机写入与X波段读出净速率积分</p><h4>状态与遥测</h4><p><b>关键对象：</b>任务时序、状态数据库、遥测调度、采样保持和storedBytes</p><p><b>关键状态：</b>任务模式、包序列、状态快照、工程量保持和存储量</p><p><b>遥测关系：</b>这是Physical Component到总体onboardTelemetry的核心处理节点；不设置平行传感器遥测接口</p><p><b>建模约束：</b>本模型仅含connect语句；所有设备只保留一组信息、热和机械接口，适用时再增加电源或环境接口。</p></html>"));
end DataHandlingSystem;
