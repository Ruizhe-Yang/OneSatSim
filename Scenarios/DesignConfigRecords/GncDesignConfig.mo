within NISSA_12UCubeSat.Scenarios.DesignConfigRecords;
record GncDesignConfig "gnc分系统设计配置"
  parameter ComputerComponentConfig computer;
  parameter MagnetometerComponentConfig magnetometer;
  parameter MagnetorquerComponentConfig magnetorquer;
  parameter MemsIMUComponentConfig memsIMU;
  parameter RateGyroComponentConfig rateGyro;
  parameter StarYComponentConfig starY;
  parameter StarZComponentConfig starZ;
  parameter SunSensorComponentConfig sunSensor;
  parameter WheelSComponentConfig wheelS;
  parameter WheelXComponentConfig wheelX;
  parameter WheelYComponentConfig wheelY;
  parameter WheelZComponentConfig wheelZ;
  annotation(Documentation(info="<html><p>按设备实例聚合本分系统硬件设计配置；不包含任务控制律和仿真初始条件。</p></html>"));
end GncDesignConfig;
