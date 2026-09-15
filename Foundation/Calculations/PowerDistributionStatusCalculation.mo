within NISSA_12UCubeSat.Foundation.Calculations;
model PowerDistributionStatusCalculation "PDB通道状态派生"
  Modelica.Blocks.Interfaces.RealInput pdCurrent[24](each unit="A") annotation(Placement(transformation(extent={{-120,35},{-80,55}})));
  Modelica.Blocks.Interfaces.IntegerInput equipmentStatus[6] annotation(Placement(transformation(extent={{-120,-55},{-80,-35}})));
  Modelica.Blocks.Interfaces.IntegerOutput pdState[24] annotation(Placement(transformation(extent={{80,-10},{100,10}})));
equation
  pdState={
    if noEvent(abs(pdCurrent[1]) > 1e-5) then 170 else 0,
    if equipmentStatus[1] > 0 then 170 else 0,
    if equipmentStatus[2] > 0 then 170 else 0,
    if equipmentStatus[3] > 0 then 170 else 0,
    if equipmentStatus[4] > 0 then 170 else 0,
    0,0,
    if noEvent(abs(pdCurrent[8]) > 1e-5) then 170 else 0,
    0,0,0,
    if noEvent(abs(pdCurrent[12]) > 1e-5) then 170 else 0,
    if noEvent(abs(pdCurrent[13]) > 1e-5) then 170 else 0,
    if noEvent(abs(pdCurrent[14]) > 1e-5) then 170 else 0,
    if noEvent(abs(pdCurrent[15]) > 1e-5) then 170 else 0,
    if noEvent(abs(pdCurrent[16]) > 1e-5) then 170 else 0,
    if equipmentStatus[5] > 0 then 170 else 0,
    0,
    if equipmentStatus[6] > 0 then 170 else 0,
    if noEvent(abs(pdCurrent[20]) > 1e-5) then 170 else 0,
    if noEvent(abs(pdCurrent[21]) > 1e-5) then 170 else 0,
    if noEvent(abs(pdCurrent[22]) > 1e-5) then 170 else 0,
    0,0};
  annotation(
    Icon(graphics={Rectangle(extent={{-100,65},{100,-65}},lineColor={180,105,20},fillColor={252,242,225},fillPattern=FillPattern.Solid),Text(extent={{-92,24},{92,-18}},textString="PDB 24 STATE")}),
    Documentation(info="<html><h4>功能定位</h4><p>由24路实际配电电流和六类设备状态派生PDB通道状态字。</p><h4>输入与物理含义</h4><p>pdCurrent[1:24]为各支路电流，equipmentStatus[1:6]为基带、发射机及载荷设备状态。</p><h4>输出与物理含义</h4><p>pdState[1:24]为统一整数状态阵列，供PDB-S0工程遥测；170=powered，0=off or physically unused。</p><h4>主要计算关系</h4><p>有直接设备状态来源的通道优先使用设备状态，其余通道按电流是否超过最小工作阈值判定；未建模通道保持明确状态。</p><h4>状态、事件与假设</h4><p>纯代数、无锁存和故障诊断；状态表示通道是否工作，不等同于继电器触点、电流越限或故障码。</p><h4>调用与结果使用</h4><p>由PowerConditioningUnit调用。查看pdState时应同时核对对应pdCurrent和通道表，避免只凭状态字推断功率。</p></html>"));
end PowerDistributionStatusCalculation;
