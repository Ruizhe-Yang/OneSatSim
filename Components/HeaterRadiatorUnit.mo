within OneSatSim.Components;
model HeaterRadiatorUnit "加热器与散热执行组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.HeatersComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance heaterResistance=config.HeaterResistance
    "分布式加热器电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity heaterDeckHeatCapacity=config.HeaterDeckHeatCapacity
    "加热器舱板热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance radiatorConductance=config.RadiatorConductance
    "散热执行路径导热；Excel单位W/K，当前设计基线";
  parameter Modelica.Units.SI.Mass mass=config.Mass
    "质量；Excel单位kg，当前设计基线";
  parameter Modelica.Units.SI.Length rcm_X=config.RCM_X
    "质心偏置X；Excel单位m，当前设计基线";
  parameter Modelica.Units.SI.Length rcm_Y=config.RCM_Y
    "质心偏置Y；Excel单位m，当前设计基线";
  parameter Modelica.Units.SI.Length rcm_Z=config.RCM_Z
    "质心偏置Z；Excel单位m，当前设计基线";
  parameter Modelica.Units.SI.Inertia inertia_XX=config.Inertia_XX
    "局部惯量 Ixx；Excel单位kg·m²，当前设计基线";
  parameter Modelica.Units.SI.Inertia inertia_YY=config.Inertia_YY
    "局部惯量 Iyy；Excel单位kg·m²，当前设计基线";
  parameter Modelica.Units.SI.Inertia inertia_ZZ=config.Inertia_ZZ
    "局部惯量 Izz；Excel单位kg·m²，当前设计基线";
  Foundation.Interfaces.PowerPort power  "功率" annotation(Placement(visible=true, transformation(origin={-360,230}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,95}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Conductor unused5Rail(G=0)  "计算/接口量 unused5Rail" annotation(Placement(visible=true, transformation(origin={-200,320}, extent={{-20,-20},{20,20}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0)  "计算/接口量 unused33Rail" annotation(Placement(visible=true, transformation(origin={-290,320}, extent={{-20,-20},{20,20}}, rotation=0)));
  Foundation.Interfaces.ThermalPort thermal  "热学" annotation(Placement(visible=true, transformation(origin={300,-148}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,-97}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(visible=true, transformation(origin={-360,-160}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.InformationPort information  "计算/接口量 information" annotation(Placement(visible=true, transformation(origin={360,30}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.IntegerSignalReader controlState[11]  "可扩展总线整数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-170,50}, extent={{-16,-16},{16,16}}, rotation=0)));
  Modelica.Blocks.Sources.IntegerConstant unusedChannel(k=0)  "计算/接口量 unusedChannel" annotation(Placement(visible=true, transformation(origin={-165,-45}, extent={{-22,-22},{22,22}}, rotation=0)));
  Foundation.Calculations.HeaterChannelCalculation heaterCalculation[12](each heaterResistance=heaterResistance)
    "单路加热器指令与平均电导计算实例；Average-value switch conductance; removes ideal electrical mode changes" annotation(Placement(visible=true, transformation(origin={15,55}, extent={{-66,-66},{66,66}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor heaterCurrent[11]  "heater电流" annotation(Placement(visible=true, transformation(origin={-240,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.VariableConductor heater[12](each useHeatPort=true)
    "任务级参数: about 1 W per distributed 12 V heater" annotation(Placement(visible=true, transformation(origin={150,230}, extent={{-28,-28},{28,28}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heaterDeck(C=heaterDeckHeatCapacity,T(start=290.15,fixed=false))  "计算/接口量 heaterDeck" annotation(Placement(visible=true, transformation(origin={15,-120}, extent={{-28,-28},{28,28}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor radiator(G=radiatorConductance)  "计算/接口量 radiator" annotation(Placement(visible=true, transformation(origin={165,-148}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.Body harnessMass(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ)  "harness质量" annotation(Placement(visible=true, transformation(origin={-260,-160}, extent={{-30,-30},{30,30}}, rotation=0)));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[11]  "实数因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={245,55}, extent={{-16,-16},{16,16}}, rotation=0)));
equation
  connect(information.device.tcState[1:11],controlState.u) annotation(Line(points={{360,30},{360,-19.02},{-217.38,-19.02},{-217.38,50},{-184.24,50}}, color={255,127,0}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(controlState.y,heaterCalculation[1:11].controlState) annotation(Line(points={{-155.76,50},{-53.74,50},{-53.74,55},{-43.74,55}}, color={255,127,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unusedChannel.y,heaterCalculation[12].controlState) annotation(Line(points={{-165,-45},{-53.74,-45},{-53.74,55},{-43.74,55}}, color={255,127,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p5,unused5Rail.p) annotation(Line(points={{-360,230},{-360,264},{-230,264},{-230,320},{-220,320}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused5Rail.n,power.n5) annotation(Line(points={{-180,320},{-170,320},{-170,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{-360,230},{-360,320},{-310,320}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{-270,320},{-260,320},{-260,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCalculation.conductance,heater.G) annotation(Line(points={{73.74,2.2},{83.74,2.2},{83.74,273.6},{150,273.6},{150,263.6}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[1].n,heater[1].p) annotation(Line(points={{-216,230},{122,230}},color={0,0,255},thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[2].n,heater[2].p) annotation(Line(points={{-216,230},{122,230}},color={0,0,255},thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[3].n,heater[3].p) annotation(Line(points={{-216,230},{122,230}},color={0,0,255},thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[4].n,heater[4].p) annotation(Line(points={{-216,230},{122,230}},color={0,0,255},thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[5].n,heater[5].p) annotation(Line(points={{-216,230},{122,230}},color={0,0,255},thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[6].n,heater[6].p) annotation(Line(points={{-216,230},{122,230}},color={0,0,255},thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[7].n,heater[7].p) annotation(Line(points={{-216,230},{122,230}},color={0,0,255},thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[8].n,heater[8].p) annotation(Line(points={{-216,230},{122,230}},color={0,0,255},thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[9].n,heater[9].p) annotation(Line(points={{-216,230},{122,230}},color={0,0,255},thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[10].n,heater[10].p) annotation(Line(points={{-216,230},{122,230}},color={0,0,255},thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[11].n,heater[11].p) annotation(Line(points={{-216,230},{122,230}},color={0,0,255},thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[1].i,informationRealBridge[1].u) annotation(Line(points={{-240,203.6},{-240,193.6},{83.74,193.6},{83.74,55},{230.76,55}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[1].y,information.device.tcCurrent[1]) annotation(Line(points={{259.24,55},{360,55},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[2].i,informationRealBridge[2].u) annotation(Line(points={{-240,203.6},{-240,193.6},{83.74,193.6},{83.74,55},{230.76,55}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[2].y,information.device.tcCurrent[2]) annotation(Line(points={{259.24,55},{360,55},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[3].i,informationRealBridge[3].u) annotation(Line(points={{-240,203.6},{-240,193.6},{83.74,193.6},{83.74,55},{230.76,55}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[3].y,information.device.tcCurrent[3]) annotation(Line(points={{259.24,55},{360,55},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[4].i,informationRealBridge[4].u) annotation(Line(points={{-240,203.6},{-240,193.6},{83.74,193.6},{83.74,55},{230.76,55}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[4].y,information.device.tcCurrent[4]) annotation(Line(points={{259.24,55},{360,55},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[5].i,informationRealBridge[5].u) annotation(Line(points={{-240,203.6},{-240,193.6},{83.74,193.6},{83.74,55},{230.76,55}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[5].y,information.device.tcCurrent[5]) annotation(Line(points={{259.24,55},{360,55},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[6].i,informationRealBridge[6].u) annotation(Line(points={{-240,203.6},{-240,193.6},{83.74,193.6},{83.74,55},{230.76,55}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[6].y,information.device.tcCurrent[6]) annotation(Line(points={{259.24,55},{360,55},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[7].i,informationRealBridge[7].u) annotation(Line(points={{-240,203.6},{-240,193.6},{83.74,193.6},{83.74,55},{230.76,55}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[7].y,information.device.tcCurrent[7]) annotation(Line(points={{259.24,55},{360,55},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[8].i,informationRealBridge[8].u) annotation(Line(points={{-240,203.6},{-240,193.6},{83.74,193.6},{83.74,55},{230.76,55}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[8].y,information.device.tcCurrent[8]) annotation(Line(points={{259.24,55},{360,55},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[9].i,informationRealBridge[9].u) annotation(Line(points={{-240,203.6},{-240,193.6},{83.74,193.6},{83.74,55},{230.76,55}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[9].y,information.device.tcCurrent[9]) annotation(Line(points={{259.24,55},{360,55},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[10].i,informationRealBridge[10].u) annotation(Line(points={{-240,203.6},{-240,193.6},{83.74,193.6},{83.74,55},{230.76,55}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[10].y,information.device.tcCurrent[10]) annotation(Line(points={{259.24,55},{360,55},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterCurrent[11].i,informationRealBridge[11].u) annotation(Line(points={{-240,203.6},{-240,193.6},{83.74,193.6},{83.74,55},{230.76,55}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[11].y,information.device.tcCurrent[11]) annotation(Line(points={{259.24,55},{360,55},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[1].heatPort,heaterDeck.port) annotation(Line(points={{150,202},{150,192},{83.74,192},{83.74,-158},{15,-158},{15,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[2].heatPort,heaterDeck.port) annotation(Line(points={{150,202},{150,192},{83.74,192},{83.74,-158},{15,-158},{15,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[3].heatPort,heaterDeck.port) annotation(Line(points={{150,202},{150,192},{83.74,192},{83.74,-158},{15,-158},{15,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[4].heatPort,heaterDeck.port) annotation(Line(points={{150,202},{150,192},{83.74,192},{83.74,-158},{15,-158},{15,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[5].heatPort,heaterDeck.port) annotation(Line(points={{150,202},{150,192},{83.74,192},{83.74,-158},{15,-158},{15,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[6].heatPort,heaterDeck.port) annotation(Line(points={{150,202},{150,192},{83.74,192},{83.74,-158},{15,-158},{15,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[7].heatPort,heaterDeck.port) annotation(Line(points={{150,202},{150,192},{83.74,192},{83.74,-158},{15,-158},{15,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[8].heatPort,heaterDeck.port) annotation(Line(points={{150,202},{150,192},{83.74,192},{83.74,-158},{15,-158},{15,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[9].heatPort,heaterDeck.port) annotation(Line(points={{150,202},{150,192},{83.74,192},{83.74,-158},{15,-158},{15,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[10].heatPort,heaterDeck.port) annotation(Line(points={{150,202},{150,192},{83.74,192},{83.74,-158},{15,-158},{15,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[11].heatPort,heaterDeck.port) annotation(Line(points={{150,202},{150,192},{83.74,192},{83.74,-158},{15,-158},{15,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[12].heatPort,heaterDeck.port) annotation(Line(points={{150,202},{150,192},{83.74,192},{83.74,-158},{15,-158},{15,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heaterDeck.port,radiator.port_a) annotation(Line(points={{15,-148},{15,-158},{131,-158},{131,-148},{141,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(radiator.port_b,thermal) annotation(Line(points={{189,-148},{300,-148}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(harnessMass.frame_a,mechanical) annotation(Line(points={{-290,-160},{-360,-160}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p12,heaterCurrent[1].p) annotation(Line(points={{-360,230},{-264,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p12,heaterCurrent[2].p) annotation(Line(points={{-360,230},{-264,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p12,heaterCurrent[3].p) annotation(Line(points={{-360,230},{-264,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p12,heaterCurrent[4].p) annotation(Line(points={{-360,230},{-264,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p12,heaterCurrent[5].p) annotation(Line(points={{-360,230},{-264,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p12,heaterCurrent[6].p) annotation(Line(points={{-360,230},{-264,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p12,heaterCurrent[7].p) annotation(Line(points={{-360,230},{-264,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p12,heaterCurrent[8].p) annotation(Line(points={{-360,230},{-264,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p12,heaterCurrent[9].p) annotation(Line(points={{-360,230},{-264,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p12,heaterCurrent[10].p) annotation(Line(points={{-360,230},{-264,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p12,heaterCurrent[11].p) annotation(Line(points={{-360,230},{-264,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p12,heater[12].p) annotation(Line(points={{-360,230},{122,230}},color={0,0,255},thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[1].n,power.n12) annotation(Line(points={{178,230},{188,230},{188,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[2].n,power.n12) annotation(Line(points={{178,230},{188,230},{188,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[3].n,power.n12) annotation(Line(points={{178,230},{188,230},{188,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[4].n,power.n12) annotation(Line(points={{178,230},{188,230},{188,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[5].n,power.n12) annotation(Line(points={{178,230},{188,230},{188,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[6].n,power.n12) annotation(Line(points={{178,230},{188,230},{188,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[7].n,power.n12) annotation(Line(points={{178,230},{188,230},{188,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[8].n,power.n12) annotation(Line(points={{178,230},{188,230},{188,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[9].n,power.n12) annotation(Line(points={{178,230},{188,230},{188,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[10].n,power.n12) annotation(Line(points={{178,230},{188,230},{188,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[11].n,power.n12) annotation(Line(points={{178,230},{188,230},{188,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(heater[12].n,power.n12) annotation(Line(points={{178,230},{188,230},{188,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>加热器与散热执行组件</h2><p><b>类路径：</b><code>OneSatSim.Components.HeaterRadiatorUnit</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>加热器与散热执行组件</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.N_systems.ThermalControlSystem\">OneSatSim.Systems.N_systems.ThermalControlSystem</a> 的 <code>heaters</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>power</code></td><td>Foundation.Interfaces.PowerPort</td><td>public</td><td>按声明/类型合同</td><td>功率</td></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr><tr><td><code>information</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr><tr><td><code>controlState[11]</code></td><td>Foundation.Interfaces.IntegerSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线整数信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>informationRealBridge[11]</code></td><td>Foundation.Interfaces.RealSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>实数因果输出到可扩展信息总线的无状态恒等桥实例</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>config</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.HeatersComponentConfig</td><td>由所属N-System传入的硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>heaterResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>分布式加热器电阻；Excel单位Ω，当前设计基线</td><td><code>=config.HeaterResistance</code></td></tr><tr><td><code>heaterDeckHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>加热器舱板热容；Excel单位J/K，当前设计基线</td><td><code>=config.HeaterDeckHeatCapacity</code></td></tr><tr><td><code>radiatorConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>散热执行路径导热；Excel单位W/K，当前设计基线</td><td><code>=config.RadiatorConductance</code></td></tr><tr><td><code>mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel单位kg，当前设计基线</td><td><code>=config.Mass</code></td></tr><tr><td><code>rcm_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel单位m，当前设计基线</td><td><code>=config.RCM_X</code></td></tr><tr><td><code>rcm_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel单位m，当前设计基线</td><td><code>=config.RCM_Y</code></td></tr><tr><td><code>rcm_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel单位m，当前设计基线</td><td><code>=config.RCM_Z</code></td></tr><tr><td><code>inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_XX</code></td></tr><tr><td><code>inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_YY</code></td></tr><tr><td><code>inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_ZZ</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>unused5Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused5Rail</td></tr><tr><td><code>unused33Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused33Rail</td></tr><tr><td><code>unusedChannel</code></td><td><a href=\"modelica://Modelica.Blocks.Sources.IntegerConstant\">Modelica.Blocks.Sources.IntegerConstant</a></td><td>计算/接口量 unusedChannel</td></tr><tr><td><code>heaterCalculation[12]</code></td><td><a href=\"modelica://OneSatSim.Foundation.Calculations.HeaterChannelCalculation\">OneSatSim.Foundation.Calculations.HeaterChannelCalculation</a></td><td>单路加热器指令与平均电导计算实例；Average-value switch conductance; removes ideal electrical mode changes</td></tr><tr><td><code>heaterCurrent[11]</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Sensors.CurrentSensor\">Modelica.Electrical.Analog.Sensors.CurrentSensor</a></td><td>heater电流</td></tr><tr><td><code>heater[12]</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.VariableConductor\">Modelica.Electrical.Analog.Basic.VariableConductor</a></td><td>任务级参数: about 1 W per distributed 12 V heater</td></tr><tr><td><code>heaterDeck</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a></td><td>计算/接口量 heaterDeck</td></tr><tr><td><code>radiator</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">Modelica.Thermal.HeatTransfer.Components.ThermalConductor</a></td><td>计算/接口量 radiator</td></tr><tr><td><code>harnessMass</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">Modelica.Mechanics.MultiBody.Parts.Body</a></td><td>harness质量</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={196,94,56}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Thermal hardware", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-51,-36},{20,36}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Line(points={{-43,-24},{-31,-24},{-31,24},{-18,24},{-18,-24},{-5,-24},{-5,24},{8,24},{8,-24},{17,-24}}, color={196,94,56}, thickness=1, pattern=LinePattern.Solid),
      Rectangle(extent={{29,-36},{51,36}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{30,-28},{49,-28}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{30,-16},{49,-16}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{30,-4},{49,-4}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{30,8},{49,8}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{30,20},{49,20}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{30,32},{49,32}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{54,-20},{61,-15},{67,-20},{73,-15}}, color={196,94,56}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{54,5},{61,10},{67,5},{73,10}}, color={196,94,56}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{54,30},{61,35},{67,30},{73,35}}, color={196,94,56}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{-63,-24},{-51,-24}}, color={77,126,172}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-63,24},{-51,24}}, color={77,126,172}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Heater and Radiator", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-404,-228},{404,462}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-295,145},{-51.4,163}}, textString="Functional core and telemetry", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-330,374},{-229.2,392}}, textString="Power supply", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-325,-106},{-157,-88}}, textString="Thermal and mounting", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-392,417},{392,446}}, textString="Heater assembly: commands to heat rejection", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-392,409},{392,409}}, color={215,220,226}, thickness=0.25)
    }));
end HeaterRadiatorUnit;