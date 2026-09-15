within OneSatSim.Components;
model SolarArrayWing3Unit "太阳翼3组件"
  parameter Modelica.Units.SI.Area activeArea=0.130
    "SYSTEM-LEVEL EQUIVALENT: smaller third deployed panel engineering area";
  parameter Real panelNormalBody[3]={1,0,0}
    "SYSTEM-LEVEL common deployed solar-array normal";
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{92,-10},{112,10}})));
  Modelica.Electrical.Analog.Basic.Conductor unused5Rail(G=0) annotation(Placement(transformation(extent={{-78,-94},{-66,-82}})));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0) annotation(Placement(transformation(extent={{-58,-94},{-46,-82}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-10,90},{10,110}})));
  Foundation.Interfaces.EnvironmentPort environment annotation(Placement(transformation(extent={{-112,40},{-92,60}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{-112,-60},{-92,-40}})));
  Modelica.Blocks.Sources.RealExpression incidenceCos(y=max(0,min(1,panelNormalBody*environment.sunVectorBody)))
    "Common deployed-wing normal is body +X" annotation(Placement(transformation(extent={{-80,58},{-50,72}})));
  Modelica.Blocks.Sources.RealExpression regulatedCurrent(y=activeArea*0.30*environment.solarFlux*incidenceCos.y/max(9.5,information.device.busVoltage[1])*max(0,min(1,(0.975-information.device.batterySOC)/0.04)))
    "Continuous battery-acceptance curtailment: zero generation at the high-SOC boundary" annotation(Placement(transformation(extent={{-78,34},{-52,54}})));
  Modelica.Blocks.Sources.RealExpression subArrayVoltage(y=if environment.solarFlux > 1 and incidenceCos.y > 1e-6 then 5.1*(0.90 + 0.10*incidenceCos.y) else 0) "SYSTEM-LEVEL EQUIVALENT: pre-MPPT array voltage" annotation(Placement(transformation(extent={{-78,2},{-48,18}})));
  Modelica.Blocks.Sources.RealExpression mpptOperatingVoltage(y=if information.device.busVoltage[1] > 9 and environment.solarFlux > 1 and incidenceCos.y > 1e-6 then 3.25*(1 + 0.002*tanh(incidenceCos.y)) else 0) "SYSTEM-LEVEL EQUIVALENT: powered MPPT3 controller-side sense point" annotation(Placement(transformation(extent={{-42,2},{-12,18}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent arraySource annotation(Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor mpptCurrent annotation(Placement(transformation(extent={{-5,30},{15,50}})));
  Modelica.Electrical.Analog.Ideal.IdealDiode blockingDiode annotation(Placement(transformation(extent={{28,30},{48,50}})));
  Modelica.Electrical.Analog.Basic.Resistor shunt(R=180,useHeatPort=true) annotation(Placement(transformation(origin={62,0},extent={{-10,-10},{10,10}},rotation=270)));
  Modelica.Electrical.Analog.Sensors.VoltageSensor mpptVoltage annotation(Placement(transformation(origin={35,0},extent={{-9,-9},{9,9}},rotation=270)));
  Modelica.Blocks.Sources.RealExpression absorbedHeat(y=activeArea*environment.solarFlux*incidenceCos.y*(1-0.30)) annotation(Placement(transformation(extent={{-78,-28},{-48,-14}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow solarHeatInput annotation(Placement(transformation(extent={{-44,-30},{-24,-10}})));
  Modelica.Blocks.Sources.RealExpression solarTerminalPower(y=max(0,mpptVoltage.v*mpptCurrent.i))
    "Same-section regulated 12 V terminal voltage times delivered current" annotation(Placement(transformation(extent={{-78,-52},{-48,-38}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor panelThermalMass(C=470,T(start=291.15,fixed=false)) annotation(Placement(transformation(extent={{-30,-48},{-10,-28}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor bracketPath(G=1.9)
    "SYSTEM-LEVEL EQUIVALENT: bracket conduction plus omitted local radiation rejection" annotation(Placement(transformation(extent={{18,-46},{38,-30}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor minusZThermistor annotation(Placement(transformation(extent={{-8,-76},{12,-56}})));
  Modelica.Mechanics.MultiBody.Parts.Body panelBody(m=0.76,r_CM={0,0,-0.28},I_11=0.029,I_22=0.029,I_33=0.002) annotation(Placement(transformation(extent={{-10,68},{10,88}})));
equation
  connect(power.p5,unused5Rail.p) annotation(Line(points={{-102,0},{-78,-88}},color={0,0,255}));
  connect(unused5Rail.n,power.n5) annotation(Line(points={{-66,-88},{-102,0}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{-102,0},{-58,-88}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{-46,-88},{-102,0}},color={0,0,255}));
  connect(regulatedCurrent.y,arraySource.i) annotation(Line(points={{-50.7,44},{-30,44},{-30,52}},color={0,0,127}));
  connect(arraySource.p,power.n12) annotation(Line(points={{-40,40},{-48,40},{-48,-14},{102,-14},{102,0}},color={0,0,255}));
  connect(arraySource.n,mpptCurrent.p) annotation(Line(points={{-20,40},{-5,40}},color={0,0,255}));
  connect(mpptCurrent.n,blockingDiode.p) annotation(Line(points={{15,40},{28,40}},color={0,0,255}));
  connect(blockingDiode.n,power.p12) annotation(Line(points={{48,40},{102,40},{102,0}},color={0,0,255}));
  connect(shunt.p,power.p12) annotation(Line(points={{62,10},{62,14},{102,14},{102,0}},color={0,0,255}));
  connect(shunt.n,power.n12) annotation(Line(points={{62,-10},{62,-14},{102,-14},{102,0}},color={0,0,255}));
  connect(mpptVoltage.p,power.p12) annotation(Line(points={{35,9},{35,14},{102,14},{102,0}},color={0,0,255}));
  connect(mpptVoltage.n,power.n12) annotation(Line(points={{35,-9},{35,-14},{102,-14},{102,0}},color={0,0,255}));
  connect(subArrayVoltage.y,information.device.subArrayVoltage[3]) annotation(Line(points={{-46.5,10},{-92,10},{-92,-50},{-102,-50}},color={0,0,127}));
  connect(mpptOperatingVoltage.y,information.device.mpptVoltage[3]) annotation(Line(points={{-10.5,10},{-84,10},{-84,-50},{-102,-50}},color={0,0,127}));
  connect(mpptCurrent.i,information.device.mpptCurrent[3]) annotation(Line(points={{5,30},{5,15},{-88,15},{-88,-50},{-102,-50}},color={0,0,127}));
  connect(solarTerminalPower.y,information.device.solarOutputPower[3]) annotation(Line(points={{-46.5,-45},{-82,-45},{-82,-50},{-102,-50}},color={0,0,127}));
  connect(absorbedHeat.y,solarHeatInput.Q_flow) annotation(Line(points={{-46.5,-21},{-44,-21},{-44,-20}},color={0,0,127}));
  connect(solarHeatInput.port,panelThermalMass.port) annotation(Line(points={{-24,-20},{-20,-20},{-20,-28}},color={191,0,0}));
  connect(shunt.heatPort,panelThermalMass.port) annotation(Line(points={{52,0},{-20,0},{-20,-28}},color={191,0,0}));
  connect(panelThermalMass.port,bracketPath.port_a) annotation(Line(points={{-20,-48},{18,-38}},color={191,0,0}));
  connect(bracketPath.port_b,thermal) annotation(Line(points={{38,-38},{52,-38},{52,-90},{0,-90},{0,-100}},color={191,0,0}));
  connect(panelThermalMass.port,minusZThermistor.port) annotation(Line(points={{-20,-48},{-20,-66},{-8,-66}},color={191,0,0}));
  connect(minusZThermistor.T,information.device.thermistorTemperature[14]) annotation(Line(points={{12,-66},{-102,-66},{-102,-50}},color={0,0,127}));
  connect(panelBody.frame_a,mechanical) annotation(Line(points={{-10,78},{0,78},{0,100}},color={95,95,95},thickness=0.5));
  annotation(Icon(graphics={Rectangle(extent={{-100,78},{100,-78}},lineColor={35,75,130},fillColor={225,236,250},fillPattern=FillPattern.Solid),Polygon(points={{-80,50},{75,50},{88,-35},{-68,-35},{-80,50}},fillColor={35,80,150},fillPattern=FillPattern.Solid),Ellipse(extent={{55,-58},{78,-35}},fillColor={220,80,40},fillPattern=FillPattern.Solid),Text(extent={{-92,-72},{92,-50}},textString="WING 3 / MPPT 3 / T14")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}}),graphics={Rectangle(extent={{-85,62},{70,16}},lineColor={0,0,160},pattern=LinePattern.Dash),Text(extent={{-82,70},{45,60}},textString="防反/泄放/第三MPPT"),Rectangle(extent={{-42,-18},{45,-78}},lineColor={190,0,0},pattern=LinePattern.Dash),Text(extent={{-40,-10},{45,-22}},textString="太阳翼3工程热敏14")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>模拟较小面积的共面展开太阳翼3、第三路MPPT、泄放支路和板温测量；三翼统一采用机体系+X受光法向。</p><p><b>建模层级：</b>Components层设备级白箱；主要由Modelica 4.0.0标准库元件和图形连线组成</p><h4>实现与接口</h4><p><b>白箱实现：</b>SignalCurrent、防反二极管、泄放电阻、电压/电流传感、面板热容、安装导热、温度传感器和刚体组成</p><p><b>关键内部元件：</b>unused5Rail（Conductor）、unused33Rail（Conductor）、regulatedCurrent（RealExpression）、subArrayVoltage（RealExpression）、mpptOperatingVoltage（RealExpression）、arraySource（SignalCurrent）、mpptCurrent（CurrentSensor）、blockingDiode（IdealDiode）、shunt（Resistor）、mpptVoltage（VoltageSensor）、panelThermalMass（HeatCapacitor）、bracketPath（ThermalConductor）、minusZThermistor（TemperatureSensor）、panelBody（Body）</p><p><b>对外接口：</b>power（PowerPort）、thermal（ThermalPort）、mechanical（MechanicalPort）、environment（EnvironmentPort）、information（InformationPort）</p><h4>工作行为与状态</h4><p><b>运行行为：</b>受光时产生受控电流，暗区关闭；泄放支路提供电气边界，14号热敏测量面板温度；absorbedHeat与电功率使用同一入射余弦。</p><p><b>关键参数：</b>0.130 m2系统级等效面积、30%效率、MPPT电压表达式、泄放电阻、面板热容和14号热敏</p><p><b>关键状态：</b>端电压、电流、面板温度和第三路MPPT量</p><p><b>物理域：</b>光伏、电、热、机械、环境、信息</p><h4>信息与遥测关系</h4><p><b>数据路径：</b>第三路子阵/MPPT工程量及同截面端口功率进入InformationPort，14号热敏进入温度组</p><p><b>使用说明：</b>设备测量与机器反馈均写入同一个InformationPort.device语义域；不存在平行的传感器遥测接口。应从N-System画布下钻本组件，并结合总体公共电/热/机械网络解释结果。</p></html>"
));
end SolarArrayWing3Unit;