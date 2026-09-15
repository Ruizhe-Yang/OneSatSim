within OneSatSim.Foundation.Interfaces;
connector CommandBus "任务与执行指令总线"
  BooleanSignal missionOn;
  BooleanSignal safeMode;
  BooleanSignal imaging;
  BooleanSignal downlink;
  BooleanSignal sunPointing;
  BooleanSignal payloadPowerCommand;
  BooleanSignal captureCommand;
  BooleanSignal earthObservationCaptureCommand
    "Dedicated Earth-observation exposure command";
  BooleanSignal selfieCaptureCommand
    "Dedicated selfie exposure command";
  BooleanSignal communicationPowerCommand;
  BooleanSignal transmitCommand;
  ControlModeSignal desiredControlMode;
  IntegerSignal groundStationIndex;
  IntegerSignal targetIndex;
  IntegerSignal missionPriority;
  RealSignal wheelCommand[4](each unit="rad/s");
  annotation(Icon(graphics={Rectangle(extent={{-100,60},{100,-60}},lineColor={120,70,150},fillColor={243,235,249},fillPattern=FillPattern.Solid),Text(extent={{-90,22},{90,-18}},textString="COMMAND")}),Documentation(info="<html><h4>接口语义</h4><p><b>用途：</b>承载任务开关、工作模式、站点/目标索引、优先级、独立相机拍摄门控和四轮速度命令</p><p><b>字段与单位：</b>missionOn、safeMode、imaging、downlink、sunPointing、earthObservationCaptureCommand、selfieCaptureCommand、groundStationIndex、targetIndex、missionPriority、wheelCommand[4] rad/s</p><p><b>信号方向语义：</b>任务控制与EquivalentAOCSCore提供；相机、通信、飞轮和热控等消费。对地成像与自拍门控分离，避免一种任务误触发两台相机。</p><p><b>典型连接：</b>InformationPort内部，连接OBC与执行设备</p><p><b>建模注意：</b>该连接器用于Modelica无因果连接网络；字段名称表达工程语义，不能仅凭曲线数组序号判断来源。</p></html>"));
end CommandBus;
