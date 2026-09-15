within NISSA_12UCubeSat.Foundation.Calculations;
model XBandTransmissionCalculation "X波段发射任务门控计算"
  parameter Real payloadDataRate(unit="1/s")=6.25e6 "载荷缓存读取率，数值单位byte/s";
  Modelica.Blocks.Interfaces.BooleanInput communicationPowerCommand annotation(Placement(transformation(extent={{-120,50},{-80,90}})));
  Modelica.Blocks.Interfaces.BooleanInput transmitCommand annotation(Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.BooleanInput dataAvailable annotation(Placement(transformation(extent={{-120,-90},{-80,-50}})));
  Modelica.Blocks.Interfaces.BooleanOutput supplyEnabled annotation(Placement(transformation(extent={{80,55},{100,75}})));
  Modelica.Blocks.Interfaces.RealOutput payloadReadRate(unit="1/s") annotation(Placement(transformation(extent={{80,-10},{100,10}})));
  Modelica.Blocks.Interfaces.IntegerOutput transmitterStatus annotation(Placement(transformation(extent={{80,-75},{100,-55}})));
equation
  supplyEnabled=communicationPowerCommand;
  payloadReadRate=if transmitCommand and dataAvailable then payloadDataRate else 0;
  transmitterStatus=if communicationPowerCommand then 1 else 0;
  annotation(
    Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={20,95,155},fillColor={228,241,250},fillPattern=FillPattern.Solid),Line(points={{-72,0},{70,0}},color={20,95,155},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-92,58},{92,18}},textString="X-BAND"),Text(extent={{-92,-18},{92,-55}},textString="GATE + RATE")}),
    Documentation(info="<html><h4>功能定位</h4><p>形成X波段高速数传的供电门控、载荷缓存读出率和设备状态。</p><h4>输入与物理含义</h4><p>communicationPowerCommand控制设备上电，transmitCommand表示实际发射动作，dataAvailable表示缓存可读；payloadDataRate以byte/s配置。</p><h4>输出与物理含义</h4><p>supplyEnabled驱动供电开关；payloadReadRate只有实际发射且有数据时为配置速率；transmitterStatus按0/1发布。</p><h4>主要计算关系</h4><p>供电状态只服从通信上电命令，业务读出需transmitCommand与dataAvailable同时满足，从而区分待机上电和真实发射。</p><h4>状态、事件与假设</h4><p>纯代数、无协议状态和射频动态；不计算编码、调制、EIRP、链路余量、RSSI/SNR或重传。</p><h4>调用与结果使用</h4><p>由XBandTransmitterUnit调用。主要查看三项输出并与任务请求、地面站机会和存储量联合判读。</p></html>"));
end XBandTransmissionCalculation;
