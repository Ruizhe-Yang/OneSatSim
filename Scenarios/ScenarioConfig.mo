within OneSatSim.Scenarios;
record ScenarioConfig "完整静态场景配置"
  parameter OneSatSim.Foundation.Types.MassProperties massProperties
    "由活动机械刚体离线汇总的统一整星质量、质心与惯量";
  parameter Boolean operationalSnapshotStart
    "从已进入稳定在轨运行状态的快照开始24 h试验";
  parameter Modelica.Units.SI.Time targetPredictionHorizon
    "包含线性化余量的目标准备预测时域";
  parameter Modelica.Units.SI.Time earlyTargetPredictionHorizon
    "提前预机动预测时域";
  parameter OrbitConfig orbit;
  parameter GroundStationConfig groundStations[8];
  parameter ImagingTargetConfig imagingTargets[32];
  parameter InitialConditionConfig initialConditions;
  annotation(Documentation(info="<html><h4>功能定位</h4><p>定义完整静态场景的字段类型，不保存数值默认值。</p><h4>配置边界</h4><p>DefaultScenario是场景与初值的唯一Modelica数值基线；GeneratedScenario只保存Excel覆盖并继承其余字段。</p><h4>使用说明</h4><p>仿真设置由Excel的Simulation工作表受控更新，不属于场景记录。</p></html>"));
end ScenarioConfig;
