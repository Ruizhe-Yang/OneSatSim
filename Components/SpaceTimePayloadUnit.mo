within NISSA_12UCubeSat.Components;
model SpaceTimePayloadUnit "时空基准载荷组件"
  parameter NISSA_12UCubeSat.Scenarios.DesignConfigRecords.SpaceTimeComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance activeResistance=config.ActiveResistance
    "时空基准激活负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.Resistance standbyResistance=config.StandbyResistance
    "时空基准待机负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.Resistance emiResistance=config.EMIResistance
    "时空载荷EMI等效串联电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity heatCapacity=config.HeatCapacity
    "时空基准热容；Excel单位J/K，当前设计基线";
  parameter Real thermalResistance(unit="K/W")=config.ThermalResistance
    "时空载荷安装热阻；Excel单位K/W，当前设计基线";
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
  Modelica.Electrical.Analog.Basic.Conductor unused12Rail(G=0) annotation(Placement(transformation(extent={{42,76},{54,88}})));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0) annotation(Placement(transformation(extent={{66,76},{78,88}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor clockCurrent annotation(Placement(transformation(extent={{-74,38},{-54,58}})));
  Modelica.Electrical.Analog.Basic.Resistor emiChoke(R=emiResistance) annotation(Placement(transformation(extent={{-44,38},{-24,58}})));
  Modelica.Electrical.Analog.Basic.VariableConductor oscillatorLoad(useHeatPort=true) "系统级 task-gated 5 V timing load" annotation(Placement(transformation(extent={{-14,38},{6,58}})));
  Foundation.Calculations.PointingModeEquipmentCalculation modeCalculation(
    activeResistance=activeResistance,standbyResistance=standbyResistance) annotation(Placement(transformation(extent={{-48,4},{2,24}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor clockNode(C=heatCapacity,T(start=295.15,fixed=false)) annotation(Placement(transformation(extent={{-20,-44},{0,-24}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor isolator(R=thermalResistance) annotation(Placement(transformation(extent={{20,-42},{40,-26}})));
  Modelica.Mechanics.MultiBody.Parts.Body clockBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-82,2},{-62,22}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[1] annotation(Placement(transformation(extent={{78,20},{86,28}})));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[1] annotation(Placement(transformation(extent={{78,0},{86,8}})));
equation
  connect(information.command.desiredControlMode,modeCalculation.desiredControlMode) annotation(Line(points={{100,0},{94,0},{94,14},{-48,14}},color={255,127,0}));
  connect(power.p12,unused12Rail.p) annotation(Line(points={{0,100},{0,94},{42,94},{42,82}},color={0,0,255}));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{54,82},{54,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,82}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{78,82},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p5,clockCurrent.p) annotation(Line(points={{0,100},{0,94},{-74,94},{-74,48}},color={0,0,255}));
  connect(clockCurrent.n,emiChoke.p) annotation(Line(points={{-54,48},{-44,48}},color={0,0,255}));
  connect(emiChoke.n,oscillatorLoad.p) annotation(Line(points={{-24,48},{-14,48}},color={0,0,255}));
  connect(modeCalculation.loadConductance,oscillatorLoad.G) annotation(Line(points={{-0.5,14},{8,14},{8,32},{-4,32},{-4,36}},color={0,0,127}));
  connect(oscillatorLoad.n,power.n5) annotation(Line(points={{6,48},{6,94},{0,94},{0,100}},color={0,0,255}));
  connect(clockCurrent.i,informationRealBridge[1].u) annotation(Line(points={{-64,38},{78,38},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.pdCurrent[5]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(modeCalculation.status,informationIntegerBridge[1].u) annotation(Line(points={{-0.5,8.5},{78,8.5},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[1].y,information.device.spaceTimeStatus) annotation(Line(points={{86,4},{94,4},{94,0},{100,0}},color={255,127,0}));
  connect(oscillatorLoad.heatPort,clockNode.port) annotation(Line(points={{-4,38},{3.5,38},{3.5,-24},{-10,-24}},color={191,0,0}));
  connect(clockNode.port,isolator.port_a) annotation(Line(points={{-10,-44},{-10,-34},{20,-34}},color={191,0,0}));
  connect(isolator.port_b,thermal) annotation(Line(points={{40,-34},{40,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(clockBody.frame_a,mechanical) annotation(Line(points={{-82,12},{-94,12},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={95,65,130},fillColor={240,234,247},fillPattern=FillPattern.Solid),Ellipse(extent={{-46,46},{46,-46}},lineColor={95,65,130},fillColor={205,190,225},fillPattern=FillPattern.Solid),Line(points={{0,0},{0,34}},color={95,65,130},thickness=2),Line(points={{0,0},{26,-18}},color={95,65,130},thickness=2),Text(extent={{-92,-74},{92,-52}},textString="SPACETIME / PD5 / A6")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Text(extent={{-90,75},{90,60}},textString="时钟负载-EMI电感-隔热安装")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>表示稳定工作的时钟/时间基准载荷及其EMI与隔热安装特性</p><p><b>建模层级：</b>Components层设备级白箱；主要由Modelica 4.0.0标准库元件和图形连线组成</p><h4>实现与接口</h4><p><b>白箱实现：</b>由时钟电流传感、EMI电感、振荡器负载、热容、ThermalResistor和刚体构成</p><p><b>关键内部元件：</b>unused12Rail（Conductor）、unused33Rail（Conductor）、clockCurrent（CurrentSensor）、emiChoke（Resistor，任务级串联损耗等效）、oscillatorLoad（Resistor）、status（IntegerConstant）、clockNode（HeatCapacitor）、isolator（ThermalResistor）、clockBody（Body）</p><p><b>对外接口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、information（InformationPort）</p><h4>工作行为与状态</h4><p><b>运行行为：</b>设备持续工作，振荡器负载产生热并通过隔热安装路径与结构交换</p><p><b>关键参数：</b>振荡器负载、EMI电感、隔热热阻和时钟节点热容</p><p><b>关键状态：</b>电感电流、时钟节点温度和设备状态</p><p><b>物理域：</b>电、热、机械、信息</p><h4>信息与遥测关系</h4><p><b>数据路径：</b>设备状态在统一信息总线中保留；六类主工程包未展开专用载荷字段</p><p><b>使用说明：</b>设备测量与机器反馈均写入同一个InformationPort.device语义域；不存在平行的传感器遥测接口。应从N-System画布下钻本组件，并结合总体公共电/热/机械网络解释结果。</p><p><b>系统级等效：</b>本设备原毫法级去耦电容和/或毫亨级EMI电感仅描述板级快速瞬态；24 h任务模型将其分别等效为直流开路去耦和0.05 ohm串联损耗，保留设备稳态电流、功率、热量、开关状态和全部遥测语义，不再要求IDA解析微秒至毫秒电气状态。</p></html>"));
end SpaceTimePayloadUnit;
