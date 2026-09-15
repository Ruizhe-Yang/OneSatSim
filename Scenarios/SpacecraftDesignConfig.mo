within OneSatSim.Scenarios;
record SpacecraftDesignConfig "整星分层硬件设计配置类型"
  parameter DesignConfigRecords.CommunicationDesignConfig communication;
  parameter DesignConfigRecords.DataHandlingDesignConfig dataHandling;
  parameter DesignConfigRecords.EpsDesignConfig eps;
  parameter DesignConfigRecords.GncDesignConfig gnc;
  parameter DesignConfigRecords.NavigationDesignConfig navigation;
  parameter DesignConfigRecords.PayloadDesignConfig payload;
  parameter DesignConfigRecords.StructureDesignConfig structure;
  parameter DesignConfigRecords.ThermalControlDesignConfig thermalControl;
  annotation(Documentation(info="<html><h4>功能定位</h4><p>按EPS、GNC、Payload、DataHandling、Communication、Navigation、ThermalControl与Structure八个专业分系统聚合设备配置。</p><h4>适用边界</h4><p>仅包含硬件和设备功能参数；任务控制律、场景初值与仿真设置不属于本记录。</p></html>"));
end SpacecraftDesignConfig;
