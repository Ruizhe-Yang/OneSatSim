within NISSA_12UCubeSat.Scenarios.DesignConfigRecords;
record PayloadDesignConfig "payload分系统设计配置"
  parameter EarthCameraComponentConfig earthCamera;
  parameter FotonAmurComponentConfig fotonAmur;
  parameter NaviEnhanceComponentConfig naviEnhance;
  parameter SelfieCameraComponentConfig selfieCamera;
  parameter SpaceTimeComponentConfig spaceTime;
  annotation(Documentation(info="<html><p>按设备实例聚合本分系统硬件设计配置；不包含任务控制律和仿真初始条件。</p></html>"));
end PayloadDesignConfig;
