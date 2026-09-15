within OneSatSim.Scenarios.DesignConfigRecords;
record CommunicationDesignConfig "communication分系统设计配置"
  parameter AntennaComponentConfig antenna;
  parameter BasebandComponentConfig baseband;
  parameter TtcReceiverComponentConfig ttcReceiver;
  parameter XbandComponentConfig xband;
  annotation(Documentation(info="<html><p>按设备实例聚合本分系统硬件设计配置；不包含任务控制律和仿真初始条件。</p></html>"));
end CommunicationDesignConfig;
