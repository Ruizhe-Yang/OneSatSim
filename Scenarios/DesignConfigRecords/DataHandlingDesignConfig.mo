within NISSA_12UCubeSat.Scenarios.DesignConfigRecords;
record DataHandlingDesignConfig "dataHandling分系统设计配置"
  parameter ObcComponentConfig obc;
  parameter RecorderComponentConfig recorder;
  annotation(Documentation(info="<html><p>按设备实例聚合本分系统硬件设计配置；不包含任务控制律和仿真初始条件。</p></html>"));
end DataHandlingDesignConfig;
