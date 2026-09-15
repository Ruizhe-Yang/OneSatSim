within OneSatSim.Foundation.Calculations;
model PointingModeEquipmentCalculation "精确指向阶段设备状态与负载计算"
  parameter Modelica.Units.SI.Resistance activeResistance=51.9;
  parameter Modelica.Units.SI.Resistance standbyResistance=1e9;
  OneSatSim.Foundation.Interfaces.ControlModeInput desiredControlMode annotation(Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput active annotation(Placement(transformation(extent={{80,45},{100,65}})));
  Modelica.Blocks.Interfaces.RealOutput loadConductance(unit="S") annotation(Placement(transformation(extent={{80,-10},{100,10}})));
  Modelica.Blocks.Interfaces.IntegerOutput status annotation(Placement(transformation(extent={{80,-65},{100,-45}})));
equation
  active=desiredControlMode == OneSatSim.Foundation.Types.ControlMode.TargetPointing or
    desiredControlMode == OneSatSim.Foundation.Types.ControlMode.GroundPointing;
  loadConductance=if active then 1/activeResistance else 1/standbyResistance;
  status=if active then 1 else 0;
  annotation(Icon(graphics={Rectangle(extent={{-100,72},{100,-72}},lineColor={95,65,130},fillColor={240,234,247},fillPattern=FillPattern.Solid),Line(points={{-70,0},{65,0}},color={95,65,130},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-90,50},{90,15}},textString="POINTING MODE"),Text(extent={{-90,-18},{90,-52}},textString="ACTIVE / G / STATUS")}),Documentation(info="<html><h4>功能定位</h4><p>根据姿态控制模式决定仅在精确指向阶段工作的设备状态和等效负载。</p><h4>输入与物理含义</h4><p>desiredControlMode为共享控制模式；activeResistance和standbyResistance定义工作/待机电阻。</p><h4>输出与物理含义</h4><p>active为工作使能，loadConductance供电气VariableConductor使用，status为0/1设备状态。</p><h4>主要计算关系</h4><p>目标指向或地面站指向时active为true；电导按对应电阻倒数切换。</p><h4>状态、事件与假设</h4><p>纯代数、无模式记忆；不负责姿态资格、设备启动延迟和故障状态。模式枚举保持无因果共享语义。</p><h4>调用与结果使用</h4><p>由NaviEnhancePayloadUnit与SpaceTimePayloadUnit调用。查看active、支路电流和status；姿态误差应在GNC链中查看。</p></html>"));
end PointingModeEquipmentCalculation;
