within OneSatSim.Foundation.Interfaces;
expandable connector DeviceStatusBus "设备测量与状态总线"
  RealSignal busVoltage[3](each unit="V") "12/5/3.3V轨实测 [V]" ;
  RealSignal busCurrent[3](each unit="A") "总线电流 [A]" ;
  RealSignal threeRailOutputPower(unit="W")
    "threeRail输出功率 [W]；Signed measured power delivered to final 12/5/3.3 V loads; excludes the two converter input branches from 12 V to avoid double count";
  RealSignal subArrayVoltage[3](each unit="V") "subArray电压 [V]；Independent pre-MPPT solar-array voltage";
  RealSignal mpptVoltage[3](each unit="V") "mppt电压 [V]" ;
  RealSignal mpptCurrent[3](each unit="A") "mppt电流 [A]" ;
  RealSignal solarOutputPower[3](each unit="W")
    "solar输出功率 [W]；Signed net power delivered at each raw-source solar wing terminal, after its local physical shunt";
  RealSignal availableSolarPower[3](each unit="W")
    "availableSolar功率 [W]；Geometry-limited power before MPPT/BCR/PCDU curtailment";
  RealSignal solarIncidenceCos[3] "计算/接口量 solarIncidenceCos；Independent body-face incidence cosines";
  RealSignal totalAvailableSolarPower(unit="W") "totalAvailableSolar功率 [W]" ;
  RealSignal totalDeliveredSolarPower(unit="W") "totalDeliveredSolar功率 [W]" ;
  RealSignal rawSourceBusVoltageAverage(unit="V")
    "raw源总线电压Average [V]；Slow raw-bus voltage used by average-value MPPT current commands";
  RealSignal solarCurtailmentFactor
    "计算/接口量 solarCurtailmentFactor；0..1 source-side MPPT limit when battery charging is inhibited";
  RealSignal batteryVoltage(unit="V") "电池端电压 [V]" ;
  RealSignal batterySOC "BMS荷电状态；0..1 BMS coulomb-count estimate from measured battery branch current, not physical cell-stack SOC";
  BooleanSignal batteryChargeAllowed
    "BMS允许充电；BMS charge permission; discharge remains available when false";
  IntegerSignal pdState[24] "pd状态" ;
  IntegerSignal tcState[24] "tc状态" ;
  RealSignal pdCurrent[24](each unit="A") "pd电流 [A]" ;
  RealSignal tcCurrent[24](each unit="A") "tc电流 [A]" ;
  RealSignal thermistorTemperature[32](each unit="K") "thermistor温度 [K]" ;
  BooleanSignal thermistorValid[32]
    "计算/接口量 thermistorValid；False identifies interface placeholders that are not physical measurements";
  RealSignal heaterUpper[14](each unit="K") "heater上界 [K]" ;
  RealSignal heaterLower[14](each unit="K") "heater下界 [K]" ;
  RealSignal wheelSpeed[4](each unit="rad/s") "四轮转速 [rad/s]" ;
  RealSignal wheelMomentum[4](each unit="kg.m2/s") "飞轮Momentum [kg.m2/s]" ;
  BooleanSignal wheelSaturated[4] "飞轮Saturated" ;
  RealSignal wheelCurrent[4](each unit="A") "飞轮电流 [A]" ;
  IntegerSignal wheelStatus[4] "飞轮Status" ;
  RealSignal starQuaternion[2,4] "star四元数" ;
  RealSignal starAngularVelocity[2,3](each unit="rad/s") "计算/接口量 starAngularVelocity [rad/s]" ;
  IntegerSignal starStatus[2] "计算/接口量 starStatus" ;
  IntegerSignal starPacketType[2] "计算/接口量 starPacketType" ;
  RealSignal yh50Rate[3](each unit="rad/s") "yh50速率 [rad/s]" ;
  RealSignal mems[6]
    "计算/接口量 mems；1:3 body-frame angular velocity rad/s; 4:6 ideal body-frame specific force m/s2 from the local NoGravity free-fall mechanical model";
  RealSignal orbitalAccelerationGCRS[3](each unit="m/s2")
    "计算/接口量 orbitalAccelerationGCRS [m/s2]；Engineering diagnostic only: central-gravity acceleration in GCRS, not an onboard accelerometer sample";
  RealSignal magneticField[3](each unit="T") "计算/接口量 magneticField [T]" ;
  RealSignal sunAngle[2](each unit="rad") "计算/接口量 sunAngle [rad]" ;
  RealSignal gnssPosition[3](each unit="m") "GNSS GCRS位置 [m]" ;
  RealSignal gnssVelocity[3](each unit="m/s") "GNSS GCRS速度 [m/s]" ;
  IntegerSignal gnssFix "GNSS有效标志" ;
  IntegerSignal cameraStatus "相机工作状态" ;
  IntegerSignal cmosStatus "计算/接口量 cmosStatus" ;
  IntegerSignal naviEnhanceStatus "计算/接口量 naviEnhanceStatus" ;
  IntegerSignal spaceTimeStatus "space时间Status" ;
  IntegerSignal fotonAmurStatus "计算/接口量 fotonAmurStatus" ;
  IntegerSignal ttcStatus "计算/接口量 ttcStatus" ;
  IntegerSignal basebandStatus "计算/接口量 basebandStatus" ;
  IntegerSignal transmitterStatus "X波段发射状态" ;
  RealSignal transmitterTemperature(unit="K") "X波段功放温度 [K]" ;
  RealSignal attitudeError(unit="rad") "指向误差 [rad]" ;
  RealSignal primaryPointingError(unit="rad") "primaryPointing误差 [rad]" ;
  RealSignal secondaryPointingError(unit="rad") "secondaryPointing误差 [rad]" ;
  RealSignal bodyRateMagnitude(unit="rad/s") "本体速率Magnitude [rad/s]" ;
  RealSignal bodyRate[3](each unit="rad/s")
    "机体系陀螺角速率 [rad/s]；Body angular-rate vector used by low-cost safe-mode detumbling";
  BooleanSignal attitudeSettled "姿态Settled" ;
  BooleanSignal attitudeReady "姿态就绪；Dwell-qualified attitude readiness diagnostic";
  BooleanSignal imagingAttitudeReady "载荷主视轴、跟踪率、驻留和成像几何均合格";
  BooleanSignal groundLinkAttitudeReady "通信主视轴、跟踪率、驻留和地面接触均合格";
  BooleanSignal imagingWindowReady
    "成像Window就绪；Formal visibility, off-nadir, boresight-FOV and illumination diagnostic";
  BooleanSignal momentumDumpActive "momentumDump激活；Normal-mode reaction-wheel momentum unloading latch";
  ControlModeSignal actualControlMode "actual控制模式" ;
  AttitudeControlStateSignal attitudeControlState "姿态控制状态" ;
  RealSignal magnetorquerTorque[3](each unit="N.m") "计算/接口量 magnetorquerTorque [N.m]" ;
  IntegerSignal commandErrorCount "指令误差Count" ;
  IntegerSignal watchdogCount "计算/接口量 watchdogCount" ;
  RealSignal cpuTemperature(unit="K") "cpu温度 [K]" ;
  RealSignal boardTemperature(unit="K") "board温度 [K]" ;
  annotation(Documentation(info="<html><h2>设备测量与状态总线</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.DeviceStatusBus</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>设备测量与状态总线</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>busVoltage[3]</code></td><td>RealSignal</td><td>public</td><td>V</td><td>12/5/3.3V轨实测 [V]</td></tr><tr><td><code>busCurrent[3]</code></td><td>RealSignal</td><td>public</td><td>A</td><td>总线电流 [A]</td></tr><tr><td><code>threeRailOutputPower</code></td><td>RealSignal</td><td>public</td><td>W</td><td>threeRail输出功率 [W]；Signed measured power delivered to final 12/5/3.3 V loads; excludes the two converter input branches from 12 V to avoid double count</td></tr><tr><td><code>subArrayVoltage[3]</code></td><td>RealSignal</td><td>public</td><td>V</td><td>subArray电压 [V]；Independent pre-MPPT solar-array voltage</td></tr><tr><td><code>mpptVoltage[3]</code></td><td>RealSignal</td><td>public</td><td>V</td><td>mppt电压 [V]</td></tr><tr><td><code>mpptCurrent[3]</code></td><td>RealSignal</td><td>public</td><td>A</td><td>mppt电流 [A]</td></tr><tr><td><code>solarOutputPower[3]</code></td><td>RealSignal</td><td>public</td><td>W</td><td>solar输出功率 [W]；Signed net power delivered at each raw-source solar wing terminal, after its local physical shunt</td></tr><tr><td><code>availableSolarPower[3]</code></td><td>RealSignal</td><td>public</td><td>W</td><td>availableSolar功率 [W]；Geometry-limited power before MPPT/BCR/PCDU curtailment</td></tr><tr><td><code>solarIncidenceCos[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 solarIncidenceCos；Independent body-face incidence cosines</td></tr><tr><td><code>totalAvailableSolarPower</code></td><td>RealSignal</td><td>public</td><td>W</td><td>totalAvailableSolar功率 [W]</td></tr><tr><td><code>totalDeliveredSolarPower</code></td><td>RealSignal</td><td>public</td><td>W</td><td>totalDeliveredSolar功率 [W]</td></tr><tr><td><code>rawSourceBusVoltageAverage</code></td><td>RealSignal</td><td>public</td><td>V</td><td>raw源总线电压Average [V]；Slow raw-bus voltage used by average-value MPPT current commands</td></tr><tr><td><code>solarCurtailmentFactor</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 solarCurtailmentFactor；0..1 source-side MPPT limit when battery charging is inhibited</td></tr><tr><td><code>batteryVoltage</code></td><td>RealSignal</td><td>public</td><td>V</td><td>电池端电压 [V]</td></tr><tr><td><code>batterySOC</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>BMS荷电状态；0..1 BMS coulomb-count estimate from measured battery branch current, not physical cell-stack SOC</td></tr><tr><td><code>batteryChargeAllowed</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>BMS允许充电；BMS charge permission; discharge remains available when false</td></tr><tr><td><code>pdState[24]</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>pd状态</td></tr><tr><td><code>tcState[24]</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>tc状态</td></tr><tr><td><code>pdCurrent[24]</code></td><td>RealSignal</td><td>public</td><td>A</td><td>pd电流 [A]</td></tr><tr><td><code>tcCurrent[24]</code></td><td>RealSignal</td><td>public</td><td>A</td><td>tc电流 [A]</td></tr><tr><td><code>thermistorTemperature[32]</code></td><td>RealSignal</td><td>public</td><td>K</td><td>thermistor温度 [K]</td></tr><tr><td><code>thermistorValid[32]</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 thermistorValid；False identifies interface placeholders that are not physical measurements</td></tr><tr><td><code>heaterUpper[14]</code></td><td>RealSignal</td><td>public</td><td>K</td><td>heater上界 [K]</td></tr><tr><td><code>heaterLower[14]</code></td><td>RealSignal</td><td>public</td><td>K</td><td>heater下界 [K]</td></tr><tr><td><code>wheelSpeed[4]</code></td><td>RealSignal</td><td>public</td><td>rad/s</td><td>四轮转速 [rad/s]</td></tr><tr><td><code>wheelMomentum[4]</code></td><td>RealSignal</td><td>public</td><td>kg.m2/s</td><td>飞轮Momentum [kg.m2/s]</td></tr><tr><td><code>wheelSaturated[4]</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>飞轮Saturated</td></tr><tr><td><code>wheelCurrent[4]</code></td><td>RealSignal</td><td>public</td><td>A</td><td>飞轮电流 [A]</td></tr><tr><td><code>wheelStatus[4]</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>飞轮Status</td></tr><tr><td><code>starQuaternion[2,4]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>star四元数</td></tr><tr><td><code>starAngularVelocity[2,3]</code></td><td>RealSignal</td><td>public</td><td>rad/s</td><td>计算/接口量 starAngularVelocity [rad/s]</td></tr><tr><td><code>starStatus[2]</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 starStatus</td></tr><tr><td><code>starPacketType[2]</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 starPacketType</td></tr><tr><td><code>yh50Rate[3]</code></td><td>RealSignal</td><td>public</td><td>rad/s</td><td>yh50速率 [rad/s]</td></tr><tr><td><code>mems[6]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 mems；1:3 body-frame angular velocity rad/s; 4:6 ideal body-frame specific force m/s2 from the local NoGravity free-fall mechanical model</td></tr><tr><td><code>orbitalAccelerationGCRS[3]</code></td><td>RealSignal</td><td>public</td><td>m/s2</td><td>计算/接口量 orbitalAccelerationGCRS [m/s2]；Engineering diagnostic only: central-gravity acceleration in GCRS, not an onboard accelerometer sample</td></tr><tr><td><code>magneticField[3]</code></td><td>RealSignal</td><td>public</td><td>T</td><td>计算/接口量 magneticField [T]</td></tr><tr><td><code>sunAngle[2]</code></td><td>RealSignal</td><td>public</td><td>rad</td><td>计算/接口量 sunAngle [rad]</td></tr><tr><td><code>gnssPosition[3]</code></td><td>RealSignal</td><td>public</td><td>m</td><td>GNSS GCRS位置 [m]</td></tr><tr><td><code>gnssVelocity[3]</code></td><td>RealSignal</td><td>public</td><td>m/s</td><td>GNSS GCRS速度 [m/s]</td></tr><tr><td><code>gnssFix</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>GNSS有效标志</td></tr><tr><td><code>cameraStatus</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>相机工作状态</td></tr><tr><td><code>cmosStatus</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 cmosStatus</td></tr><tr><td><code>naviEnhanceStatus</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 naviEnhanceStatus</td></tr><tr><td><code>spaceTimeStatus</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>space时间Status</td></tr><tr><td><code>fotonAmurStatus</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 fotonAmurStatus</td></tr><tr><td><code>ttcStatus</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 ttcStatus</td></tr><tr><td><code>basebandStatus</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 basebandStatus</td></tr><tr><td><code>transmitterStatus</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>X波段发射状态</td></tr><tr><td><code>transmitterTemperature</code></td><td>RealSignal</td><td>public</td><td>K</td><td>X波段功放温度 [K]</td></tr><tr><td><code>attitudeError</code></td><td>RealSignal</td><td>public</td><td>rad</td><td>指向误差 [rad]</td></tr><tr><td><code>primaryPointingError</code></td><td>RealSignal</td><td>public</td><td>rad</td><td>primaryPointing误差 [rad]</td></tr><tr><td><code>secondaryPointingError</code></td><td>RealSignal</td><td>public</td><td>rad</td><td>secondaryPointing误差 [rad]</td></tr><tr><td><code>bodyRateMagnitude</code></td><td>RealSignal</td><td>public</td><td>rad/s</td><td>本体速率Magnitude [rad/s]</td></tr><tr><td><code>bodyRate[3]</code></td><td>RealSignal</td><td>public</td><td>rad/s</td><td>机体系陀螺角速率 [rad/s]；Body angular-rate vector used by low-cost safe-mode detumbling</td></tr><tr><td><code>attitudeSettled</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>姿态Settled</td></tr><tr><td><code>attitudeReady</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>姿态就绪；Dwell-qualified attitude readiness diagnostic</td></tr><tr><td><code>imagingAttitudeReady</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>载荷主视轴、跟踪率、驻留和成像几何均合格</td></tr><tr><td><code>groundLinkAttitudeReady</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>通信主视轴、跟踪率、驻留和地面接触均合格</td></tr><tr><td><code>imagingWindowReady</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>成像Window就绪；Formal visibility, off-nadir, boresight-FOV and illumination diagnostic</td></tr><tr><td><code>momentumDumpActive</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>momentumDump激活；Normal-mode reaction-wheel momentum unloading latch</td></tr><tr><td><code>actualControlMode</code></td><td>ControlModeSignal</td><td>public</td><td>按声明/类型合同</td><td>actual控制模式</td></tr><tr><td><code>attitudeControlState</code></td><td>AttitudeControlStateSignal</td><td>public</td><td>按声明/类型合同</td><td>姿态控制状态</td></tr><tr><td><code>magnetorquerTorque[3]</code></td><td>RealSignal</td><td>public</td><td>N.m</td><td>计算/接口量 magnetorquerTorque [N.m]</td></tr><tr><td><code>commandErrorCount</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>指令误差Count</td></tr><tr><td><code>watchdogCount</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 watchdogCount</td></tr><tr><td><code>cpuTemperature</code></td><td>RealSignal</td><td>public</td><td>K</td><td>cpu温度 [K]</td></tr><tr><td><code>boardTemperature</code></td><td>RealSignal</td><td>public</td><td>K</td><td>board温度 [K]</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,137,123},lineColor={0,137,123},lineThickness=0,radius=0),
      Line(points={{-48,0},{-14,-34},{48,42}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{-45,-52},{45,-52}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,137,123},lineColor={0,137,123},lineThickness=0,radius=0),
      Line(points={{-48,0},{-14,-34},{48,42}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{-45,-52},{45,-52}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }));
end DeviceStatusBus;