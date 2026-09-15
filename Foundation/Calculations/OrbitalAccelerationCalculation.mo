within OneSatSim.Foundation.Calculations;
model OrbitalAccelerationCalculation "轨道中心引力加速度计算"
  parameter Real gravitationalParameter(unit="m3/s2")=3.986004418e14;
  Modelica.Blocks.Interfaces.RealInput position[3](each unit="m") annotation(Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput acceleration[3](each unit="m/s2") annotation(Placement(transformation(extent={{80,-10},{100,10}})));
protected
  Real radiusSquared(unit="m2") annotation(HideResult=true);
equation
  radiusSquared=position*position;
  acceleration=-position*gravitationalParameter/radiusSquared^1.5;
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={50,95,125},fillColor={230,243,246},fillPattern=FillPattern.Solid),Line(points={{-70,0},{65,0}},color={50,95,125},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-90,45},{90,-45}},textString="r -> g")}),Documentation(info="<html><h4>功能定位</h4><p>由位置向量计算地心二体引力加速度，作为MEMS IMU的低阶平动参考。</p><h4>输入与物理含义</h4><p>position[3]为相对地心的位置，单位m；gravitationalParameter为地球标准引力参数。</p><h4>输出与物理含义</h4><p>acceleration[3]为-mu*r/|r|^3，单位m/s2。</p><h4>主要计算关系</h4><p>使用位置模的三次方归一化中心引力，分母设置最小正值以避免零位置数值奇异。</p><h4>状态、事件与假设</h4><p>纯代数、无状态；忽略J2、高阶摄动、气阻、太阳辐压、推力和本体系转换。</p><h4>调用与结果使用</h4><p>由MEMSIMUUnit调用。总体用户通常查看三轴加速度输出；内部位置模只用于数值诊断。</p></html>"));
end OrbitalAccelerationCalculation;
