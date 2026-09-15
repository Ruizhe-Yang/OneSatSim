within OneSatSim.Simulation;
model CompleteMission "真实历元完整任务仿真入口"
  parameter OneSatSim.Scenarios.GeneratedScenario scenario=
    OneSatSim.Scenarios.GeneratedScenario()
    "由根目录DesignConfig.xlsx离线生成的任务场景与初始条件";
  parameter OneSatSim.Scenarios.GeneratedSpacecraftDesignConfig designConfig=
    OneSatSim.Scenarios.GeneratedSpacecraftDesignConfig()
    "由根目录DesignConfig.xlsx离线生成的整星硬件设计配置";
  Systems.SpacecraftSystem spacecraft(scenario=scenario,designConfig=designConfig) annotation(Placement(transformation(origin={-17,-8.88178e-16},
extent={{-45,-45},{45,45}})));
  Foundation.Interfaces.OnboardTelemetryPort onboardTelemetry annotation(Placement(transformation(origin={80,-24.75},
extent={{-10,-10},{10,10}})));
equation
  connect(spacecraft.onboardTelemetry,onboardTelemetry) annotation(Line(origin={0,0},
points={{32.5,-24.75},{80,-24.75}},
color={0,105,165},
thickness=0.5));
  annotation(experiment(StartTime=0.0,StopTime=86400.0,Interval=1.0,Tolerance=1e-05),Icon(graphics={Rectangle(extent={{-100,90},{100,-90}},lineColor={35,75,120},fillColor={232,242,250},fillPattern=FillPattern.Solid),Polygon(points={{-45,45},{45,0},{-45,-45},{-45,45}},fillColor={45,130,195},fillPattern=FillPattern.Solid),Text(extent={{-88,-82},{88,-58}},textString="IDA / EPOCH / CONFIG")}),Diagram(coordinateSystem(extent={{-100,-70},{110,70}},
grid={2,2}),graphics = {Rectangle(origin={-16,0},
lineColor={35,75,120},
pattern=LinePattern.Dash,
extent={{-56,55},{56,-55}})}),Documentation(info="<html><h4>功能定位</h4><p>唯一完整任务仿真入口。根目录DesignConfig.xlsx经UpdateConfig.bat校验后，生成绝对时间、初始轨道状态、连续环境表、任务场景与整星硬件配置。</p><h4>模型结构</h4><p>仅实例化SpacecraftSystem，并把其onboardTelemetry连接到同名输出；顶层equation仅包含connect()，保持纯连接白箱。</p><h4>时间与求解</h4><p>Modelica time始终从0 s开始；StopTime由Excel中的物理Duration换算。日历历元只在离线环境生成阶段绑定。IDA采用自适应内部步长，OutputInterval仅定义规则结果输出网格。</p><h4>使用说明</h4><p>打开根目录DesignConfig.xlsx填写日期、时区、时长和完整轨道状态，保存后双击UpdateConfig.bat；成功后在OpenModelica中手动运行本模型。Modelica运行时只读取本地生成资源，不联网或调用Python。</p></html>"),__OpenModelica_commandLineOptions="--maxSizeLinearTearing=1000",__OpenModelica_simulationFlags(s="ida",idaLS="spgmr",jacobian="coloredNumerical"),__MWORKS(ContinueSimConfig(SaveContinueFile="false",SaveBeforeStop="false",NumberBeforeStop=1,FixedContinueInterval="false",ContinueIntervalLength=10,ContinueTimeVector)));
end CompleteMission;
