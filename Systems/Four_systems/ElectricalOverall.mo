within OneSatSim.Systems.Four_systems;
model ElectricalOverall "电气总体"
  Foundation.Interfaces.PowerPort subsystem[8] annotation(Placement(transformation(extent={{-112,-10},{-92,10}})));
  Modelica.Electrical.Analog.Basic.Ground ground12 annotation(Placement(transformation(extent={{-45,-55},{-25,-35}})));
  Modelica.Electrical.Analog.Basic.Ground ground5 annotation(Placement(transformation(extent={{-10,-55},{10,-35}})));
  Modelica.Electrical.Analog.Basic.Ground ground3V3 annotation(Placement(transformation(extent={{25,-55},{45,-35}})));
equation
  connect(subsystem[1],subsystem[2]) annotation(Line(points={{-102,0},{-70,0}},color={0,0,255}));
  connect(subsystem[1],subsystem[3]) annotation(Line(points={{-102,0},{-60,0}},color={0,0,255}));
  connect(subsystem[1],subsystem[4]) annotation(Line(points={{-102,0},{-50,0}},color={0,0,255}));
  connect(subsystem[1],subsystem[5]) annotation(Line(points={{-102,0},{-40,0}},color={0,0,255}));
  connect(subsystem[1],subsystem[6]) annotation(Line(points={{-102,0},{-30,0}},color={0,0,255}));
  connect(subsystem[1],subsystem[7]) annotation(Line(points={{-102,0},{-20,0}},color={0,0,255}));
  connect(subsystem[1],subsystem[8]) annotation(Line(points={{-102,0},{-10,0}},color={0,0,255}));
  connect(subsystem[1].n12,ground12.p) annotation(Line(points={{-102,0},{-35,0},{-35,-35}},color={0,0,255}));
  connect(subsystem[1].n5,ground5.p) annotation(Line(points={{-102,0},{0,0},{0,-35}},color={0,0,255}));
  connect(subsystem[1].n33,ground3V3.p) annotation(Line(points={{-102,0},{35,0},{35,-35}},color={0,0,255}));
  annotation(Icon(graphics={Rectangle(extent={{-100,85},{100,-85}},lineColor={25,70,170},fillColor={230,236,252},fillPattern=FillPattern.Solid),Line(points={{-75,35},{75,35}},color={220,40,35},thickness=4),Line(points={{-75,0},{75,0}},color={60,120,220},thickness=4),Line(points={{-75,-35},{75,-35}},color={40,160,90},thickness=4),Text(extent={{-92,-82},{92,-58}},textString="12 / 5 / 3.3 V OVERALL")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}}),graphics={Text(extent={{-94,80},{94,66}},textString="8个N分系统共用三条物理母线")}),Documentation(info="<html><h4>总体职责</h4><p><b>系统角色：</b>1+4+8中的电气总体，为八个分系统提供统一12/5/3.3 V受控负载母线与回路参考。</p><p><b>建模层级：</b>四个领域Overall之一，直接服务严格1+4+8总体集成。</p><h4>实现与交互</h4><p><b>白箱实现：</b>Ground与八个PowerPort并联连接构成三轨公共负载网；电压由ElectricalPowerSystem中的PCDU建立。</p><p><b>运行行为：</b>各N-System的受控负载在同一电路方程组中平衡；体装太阳阵和电池只连接EPS内部SourcePowerPort，不直接进入本总体负载网。</p><h4>参数、状态与使用</h4><p><b>关键状态：</b>12 V、5 V、3.3 V电网电压电流。</p><p><b>遥测关系：</b>母线量由PowerConditioningUnit传感器测得，经统一InformationPort进入总体工程遥测Observer。</p></html>"));
end ElectricalOverall;
