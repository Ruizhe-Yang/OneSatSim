within NISSA_12UCubeSat.Scenarios.DesignConfigRecords;
record EpsDesignConfig "eps分系统设计配置"
  parameter BatteryComponentConfig battery;
  parameter PcduComponentConfig pcdu;
  parameter SolarArrayMinusXComponentConfig solarArrayMinusX;
  parameter SolarArrayPlusXComponentConfig solarArrayPlusX;
  parameter SolarArrayPlusYComponentConfig solarArrayPlusY;
  annotation(Documentation(info="<html><p>按设备实例聚合本分系统硬件设计配置；不包含任务控制律和仿真初始条件。</p></html>"));
end EpsDesignConfig;
