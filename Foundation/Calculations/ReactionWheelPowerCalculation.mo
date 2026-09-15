within OneSatSim.Foundation.Calculations;
model ReactionWheelPowerCalculation "反作用飞轮平均值机电热功率计算"
  parameter Real etaMotor(min=0.1,max=1)=1
    "电动工况平均效率；缺少器件数据时取1作为透明功率闭合基线";
  parameter Modelica.Units.SI.Voltage minimumBusVoltage=6
    "低压除零保护电压，不是欠压硬钳位";
  Modelica.Blocks.Interfaces.RealInput motorTorque(unit="N.m")
    annotation(Placement(transformation(extent={{-120,45},{-80,65}})));
  Modelica.Blocks.Interfaces.RealInput angularVelocity(unit="rad/s")
    annotation(Placement(transformation(extent={{-120,-10},{-80,10}})));
  Modelica.Blocks.Interfaces.RealInput busVoltage(unit="V")
    annotation(Placement(transformation(extent={{-120,-65},{-80,-45}})));
  Modelica.Blocks.Interfaces.RealOutput mechanicalPower(unit="W")
    annotation(Placement(transformation(extent={{80,55},{100,75}})));
  Modelica.Blocks.Interfaces.RealOutput dynamicElectricalPower(unit="W")
    annotation(Placement(transformation(extent={{80,20},{100,40}})));
  Modelica.Blocks.Interfaces.RealOutput dynamicCurrentCommand(unit="A")
    annotation(Placement(transformation(extent={{80,-20},{100,0}})));
  Modelica.Blocks.Interfaces.RealOutput dynamicLossHeat(unit="W")
    annotation(Placement(transformation(extent={{80,-60},{100,-40}})));
equation
  mechanicalPower=motorTorque*angularVelocity;
  dynamicElectricalPower=noEvent(if mechanicalPower > 0 then mechanicalPower/etaMotor else 0);
  dynamicCurrentCommand=dynamicElectricalPower/noEvent(max(minimumBusVoltage,abs(busVoltage)));
  dynamicLossHeat=dynamicElectricalPower-mechanicalPower;
  annotation(
    Icon(graphics={Rectangle(extent={{-100,72},{100,-72}},lineColor={55,75,115},fillColor={235,241,249},fillPattern=FillPattern.Solid),Ellipse(extent={{-42,42},{42,-42}},lineColor={55,75,115},fillColor={155,175,205},fillPattern=FillPattern.Solid),Line(points={{-76,0},{72,0}},color={180,55,40},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-94,-66},{94,-44}},textString="tau*w / I / Q")}),
    Documentation(info="<html><h4>功能定位</h4><p>把单台反作用飞轮轴上机械功率转换为12 V平均值动态负载和热损耗，使机、电、热三个域在任务时间尺度闭合。</p><h4>物理关系</h4><p>mechanicalPower=tau*omega。电动工况由母线提供Pmech/etaMotor；无回馈制动工况不向母线倒灌，转子释放的机械能全部进入dynamicLossHeat。待机电子学功耗仍由父组件独立电阻表示。</p><h4>建模边界</h4><p>纯代数、无状态，不展开PWM、H桥、绕组电感、电流环和再生充电。minimumBusVoltage只防止低压除零；etaMotor应在获得器件数据后标定。</p></html>"));
end ReactionWheelPowerCalculation;
