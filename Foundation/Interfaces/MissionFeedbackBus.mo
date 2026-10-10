within OneSatSim.Foundation.Interfaces;
connector MissionFeedbackBus "Selected physical feedback used by mission control"
  RealSignal batterySOC "BMS荷电状态" ;
  RealSignal busVoltage(unit="V") "12/5/3.3V轨实测 [V]" ;
  RealSignal generatedPower(unit="W") "生成功率 [W]" ;
  RealSignal loadPower(unit="W") "负载功率 [W]" ;
  RealSignal batteryTemperature(unit="K") "电池温度 [K]" ;
  RealSignal payloadTemperature(unit="K") "payload温度 [K]" ;
  RealSignal transmitterTemperature(unit="K") "X波段功放温度 [K]" ;
  RealSignal attitudeError(unit="rad") "指向误差 [rad]" ;
  BooleanSignal attitudeSettled "姿态Settled" ;
  BooleanSignal imagingAttitudeReady "载荷主视轴、跟踪率、驻留和成像几何均合格" ;
  BooleanSignal groundLinkAttitudeReady "地面链路姿态就绪" ;
  BooleanSignal attitudeEstimateValid "姿态EstimateValid" ;
  BooleanSignal wheelActuationAvailable "飞轮ActuationAvailable" ;
  BooleanSignal aocsAvailable "计算/接口量 aocsAvailable" ;
  BooleanSignal cameraReady "camera就绪" ;
  BooleanSignal transmitterReady "transmitter就绪" ;
  RealSignal usedStorage(unit="1") "计算/接口量 usedStorage [1]" ;
  RealSignal capacityStorage(unit="1") "计算/接口量 capacityStorage [1]" ;
  RealSignal remainingStorage(unit="1") "计算/接口量 remainingStorage [1]" ;
  RealSignal storageUtilization "计算/接口量 storageUtilization；0..1 operational payload-buffer utilization";
  RealSignal downlinkReadRate(unit="1/s") "字节读取率，数值单位byte/s [1/s]；byte/s";
  BooleanSignal dataAvailable "数据Available" ;
  BooleanSignal storageHigh "计算/接口量 storageHigh" ;
  BooleanSignal storageFull "计算/接口量 storageFull" ;
  annotation(Documentation(info="<html><h2>Mission反馈总线</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.MissionFeedbackBus</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>Mission反馈总线。原源码功能描述：Selected physical feedback used by mission control</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>batterySOC</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>BMS荷电状态</td></tr><tr><td><code>busVoltage</code></td><td>RealSignal</td><td>public</td><td>V</td><td>12/5/3.3V轨实测 [V]</td></tr><tr><td><code>generatedPower</code></td><td>RealSignal</td><td>public</td><td>W</td><td>生成功率 [W]</td></tr><tr><td><code>loadPower</code></td><td>RealSignal</td><td>public</td><td>W</td><td>负载功率 [W]</td></tr><tr><td><code>batteryTemperature</code></td><td>RealSignal</td><td>public</td><td>K</td><td>电池温度 [K]</td></tr><tr><td><code>payloadTemperature</code></td><td>RealSignal</td><td>public</td><td>K</td><td>payload温度 [K]</td></tr><tr><td><code>transmitterTemperature</code></td><td>RealSignal</td><td>public</td><td>K</td><td>X波段功放温度 [K]</td></tr><tr><td><code>attitudeError</code></td><td>RealSignal</td><td>public</td><td>rad</td><td>指向误差 [rad]</td></tr><tr><td><code>attitudeSettled</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>姿态Settled</td></tr><tr><td><code>imagingAttitudeReady</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>载荷主视轴、跟踪率、驻留和成像几何均合格</td></tr><tr><td><code>groundLinkAttitudeReady</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>地面链路姿态就绪</td></tr><tr><td><code>attitudeEstimateValid</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>姿态EstimateValid</td></tr><tr><td><code>wheelActuationAvailable</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>飞轮ActuationAvailable</td></tr><tr><td><code>aocsAvailable</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 aocsAvailable</td></tr><tr><td><code>cameraReady</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>camera就绪</td></tr><tr><td><code>transmitterReady</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>transmitter就绪</td></tr><tr><td><code>usedStorage</code></td><td>RealSignal</td><td>public</td><td>1</td><td>计算/接口量 usedStorage [1]</td></tr><tr><td><code>capacityStorage</code></td><td>RealSignal</td><td>public</td><td>1</td><td>计算/接口量 capacityStorage [1]</td></tr><tr><td><code>remainingStorage</code></td><td>RealSignal</td><td>public</td><td>1</td><td>计算/接口量 remainingStorage [1]</td></tr><tr><td><code>storageUtilization</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 storageUtilization；0..1 operational payload-buffer utilization</td></tr><tr><td><code>downlinkReadRate</code></td><td>RealSignal</td><td>public</td><td>1/s</td><td>字节读取率，数值单位byte/s [1/s]；byte/s</td></tr><tr><td><code>dataAvailable</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>数据Available</td></tr><tr><td><code>storageHigh</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 storageHigh</td></tr><tr><td><code>storageFull</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 storageFull</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,121,107},lineColor={0,121,107},lineThickness=0,radius=0),
      Line(points={{48,35},{-20,35},{-20,-30},{43,-30}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Polygon(points={{31,-44},{51,-30},{31,-16},{31,-44}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,121,107},lineColor={0,121,107},lineThickness=0,radius=0),
      Line(points={{48,35},{-20,35},{-20,-30},{43,-30}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Polygon(points={{31,-44},{51,-30},{31,-16},{31,-44}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4)
    }));
end MissionFeedbackBus;