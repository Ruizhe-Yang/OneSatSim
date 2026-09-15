within OneSatSim.Foundation.Interfaces;
expandable connector DeviceStatusBus "设备测量与状态总线"
  RealSignal busVoltage[3](each unit="V");
  RealSignal busCurrent[3](each unit="A");
  RealSignal subArrayVoltage[3](each unit="V") "Independent pre-MPPT solar-array voltage";
  RealSignal mpptVoltage[3](each unit="V");
  RealSignal mpptCurrent[3](each unit="A");
  RealSignal solarOutputPower[3](each unit="W")
    "Each wing terminal power: regulated 12 V terminal voltage times delivered current";
  RealSignal availableSolarPower[3](each unit="W")
    "Geometry-limited power before MPPT/BCR/PCDU curtailment";
  RealSignal solarIncidenceCos[3] "Independent body-face incidence cosines";
  RealSignal totalAvailableSolarPower(unit="W");
  RealSignal totalDeliveredSolarPower(unit="W");
  RealSignal rawSourceBusVoltageAverage(unit="V")
    "Slow raw-bus voltage used by average-value MPPT current commands";
  RealSignal solarCurtailmentFactor
    "0..1 source-side MPPT limit when battery charging is inhibited";
  RealSignal chargerVoltage[2](each unit="V");
  RealSignal chargerCurrent[2](each unit="A");
  RealSignal batteryVoltage(unit="V");
  RealSignal batterySOC "0..1 electrochemical state of charge";
  BooleanSignal batteryChargeAllowed
    "BMS charge permission; discharge remains available when false";
  IntegerSignal pdState[24];
  IntegerSignal tcState[24];
  RealSignal pdCurrent[24](each unit="A");
  RealSignal tcCurrent[24](each unit="A");
  RealSignal thermistorTemperature[32](each unit="K");
  BooleanSignal thermistorValid[32]
    "False identifies interface placeholders that are not physical measurements";
  RealSignal heaterUpper[14](each unit="K");
  RealSignal heaterLower[14](each unit="K");
  RealSignal wheelSpeed[4](each unit="rad/s");
  RealSignal wheelMomentum[4](each unit="kg.m2/s");
  BooleanSignal wheelSaturated[4];
  RealSignal wheelCurrent[4](each unit="A");
  IntegerSignal wheelStatus[4];
  RealSignal starQuaternion[2,4];
  RealSignal starAngularVelocity[2,3](each unit="rad/s");
  IntegerSignal starStatus[2];
  IntegerSignal starPacketType[2];
  RealSignal yh50Rate[3](each unit="rad/s");
  RealSignal mems[6];
  RealSignal magneticField[3](each unit="T");
  RealSignal sunAngle[2](each unit="rad");
  RealSignal gnssPosition[3](each unit="m");
  RealSignal gnssVelocity[3](each unit="m/s");
  IntegerSignal gnssFix;
  IntegerSignal cameraStatus;
  IntegerSignal cmosStatus;
  IntegerSignal naviEnhanceStatus;
  IntegerSignal spaceTimeStatus;
  IntegerSignal fotonAmurStatus;
  IntegerSignal ttcStatus;
  IntegerSignal basebandStatus;
  IntegerSignal transmitterStatus;
  RealSignal transmitterTemperature(unit="K");
  RealSignal attitudeError(unit="rad");
  RealSignal primaryPointingError(unit="rad");
  RealSignal secondaryPointingError(unit="rad");
  RealSignal bodyRateMagnitude(unit="rad/s");
  RealSignal bodyRate[3](each unit="rad/s")
    "Body angular-rate vector used by low-cost safe-mode detumbling";
  BooleanSignal attitudeSettled;
  BooleanSignal attitudeReady "Dwell-qualified attitude readiness diagnostic";
  BooleanSignal imagingAttitudeReady "载荷主视轴、跟踪率、驻留和成像几何均合格";
  BooleanSignal groundLinkAttitudeReady "通信主视轴、跟踪率、驻留和地面接触均合格";
  BooleanSignal imagingWindowReady
    "Formal visibility, off-nadir, boresight-FOV and illumination diagnostic";
  BooleanSignal momentumDumpActive "Normal-mode reaction-wheel momentum unloading latch";
  ControlModeSignal actualControlMode;
  AttitudeControlStateSignal attitudeControlState;
  RealSignal magnetorquerTorque[3](each unit="N.m");
  IntegerSignal commandErrorCount;
  IntegerSignal watchdogCount;
  RealSignal cpuTemperature(unit="K");
  RealSignal boardTemperature(unit="K");
  annotation(Icon(graphics={Rectangle(extent={{-100,60},{100,-60}},lineColor={20,100,155},fillColor={225,242,250},fillPattern=FillPattern.Solid),Text(extent={{-90,22},{90,-18}},textString="DEVICE STATE")}),Documentation(info="<html><h4>接口语义</h4><p><b>用途：</b>汇集全部单机测量、状态、热敏、功率和姿态导航数据</p><p><b>字段与单位：</b>3路母线/子阵/MPPT、三翼端口输出功率、2路充电、24路PDB/TCB、32路热敏、4轮、2星敏、惯导、磁场、太阳角、GNSS、载荷通信及板温</p><p><b>功率截面：</b>solarOutputPower[i]严格等于第i翼受控12 V端口电压乘以该翼向汇流端交付的电流；它与MPPT控制器侧电压遥测不是同一测量截面。</p><p><b>信号方向语义：</b>各Components通过因果发布边界提供相应字段；OnboardComputerUnit读取并形成状态数据库</p><p><b>典型连接：</b>InformationPort内部，是Physical Component到OBC state的唯一设备数据路径</p><p><b>建模注意：</b>该接口是可扩展信息总线，不包含伪造flow变量；字段名称表达工程语义，不能仅凭曲线数组序号判断来源。</p></html>"));
end DeviceStatusBus;
