within OneSatSim.Foundation.Interfaces;
expandable connector OnboardTelemetryPort "星上工程遥测接口"
  RealSignal SAT_S0_busVoltage_V[3] "12/5/3.3V轨实测" ;
  RealSignal SAT_S0_busCurrent_A[3] "SATS0总线电流A" ;
  RealSignal SAT_S0_subArray_V[3] "计算/接口量 SAT_S0_subArray_V" ;
  RealSignal SAT_S0_MPPT_V[3] "计算/接口量 SAT_S0_MPPT_V" ;
  RealSignal SAT_S0_MPPT_A[3] "计算/接口量 SAT_S0_MPPT_A" ;
  RealSignal SAT_S0_batteryCurrent_A "电池端电流(+放电)；Positive discharge, negative charge";
  RealSignal SAT_S0_batteryVoltage_V "电池端电压" ;
  RealSignal SAT_S0_batterySOC "BMS荷电状态" ;

  RealSignal SAT_S1_thermistor_degC[20] "计算/接口量 SAT_S1_thermistor_degC" ;

  RealSignal SAT_S2_wheel_rpm[4] "四轮转速" ;
  RealSignal SAT_S2_wheel_A[4] "SATS2飞轮A" ;
  IntegerSignal SAT_S2_wheelStatus[4] "SATS2飞轮Status" ;
  RealSignal SAT_S2_starY_q[4] "Y星敏实测四元数" ;
  RealSignal SAT_S2_starZ_q[4] "计算/接口量 SAT_S2_starZ_q" ;
  RealSignal SAT_S2_starY_w_deg_s[3] "计算/接口量 SAT_S2_starY_w_deg_s" ;
  RealSignal SAT_S2_starZ_w_deg_s[3] "计算/接口量 SAT_S2_starZ_w_deg_s" ;
  RealSignal SAT_S2_YH50_deg_s[3] "机体系陀螺角速率" ;
  RealSignal SAT_S2_GNSS_position_m[3] "GNSS GCRS位置" ;
  RealSignal SAT_S2_GNSS_velocity_m_s[3] "GNSS GCRS速度" ;
  RealSignal SAT_S2_magneticField_Gauss[3] "计算/接口量 SAT_S2_magneticField_Gauss" ;
  RealSignal SAT_S2_MEMS_gyro_deg_s[3] "计算/接口量 SAT_S2_MEMS_gyro_deg_s" ;
  RealSignal SAT_S2_MEMS_accel_m_s2[3] "计算/接口量 SAT_S2_MEMS_accel_m_s2" ;
  RealSignal SAT_S2_sunAngle_deg[2] "计算/接口量 SAT_S2_sunAngle_deg" ;

  IntegerSignal SAT_S3_commandErrorCount "SATS3指令误差Count" ;
  IntegerSignal SAT_S3_watchdogCount "计算/接口量 SAT_S3_watchdogCount" ;
  IntegerSignal SAT_S3_bootSeconds "计算/接口量 SAT_S3_bootSeconds" ;
  IntegerSignal SAT_S3_milliseconds "计算/接口量 SAT_S3_milliseconds" ;
  RealSignal SAT_S3_cpuTemperature_degC "OBC CPU温度" ;
  RealSignal SAT_S3_boardTemperature_degC "OBC板温" ;
  IntegerSignal SAT_S3_missionMode "任务模式" ;
  IntegerSignal SAT_S3_controlMode "SATS3控制模式" ;
  IntegerSignal SAT_S3_commandType "SATS3指令Type" ;
  IntegerSignal SAT_S3_commandExecutionStatus "执行状态" ;
  IntegerSignal SAT_S3_rejectReason "计算/接口量 SAT_S3_rejectReason" ;
  IntegerSignal SAT_S3_commandId "当前/最近请求ID" ;
  IntegerSignal SAT_S3_transitionCounter "计算/接口量 SAT_S3_transitionCounter" ;
  RealSignal SAT_S3_executionTime_s "SATS3execution时间s" ;
  BooleanSignal SAT_S3_commandAccepted "SATS3指令Accepted" ;
  BooleanSignal SAT_S3_commandRejected "SATS3指令Rejected" ;
  BooleanSignal SAT_S3_commandExecuting "SATS3指令Executing" ;
  BooleanSignal SAT_S3_commandCompleted "SATS3指令Completed" ;
  BooleanSignal SAT_S3_commandFailed "SATS3指令Failed" ;
  BooleanSignal SAT_S3_commandAborted "SATS3指令Aborted" ;
  BooleanSignal SAT_S3_commandTimeout "SATS3指令Timeout" ;
  BooleanSignal SAT_S3_imagingOpportunity "成像几何机会" ;
  BooleanSignal SAT_S3_downlinkOpportunity "地面站机会" ;
  BooleanSignal SAT_S3_imagingAllowed "SATS3成像Allowed" ;
  BooleanSignal SAT_S3_downlinkAllowed "SATS3下传Allowed" ;
  BooleanSignal SAT_S3_safeModeRequired "SATS3安全模式模式Required" ;
  RealSignal SAT_S3_usedStorage_MB "计算/接口量 SAT_S3_usedStorage_MB" ;
  RealSignal SAT_S3_remainingStorage_MB "计算/接口量 SAT_S3_remainingStorage_MB" ;
  RealSignal SAT_S3_attitudeError_deg "指向误差" ;
  BooleanSignal SAT_S3_attitudeSettled "SATS3姿态Settled" ;
  BooleanSignal SAT_S3_imagingCaptureStarted "SATS3成像CaptureStarted" ;
  BooleanSignal SAT_S3_imagingImageComplete "SATS3成像ImageComplete" ;
  RealSignal SAT_S3_imagingValidImageBytes(unit="1") "最近完整图有效字节 [1]" ;
  IntegerSignal SAT_S3_imagingFailureReason "SATS3成像FailureReason" ;

  IntegerSignal PDB_S0_channelState[24] "PDBS0channel状态" ;
  RealSignal PDB_S0_channelCurrent_A[24] "PDBS0channel电流A" ;

  IntegerSignal TCB_S0_channelState[24] "TCBS0channel状态" ;
  RealSignal TCB_S0_channelCurrent_A[24] "TCBS0channel电流A" ;
  RealSignal TCB_S0_heaterUpper_degC[14] "TCBS0heater上界degC" ;
  RealSignal TCB_S0_heaterLower_degC[14] "TCBS0heater下界degC" ;
  RealSignal TCB_S0_thermistor_degC[32] "相机光机温度" ;

  IntegerSignal GNSS_fix "GNSS有效标志" ;
  IntegerSignal Camera_status "相机工作状态" ;
  IntegerSignal Baseband_status "计算/接口量 Baseband_status" ;
  IntegerSignal TTC_status "计算/接口量 TTC_status" ;
  IntegerSignal StarTrackerY_status "计算/接口量 StarTrackerY_status" ;
  IntegerSignal StarTrackerZ_status "计算/接口量 StarTrackerZ_status" ;
  RealSignal SOLAR_netDeliveredPower_W(unit="W") "太阳阵净交付功率 [W]；Signed sum of the three measured delivered solar terminal powers";
  RealSignal POWER_threeRailOutputPower_W(unit="W") "三轨输出负载功率 [W]；Measured three-rail boundary power without DC/DC double counting";
  BooleanSignal BMS_chargeAllowed "BMS允许充电" ;
  RealSignal THERM_transmitter_degC "X波段功放温度" ;
  BooleanSignal ATT_starY_valid "星敏读数有效" ;
  RealSignal DATA_storedBytes(unit="1") "有效存储量 [1]" ;
  RealSignal DATA_acceptedWriteRate_B_s(unit="1/s") "记录器实际写率 [1/s]" ;
  RealSignal DATA_actualReadRate_B_s(unit="1/s") "真实下传读率 [1/s]" ;
  IntegerSignal MISSION_targetIndex "锁存目标ID" ;
  IntegerSignal MISSION_stationIndex "锁存地面站ID" ;
  IntegerSignal MISSION_completedImagingCount "完整成像计数" ;
  IntegerSignal MISSION_completedDownlinkCount "下传完成计数" ;
  IntegerSignal MISSION_lastCompletedTargetIndex "最近完成目标ID" ;
  IntegerSignal MISSION_lastTerminalRequestId "最近终止请求ID" ;
  IntegerSignal MISSION_lastTerminalReasonCode "最近终止原因码；RejectReason enumeration ordinal; None=1";
  IntegerSignal TRANSMITTER_status "X波段发射状态" ;
  annotation(Documentation(info="<html><h2>星上工程遥测接口</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.OnboardTelemetryPort</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>星上工程遥测接口</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>SAT_S0_busVoltage_V[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>12/5/3.3V轨实测</td></tr><tr><td><code>SAT_S0_busCurrent_A[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>SATS0总线电流A</td></tr><tr><td><code>SAT_S0_subArray_V[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 SAT_S0_subArray_V</td></tr><tr><td><code>SAT_S0_MPPT_V[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 SAT_S0_MPPT_V</td></tr><tr><td><code>SAT_S0_MPPT_A[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 SAT_S0_MPPT_A</td></tr><tr><td><code>SAT_S0_batteryCurrent_A</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>电池端电流(+放电)；Positive discharge, negative charge</td></tr><tr><td><code>SAT_S0_batteryVoltage_V</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>电池端电压</td></tr><tr><td><code>SAT_S0_batterySOC</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>BMS荷电状态</td></tr><tr><td><code>SAT_S1_thermistor_degC[20]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 SAT_S1_thermistor_degC</td></tr><tr><td><code>SAT_S2_wheel_rpm[4]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>四轮转速</td></tr><tr><td><code>SAT_S2_wheel_A[4]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>SATS2飞轮A</td></tr><tr><td><code>SAT_S2_wheelStatus[4]</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>SATS2飞轮Status</td></tr><tr><td><code>SAT_S2_starY_q[4]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>Y星敏实测四元数</td></tr><tr><td><code>SAT_S2_starZ_q[4]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 SAT_S2_starZ_q</td></tr><tr><td><code>SAT_S2_starY_w_deg_s[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 SAT_S2_starY_w_deg_s</td></tr><tr><td><code>SAT_S2_starZ_w_deg_s[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 SAT_S2_starZ_w_deg_s</td></tr><tr><td><code>SAT_S2_YH50_deg_s[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>机体系陀螺角速率</td></tr><tr><td><code>SAT_S2_GNSS_position_m[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>GNSS GCRS位置</td></tr><tr><td><code>SAT_S2_GNSS_velocity_m_s[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>GNSS GCRS速度</td></tr><tr><td><code>SAT_S2_magneticField_Gauss[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 SAT_S2_magneticField_Gauss</td></tr><tr><td><code>SAT_S2_MEMS_gyro_deg_s[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 SAT_S2_MEMS_gyro_deg_s</td></tr><tr><td><code>SAT_S2_MEMS_accel_m_s2[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 SAT_S2_MEMS_accel_m_s2</td></tr><tr><td><code>SAT_S2_sunAngle_deg[2]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 SAT_S2_sunAngle_deg</td></tr><tr><td><code>SAT_S3_commandErrorCount</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>SATS3指令误差Count</td></tr><tr><td><code>SAT_S3_watchdogCount</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 SAT_S3_watchdogCount</td></tr><tr><td><code>SAT_S3_bootSeconds</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 SAT_S3_bootSeconds</td></tr><tr><td><code>SAT_S3_milliseconds</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 SAT_S3_milliseconds</td></tr><tr><td><code>SAT_S3_cpuTemperature_degC</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>OBC CPU温度</td></tr><tr><td><code>SAT_S3_boardTemperature_degC</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>OBC板温</td></tr><tr><td><code>SAT_S3_missionMode</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>任务模式</td></tr><tr><td><code>SAT_S3_controlMode</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>SATS3控制模式</td></tr><tr><td><code>SAT_S3_commandType</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>SATS3指令Type</td></tr><tr><td><code>SAT_S3_commandExecutionStatus</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>执行状态</td></tr><tr><td><code>SAT_S3_rejectReason</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 SAT_S3_rejectReason</td></tr><tr><td><code>SAT_S3_commandId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>当前/最近请求ID</td></tr><tr><td><code>SAT_S3_transitionCounter</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 SAT_S3_transitionCounter</td></tr><tr><td><code>SAT_S3_executionTime_s</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>SATS3execution时间s</td></tr><tr><td><code>SAT_S3_commandAccepted</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>SATS3指令Accepted</td></tr><tr><td><code>SAT_S3_commandRejected</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>SATS3指令Rejected</td></tr><tr><td><code>SAT_S3_commandExecuting</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>SATS3指令Executing</td></tr><tr><td><code>SAT_S3_commandCompleted</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>SATS3指令Completed</td></tr><tr><td><code>SAT_S3_commandFailed</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>SATS3指令Failed</td></tr><tr><td><code>SAT_S3_commandAborted</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>SATS3指令Aborted</td></tr><tr><td><code>SAT_S3_commandTimeout</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>SATS3指令Timeout</td></tr><tr><td><code>SAT_S3_imagingOpportunity</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>成像几何机会</td></tr><tr><td><code>SAT_S3_downlinkOpportunity</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>地面站机会</td></tr><tr><td><code>SAT_S3_imagingAllowed</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>SATS3成像Allowed</td></tr><tr><td><code>SAT_S3_downlinkAllowed</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>SATS3下传Allowed</td></tr><tr><td><code>SAT_S3_safeModeRequired</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>SATS3安全模式模式Required</td></tr><tr><td><code>SAT_S3_usedStorage_MB</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 SAT_S3_usedStorage_MB</td></tr><tr><td><code>SAT_S3_remainingStorage_MB</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 SAT_S3_remainingStorage_MB</td></tr><tr><td><code>SAT_S3_attitudeError_deg</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>指向误差</td></tr><tr><td><code>SAT_S3_attitudeSettled</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>SATS3姿态Settled</td></tr><tr><td><code>SAT_S3_imagingCaptureStarted</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>SATS3成像CaptureStarted</td></tr><tr><td><code>SAT_S3_imagingImageComplete</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>SATS3成像ImageComplete</td></tr><tr><td><code>SAT_S3_imagingValidImageBytes</code></td><td>RealSignal</td><td>public</td><td>1</td><td>最近完整图有效字节 [1]</td></tr><tr><td><code>SAT_S3_imagingFailureReason</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>SATS3成像FailureReason</td></tr><tr><td><code>PDB_S0_channelState[24]</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>PDBS0channel状态</td></tr><tr><td><code>PDB_S0_channelCurrent_A[24]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>PDBS0channel电流A</td></tr><tr><td><code>TCB_S0_channelState[24]</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>TCBS0channel状态</td></tr><tr><td><code>TCB_S0_channelCurrent_A[24]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>TCBS0channel电流A</td></tr><tr><td><code>TCB_S0_heaterUpper_degC[14]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>TCBS0heater上界degC</td></tr><tr><td><code>TCB_S0_heaterLower_degC[14]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>TCBS0heater下界degC</td></tr><tr><td><code>TCB_S0_thermistor_degC[32]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>相机光机温度</td></tr><tr><td><code>GNSS_fix</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>GNSS有效标志</td></tr><tr><td><code>Camera_status</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>相机工作状态</td></tr><tr><td><code>Baseband_status</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 Baseband_status</td></tr><tr><td><code>TTC_status</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 TTC_status</td></tr><tr><td><code>StarTrackerY_status</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 StarTrackerY_status</td></tr><tr><td><code>StarTrackerZ_status</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 StarTrackerZ_status</td></tr><tr><td><code>SOLAR_netDeliveredPower_W</code></td><td>RealSignal</td><td>public</td><td>W</td><td>太阳阵净交付功率 [W]；Signed sum of the three measured delivered solar terminal powers</td></tr><tr><td><code>POWER_threeRailOutputPower_W</code></td><td>RealSignal</td><td>public</td><td>W</td><td>三轨输出负载功率 [W]；Measured three-rail boundary power without DC/DC double counting</td></tr><tr><td><code>BMS_chargeAllowed</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>BMS允许充电</td></tr><tr><td><code>THERM_transmitter_degC</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>X波段功放温度</td></tr><tr><td><code>ATT_starY_valid</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>星敏读数有效</td></tr><tr><td><code>DATA_storedBytes</code></td><td>RealSignal</td><td>public</td><td>1</td><td>有效存储量 [1]</td></tr><tr><td><code>DATA_acceptedWriteRate_B_s</code></td><td>RealSignal</td><td>public</td><td>1/s</td><td>记录器实际写率 [1/s]</td></tr><tr><td><code>DATA_actualReadRate_B_s</code></td><td>RealSignal</td><td>public</td><td>1/s</td><td>真实下传读率 [1/s]</td></tr><tr><td><code>MISSION_targetIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>锁存目标ID</td></tr><tr><td><code>MISSION_stationIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>锁存地面站ID</td></tr><tr><td><code>MISSION_completedImagingCount</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>完整成像计数</td></tr><tr><td><code>MISSION_completedDownlinkCount</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>下传完成计数</td></tr><tr><td><code>MISSION_lastCompletedTargetIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>最近完成目标ID</td></tr><tr><td><code>MISSION_lastTerminalRequestId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>最近终止请求ID</td></tr><tr><td><code>MISSION_lastTerminalReasonCode</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>最近终止原因码；RejectReason enumeration ordinal; None=1</td></tr><tr><td><code>TRANSMITTER_status</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>X波段发射状态</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={213,0,143},lineColor={213,0,143},lineThickness=0,radius=0),
      Rectangle(extent={{-53,-20},{53,48}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,radius=0),
      Rectangle(extent={{-8,-42},{8,-20}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Rectangle(extent={{-34,-52},{34,-42}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={213,0,143},lineColor={213,0,143},lineThickness=0,radius=0),
      Rectangle(extent={{-53,-20},{53,48}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,radius=0),
      Rectangle(extent={{-8,-42},{8,-20}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Rectangle(extent={{-34,-52},{34,-42}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0)
    }));
end OnboardTelemetryPort;