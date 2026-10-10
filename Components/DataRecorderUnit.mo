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
  Foundation.Interfaces.PowerPort power  "功率" annotation(Placement(visible=true, transformation(origin={-360,230}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,95}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Conductor unused12Rail(G=0)  "计算/接口量 unused12Rail" annotation(Placement(visible=true, transformation(origin={-290,320}, extent={{-20,-20},{20,20}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0)  "计算/接口量 unused33Rail" annotation(Placement(visible=true, transformation(origin={-200,320}, extent={{-20,-20},{20,20}}, rotation=0)));
  Foundation.Interfaces.ThermalPort thermal  "热学" annotation(Placement(visible=true, transformation(origin={320,-293}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,-97}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(visible=true, transformation(origin={-370,-245}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.InformationPort information  "计算/接口量 information" annotation(Placement(visible=true, transformation(origin={370,20}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor storageCurrent  "storage电流" annotation(Placement(visible=true, transformation(origin={-240,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor nandLoad(R=nandLoadResistance,useHeatPort=true) "系统级 nominal 5 V storage load" annotation(Placement(visible=true, transformation(origin={-125,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Conductor writeBuffer(G=0)  "计算/接口量 writeBuffer" annotation(Placement(visible=true, transformation(origin={40,320}, extent={{-22,-22},{22,22}}, rotation=0)));
  Modelica.Blocks.Continuous.LimIntegrator storedBytes(k=1,y_start=initialStoredBytes,outMin=0,outMax=capacity,strict=true)  "有效存储量" annotation(Placement(visible=true, transformation(origin={30,-130}, extent={{-42,-42},{42,42}}, rotation=0)));
  Foundation.Interfaces.RealSignalReader dataRateInput[3]  "可扩展总线实数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-190,65}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.IntegerSignalReader imagingRequestIdInput 
     "可扩展总线整数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-190,-65}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Calculations.DataRecorderCalculation recorderCalculation(capacity=capacity)  "星上数据记录器业务量计算实例" annotation(Placement(visible=true, transformation(origin={-10,55}, extent={{-70,-70},{70,70}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor memoryNode(C=memoryHeatCapacity,T(start=295.15,fixed=false))  "计算/接口量 memoryNode" annotation(Placement(visible=true, transformation(origin={-110,-265}, extent={{-28,-28},{28,28}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor cardGuide(G=cardGuideConductance)  "计算/接口量 cardGuide" annotation(Placement(visible=true, transformation(origin={55,-293}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.Body recorderBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ)  "recorder本体" annotation(Placement(visible=true, transformation(origin={-280,-245}, extent={{-30,-30},{30,30}}, rotation=0)));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[11]  "实数因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={245,90}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[1] 
     "整数因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={245,-35}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.BooleanSignalBridge informationBooleanBridge[3]  "布尔因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={245,-165}, extent={{-16,-16},{16,16}}, rotation=0)));
equation
  connect(information.payload.earthCameraWriteRate,dataRateInput[1].u) annotation(Line(points={{370,20},{370,135},{-237.38,135},{-237.38,65},{-204.24,65}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information.payload.selfieCameraWriteRate,dataRateInput[2].u) annotation(Line(points={{370,20},{370,135},{-237.38,135},{-237.38,65},{-204.24,65}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information.payload.downlinkReadRate,dataRateInput[3].u) annotation(Line(points={{370,20},{370,135},{-237.38,135},{-237.38,65},{-204.24,65}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information.command.imagingRequestId,imagingRequestIdInput.u) annotation(Line(points={{370,20},{370,135},{-237.38,135},{-237.38,-65},{-204.24,-65}}, color={255,127,0}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(dataRateInput[1].y,recorderCalculation.earthCameraWriteRate) annotation(Line(points={{-175.76,65},{-82.3,65},{-82.3,111},{-72.3,111}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(dataRateInput[2].y,recorderCalculation.selfieCameraWriteRate) annotation(Line(points={{-175.76,65},{-82.3,65},{-82.3,83},{-72.3,83}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(dataRateInput[3].y,recorderCalculation.downlinkReadRate) annotation(Line(points={{-175.76,65},{-82.3,65},{-82.3,55},{-72.3,55}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(storedBytes.y,recorderCalculation.storedBytes) annotation(Line(points={{76.2,-130},{86.2,-130},{86.2,-78},{-82.3,-78},{-82.3,27},{-72.3,27}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(imagingRequestIdInput.y,recorderCalculation.imagingRequestId) annotation(Line(points={{-175.76,-65},{-82.3,-65},{-82.3,-1},{-72.3,-1}}, color={255,127,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p12,unused12Rail.p) annotation(Line(points={{-360,230},{-360,320},{-310,320}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{-270,320},{-260,320},{-260,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{-360,230},{-360,264},{-230,264},{-230,320},{-220,320}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{-180,320},{-170,320},{-170,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p5,storageCurrent.p) annotation(Line(points={{-360,230},{-264,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(storageCurrent.n,nandLoad.p) annotation(Line(points={{-216,230},{-149,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(nandLoad.n,power.n5) annotation(Line(points={{-101,230},{-91,230},{-91,196},{-360,196},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(writeBuffer.p,power.p5) annotation(Line(points={{18,320},{8,320},{8,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(writeBuffer.n,power.n5) annotation(Line(points={{62,320},{72,320},{72,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(storageCurrent.i,informationRealBridge[1].u) annotation(Line(points={{-240,203.6},{-240,193.6},{197.62,193.6},{197.62,90},{230.76,90}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[1].y,information.device.pdCurrent[1]) annotation(Line(points={{259.24,90},{370,90},{370,20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(recorderCalculation.netRate,storedBytes.u) annotation(Line(points={{52.3,111},{62.3,111},{62.3,-78},{-30.4,-78},{-30.4,-130},{-20.4,-130}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(storedBytes.y,informationRealBridge[2].u) annotation(Line(points={{76.2,-130},{197.62,-130},{197.62,90},{230.76,90}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[2].y,information.payload.storedBytes) annotation(Line(points={{259.24,90},{370,90},{370,20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(recorderCalculation.capacityBytes,informationRealBridge[3].u) annotation(Line(points={{52.3,102.38462},{197.62,102.38462},{197.62,90},{230.76,90}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[3].y,information.payload.capacityBytes) annotation(Line(points={{259.24,90},{370,90},{370,20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(recorderCalculation.remainingBytes,informationRealBridge[4].u) annotation(Line(points={{52.3,93.76923},{197.62,93.76923},{197.62,90},{230.76,90}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[4].y,information.payload.remainingBytes) annotation(Line(points={{259.24,90},{370,90},{370,20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(recorderCalculation.acceptedEarthCameraWriteRate,informationRealBridge[5].u) annotation(Line(points={{52.3,50.6923},{197.62,50.6923},{197.62,90},{230.76,90}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[5].y,information.payload.acceptedEarthCameraWriteRate) annotation(Line(points={{259.24,90},{370,90},{370,20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(recorderCalculation.rejectedEarthCameraWriteRate,informationRealBridge[6].u) annotation(Line(points={{52.3,42.07692},{197.62,42.07692},{197.62,90},{230.76,90}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[6].y,information.payload.rejectedEarthCameraWriteRate) annotation(Line(points={{259.24,90},{370,90},{370,20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(recorderCalculation.acceptedSelfieWriteRate,informationRealBridge[7].u) annotation(Line(points={{52.3,33.46154},{197.62,33.46154},{197.62,90},{230.76,90}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[7].y,information.payload.acceptedSelfieWriteRate) annotation(Line(points={{259.24,90},{370,90},{370,20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(recorderCalculation.rejectedSelfieWriteRate,informationRealBridge[8].u) annotation(Line(points={{52.3,24.84616},{197.62,24.84616},{197.62,90},{230.76,90}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[8].y,information.payload.rejectedSelfieWriteRate) annotation(Line(points={{259.24,90},{370,90},{370,20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(recorderCalculation.actualDownlinkReadRate,informationRealBridge[9].u) annotation(Line(points={{52.3,16.23077},{197.62,16.23077},{197.62,90},{230.76,90}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[9].y,information.payload.actualDownlinkReadRate) annotation(Line(points={{259.24,90},{370,90},{370,20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(recorderCalculation.requestedWriteRate,informationRealBridge[10].u) annotation(Line(points={{52.3,59.3077},{197.62,59.3077},{197.62,90},{230.76,90}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[10].y,information.payload.requestedWriteRate) annotation(Line(points={{259.24,90},{370,90},{370,20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(recorderCalculation.discardedBytesRate,informationRealBridge[11].u) annotation(Line(points={{52.3,7.61538},{197.62,7.61538},{197.62,90},{230.76,90}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[11].y,information.payload.discardedBytesRate) annotation(Line(points={{259.24,90},{370,90},{370,20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(recorderCalculation.acceptedImagingRequestId,informationIntegerBridge[1].u) annotation(Line(points={{52.3,-1},{197.62,-1},{197.62,-35},{230.76,-35}}, color={255,127,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationIntegerBridge[1].y,information.payload.acceptedImagingRequestId) annotation(Line(points={{259.24,-35},{370,-35},{370,20}}, color={255,127,0}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(recorderCalculation.dataAvailable,informationBooleanBridge[1].u) annotation(Line(points={{52.3,85.15384},{197.62,85.15384},{197.62,-165},{230.76,-165}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationBooleanBridge[1].y,information.payload.dataAvailable) annotation(Line(points={{259.24,-165},{370,-165},{370,20}}, color={255,0,255}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(recorderCalculation.storageHigh,informationBooleanBridge[2].u) annotation(Line(points={{52.3,76.53846},{197.62,76.53846},{197.62,-165},{230.76,-165}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationBooleanBridge[2].y,information.payload.storageHigh) annotation(Line(points={{259.24,-165},{370,-165},{370,20}}, color={255,0,255}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(recorderCalculation.storageFull,informationBooleanBridge[3].u) annotation(Line(points={{52.3,67.92308},{197.62,67.92308},{197.62,-165},{230.76,-165}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationBooleanBridge[3].y,information.payload.storageFull) annotation(Line(points={{259.24,-165},{370,-165},{370,20}}, color={255,0,255}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(nandLoad.heatPort,memoryNode.port) annotation(Line(points={{-125,206},{-125,196},{-335,196},{-335,-303},{-110,-303},{-110,-293}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(memoryNode.port,cardGuide.port_a) annotation(Line(points={{-110,-293},{-110,-303},{21,-303},{21,-293},{31,-293}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(cardGuide.port_b,thermal) annotation(Line(points={{79,-293},{320,-293}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(recorderBody.frame_a,mechanical) annotation(Line(points={{-310,-245},{-370,-245}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>星上数据记录器组件</h2><p><b>类路径：</b><code>OneSatSim.Components.DataRecorderUnit</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>星上数据记录器组件</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.N_systems.DataHandlingSystem\">OneSatSim.Systems.N_systems.DataHandlingSystem</a> 的 <code>recorder</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>power</code></td><td>Foundation.Interfaces.PowerPort</td><td>public</td><td>按声明/类型合同</td><td>功率</td></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr><tr><td><code>information</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr><tr><td><code>dataRateInput[3]</code></td><td>Foundation.Interfaces.RealSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线实数信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>imagingRequestIdInput</code></td><td>Foundation.Interfaces.IntegerSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线整数信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>informationRealBridge[11]</code></td><td>Foundation.Interfaces.RealSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>实数因果输出到可扩展信息总线的无状态恒等桥实例</td></tr><tr><td><code>informationIntegerBridge[1]</code></td><td>Foundation.Interfaces.IntegerSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>整数因果输出到可扩展信息总线的无状态恒等桥实例</td></tr><tr><td><code>informationBooleanBridge[3]</code></td><td>Foundation.Interfaces.BooleanSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>布尔因果输出到可扩展信息总线的无状态恒等桥实例</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>config</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.RecorderComponentConfig</td><td>由所属N-System传入的硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>nandLoadResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>存储器等效负载电阻；Excel单位Ω，当前设计基线</td><td><code>=config.NANDLoadResistance</code></td></tr><tr><td><code>memoryHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>存储器等效热容；Excel单位J/K，当前设计基线</td><td><code>=config.MemoryHeatCapacity</code></td></tr><tr><td><code>cardGuideConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>记录器安装导热；Excel单位W/K，当前设计基线</td><td><code>=config.CardGuideConductance</code></td></tr><tr><td><code>mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel单位kg，当前设计基线</td><td><code>=config.Mass</code></td></tr><tr><td><code>rcm_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel单位m，当前设计基线</td><td><code>=config.RCM_X</code></td></tr><tr><td><code>rcm_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel单位m，当前设计基线</td><td><code>=config.RCM_Y</code></td></tr><tr><td><code>rcm_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel单位m，当前设计基线</td><td><code>=config.RCM_Z</code></td></tr><tr><td><code>inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_XX</code></td></tr><tr><td><code>inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_YY</code></td></tr><tr><td><code>inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_ZZ</code></td></tr><tr><td><code>capacity</code></td><td>Real</td><td>任务级参数: operational payload storage capacity in byte (128 GB decimal)</td><td><code>=config.CapacityBytes</code></td></tr><tr><td><code>initialStoredBytes</code></td><td>Real</td><td>场景初始存储量，byte</td><td><code>=0</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>unused12Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused12Rail</td></tr><tr><td><code>unused33Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused33Rail</td></tr><tr><td><code>storageCurrent</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Sensors.CurrentSensor\">Modelica.Electrical.Analog.Sensors.CurrentSensor</a></td><td>storage电流</td></tr><tr><td><code>nandLoad</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Resistor\">Modelica.Electrical.Analog.Basic.Resistor</a></td><td>系统级 nominal 5 V storage load</td></tr><tr><td><code>writeBuffer</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 writeBuffer</td></tr><tr><td><code>storedBytes</code></td><td><a href=\"modelica://Modelica.Blocks.Continuous.LimIntegrator\">Modelica.Blocks.Continuous.LimIntegrator</a></td><td>有效存储量</td></tr><tr><td><code>recorderCalculation</code></td><td><a href=\"modelica://OneSatSim.Foundation.Calculations.DataRecorderCalculation\">OneSatSim.Foundation.Calculations.DataRecorderCalculation</a></td><td>星上数据记录器业务量计算实例</td></tr><tr><td><code>memoryNode</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a></td><td>计算/接口量 memoryNode</td></tr><tr><td><code>cardGuide</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">Modelica.Thermal.HeatTransfer.Components.ThermalConductor</a></td><td>计算/接口量 cardGuide</td></tr><tr><td><code>recorderBody</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">Modelica.Mechanics.MultiBody.Parts.Body</a></td><td>recorder本体</td></tr></table></html>"
),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={83,131,109}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Data hardware", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-51,-34},{40,37}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Rectangle(extent={{-39,-23},{-16,-2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{-43,-19},{-39,-19}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-19},{-12,-19}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-43,-13},{-39,-13}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-13},{-12,-13}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-43,-7},{-39,-7}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-7},{-12,-7}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Rectangle(extent={{-39,6},{-16,27}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{-43,10},{-39,10}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,10},{-12,10}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-43,16},{-39,16}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,16},{-12,16}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-43,22},{-39,22}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,22},{-12,22}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Rectangle(extent={{-5,-23},{18,-2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{-9,-19},{-5,-19}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{18,-19},{22,-19}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-9,-13},{-5,-13}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{18,-13},{22,-13}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-9,-7},{-5,-7}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{18,-7},{22,-7}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Rectangle(extent={{-5,6},{18,27}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{-9,10},{-5,10}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{18,10},{22,10}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-9,16},{-5,16}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{18,16},{22,16}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-9,22},{-5,22}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{18,22},{22,22}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-70,23},{-55,23}}, color={83,131,109}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{44,-11},{69,-11}}, color={83,131,109}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{48,17},{68,23}}, lineColor={0,0,0}, fillColor={227,240,232}, fillPattern=FillPattern.Solid, lineThickness=0.4, radius=0),
      Rectangle(extent={{48,27},{68,33}}, lineColor={0,0,0}, fillColor={227,240,232}, fillPattern=FillPattern.Solid, lineThickness=0.4, radius=0),
      Rectangle(extent={{48,37},{68,43}}, lineColor={0,0,0}, fillColor={227,240,232}, fillPattern=FillPattern.Solid, lineThickness=0.4, radius=0),
      Line(points={{-43,-43},{32,-43}}, color={113,122,132}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-43,-43},{8,-43}}, color={83,131,109}, thickness=2, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Data Recorder", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-414,-355},{414,462}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-295,145},{-51.4,163}}, textString="Functional core and telemetry", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-330,374},{-229.2,392}}, textString="Power supply", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-325,-154},{-157,-136}}, textString="Thermal and mounting", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-402,417},{402,446}}, textString="Data recorder: accepted data and storage state", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-402,409},{402,409}}, color={215,220,226}, thickness=0.25)
    }));
end DataRecorderUnit;