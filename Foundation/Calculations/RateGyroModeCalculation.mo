within NISSA_12UCubeSat.Foundation.Calculations;
model RateGyroModeCalculation "高精度角速率陀螺工作模式计算"
  NISSA_12UCubeSat.Foundation.Interfaces.ControlModeInput desiredControlMode annotation(Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput precisionEnabled annotation(Placement(transformation(extent={{80,-10},{100,10}})));
equation
  precisionEnabled=desiredControlMode == NISSA_12UCubeSat.Foundation.Types.ControlMode.TargetPointing or
    desiredControlMode == NISSA_12UCubeSat.Foundation.Types.ControlMode.GroundPointing;
  annotation(Icon(graphics={Rectangle(extent={{-100,65},{100,-65}},lineColor={60,85,120},fillColor={235,241,248},fillPattern=FillPattern.Solid),Line(points={{-70,0},{65,0}},color={60,85,120},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-90,42},{90,-42}},textString="YH50 MODE")}),Documentation(info="<html><h4>功能定位</h4><p>识别需要YH50高精度角速度测量的任务模式。</p><h4>输入与物理含义</h4><p>desiredControlMode为星上共享姿态控制模式枚举。</p><h4>输出与物理含义</h4><p>precisionEnabled在目标指向或地面站指向阶段为true。</p><h4>主要计算关系</h4><p>使用枚举比较组合两种精确指向模式。</p><h4>状态、事件与假设</h4><p>纯代数、无状态；不负责陀螺预热、量程切换、零偏和采样。</p><h4>调用与结果使用</h4><p>由RateGyroUnit调用。该量主要解释陀螺负载与状态，姿态稳定性应查看实际body rate。</p></html>"));
end RateGyroModeCalculation;
