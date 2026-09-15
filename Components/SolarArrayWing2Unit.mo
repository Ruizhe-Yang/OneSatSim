within OneSatSim.Components;
model SolarArrayWing2Unit "太阳翼2双串组件"
  parameter Modelica.Units.SI.Area stringAreaA=0.0725 "SYSTEM-LEVEL EQUIVALENT area for 24 h battery charge balance";
  parameter Modelica.Units.SI.Area stringAreaB=0.0725 "SYSTEM-LEVEL EQUIVALENT area for 24 h battery charge balance";
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
    "Common deployed-wing normal is body +X" annotation(Placement(transformation(extent={{-82,62},{-52,76}})));
  Modelica.Blocks.Sources.RealExpression stringCurrentA(y=stringAreaA*0.285*environment.solarFlux*incidenceCos.y/max(9.5,information.device.busVoltage[1])*max(0,min(1,(0.975-information.device.batterySOC)/0.04)))
    "Continuous battery-acceptance curtailment: zero generation at the high-SOC boundary" annotation(Placement(transformation(extent={{-80,42},{-58,58}})));
  Modelica.Blocks.Sources.RealExpression stringCurrentB(y=stringAreaB*0.285*environment.solarFlux*incidenceCos.y/max(9.5,information.device.busVoltage[1])*max(0,min(1,(0.975-information.device.batterySOC)/0.04)))
    "Continuous battery-acceptance curtailment: zero generation at the high-SOC boundary" annotation(Placement(transformation(extent={{-80,12},{-58,28}})));
  Modelica.Blocks.Sources.RealExpression subArrayVoltage(y=if environment.solarFlux > 1 and incidenceCos.y > 1e-6 then 5.5*(0.90 + 0.10*incidenceCos.y) else 0) "SYSTEM-LEVEL EQUIVALENT: pre-MPPT dual-string voltage" annotation(Placement(transformation(extent={{-78,-18},{-48,-2}})));
  Modelica.Blocks.Sources.RealExpression mpptOperatingVoltage(y=if information.device.busVoltage[1] > 9 and environment.solarFlux > 1 and incidenceCos.y > 1e-6 then 3.445*(1 + 0.002*tanh(incidenceCos.y)) else 0) "SYSTEM-LEVEL EQUIVALENT: powered MPPT2 controller-side sense point" annotation(Placement(transformation(extent={{-42,-18},{-12,-2}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent sourceA annotation(Placement(transformation(extent={{-48,38},{-28,58}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent sourceB annotation(Placement(transformation(extent={{-48,8},{-28,28}})));
  Modelica.Electrical.Analog.Basic.Resistor harnessA(R=0.08,useHeatPort=true) annotation(Placement(transformation(extent={{-15,38},{5,58}})));
  Modelica.Electrical.Analog.Basic.Resistor harnessB(R=0.09,useHeatPort=true) annotation(Placement(transformation(extent={{-15,8},{5,28}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor combinedCurrent annotation(Placement(transformation(extent={{20,23},{40,43}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor terminalVoltage annotation(Placement(transformation(origin={56,0},extent={{-9,-9},{9,9}},rotation=270)));
  Modelica.Blocks.Sources.RealExpression absorbedHeat(y=(stringAreaA+stringAreaB)*environment.solarFlux*incidenceCos.y*(1-0.285)) annotation(Placement(transformation(extent={{-78,-42},{-48,-28}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow solarHeatInput annotation(Placement(transformation(extent={{-42,-44},{-22,-24}})));
  Modelica.Blocks.Sources.RealExpression solarTerminalPower(y=max(0,terminalVoltage.v*combinedCurrent.i))
    "Same-section regulated 12 V terminal voltage times delivered current" annotation(Placement(transformation(extent={{-78,-66},{-48,-52}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor panelThermalMass(C=525,T(start=294.15,fixed=false)) annotation(Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor boomPath(G=2.1)
    "SYSTEM-LEVEL EQUIVALENT: boom conduction plus omitted local radiation rejection" annotation(Placement(transformation(extent={{20,-48},{40,-32}})));
  Modelica.Mechanics.MultiBody.Parts.Body panelBody(m=0.86,r_CM={0,0.33,0},I_11=0.037,I_22=0.002,I_33=0.037) annotation(Placement(transformation(extent={{-10,68},{10,88}})));
equation
  connect(power.p5,unused5Rail.p) annotation(Line(points={{-102,0},{-78,-88}},color={0,0,255}));
  connect(unused5Rail.n,power.n5) annotation(Line(points={{-66,-88},{-102,0}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{-102,0},{-58,-88}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{-46,-88},{-102,0}},color={0,0,255}));
  connect(stringCurrentA.y,sourceA.i) annotation(Line(points={{-56.9,50},{-38,50},{-38,60}},color={0,0,127}));
  connect(stringCurrentB.y,sourceB.i) annotation(Line(points={{-56.9,20},{-38,20},{-38,30}},color={0,0,127}));
  connect(sourceA.p,power.n12) annotation(Line(points={{-48,48},{-52,48},{-52,-5},{102,-5},{102,0}},color={0,0,255}));
  connect(sourceB.p,power.n12) annotation(Line(points={{-48,18},{-52,18},{-52,-5},{102,-5},{102,0}},color={0,0,255}));
  connect(sourceA.n,harnessA.p) annotation(Line(points={{-28,48},{-15,48}},color={0,0,255}));
  connect(sourceB.n,harnessB.p) annotation(Line(points={{-28,18},{-15,18}},color={0,0,255}));
  connect(harnessA.n,combinedCurrent.p) annotation(Line(points={{5,48},{12,48},{12,33},{20,33}},color={0,0,255}));
  connect(harnessB.n,combinedCurrent.p) annotation(Line(points={{5,18},{12,18},{12,33},{20,33}},color={0,0,255}));
  connect(combinedCurrent.n,power.p12) annotation(Line(points={{40,33},{102,33},{102,0}},color={0,0,255}));
  connect(terminalVoltage.p,power.p12) annotation(Line(points={{56,9},{56,15},{102,15},{102,0}},color={0,0,255}));
  connect(terminalVoltage.n,power.n12) annotation(Line(points={{56,-9},{56,-15},{102,-15},{102,0}},color={0,0,255}));
  connect(subArrayVoltage.y,information.device.subArrayVoltage[2]) annotation(Line(points={{-46.5,-10},{-92,-10},{-92,-50},{-102,-50}},color={0,0,127}));
  connect(mpptOperatingVoltage.y,information.device.mpptVoltage[2]) annotation(Line(points={{-10.5,-10},{-84,-10},{-84,-50},{-102,-50}},color={0,0,127}));
  connect(combinedCurrent.i,information.device.mpptCurrent[2]) annotation(Line(points={{30,23},{30,-12},{-85,-12},{-85,-50},{-102,-50}},color={0,0,127}));
  connect(solarTerminalPower.y,information.device.solarOutputPower[2]) annotation(Line(points={{-46.5,-59},{-82,-59},{-82,-50},{-102,-50}},color={0,0,127}));
  connect(absorbedHeat.y,solarHeatInput.Q_flow) annotation(Line(points={{-46.5,-35},{-42,-35},{-42,-34}},color={0,0,127}));
  connect(solarHeatInput.port,panelThermalMass.port) annotation(Line(points={{-22,-34},{-10,-34},{-10,-30}},color={191,0,0}));
  connect(harnessA.heatPort,panelThermalMass.port) annotation(Line(points={{-5,38},{-5,-30},{-10,-30}},color={191,0,0}));
  connect(harnessB.heatPort,panelThermalMass.port) annotation(Line(points={{-5,8},{-5,-30},{-10,-30}},color={191,0,0}));
  connect(panelThermalMass.port,boomPath.port_a) annotation(Line(points={{-10,-50},{20,-40}},color={191,0,0}));
  connect(boomPath.port_b,thermal) annotation(Line(points={{40,-40},{55,-40},{55,-90},{0,-90},{0,-100}},color={191,0,0}));
  connect(panelBody.frame_a,mechanical) annotation(Line(points={{-10,78},{0,78},{0,100}},color={95,95,95},thickness=0.5));
  annotation(Icon(graphics={Rectangle(extent={{-100,78},{100,-78}},lineColor={40,80,135},fillColor={228,238,250},fillPattern=FillPattern.Solid),Rectangle(extent={{-84,52},{-5,-42}},fillColor={45,90,160},fillPattern=FillPattern.Solid),Rectangle(extent={{5,52},{84,-42}},fillColor={55,100,170},fillPattern=FillPattern.Solid),Text(extent={{-92,-72},{92,-50}},textString="DUAL STRING / MPPT 2")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}}),graphics={Rectangle(extent={{-88,64},{48,0}},lineColor={0,0,160},pattern=LinePattern.Dash),Text(extent={{-84,72},{52,62}},textString="两串独立线束损耗并联汇流")}),Documentation(info="<html><h4>用途与系统角色</h4><p>共面展开双串太阳翼2；三翼统一采用机体系+X受光法向。两串面积各0.0725 m2、效率28.5%。</p><h4>白箱实现</h4><p>两路SignalCurrent和独立线束电阻并联汇流；端电流/电压、吸收太阳热源、面板热容、等效散热路径和刚体显式连接。</p><h4>物理与遥测语义</h4><p>两串发电、子阵电压、MPPT控制器侧电压和吸收热流使用同一incidenceCos。只有母线有电、solarFlux大于1 W/m2且入射余弦有效时MPPT电压才非零。solarOutputPower[2]为受控12 V端口电压乘合流电流。</p></html>"));
end SolarArrayWing2Unit;