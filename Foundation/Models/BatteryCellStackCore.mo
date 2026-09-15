within OneSatSim.Foundation.Models;
model BatteryCellStackCore "带SOC信号接口的电化学电池栈核心"
  parameter Integer Ns(min=1)=1 "串联电芯数";
  parameter Integer Np(min=1)=1 "并联电芯数";
  parameter Modelica.Electrical.Batteries.ParameterRecords.CellData cellData;
  parameter Real initialSOC(min=0,max=1)=0.78;
  Modelica.Electrical.Analog.Interfaces.PositivePin p annotation(Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n annotation(Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort annotation(Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Interfaces.RealOutput SOC annotation(Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Electrical.Batteries.BatteryStacks.CellStack cellStack(
    Ns=Ns,Np=Np,cellData=cellData,useHeatPort=true,
    SOC(start=initialSOC,fixed=true)) annotation(Placement(transformation(extent={{-30,-20},{30,40}})));
equation
  connect(p,cellStack.p) annotation(Line(points={{-100,0},{-30,0},{-30,10}},color={0,0,255}));
  connect(cellStack.n,n) annotation(Line(points={{30,10},{70,10},{70,0},{100,0}},color={0,0,255}));
  connect(cellStack.heatPort,heatPort) annotation(Line(points={{0,-20},{0,-100}},color={191,0,0}));
  SOC=cellStack.SOC;
  annotation(Icon(graphics={Rectangle(extent={{-100,72},{100,-72}},lineColor={45,105,55},fillColor={239,248,237},fillPattern=FillPattern.Solid),Line(points={{-70,0},{65,0}},color={45,105,55},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-90,55},{90,20}},textString="CELL STACK"),Text(extent={{-90,-20},{90,-52}},textString="OCV / SOC")}),Documentation(info="<html><h4>功能定位</h4><p>封装Modelica 4.0.0电池CellStack并把内部SOC以窄因果输出提供给BatteryUnit。</p><h4>输入与接口关系</h4><p>p/n为电池电气端口，heatPort接收电化学与内阻损耗；Ns、Np、cellData和initialSOC定义串并联与初始状态。</p><h4>内部职责与实现</h4><p>直接复用标准库CellStack的开路电压、内阻和电量积分方程，仅增加SOC输出适配，不重复实现电化学方程。</p><h4>输出</h4><p>SOC为0至1的电量状态输出，电压、电流和热流保留在物理端口。</p><h4>连续/离散状态</h4><p>SOC是连续动态状态，其初值由initialSOC确定；本封装不增加采样、事件或额外储能。</p><h4>使用与观察</h4><p>由BatteryUnit调用。总体分析查看SOC、端电压、支路电流和电芯温度，单独观察封装内部量通常没有必要。</p><h4>建模边界</h4><p>精度与标准库CellStack一致，不增加单体失配、老化、均衡和故障传播。</p></html>"));
end BatteryCellStackCore;
