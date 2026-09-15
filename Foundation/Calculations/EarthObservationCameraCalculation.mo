within NISSA_12UCubeSat.Foundation.Calculations;
model EarthObservationCameraCalculation "对地观测相机任务状态计算"
  parameter Real imagingDataRate(unit="1/s")=10e6;
  parameter Modelica.Units.SI.Resistance focalHeaterResistance=36;
  Modelica.Blocks.Interfaces.BooleanInput payloadPowered annotation(Placement(transformation(extent={{-120,45},{-80,65}})));
  Modelica.Blocks.Interfaces.BooleanInput captureCommand annotation(Placement(transformation(extent={{-120,5},{-80,25}})));
  Modelica.Blocks.Interfaces.IntegerInput focalHeaterState annotation(Placement(transformation(extent={{-120,-55},{-80,-35}})));
  Modelica.Blocks.Interfaces.IntegerOutput status annotation(Placement(transformation(extent={{80,45},{100,65}})));
  Modelica.Blocks.Interfaces.RealOutput payloadWriteRate annotation(Placement(transformation(extent={{80,5},{100,25}})));
  Modelica.Blocks.Interfaces.RealOutput focalHeaterConductance(unit="S") annotation(Placement(transformation(extent={{80,-55},{100,-35}})));
equation
  status=if payloadPowered then 1 else 0;
  payloadWriteRate=if captureCommand then imagingDataRate else 0;
  focalHeaterConductance=if focalHeaterState == 170 then 1/focalHeaterResistance else 0;
  annotation(Icon(graphics={Rectangle(extent={{-100,72},{100,-72}},lineColor={60,80,115},fillColor={237,241,247},fillPattern=FillPattern.Solid),Ellipse(extent={{-35,35},{35,-35}},fillColor={40,50,75},fillPattern=FillPattern.Solid),Line(points={{-72,0},{65,0}},color={60,80,115},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-90,-64},{90,-40}},textString="EO STATUS / RATE / HEAT")}),Documentation(info="<html><h4>功能定位</h4><p>集中形成对地观测相机的上电状态、成像写入率和焦面加热支路电导。</p><h4>输入与物理含义</h4><p>payloadPowered表示相机电源允许，captureCommand表示实际曝光/存储动作，focalHeaterState为TCB状态字。</p><h4>输出与物理含义</h4><p>status表示设备上电；payloadWriteRate在拍摄时等于imagingDataRate；focalHeaterConductance在状态字170时等于加热电阻倒数。</p><h4>主要计算关系</h4><p>三个输出分别由独立条件关系计算，设备上电与拍摄动作不混为同一条件。</p><h4>状态、事件与假设</h4><p>纯代数、无状态；不负责相机任务时序、图像压缩、光学成像质量或焦面温度积分。</p><h4>调用与结果使用</h4><p>由EarthObservationCameraUnit调用。主要查看status、payloadWriteRate和焦面电导；热温度、功率和传感值在父白箱中观察。</p></html>"));
end EarthObservationCameraCalculation;
