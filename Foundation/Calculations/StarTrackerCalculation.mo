within NISSA_12UCubeSat.Foundation.Calculations;
model StarTrackerCalculation "星敏任务门控与测量计算"
  parameter Modelica.Units.SI.Resistance activeResistance=51.9;
  NISSA_12UCubeSat.Foundation.Interfaces.ControlModeInput desiredControlMode annotation(Placement(transformation(extent={{-110,55},{-90,75}})));
  Modelica.Blocks.Interfaces.RealInput quaternion[4] annotation(Placement(transformation(extent={{-120,-5},{-80,15}})));
  Modelica.Blocks.Interfaces.RealInput bodyRate[3](each unit="rad/s") annotation(Placement(transformation(extent={{-120,-65},{-80,-45}})));
  Modelica.Blocks.Interfaces.BooleanOutput active annotation(Placement(transformation(extent={{80,65},{100,85}})));
  Modelica.Blocks.Interfaces.RealOutput loadConductance(unit="S") annotation(Placement(transformation(extent={{80,35},{100,55}})));
  Modelica.Blocks.Interfaces.RealOutput measuredQuaternion[4] annotation(Placement(transformation(extent={{80,0},{100,20}})));
  Modelica.Blocks.Interfaces.RealOutput measuredBodyRate[3](each unit="rad/s") annotation(Placement(transformation(extent={{80,-35},{100,-15}})));
  Modelica.Blocks.Interfaces.IntegerOutput status annotation(Placement(transformation(extent={{80,-75},{100,-55}})));
equation
  active=desiredControlMode == NISSA_12UCubeSat.Foundation.Types.ControlMode.TargetPointing or
    desiredControlMode == NISSA_12UCubeSat.Foundation.Types.ControlMode.GroundPointing;
  loadConductance=if active then 1/activeResistance else 0;
  measuredQuaternion=if active then quaternion else {0,0,0,0};
  measuredBodyRate=if active then bodyRate else {0,0,0};
  status=if active then 1 else 0;
  annotation(Icon(graphics={Rectangle(extent={{-100,75},{100,-75}},lineColor={55,70,105},fillColor={237,241,247},fillPattern=FillPattern.Solid),Polygon(points={{-52,32},{16,32},{52,0},{16,-32},{-52,-32},{-52,32}},fillColor={130,150,185},fillPattern=FillPattern.Solid),Line(points={{-72,0},{65,0}},color={55,70,105},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-90,-67},{90,-45}},textString="STAR q / w / STATUS")}),Documentation(info="<html><h4>功能定位</h4><p>在精确指向阶段门控Z向星敏负载、姿态测量和设备状态。</p><h4>输入与物理含义</h4><p>desiredControlMode决定是否工作；quaternion与bodyRate来自环境真值读取；activeResistance定义等效负载。</p><h4>输出与物理含义</h4><p>active、loadConductance、measuredQuaternion、measuredBodyRate和status分别给出使能、负载、门控测量与状态。</p><h4>主要计算关系</h4><p>目标或地面站指向时输出输入测量并接通负载，否则测量置零、状态关闭。</p><h4>状态、事件与假设</h4><p>纯代数、无捕获/失锁记忆；不模拟星图识别、视场、星等、噪声、四元数估计和时延。</p><h4>调用与结果使用</h4><p>由StarTrackerZUnit调用。查看active、measuredQuaternion/bodyRate及父组件电流温度；Y向星敏采用另一独立白箱路径。</p></html>"));
end StarTrackerCalculation;
