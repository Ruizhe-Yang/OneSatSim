within NISSA_12UCubeSat.Foundation.Models;
model AverageDCDCConverterCore "连续低阶非理想直流变换核心"
  parameter Modelica.Units.SI.Voltage nominalOutputVoltage=5;
  parameter Real efficiency(min=0.5,max=1)=0.90;
  parameter Modelica.Units.SI.Current outputCurrentLimit=3;
  parameter Modelica.Units.SI.Power outputPowerLimit=15;
  parameter Modelica.Units.SI.Voltage minimumInputVoltage=8;
  parameter Modelica.Units.SI.Resistance outputResistance=0.03;
  parameter Modelica.Units.SI.Resistance overloadDroop=0.5;
  parameter Modelica.Units.SI.Voltage dropoutRange=1;
  parameter Modelica.Units.SI.Voltage nominalInputVoltage=12.1;
  Modelica.Electrical.Analog.Interfaces.PositivePin p1
    annotation(Placement(transformation(extent={{-110,40},{-90,60}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n1
    annotation(Placement(transformation(extent={{-110,-60},{-90,-40}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p2
    annotation(Placement(transformation(extent={{90,40},{110,60}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n2
    annotation(Placement(transformation(extent={{90,-60},{110,-40}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    annotation(Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Units.SI.Voltage inputVoltage;
  Modelica.Units.SI.Voltage outputVoltage;
  Modelica.Units.SI.Current outputCurrent;
  final parameter Modelica.Units.SI.Current effectiveCurrentLimit=
    min(outputCurrentLimit,outputPowerLimit/max(nominalOutputVoltage,0.1));
  Modelica.Units.SI.Current overloadCurrent;
  Modelica.Units.SI.Power outputPower;
  Modelica.Units.SI.Power inputPower;
  Modelica.Units.SI.Power lossPower;
  Real inputAvailability;
  Modelica.Units.SI.Voltage positiveInputVoltage;
  Real overloadDelta(unit="A",start=0);
  Real inputCurrentDenominator(unit="V");
equation
  inputVoltage=p1.v-n1.v;
  outputVoltage=p2.v-n2.v;
  p1.i+n1.i=0;
  p2.i+n2.i=0;
  outputCurrent=-p2.i;
  positiveInputVoltage=0.5*(inputVoltage+sqrt(inputVoltage^2+1e-6));
  inputAvailability=noEvent(max(0,min(1,positiveInputVoltage/minimumInputVoltage)))
    "Regulated above minimumInputVoltage, continuous linear dropout below it";
  overloadDelta=outputCurrent-effectiveCurrentLimit;
  overloadCurrent=0.5*(overloadDelta+sqrt(overloadDelta^2+1e-8));
  outputVoltage=nominalOutputVoltage*inputAvailability-
    outputResistance*outputCurrent-overloadDroop*overloadCurrent;
  outputPower=outputVoltage*outputCurrent;
  inputCurrentDenominator=sqrt(inputVoltage^2+1);
  p1.i=outputPower/(efficiency*inputCurrentDenominator);
  inputPower=inputVoltage*p1.i;
  lossPower=inputPower-outputPower;
  heatPort.Q_flow=-lossPower;
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={35,85,150},fillColor={235,244,252},fillPattern=FillPattern.Solid),Polygon(points={{-42,30},{22,30},{48,0},{22,-30},{-42,-30},{-42,30}},fillColor={85,140,200},fillPattern=FillPattern.Solid),Text(extent={{-92,-64},{92,-42}},textString="AVG DC/DC")}),Documentation(info="<html><h4>功能定位</h4><p>为5 V与3.3 V派生母线提供连续平均值DC/DC功率关系，保留效率、输入欠压、输出内阻、限流和限功率。</p><h4>输入与接口关系</h4><p>电气端口直接连接输入/输出双线域；参数定义额定输出电压、效率、限流、限功率、最低输入电压、正常压降和过载droop。</p><h4>内部职责与实现</h4><p>根据输出电流与功率限制形成有限下垂的输出电压关系，并按输入/输出功率与效率闭合源侧电流；低输入电压通过连续dropout降额。</p><h4>输出</h4><p>通过电气端口给出输出电压、电流和源侧取电，lossPower供父组件热网络使用。</p><h4>连续/离散状态</h4><p>模型不含控制器积分状态和开关状态；电气网络中的端口变量由总体方程同时求解。</p><h4>使用与观察</h4><p>由PowerConditioningUnit实例化。应查看输出母线电压、电流和lossPower，并与12 V源侧功率核对。</p><h4>建模边界</h4><p>不包含PWM、MOSFET、储能电感、开关纹波和环路补偿，不能用于变换器稳定裕度或EMI分析。</p></html>"));
end AverageDCDCConverterCore;
