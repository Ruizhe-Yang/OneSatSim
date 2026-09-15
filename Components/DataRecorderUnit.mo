within OneSatSim.Components;
model DataRecorderUnit "星上数据记录器组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.RecorderComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance nandLoadResistance=config.NANDLoadResistance
    "存储器等效负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity memoryHeatCapacity=config.MemoryHeatCapacity
    "存储器等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance cardGuideConductance=config.CardGuideConductance
    "记录器安装导热；Excel单位W/K，当前设计基线";
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
  parameter Real capacity(unit="1")=config.CapacityBytes
    "任务级参数: operational payload storage capacity in byte (128 GB decimal)";
  parameter Real initialStoredBytes(unit="1")=0 "场景初始存储量，byte";
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}}),iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Basic.Conductor unused12Rail(G=0) annotation(Placement(transformation(extent={{42,76},{54,88}})));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0) annotation(Placement(transformation(extent={{66,76},{78,88}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor storageCurrent annotation(Placement(transformation(extent={{-72,38},{-52,58}})));
  Modelica.Electrical.Analog.Basic.Resistor nandLoad(R=nandLoadResistance,useHeatPort=true) "系统级 nominal 5 V storage load" annotation(Placement(transformation(extent={{-38,38},{-18,58}})));
  Modelica.Electrical.Analog.Basic.Conductor writeBuffer(G=0) annotation(Placement(transformation(origin={10,20},extent={{-8,-8},{8,8}},rotation=270)));
  Modelica.Blocks.Continuous.LimIntegrator storedBytes(k=1,y_start=initialStoredBytes,outMin=0,outMax=capacity,strict=true) annotation(Placement(transformation(extent={{44,42},{64,62}})));
  Foundation.Interfaces.RealSignalReader dataRateInput[3] annotation(Placement(transformation(extent={{-8,66},{8,78}})));
  Foundation.Calculations.DataRecorderCalculation recorderCalculation(capacity=capacity) annotation(Placement(transformation(extent={{10,42},{34,66}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor memoryNode(C=memoryHeatCapacity,T(start=295.15,fixed=false)) annotation(Placement(transformation(extent={{-20,-45},{0,-25}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor cardGuide(G=cardGuideConductance) annotation(Placement(transformation(extent={{20,-43},{40,-27}})));
  Modelica.Mechanics.MultiBody.Parts.Body recorderBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-82,2},{-62,22}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[4] annotation(Placement(transformation(extent={{78,20},{86,28}})));
  Foundation.Interfaces.BooleanSignalBridge informationBooleanBridge[3] annotation(Placement(transformation(extent={{78,-20},{86,-12}})));
equation
  connect(information.payload.earthCameraWriteRate,dataRateInput[1].u) annotation(Line(points={{100,0},{94,0},{94,72},{-8,72}},color={0,90,180}));
  connect(information.payload.selfieCameraWriteRate,dataRateInput[2].u) annotation(Line(points={{100,0},{94,0},{94,72},{-8,72}},color={0,90,180}));
  connect(information.payload.downlinkReadRate,dataRateInput[3].u) annotation(Line(points={{100,0},{94,0},{94,72},{-8,72}},color={0,90,180}));
  connect(dataRateInput[1].y,recorderCalculation.earthCameraWriteRate) annotation(Line(points={{8,72},{9,72},{9,61.8},{10,61.8}},color={0,0,127}));
  connect(dataRateInput[2].y,recorderCalculation.selfieCameraWriteRate) annotation(Line(points={{8,72},{9,72},{9,57.6},{10,57.6}},color={0,0,127}));
  connect(dataRateInput[3].y,recorderCalculation.downlinkReadRate) annotation(Line(points={{8,72},{9,72},{9,52.8},{10,52.8}},color={0,0,127}));
  connect(storedBytes.y,recorderCalculation.storedBytes) annotation(Line(points={{65,52},{44,52},{44,40},{8,40},{8,48},{10,48}},color={0,0,127}));
  connect(power.p12,unused12Rail.p) annotation(Line(points={{0,100},{0,94},{42,94},{42,82}},color={0,0,255}));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{54,82},{54,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,82}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{78,82},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p5,storageCurrent.p) annotation(Line(points={{0,100},{0,94},{-72,94},{-72,48}},color={0,0,255}));
  connect(storageCurrent.n,nandLoad.p) annotation(Line(points={{-52,48},{-38,48}},color={0,0,255}));
  connect(nandLoad.n,power.n5) annotation(Line(points={{-18,48},{-18,94},{0,94},{0,100}},color={0,0,255}));
  connect(writeBuffer.p,power.p5) annotation(Line(points={{10,28},{10,94},{0,94},{0,100}},color={0,0,255}));
  connect(writeBuffer.n,power.n5) annotation(Line(points={{10,12},{10,94},{0,94},{0,100}},color={0,0,255}));
  connect(storageCurrent.i,informationRealBridge[1].u) annotation(Line(points={{-62,38},{78,38},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.pdCurrent[1]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(recorderCalculation.netRate,storedBytes.u) annotation(Line(points={{32.8,62.4},{36,62.4},{36,36},{18,36},{18,52},{42,52}},color={0,0,127}));
  connect(storedBytes.y,informationRealBridge[2].u) annotation(Line(points={{65,52},{78,52},{78,24}},color={0,90,180}));
  connect(informationRealBridge[2].y,information.payload.storedBytes) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,90,180}));
  connect(recorderCalculation.capacityBytes,informationRealBridge[3].u) annotation(Line(points={{32.8,59.4},{32.8,24},{78,24}},color={0,90,180}));
  connect(informationRealBridge[3].y,information.payload.capacityBytes) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,90,180}));
  connect(recorderCalculation.remainingBytes,informationRealBridge[4].u) annotation(Line(points={{32.8,56.4},{32.8,24},{78,24}},color={0,90,180}));
  connect(informationRealBridge[4].y,information.payload.remainingBytes) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,90,180}));
  connect(recorderCalculation.dataAvailable,informationBooleanBridge[1].u) annotation(Line(points={{32.8,53.4},{32.8,-16},{78,-16}},color={255,0,255}));
  connect(informationBooleanBridge[1].y,information.payload.dataAvailable) annotation(Line(points={{86,-16},{94,-16},{94,0},{100,0}},color={255,0,255}));
  connect(recorderCalculation.storageHigh,informationBooleanBridge[2].u) annotation(Line(points={{32.8,50.4},{32.8,-16},{78,-16}},color={255,0,255}));
  connect(informationBooleanBridge[2].y,information.payload.storageHigh) annotation(Line(points={{86,-16},{94,-16},{94,0},{100,0}},color={255,0,255}));
  connect(recorderCalculation.storageFull,informationBooleanBridge[3].u) annotation(Line(points={{32.8,47.4},{32.8,-16},{78,-16}},color={255,0,255}));
  connect(informationBooleanBridge[3].y,information.payload.storageFull) annotation(Line(points={{86,-16},{94,-16},{94,0},{100,0}},color={255,0,255}));
  connect(nandLoad.heatPort,memoryNode.port) annotation(Line(points={{-28,38},{-28,-25},{-10,-25}},color={191,0,0}));
  connect(memoryNode.port,cardGuide.port_a) annotation(Line(points={{-10,-45},{-10,-35},{20,-35}},color={191,0,0}));
  connect(cardGuide.port_b,thermal) annotation(Line(points={{40,-35},{40,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(recorderBody.frame_a,mechanical) annotation(Line(points={{-82,12},{-94,12},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={45,80,130},fillColor={230,238,250},fillPattern=FillPattern.Solid),Ellipse(extent={{-55,48},{55,12}},fillColor={120,160,210},fillPattern=FillPattern.Solid),Rectangle(extent={{-55,30},{55,-40}},fillColor={190,210,235},fillPattern=FillPattern.Solid),Ellipse(extent={{-55,-22},{55,-58}},fillColor={120,160,210},fillPattern=FillPattern.Solid),Text(extent={{-92,-74},{92,-52}},textString="FRAM0/1 + STORAGE / PD1")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Text(extent={{-90,72},{90,60}},textString="成像写入-下传读出-存储积分")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>对成像写入和数传读出之间的净数据率进行容量积分，并刻画存储板电热机械负载</p><p><b>建模层级：</b>Components层设备级白箱；主要由Modelica 4.0.0标准库元件和图形连线组成</p><h4>实现与接口</h4><p><b>白箱实现：</b>由积分器、数据记录器计算黑箱、5 V阻性负载、缓冲电容、存储热节点和板卡刚体构成</p><p><b>关键内部元件：</b>unused12Rail（Conductor）、unused33Rail（Conductor）、storageCurrent（CurrentSensor）、nandLoad（Resistor）、writeBuffer（Conductor，任务级去耦开路等效）、storedBytes（Integrator）、recorderCalculation（DataRecorderCalculation）、memoryNode（HeatCapacitor）、cardGuide（ThermalConductor）、recorderBody（Body）</p><p><b>对外接口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、information（InformationPort）</p><h4>工作行为与状态</h4><p><b>运行行为：</b>storedBytes按两路相机写入率减数传读出率连续积分；存储板功耗转化为热并经卡锁导热至公共热网</p><p><b>关键参数：</b>存储负载电阻、写缓冲电容、热容、卡锁导热和积分初值</p><p><b>关键状态：</b>storedBytes、缓冲电容电压、存储节点温度</p><p><b>物理域：</b>电、热、机械、信息、业务数据</p><h4>信息与遥测关系</h4><p><b>数据路径：</b>存储量属于PayloadDataPort诊断量；设备用电与温度可在上游设备状态层定位，不单独占用六类主遥测包字段</p><p><b>使用说明：</b>设备测量与机器反馈均写入同一个InformationPort.device语义域；不存在平行的传感器遥测接口。应从N-System画布下钻本组件，并结合总体公共电/热/机械网络解释结果。</p><p><b>系统级等效：</b>本设备原毫法级去耦电容和/或毫亨级EMI电感仅描述板级快速瞬态；24 h任务模型将其分别等效为直流开路去耦和0.05 ohm串联损耗，保留设备稳态电流、功率、热量、开关状态和全部遥测语义，不再要求IDA解析微秒至毫秒电气状态。</p></html>"));
end DataRecorderUnit;
