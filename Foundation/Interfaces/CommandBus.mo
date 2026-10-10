within OneSatSim.Foundation.Interfaces;
connector CommandBus "任务与执行指令总线"
  BooleanSignal missionOn "计算/接口量 missionOn" ;
  BooleanSignal safeMode "安全模式模式" ;
  BooleanSignal imaging "成像" ;
  BooleanSignal downlink "下传" ;
  BooleanSignal sunPointing "计算/接口量 sunPointing" ;
  BooleanSignal payloadPowerCommand "payload功率指令" ;
  BooleanSignal captureCommand "capture指令" ;
  BooleanSignal earthObservationCaptureCommand
    "earthObservationCapture指令；Dedicated Earth-observation exposure command";
  IntegerSignal imagingRequestId "成像请求Id；Existing mission request ID associated with Earth-camera writes";
  BooleanSignal selfieCaptureCommand
    "selfieCapture指令；Dedicated selfie exposure command";
  BooleanSignal communicationPowerCommand "communication功率指令" ;
  BooleanSignal transmitCommand "transmit指令" ;
  ControlModeSignal desiredControlMode "desired控制模式" ;
  IntegerSignal groundStationIndex "地面站点Index" ;
  IntegerSignal targetIndex "目标Index" ;
  IntegerSignal missionPriority "计算/接口量 missionPriority" ;
  RealSignal wheelCommand[4](each unit="rad/s") "飞轮指令 [rad/s]" ;
  annotation(Documentation(info="<html><h2>任务与执行指令总线</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.CommandBus</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>任务与执行指令总线</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>missionOn</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 missionOn</td></tr><tr><td><code>safeMode</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>安全模式模式</td></tr><tr><td><code>imaging</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>成像</td></tr><tr><td><code>downlink</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>下传</td></tr><tr><td><code>sunPointing</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 sunPointing</td></tr><tr><td><code>payloadPowerCommand</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>payload功率指令</td></tr><tr><td><code>captureCommand</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>capture指令</td></tr><tr><td><code>earthObservationCaptureCommand</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>earthObservationCapture指令；Dedicated Earth-observation exposure command</td></tr><tr><td><code>imagingRequestId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>成像请求Id；Existing mission request ID associated with Earth-camera writes</td></tr><tr><td><code>selfieCaptureCommand</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>selfieCapture指令；Dedicated selfie exposure command</td></tr><tr><td><code>communicationPowerCommand</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>communication功率指令</td></tr><tr><td><code>transmitCommand</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>transmit指令</td></tr><tr><td><code>desiredControlMode</code></td><td>ControlModeSignal</td><td>public</td><td>按声明/类型合同</td><td>desired控制模式</td></tr><tr><td><code>groundStationIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>地面站点Index</td></tr><tr><td><code>targetIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>目标Index</td></tr><tr><td><code>missionPriority</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 missionPriority</td></tr><tr><td><code>wheelCommand[4]</code></td><td>RealSignal</td><td>public</td><td>rad/s</td><td>飞轮指令 [rad/s]</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={117,0,255},lineColor={117,0,255},lineThickness=0,radius=0),
      Polygon(points={{-54,-12},{12,-12},{12,-37},{56,0},{12,37},{12,12},{-54,12},{-54,-12}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={117,0,255},lineColor={117,0,255},lineThickness=0,radius=0),
      Polygon(points={{-54,-12},{12,-12},{12,-37},{56,0},{12,37},{12,12},{-54,12},{-54,-12}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4)
    }));
end CommandBus;