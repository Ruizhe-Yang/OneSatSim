within NISSA_12UCubeSat.Foundation.Calculations;
model PayloadCaptureCalculation "载荷拍摄状态与写入率计算"
  parameter Real imagingDataRate(unit="1/s")=2e6;
  Modelica.Blocks.Interfaces.BooleanInput captureCommand annotation(Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.IntegerOutput status annotation(Placement(transformation(extent={{80,25},{100,45}})));
  Modelica.Blocks.Interfaces.RealOutput payloadWriteRate annotation(Placement(transformation(extent={{80,-45},{100,-25}})));
equation
  status=if captureCommand then 1 else 0;
  payloadWriteRate=if captureCommand then imagingDataRate else 0;
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={70,80,110},fillColor={238,241,247},fillPattern=FillPattern.Solid),Line(points={{-70,0},{65,0}},color={70,80,110},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-90,50},{90,15}},textString="CAPTURE"),Text(extent={{-90,-18},{90,-52}},textString="STATUS / RATE")}),Documentation(info="<html><h4>功能定位</h4><p>把载荷拍摄布尔指令转换为设备状态和业务写入率。</p><h4>输入与物理含义</h4><p>captureCommand为已经仲裁的实际拍摄动作，imagingDataRate为配置写入率。</p><h4>输出与物理含义</h4><p>status按0/1表示拍摄状态，payloadWriteRate在拍摄时等于配置速率。</p><h4>主要计算关系</h4><p>两个输出均由同一布尔条件生成，但状态与业务数据率保持不同接口语义。</p><h4>状态、事件与假设</h4><p>纯代数、无曝光状态、无图像内容和压缩算法；动作时长由上层时序器决定。</p><h4>调用与结果使用</h4><p>由SelfieCameraUnit等简化成像载荷调用。查看状态与写入率即可；存储积分在DataRecorderUnit中完成。</p></html>"));
end PayloadCaptureCalculation;
