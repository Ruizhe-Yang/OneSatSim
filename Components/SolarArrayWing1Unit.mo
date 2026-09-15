within NISSA_12UCubeSat.Components;
model SolarArrayWing1Unit "太阳翼1组件"
  parameter Modelica.Units.SI.Area activeArea=0.145 "SYSTEM-LEVEL EQUIVALENT area for 24 h battery charge balance";
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
    "Common deployed-wing normal is body +X" annotation(Placement(transformation(extent={{-78,56},{-48,70}})));
  Modelica.Blocks.Sources.RealExpression photoCurrent(y=activeArea*0.29*environment.solarFlux*incidenceCos.y/max(9.5,information.device.busVoltage[1])*max(0,min(1,(0.975-information.device.batterySOC)/0.04)))
    "Continuous battery-acceptance curtailment: zero generation at the high-SOC boundary" annotation(Placement(transformation(extent={{-75,28},{-50,48}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent stringSource annotation(Placement(transformation(extent={{-38,24},{-18,44}})));
  Modelica.Electrical.Analog.Ideal.IdealDiode blockingDiode annotation(Placement(transformation(extent={{15,24},{35,44}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor mpptCurrent annotation(Placement(transformation(extent={{-10,24},{10,44}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor mpptVoltage annotation(Placement(transformation(origin={42,0},extent={{-9,-9},{9,9}},rotation=270)));
  Modelica.Electrical.Analog.Basic.Capacitor inputFilter(C=0.0012) annotation(Placement(transformation(origin={68,0},extent={{-9,-9},{9,9}},rotation=270)));
  Modelica.Blocks.Sources.RealExpression absorbedHeat(y=activeArea*environment.solarFlux*incidenceCos.y*(1-0.29)) annotation(Placement(transformation(extent={{-75,-12},{-50,8}})));
  Modelica.Blocks.Sources.RealExpression subArrayVoltage(y=if environment.solarFlux > 1 and incidenceCos.y > 1e-6 then 5.2*(0.90 + 0.10*incidenceCos.y) else 0) "SYSTEM-LEVEL EQUIVALENT: pre-MPPT array voltage" annotation(Placement(transformation(extent={{-78,-42},{-48,-26}})));
  Modelica.Blocks.Sources.RealExpression mpptOperatingVoltage(y=if information.device.busVoltage[1] > 9 and environment.solarFlux > 1 and incidenceCos.y > 1e-6 then 3.175*(1 + 0.002*tanh(incidenceCos.y)) else 0) "SYSTEM-LEVEL EQUIVALENT: powered MPPT1 controller-side sense point" annotation(Placement(transformation(extent={{-42,-42},{-12,-26}})));
  Modelica.Blocks.Sources.RealExpression solarTerminalPower(y=max(0,mpptVoltage.v*mpptCurrent.i))
    "Same-section regulated 12 V terminal voltage times delivered current" annotation(Placement(transformation(extent={{-78,-66},{-48,-52}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatInput annotation(Placement(transformation(extent={{-35,-12},{-15,8}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor panelThermalMass(C=510,T(start=293.15,fixed=false)) annotation(Placement(transformation(extent={{0,-45},{20,-25}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor hingePath(G=2.2) "SYSTEM-LEVEL EQUIVALENT: panel mounting plus omitted local radiation rejection" annotation(Placement(transformation(extent={{35,-43},{55,-27}})));
  Modelica.Mechanics.MultiBody.Parts.Body panelBody(m=0.82,r_CM={0.32,0,0},I_11=0.002,I_22=0.035,I_33=0.035) annotation(Placement(transformation(extent={{-10,65},{10,85}})));
equation
  connect(power.p5,unused5Rail.p) annotation(Line(points={{-102,0},{-78,-88}},color={0,0,255}));
  connect(unused5Rail.n,power.n5) annotation(Line(points={{-66,-88},{-102,0}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{-102,0},{-58,-88}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{-46,-88},{-102,0}},color={0,0,255}));
  connect(photoCurrent.y,stringSource.i) annotation(Line(points={{-48.75,38},{-28,38},{-28,46}},color={0,0,127}));
  connect(stringSource.p,power.n12) annotation(Line(points={{-38,34},{-45,34},{-45,15},{102,15},{102,0}},color={0,0,255}));
  connect(stringSource.n,mpptCurrent.p) annotation(Line(points={{-18,34},{-10,34}},color={0,0,255}));
  connect(mpptCurrent.n,blockingDiode.p) annotation(Line(points={{10,34},{15,34}},color={0,0,255}));
  connect(blockingDiode.n,power.p12) annotation(Line(points={{35,34},{102,34},{102,0}},color={0,0,255}));
  connect(mpptVoltage.p,power.p12) annotation(Line(points={{42,9},{42,15},{102,15},{102,0}},color={0,0,255}));
  connect(mpptVoltage.n,power.n12) annotation(Line(points={{42,-9},{42,-15},{102,-15},{102,0}},color={0,0,255}));
  connect(inputFilter.p,power.p12) annotation(Line(points={{68,9},{68,15},{102,15},{102,0}},color={0,0,255}));
  connect(inputFilter.n,power.n12) annotation(Line(points={{68,-9},{68,-15},{102,-15},{102,0}},color={0,0,255}));
  connect(subArrayVoltage.y,information.device.subArrayVoltage[1]) annotation(Line(points={{-46.5,-34},{-92,-34},{-92,-50},{-102,-50}},color={0,0,127}));
  connect(mpptOperatingVoltage.y,information.device.mpptVoltage[1]) annotation(Line(points={{-10.5,-34},{-84,-34},{-84,-50},{-102,-50}},color={0,0,127}));
  connect(mpptCurrent.i,information.device.mpptCurrent[1]) annotation(Line(points={{0,24},{0,15},{-90,15},{-90,-50},{-102,-50}},color={0,0,127}));
  connect(solarTerminalPower.y,information.device.solarOutputPower[1]) annotation(Line(points={{-46.5,-59},{-82,-59},{-82,-50},{-102,-50}},color={0,0,127}));
  connect(absorbedHeat.y,heatInput.Q_flow) annotation(Line(points={{-48.75,-2},{-35,-2}},color={0,0,127}));
  connect(heatInput.port,panelThermalMass.port) annotation(Line(points={{-15,-2},{10,-2},{10,-25}},color={191,0,0}));
  connect(panelThermalMass.port,hingePath.port_a) annotation(Line(points={{10,-45},{35,-35}},color={191,0,0}));
  connect(hingePath.port_b,thermal) annotation(Line(points={{55,-35},{65,-35},{65,-90},{0,-90},{0,-100}},color={191,0,0}));
  connect(panelBody.frame_a,mechanical) annotation(Line(points={{-10,75},{0,75},{0,100}},color={95,95,95},thickness=0.5));
  annotation(Icon(graphics={Rectangle(extent={{-100,78},{100,-78}},lineColor={30,70,130},fillColor={224,235,250},fillPattern=FillPattern.Solid),Rectangle(extent={{-82,50},{82,-42}},fillColor={35,85,155},fillPattern=FillPattern.Solid),Line(points={{-40,50},{-40,-42}},color={220,230,245}),Line(points={{0,50},{0,-42}},color={220,230,245}),Line(points={{40,50},{40,-42}},color={220,230,245}),Text(extent={{-92,-72},{92,-50}},textString="WING 1 / MPPT 1")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}}),graphics={Rectangle(extent={{-85,56},{78,16}},lineColor={0,0,160},pattern=LinePattern.Dash),Text(extent={{-80,65},{45,55}},textString="光生电流-防反二极管-滤波")}),Documentation(info="<html><h4>用途与系统角色</h4><p>共面展开太阳翼1；三翼统一采用机体系+X受光法向。有效面积0.145 m2、效率29%。</p><h4>白箱实现</h4><p>SignalCurrent、防反二极管、端电流/电压传感、滤波电容、吸收太阳热源、面板热容、等效散热路径和刚体显式连接。</p><h4>物理与遥测语义</h4><p>发电、子阵电压、MPPT控制器侧电压和吸收热流使用同一incidenceCos。只有母线有电、solarFlux大于1 W/m2且入射余弦有效时MPPT电压才非零。solarOutputPower[1]为受控12 V端口电压乘交付电流。</p></html>"));
end SolarArrayWing1Unit;