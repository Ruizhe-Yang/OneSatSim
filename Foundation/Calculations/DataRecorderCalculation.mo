within OneSatSim.Foundation.Calculations;
model DataRecorderCalculation "星上数据记录器业务量计算"
  parameter Real capacity(unit="1")=128e9 "可用存储容量，byte";
  Modelica.Blocks.Interfaces.RealInput earthCameraWriteRate annotation(Placement(transformation(extent={{-120,55},{-80,75}})));
  Modelica.Blocks.Interfaces.RealInput selfieCameraWriteRate annotation(Placement(transformation(extent={{-120,20},{-80,40}})));
  Modelica.Blocks.Interfaces.RealInput downlinkReadRate annotation(Placement(transformation(extent={{-120,-20},{-80,0}})));
  Modelica.Blocks.Interfaces.RealInput storedBytes annotation(Placement(transformation(extent={{-120,-60},{-80,-40}})));
  Modelica.Blocks.Interfaces.RealOutput netRate annotation(Placement(transformation(extent={{80,60},{100,80}})));
  Modelica.Blocks.Interfaces.RealOutput capacityBytes annotation(Placement(transformation(extent={{80,35},{100,55}})));
  Modelica.Blocks.Interfaces.RealOutput remainingBytes annotation(Placement(transformation(extent={{80,10},{100,30}})));
  Modelica.Blocks.Interfaces.BooleanOutput dataAvailable annotation(Placement(transformation(extent={{80,-15},{100,5}})));
  Modelica.Blocks.Interfaces.BooleanOutput storageHigh annotation(Placement(transformation(extent={{80,-40},{100,-20}})));
  Modelica.Blocks.Interfaces.BooleanOutput storageFull annotation(Placement(transformation(extent={{80,-65},{100,-45}})));
equation
  netRate=earthCameraWriteRate + selfieCameraWriteRate - downlinkReadRate;
  capacityBytes=capacity;
  remainingBytes=max(0,capacity-storedBytes);
  dataAvailable=storedBytes > 1;
  storageHigh=storedBytes >= 0.80*capacity;
  storageFull=storedBytes >= 0.90*capacity;
  annotation(Icon(graphics={Rectangle(extent={{-100,75},{100,-75}},lineColor={45,80,130},fillColor={230,238,250},fillPattern=FillPattern.Solid),Line(points={{-70,0},{65,0}},color={45,80,130},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-90,58},{90,22}},textString="RECORDER"),Text(extent={{-90,-20},{90,-56}},textString="RATE / CAPACITY")}),Documentation(info="<html><h4>功能定位</h4><p>计算星上存储器的净业务速率、剩余容量和容量门限。</p><h4>输入与物理含义</h4><p>两路writeRate分别来自对地相机和自拍相机，downlinkReadRate来自X波段读出，storedBytes由父组件积分器保存。</p><h4>输出与物理含义</h4><p>netRate供积分器使用；capacityBytes和remainingBytes给出容量；dataAvailable、storageHigh与storageFull为任务门控状态。</p><h4>主要计算关系</h4><p>净速率等于两路写入之和减读出；剩余量下限为0；高水位和满载阈值分别为容量的80%与90%。</p><h4>状态、事件与假设</h4><p>本黑箱无状态和采样；容量积分、上下限及初值由DataRecorderUnit中的Modelica积分器承担。单位采用数值byte及byte/s。</p><h4>调用与结果使用</h4><p>由DataRecorderUnit调用。任务级优先查看storedBytes、netRate和三个门限；内部capacityBytes通常无需进入生产结果。</p></html>"));
end DataRecorderCalculation;
