within NISSA_12UCubeSat.Components;
model HeaterRadiatorUnit "加热器与散热执行组件"
  parameter NISSA_12UCubeSat.Scenarios.DesignConfigRecords.HeatersComponentConfig config
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
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}}),iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Basic.Conductor unused5Rail(G=0) annotation(Placement(transformation(extent={{30,76},{42,88}})));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0) annotation(Placement(transformation(extent={{54,76},{66,88}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  Foundation.Interfaces.IntegerSignalReader controlState[11] annotation(Placement(transformation(extent={{-92,58},{-76,74}})));
  Modelica.Blocks.Sources.IntegerConstant unusedChannel(k=0) annotation(Placement(transformation(extent={{76,74},{92,90}})));
  Foundation.Calculations.HeaterChannelCalculation heaterCalculation[12](each heaterResistance=heaterResistance)
    "Average-value switch conductance; removes ideal electrical mode changes" annotation(Placement(transformation(extent={{-68,56},{-42,76}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor heaterCurrent[12] annotation(Placement(transformation(extent={{-20,38},{0,58}})));
  Modelica.Electrical.Analog.Basic.VariableConductor heater[12](each useHeatPort=true)
    "任务级参数: about 1 W per distributed 12 V heater" annotation(Placement(transformation(extent={{15,38},{35,58}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heaterDeck(C=heaterDeckHeatCapacity,T(start=290.15,fixed=false)) annotation(Placement(transformation(extent={{-20,-35},{0,-15}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor radiator(G=radiatorConductance) annotation(Placement(transformation(extent={{20,-33},{40,-17}})));
  Modelica.Mechanics.MultiBody.Parts.Body harnessMass(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-82,2},{-62,22}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[11] annotation(Placement(transformation(extent={{78,20},{86,28}})));
equation
  connect(information.device.tcState[1:11],controlState.u) annotation(Line(points={{100,0},{94,0},{94,66},{-92,66}},color={255,127,0}));
  connect(controlState.y,heaterCalculation[1:11].controlState) annotation(Line(points={{-76,66},{-68,66}},color={255,127,0}));
  connect(unusedChannel.y,heaterCalculation[12].controlState) annotation(Line(points={{92.8,82},{92.8,66},{-68,66}},color={255,127,0}));
  connect(power.p5,unused5Rail.p) annotation(Line(points={{0,100},{0,94},{30,94},{30,82}},color={0,0,255}));
  connect(unused5Rail.n,power.n5) annotation(Line(points={{42,82},{42,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{0,94},{54,94},{54,82}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{66,82},{66,94},{0,94},{0,100}},color={0,0,255}));
  connect(heaterCalculation.conductance,heater.G) annotation(Line(points={{-43.3,62.5},{25,62.5},{25,60}},color={0,0,127}));
  connect(heaterCurrent.n,heater.p) annotation(Line(points={{0,48},{15,48}},color={0,0,255}));
  connect(heaterCurrent[1].i,informationRealBridge[1].u) annotation(Line(points={{-10,38},{78,38},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.tcCurrent[1]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(heaterCurrent[2].i,informationRealBridge[2].u) annotation(Line(points={{-10,38},{78,38},{78,24}},color={0,0,127}));
  connect(informationRealBridge[2].y,information.device.tcCurrent[2]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(heaterCurrent[3].i,informationRealBridge[3].u) annotation(Line(points={{-10,38},{78,38},{78,24}},color={0,0,127}));
  connect(informationRealBridge[3].y,information.device.tcCurrent[3]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(heaterCurrent[4].i,informationRealBridge[4].u) annotation(Line(points={{-10,38},{78,38},{78,24}},color={0,0,127}));
  connect(informationRealBridge[4].y,information.device.tcCurrent[4]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(heaterCurrent[5].i,informationRealBridge[5].u) annotation(Line(points={{-10,38},{78,38},{78,24}},color={0,0,127}));
  connect(informationRealBridge[5].y,information.device.tcCurrent[5]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(heaterCurrent[6].i,informationRealBridge[6].u) annotation(Line(points={{-10,38},{78,38},{78,24}},color={0,0,127}));
  connect(informationRealBridge[6].y,information.device.tcCurrent[6]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(heaterCurrent[7].i,informationRealBridge[7].u) annotation(Line(points={{-10,38},{78,38},{78,24}},color={0,0,127}));
  connect(informationRealBridge[7].y,information.device.tcCurrent[7]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(heaterCurrent[8].i,informationRealBridge[8].u) annotation(Line(points={{-10,38},{78,38},{78,24}},color={0,0,127}));
  connect(informationRealBridge[8].y,information.device.tcCurrent[8]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(heaterCurrent[9].i,informationRealBridge[9].u) annotation(Line(points={{-10,38},{78,38},{78,24}},color={0,0,127}));
  connect(informationRealBridge[9].y,information.device.tcCurrent[9]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(heaterCurrent[10].i,informationRealBridge[10].u) annotation(Line(points={{-10,38},{78,38},{78,24}},color={0,0,127}));
  connect(informationRealBridge[10].y,information.device.tcCurrent[10]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(heaterCurrent[11].i,informationRealBridge[11].u) annotation(Line(points={{-10,38},{78,38},{78,24}},color={0,0,127}));
  connect(informationRealBridge[11].y,information.device.tcCurrent[11]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(heater[1].heatPort,heaterDeck.port) annotation(Line(points={{25,38},{25,-15},{-10,-15}},color={191,0,0}));
  connect(heater[2].heatPort,heaterDeck.port) annotation(Line(points={{25,38},{25,-15},{-10,-15}},color={191,0,0}));
  connect(heater[3].heatPort,heaterDeck.port) annotation(Line(points={{25,38},{25,-15},{-10,-15}},color={191,0,0}));
  connect(heater[4].heatPort,heaterDeck.port) annotation(Line(points={{25,38},{25,-15},{-10,-15}},color={191,0,0}));
  connect(heater[5].heatPort,heaterDeck.port) annotation(Line(points={{25,38},{25,-15},{-10,-15}},color={191,0,0}));
  connect(heater[6].heatPort,heaterDeck.port) annotation(Line(points={{25,38},{25,-15},{-10,-15}},color={191,0,0}));
  connect(heater[7].heatPort,heaterDeck.port) annotation(Line(points={{25,38},{25,-15},{-10,-15}},color={191,0,0}));
  connect(heater[8].heatPort,heaterDeck.port) annotation(Line(points={{25,38},{25,-15},{-10,-15}},color={191,0,0}));
  connect(heater[9].heatPort,heaterDeck.port) annotation(Line(points={{25,38},{25,-15},{-10,-15}},color={191,0,0}));
  connect(heater[10].heatPort,heaterDeck.port) annotation(Line(points={{25,38},{25,-15},{-10,-15}},color={191,0,0}));
  connect(heater[11].heatPort,heaterDeck.port) annotation(Line(points={{25,38},{25,-15},{-10,-15}},color={191,0,0}));
  connect(heater[12].heatPort,heaterDeck.port) annotation(Line(points={{25,38},{25,-15},{-10,-15}},color={191,0,0}));
  connect(heaterDeck.port,radiator.port_a) annotation(Line(points={{-10,-35},{-10,-25},{20,-25}},color={191,0,0}));
  connect(radiator.port_b,thermal) annotation(Line(points={{40,-25},{40,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(harnessMass.frame_a,mechanical) annotation(Line(points={{-82,12},{-94,12},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  connect(power.p12,heaterCurrent[1].p) annotation(Line(points={{0,100},{0,94},{-20,94},{-20,48}},color={0,0,255}));
  connect(power.p12,heaterCurrent[2].p) annotation(Line(points={{0,100},{0,94},{-20,94},{-20,48}},color={0,0,255}));
  connect(power.p12,heaterCurrent[3].p) annotation(Line(points={{0,100},{0,94},{-20,94},{-20,48}},color={0,0,255}));
  connect(power.p12,heaterCurrent[4].p) annotation(Line(points={{0,100},{0,94},{-20,94},{-20,48}},color={0,0,255}));
  connect(power.p12,heaterCurrent[5].p) annotation(Line(points={{0,100},{0,94},{-20,94},{-20,48}},color={0,0,255}));
  connect(power.p12,heaterCurrent[6].p) annotation(Line(points={{0,100},{0,94},{-20,94},{-20,48}},color={0,0,255}));
  connect(power.p12,heaterCurrent[7].p) annotation(Line(points={{0,100},{0,94},{-20,94},{-20,48}},color={0,0,255}));
  connect(power.p12,heaterCurrent[8].p) annotation(Line(points={{0,100},{0,94},{-20,94},{-20,48}},color={0,0,255}));
  connect(power.p12,heaterCurrent[9].p) annotation(Line(points={{0,100},{0,94},{-20,94},{-20,48}},color={0,0,255}));
  connect(power.p12,heaterCurrent[10].p) annotation(Line(points={{0,100},{0,94},{-20,94},{-20,48}},color={0,0,255}));
  connect(power.p12,heaterCurrent[11].p) annotation(Line(points={{0,100},{0,94},{-20,94},{-20,48}},color={0,0,255}));
  connect(power.p12,heaterCurrent[12].p) annotation(Line(points={{0,100},{0,94},{-20,94},{-20,48}},color={0,0,255}));
  connect(heater[1].n,power.n12) annotation(Line(points={{35,48},{35,74.5},{0,74.5},{0,100}},color={0,0,255}));
  connect(heater[2].n,power.n12) annotation(Line(points={{35,48},{35,74.5},{0,74.5},{0,100}},color={0,0,255}));
  connect(heater[3].n,power.n12) annotation(Line(points={{35,48},{35,74.5},{0,74.5},{0,100}},color={0,0,255}));
  connect(heater[4].n,power.n12) annotation(Line(points={{35,48},{35,74.5},{0,74.5},{0,100}},color={0,0,255}));
  connect(heater[5].n,power.n12) annotation(Line(points={{35,48},{35,74.5},{0,74.5},{0,100}},color={0,0,255}));
  connect(heater[6].n,power.n12) annotation(Line(points={{35,48},{35,74.5},{0,74.5},{0,100}},color={0,0,255}));
  connect(heater[7].n,power.n12) annotation(Line(points={{35,48},{35,74.5},{0,74.5},{0,100}},color={0,0,255}));
  connect(heater[8].n,power.n12) annotation(Line(points={{35,48},{35,74.5},{0,74.5},{0,100}},color={0,0,255}));
  connect(heater[9].n,power.n12) annotation(Line(points={{35,48},{35,74.5},{0,74.5},{0,100}},color={0,0,255}));
  connect(heater[10].n,power.n12) annotation(Line(points={{35,48},{35,74.5},{0,74.5},{0,100}},color={0,0,255}));
  connect(heater[11].n,power.n12) annotation(Line(points={{35,48},{35,74.5},{0,74.5},{0,100}},color={0,0,255}));
  connect(heater[12].n,power.n12) annotation(Line(points={{35,48},{35,74.5},{0,74.5},{0,100}},color={0,0,255}));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={190,50,25},fillColor={252,232,224},fillPattern=FillPattern.Solid),Line(points={{-75,45},{75,45}},color={230,90,40},thickness=5),Line(points={{-75,15},{75,15}},color={230,90,40},thickness=5),Line(points={{-75,-15},{75,-15}},color={230,90,40},thickness=5),Line(points={{-75,-45},{75,-45}},color={230,90,40},thickness=5),Text(extent={{-92,-74},{92,-52}},textString="12 DISTRIBUTED HEATERS")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Text(extent={{-92,75},{92,62}},textString="12路平均值电导-电流传感-电阻热源")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>把1至12路热控指令转换为公共舱板加热功率；电池17/18路已下沉到BatteryUnit并直接加热电芯/壳体。</p><p><b>白箱实现：</b>12路状态转发、HeaterChannelCalculation、VariableConductor和电流传感器构成低阶平均值加热支路，移除理想开关非线性模式；焦耳热进入公共加热舱板。</p><p><b>信息与遥测：</b>本组件提供tcCurrent[1:12]，BatteryUnit提供tcCurrent[17:18]，TCB-S0通道定义保持不变。</p><h4>功能与接口</h4><p>本组件把TCB通道状态转换为11路公共加热/散热执行支路；电池17/18路和相机12路在各自敏感组件内部直接执行，因此不在此重复注热。information读取通道状态并发布执行电流，power供给加热器，thermal汇集焦耳热，mechanical提供安装质量。</p><h4>内部能量路径</h4><p>IntegerSignalReader把控制码交给HeaterChannelCalculation，计算每路导通状态和等效电导；VariableConductor从相应母线取电，useHeatPort把真实焦耳损耗送入加热舱板。舱板热容与导热件再把热量交给公共热网。</p><h4>结果查看与边界</h4><p>查看heaterCalculation.enabled、heaterCurrent[i].i、heater[i].lossPower及加热舱板温度，并核对通道号和热控阈值。模型不展开继电器触点、电缆压降、PWM和贴片空间温差；Radiator名称表示执行/散热组件语义，不额外建立主动制冷回路。</p></html>"));
end HeaterRadiatorUnit;
