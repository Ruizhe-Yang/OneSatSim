within OneSatSim.Simulation;
model OnboardTelemetry "只读星上工程遥测"
  OneSatSim.Foundation.Interfaces.OnboardTelemetryPort telemetry 
     "只读遥测信息接口" annotation(Placement(transformation(origin={-100,0},
extent={{-2,-2},{2,2}}),
iconTransformation(origin={-92,10},
extent={{-10,-10},{10,10}}),
iconVisible=true));
  output Real batterySOC(unit="1") "BMS荷电状态";
  output Real batteryVoltage(unit="V") "电池端电压";
  output Real batteryCurrent(unit="A") "电池端电流(+放电)";
  output Real busVoltage[3](each unit="V") "12/5/3.3V轨实测";
  output Real solarNetPower(unit="W") "太阳阵净交付功率";
  output Real threeRailLoadPower(unit="W") "三轨输出负载功率";
  output Boolean batteryChargeAllowed "BMS允许充电";
  output Real batteryCellTemperature(unit="degC") "电芯温度";
  output Real batteryCaseTemperature(unit="degC") "电池壳温度";
  output Real obcCpuTemperature(unit="degC") "OBC CPU温度";
  output Real obcBoardTemperature(unit="degC") "OBC板温";
  output Real cameraFocalTemperature(unit="degC") "相机焦面温度";
  output Real cameraOpticsTemperature(unit="degC") "相机光机温度";
  output Real transmitterTemperature(unit="degC") "X波段功放温度";
  output Real attitudeQuaternion[4](each unit="1") "Y星敏实测四元数";
  output Real bodyRate[3](each unit="deg/s") "机体系陀螺角速率";
  output Real wheelSpeed[4](each unit="rpm") "四轮转速";
  output Real attitudeError(unit="deg") "指向误差";
  output Boolean attitudeReadingValid "星敏读数有效";
  output Real gnssPosition[3](each unit="m") "GNSS GCRS位置";
  output Real gnssVelocity[3](each unit="m/s") "GNSS GCRS速度";
  output Integer gnssFix "GNSS有效标志";
  output Integer missionMode "任务模式";
  output Integer executionStatus "执行状态";
  output Integer requestId "当前/最近请求ID";
  output Integer activeTargetId "锁存目标ID";
  output Integer activeStationId "锁存地面站ID";
  output Integer completedImagingCount "完整成像计数";
  output Integer completedDownlinkCount "下传完成计数";
  output Integer lastCompletedTargetId "最近完成目标ID";
  output Integer lastTerminalRequestId "最近终止请求ID";
  output Integer lastTerminalReasonCode "最近终止原因码";
  output Integer cameraStatus "相机工作状态";
  output Integer transmitterStatus "X波段发射状态";
  output Real storedBytes(unit="byte") "有效存储量";
  output Real acceptedWriteRate(unit="byte/s") "记录器实际写率";
  output Real actualReadRate(unit="byte/s") "真实下传读率";
  output Real validImageBytes(unit="byte") "最近完整图有效字节";
  output Boolean imagingOpportunity "成像几何机会";
  output Boolean downlinkOpportunity "地面站机会";
equation
  batterySOC=telemetry.SAT_S0_batterySOC;
  batteryVoltage=telemetry.SAT_S0_batteryVoltage_V;
  batteryCurrent=telemetry.SAT_S0_batteryCurrent_A;
  busVoltage=telemetry.SAT_S0_busVoltage_V;
  solarNetPower=telemetry.SOLAR_netDeliveredPower_W;
  threeRailLoadPower=telemetry.POWER_threeRailOutputPower_W;
  batteryChargeAllowed=telemetry.BMS_chargeAllowed;
  batteryCellTemperature=telemetry.TCB_S0_thermistor_degC[31];
  batteryCaseTemperature=telemetry.TCB_S0_thermistor_degC[32];
  obcCpuTemperature=telemetry.SAT_S3_cpuTemperature_degC;
  obcBoardTemperature=telemetry.SAT_S3_boardTemperature_degC;
  cameraFocalTemperature=telemetry.TCB_S0_thermistor_degC[20];
  cameraOpticsTemperature=telemetry.TCB_S0_thermistor_degC[21];
  transmitterTemperature=telemetry.THERM_transmitter_degC;
  attitudeQuaternion=telemetry.SAT_S2_starY_q;
  bodyRate=telemetry.SAT_S2_YH50_deg_s;
  wheelSpeed=telemetry.SAT_S2_wheel_rpm;
  attitudeError=telemetry.SAT_S3_attitudeError_deg;
  attitudeReadingValid=telemetry.ATT_starY_valid;
  gnssPosition=telemetry.SAT_S2_GNSS_position_m;
  gnssVelocity=telemetry.SAT_S2_GNSS_velocity_m_s;
  gnssFix=telemetry.GNSS_fix;
  missionMode=telemetry.SAT_S3_missionMode;
  executionStatus=telemetry.SAT_S3_commandExecutionStatus;
  requestId=telemetry.SAT_S3_commandId;
  activeTargetId=telemetry.MISSION_targetIndex;
  activeStationId=telemetry.MISSION_stationIndex;
  completedImagingCount=telemetry.MISSION_completedImagingCount;
  completedDownlinkCount=telemetry.MISSION_completedDownlinkCount;
  lastCompletedTargetId=telemetry.MISSION_lastCompletedTargetIndex;
  lastTerminalRequestId=telemetry.MISSION_lastTerminalRequestId;
  lastTerminalReasonCode=telemetry.MISSION_lastTerminalReasonCode;
  cameraStatus=telemetry.Camera_status;
  transmitterStatus=telemetry.TRANSMITTER_status;
  storedBytes=telemetry.DATA_storedBytes;
  acceptedWriteRate=telemetry.DATA_acceptedWriteRate_B_s;
  actualReadRate=telemetry.DATA_actualReadRate_B_s;
  validImageBytes=telemetry.SAT_S3_imagingValidImageBytes;
  imagingOpportunity=telemetry.SAT_S3_imagingOpportunity;
  downlinkOpportunity=telemetry.SAT_S3_downlinkOpportunity;
  annotation(Documentation(info="<html><h2>只读星上工程遥测</h2><p><b>类路径：</b><code>OneSatSim.Simulation.OnboardTelemetry</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>只读星上工程遥测</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Simulation.CompleteMission\">OneSatSim.Simulation.CompleteMission</a> 的 <code>onboardTelemetry</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>telemetry</code></td><td>OneSatSim.Foundation.Interfaces.OnboardTelemetryPort</td><td>public</td><td>按声明/类型合同</td><td>只读遥测信息接口</td></tr><tr><td><code>batterySOC</code></td><td>Real</td><td>output</td><td>1</td><td>BMS荷电状态</td></tr><tr><td><code>batteryVoltage</code></td><td>Real</td><td>output</td><td>V</td><td>电池端电压</td></tr><tr><td><code>batteryCurrent</code></td><td>Real</td><td>output</td><td>A</td><td>电池端电流(+放电)</td></tr><tr><td><code>busVoltage[3]</code></td><td>Real</td><td>output</td><td>V</td><td>12/5/3.3V轨实测</td></tr><tr><td><code>solarNetPower</code></td><td>Real</td><td>output</td><td>W</td><td>太阳阵净交付功率</td></tr><tr><td><code>threeRailLoadPower</code></td><td>Real</td><td>output</td><td>W</td><td>三轨输出负载功率</td></tr><tr><td><code>batteryChargeAllowed</code></td><td>Boolean</td><td>output</td><td>按声明/类型合同</td><td>BMS允许充电</td></tr><tr><td><code>batteryCellTemperature</code></td><td>Real</td><td>output</td><td>degC</td><td>电芯温度</td></tr><tr><td><code>batteryCaseTemperature</code></td><td>Real</td><td>output</td><td>degC</td><td>电池壳温度</td></tr><tr><td><code>obcCpuTemperature</code></td><td>Real</td><td>output</td><td>degC</td><td>OBC CPU温度</td></tr><tr><td><code>obcBoardTemperature</code></td><td>Real</td><td>output</td><td>degC</td><td>OBC板温</td></tr><tr><td><code>cameraFocalTemperature</code></td><td>Real</td><td>output</td><td>degC</td><td>相机焦面温度</td></tr><tr><td><code>cameraOpticsTemperature</code></td><td>Real</td><td>output</td><td>degC</td><td>相机光机温度</td></tr><tr><td><code>transmitterTemperature</code></td><td>Real</td><td>output</td><td>degC</td><td>X波段功放温度</td></tr><tr><td><code>attitudeQuaternion[4]</code></td><td>Real</td><td>output</td><td>1</td><td>Y星敏实测四元数</td></tr><tr><td><code>bodyRate[3]</code></td><td>Real</td><td>output</td><td>deg/s</td><td>机体系陀螺角速率</td></tr><tr><td><code>wheelSpeed[4]</code></td><td>Real</td><td>output</td><td>rpm</td><td>四轮转速</td></tr><tr><td><code>attitudeError</code></td><td>Real</td><td>output</td><td>deg</td><td>指向误差</td></tr><tr><td><code>attitudeReadingValid</code></td><td>Boolean</td><td>output</td><td>按声明/类型合同</td><td>星敏读数有效</td></tr><tr><td><code>gnssPosition[3]</code></td><td>Real</td><td>output</td><td>m</td><td>GNSS GCRS位置</td></tr><tr><td><code>gnssVelocity[3]</code></td><td>Real</td><td>output</td><td>m/s</td><td>GNSS GCRS速度</td></tr><tr><td><code>gnssFix</code></td><td>Integer</td><td>output</td><td>按声明/类型合同</td><td>GNSS有效标志</td></tr><tr><td><code>missionMode</code></td><td>Integer</td><td>output</td><td>按声明/类型合同</td><td>任务模式</td></tr><tr><td><code>executionStatus</code></td><td>Integer</td><td>output</td><td>按声明/类型合同</td><td>执行状态</td></tr><tr><td><code>requestId</code></td><td>Integer</td><td>output</td><td>按声明/类型合同</td><td>当前/最近请求ID</td></tr><tr><td><code>activeTargetId</code></td><td>Integer</td><td>output</td><td>按声明/类型合同</td><td>锁存目标ID</td></tr><tr><td><code>activeStationId</code></td><td>Integer</td><td>output</td><td>按声明/类型合同</td><td>锁存地面站ID</td></tr><tr><td><code>completedImagingCount</code></td><td>Integer</td><td>output</td><td>按声明/类型合同</td><td>完整成像计数</td></tr><tr><td><code>completedDownlinkCount</code></td><td>Integer</td><td>output</td><td>按声明/类型合同</td><td>下传完成计数</td></tr><tr><td><code>lastCompletedTargetId</code></td><td>Integer</td><td>output</td><td>按声明/类型合同</td><td>最近完成目标ID</td></tr><tr><td><code>lastTerminalRequestId</code></td><td>Integer</td><td>output</td><td>按声明/类型合同</td><td>最近终止请求ID</td></tr><tr><td><code>lastTerminalReasonCode</code></td><td>Integer</td><td>output</td><td>按声明/类型合同</td><td>最近终止原因码</td></tr><tr><td><code>cameraStatus</code></td><td>Integer</td><td>output</td><td>按声明/类型合同</td><td>相机工作状态</td></tr><tr><td><code>transmitterStatus</code></td><td>Integer</td><td>output</td><td>按声明/类型合同</td><td>X波段发射状态</td></tr><tr><td><code>storedBytes</code></td><td>Real</td><td>output</td><td>byte</td><td>有效存储量</td></tr><tr><td><code>acceptedWriteRate</code></td><td>Real</td><td>output</td><td>byte/s</td><td>记录器实际写率</td></tr><tr><td><code>actualReadRate</code></td><td>Real</td><td>output</td><td>byte/s</td><td>真实下传读率</td></tr><tr><td><code>validImageBytes</code></td><td>Real</td><td>output</td><td>byte</td><td>最近完整图有效字节</td></tr><tr><td><code>imagingOpportunity</code></td><td>Boolean</td><td>output</td><td>按声明/类型合同</td><td>成像几何机会</td></tr><tr><td><code>downlinkOpportunity</code></td><td>Boolean</td><td>output</td><td>按声明/类型合同</td><td>地面站机会</td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] batterySOC=telemetry.SAT_S0_batterySOC;\n[equation] batteryVoltage=telemetry.SAT_S0_batteryVoltage_V;\n[equation] batteryCurrent=telemetry.SAT_S0_batteryCurrent_A;\n[equation] busVoltage=telemetry.SAT_S0_busVoltage_V;\n[equation] solarNetPower=telemetry.SOLAR_netDeliveredPower_W;\n[equation] threeRailLoadPower=telemetry.POWER_threeRailOutputPower_W;\n[equation] batteryChargeAllowed=telemetry.BMS_chargeAllowed;\n[equation] batteryCellTemperature=telemetry.TCB_S0_thermistor_degC[31];\n[equation] batteryCaseTemperature=telemetry.TCB_S0_thermistor_degC[32];\n[equation] obcCpuTemperature=telemetry.SAT_S3_cpuTemperature_degC;</pre><p>本类另有30段语句；阅读完整源码可查看其余边界与逻辑。</p></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={
      Rectangle(extent={{-84,-43},{84,72}}, lineColor={35,45,65}, fillColor={35,45,65}, fillPattern=FillPattern.Solid, radius=3),
      Rectangle(extent={{-70,-29},{70,58}}, lineColor={0,102,255}, fillColor={0,102,255}, fillPattern=FillPattern.Solid, radius=0),
      Line(points={{-49,8},{-30,8},{-17,32},{1,-10},{17,17},{49,17}}, color={255,255,255}, thickness=2, pattern=LinePattern.Solid, smooth=Smooth.None),
      Rectangle(extent={{-10,-70},{10,-43}}, lineColor={35,45,65}, fillColor={35,45,65}, fillPattern=FillPattern.Solid),
      Rectangle(extent={{-47,-81},{47,-70}}, lineColor={35,45,65}, fillColor={35,45,65}, fillPattern=FillPattern.Solid, radius=2),
      Ellipse(extent={{58,-39},{65,-32}}, lineColor={0,200,83}, fillColor={0,200,83}, fillPattern=FillPattern.Solid)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true), graphics={
      Rectangle(extent={{-84,-43},{84,72}}, lineColor={35,45,65}, fillColor={35,45,65}, fillPattern=FillPattern.Solid, radius=3),
      Rectangle(extent={{-70,-29},{70,58}}, lineColor={0,102,255}, fillColor={0,102,255}, fillPattern=FillPattern.Solid, radius=0),
      Line(points={{-49,8},{-30,8},{-17,32},{1,-10},{17,17},{49,17}}, color={255,255,255}, thickness=2, pattern=LinePattern.Solid, smooth=Smooth.None),
      Rectangle(extent={{-10,-70},{10,-43}}, lineColor={35,45,65}, fillColor={35,45,65}, fillPattern=FillPattern.Solid),
      Rectangle(extent={{-47,-81},{47,-70}}, lineColor={35,45,65}, fillColor={35,45,65}, fillPattern=FillPattern.Solid, radius=2),
      Ellipse(extent={{58,-39},{65,-32}}, lineColor={0,200,83}, fillColor={0,200,83}, fillPattern=FillPattern.Solid)
    }));
end OnboardTelemetry;