within OneSatSim.Components;
model StarTrackerZUnit "Z向星敏感器组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.StarZComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance loadResistance=config.LoadResistance
    "starZ等效负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity heatCapacity=config.HeatCapacity
    "starZ等效热容；Excel单位J/K，当前设计基线";
  parameter Real thermalResistance(unit="K/W")=config.ThermalResistance
    "starZ安装热阻；Excel单位K/W，当前设计基线";
  parameter Modelica.Units.SI.Resistance emiResistance=config.EMIResistance
    "Z星敏EMI等效串联电阻；Excel单位Ω，当前设计基线";
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
  Modelica.Electrical.Analog.Basic.Conductor unused12Rail(G=0)  "计算/接口量 unused12Rail" annotation(Placement(visible=true, transformation(origin={-290,320}, extent={{-20,-20},{20,20}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0)  "计算/接口量 unused33Rail" annotation(Placement(visible=true, transformation(origin={-200,320}, extent={{-20,-20},{20,20}}, rotation=0)));
  Foundation.Interfaces.ThermalPort thermal  "热学" annotation(Placement(visible=true, transformation(origin={300,-148}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,-97}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(visible=true, transformation(origin={-360,20}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-12,-12},{12,12}}, rotation=0)));
  Foundation.Interfaces.InformationPort information  "计算/接口量 information" annotation(Placement(visible=true, transformation(origin={360,30}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor supplyCurrent  "供给电流" annotation(Placement(visible=true, transformation(origin={-240,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.VariableConductor detectorLoad(useHeatPort=true) "系统级 task-gated star tracker Z load" annotation(Placement(visible=true, transformation(origin={-125,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor emiFilter(R=emiResistance)  "emi滤波" annotation(Placement(visible=true, transformation(origin={-10,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngles starAngles  "计算/接口量 starAngles" annotation(Placement(visible=true, transformation(origin={-225,90}, extent={{-36,-36},{36,36}}, rotation=0)));
  Foundation.Calculations.StarQuaternionCalculation quaternionCalculation  "沿用原旋转序列的星敏四元数计算实例" annotation(Placement(transformation(origin={-110,80}, extent={{-22,-22},{22,22}})));
  Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngularVelocity starAngularRate(
    resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a) 
     "starAngular速率" annotation(Placement(visible=true, transformation(origin={-225,-30}, extent={{-36,-36},{36,36}}, rotation=0)));
  Foundation.Calculations.StarTrackerCalculation trackerCalculation(activeResistance=loadResistance) 
     "星敏任务门控与测量计算实例" annotation(Placement(visible=true, transformation(origin={-15,55}, extent={{-68,-68},{68,68}}, rotation=0)));
  Modelica.Blocks.Sources.IntegerConstant packetType(k=3)  "计算/接口量 packetType" annotation(Placement(visible=true, transformation(origin={70,-110}, extent={{-22,-22},{22,22}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor focalPlane(C=heatCapacity,T(start=288.15,fixed=false))  "计算/接口量 focalPlane" annotation(Placement(visible=true, transformation(origin={15,-120}, extent={{-28,-28},{28,28}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor isolator(R=thermalResistance)  "计算/接口量 isolator" annotation(Placement(visible=true, transformation(origin={165,-148}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.Body trackerBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ)  "tracker本体" annotation(Placement(visible=true, transformation(origin={-230,-180}, extent={{-30,-30},{30,30}}, rotation=0)));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[8]  "实数因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={240,70}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[2]  "整数因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={235,-75}, extent={{-16,-16},{16,16}}, rotation=0)));
equation
  connect(information.command.desiredControlMode,trackerCalculation.desiredControlMode) annotation(Line(points={{360,30},{360,129.6},{-85.52,129.6},{-85.52,109.4},{-75.52,109.4}}, color={0,102,255}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(starAngles.angles,quaternionCalculation.angles) annotation(Line(points={{-189,90},{-132,90},{-132,80}},color={0,0,127},thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,starAngles.frame_a) annotation(Line(points={{-360,20},{-360,90},{-261,90}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,starAngularRate.frame_a) annotation(Line(points={{-360,20},{-360,-30},{-261,-30}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));

  connect(quaternionCalculation.quaternion[4],trackerCalculation.quaternion[1]) annotation(Line(points={{-88,80},{-75,80}},color={0,0,127},thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(quaternionCalculation.quaternion[1],trackerCalculation.quaternion[2]) annotation(Line(points={{-88,80},{-75,80}},color={0,0,127},thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(quaternionCalculation.quaternion[2],trackerCalculation.quaternion[3]) annotation(Line(points={{-88,80},{-75,80}},color={0,0,127},thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(quaternionCalculation.quaternion[3],trackerCalculation.quaternion[4]) annotation(Line(points={{-88,80},{-75,80}},color={0,0,127},thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(starAngularRate.w,trackerCalculation.bodyRate) annotation(Line(points={{-185.4,-30},{-85.52,-30},{-85.52,0.6},{-75.52,0.6}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p12,unused12Rail.p) annotation(Line(points={{-360,230},{-360,320},{-310,320}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{-270,320},{-260,320},{-260,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{-360,230},{-360,264},{-230,264},{-230,320},{-220,320}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{-180,320},{-170,320},{-170,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p5,supplyCurrent.p) annotation(Line(points={{-360,230},{-264,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(supplyCurrent.n,detectorLoad.p) annotation(Line(points={{-216,230},{-149,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(trackerCalculation.loadConductance,detectorLoad.G) annotation(Line(points={{45.52,82.2},{55.52,82.2},{55.52,268.8},{-125,268.8},{-125,258.8}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(supplyCurrent.i,informationRealBridge[1].u) annotation(Line(points={{-240,203.6},{-240,193.6},{48.6,193.6},{48.6,70},{225.76,70}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[1].y,information.device.tcCurrent[13]) annotation(Line(points={{254.24,70},{360,70},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(detectorLoad.n,emiFilter.p) annotation(Line(points={{-101,230},{-34,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(emiFilter.n,power.n5) annotation(Line(points={{14,230},{24,230},{24,197},{-360,197},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(trackerCalculation.measuredQuaternion[1],informationRealBridge[2].u) annotation(Line(points={{45.52,55},{194.4,55},{194.4,70},{225.76,70}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[2].y,information.device.starQuaternion[2,1]) annotation(Line(points={{254.24,70},{360,70},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(trackerCalculation.measuredQuaternion[2],informationRealBridge[3].u) annotation(Line(points={{45.52,55},{194.4,55},{194.4,70},{225.76,70}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[3].y,information.device.starQuaternion[2,2]) annotation(Line(points={{254.24,70},{360,70},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(trackerCalculation.measuredQuaternion[3],informationRealBridge[4].u) annotation(Line(points={{45.52,55},{194.4,55},{194.4,70},{225.76,70}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[4].y,information.device.starQuaternion[2,3]) annotation(Line(points={{254.24,70},{360,70},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(trackerCalculation.measuredQuaternion[4],informationRealBridge[5].u) annotation(Line(points={{45.52,55},{194.4,55},{194.4,70},{225.76,70}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[5].y,information.device.starQuaternion[2,4]) annotation(Line(points={{254.24,70},{360,70},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(trackerCalculation.measuredBodyRate[1],informationRealBridge[6].u) annotation(Line(points={{45.52,27.8},{194.4,27.8},{194.4,70},{225.76,70}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[6].y,information.device.starAngularVelocity[2,1]) annotation(Line(points={{254.24,70},{360,70},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(trackerCalculation.measuredBodyRate[2],informationRealBridge[7].u) annotation(Line(points={{45.52,27.8},{194.4,27.8},{194.4,70},{225.76,70}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[7].y,information.device.starAngularVelocity[2,2]) annotation(Line(points={{254.24,70},{360,70},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(trackerCalculation.measuredBodyRate[3],informationRealBridge[8].u) annotation(Line(points={{45.52,27.8},{194.4,27.8},{194.4,70},{225.76,70}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[8].y,information.device.starAngularVelocity[2,3]) annotation(Line(points={{254.24,70},{360,70},{360,30}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(trackerCalculation.status,informationIntegerBridge[1].u) annotation(Line(points={{45.52,0.6},{187.62,0.6},{187.62,-75},{220.76,-75}}, color={255,127,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationIntegerBridge[1].y,information.device.starStatus[2]) annotation(Line(points={{249.24,-75},{360,-75},{360,30}}, color={255,127,0}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(packetType.y,informationIntegerBridge[2].u) annotation(Line(points={{70,-110},{70,-75},{220.76,-75}}, color={255,127,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationIntegerBridge[2].y,information.device.starPacketType[2]) annotation(Line(points={{249.24,-75},{360,-75},{360,30}}, color={255,127,0}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(detectorLoad.heatPort,focalPlane.port) annotation(Line(points={{-125,206},{-125,196},{48.6,196},{48.6,-158},{15,-158},{15,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(focalPlane.port,isolator.port_a) annotation(Line(points={{15,-148},{15,-158},{131,-158},{131,-148},{141,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(isolator.port_b,thermal) annotation(Line(points={{189,-148},{300,-148}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(trackerBody.frame_a,mechanical) annotation(Line(points={{-260,-180},{-360,-180},{-360,20}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>Z向星敏感器组件</h2><p><b>类路径：</b><code>OneSatSim.Components.StarTrackerZUnit</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>Z向星敏感器组件</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.N_systems.GNCSystem\">OneSatSim.Systems.N_systems.GNCSystem</a> 的 <code>starZ</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>power</code></td><td>Foundation.Interfaces.PowerPort</td><td>public</td><td>按声明/类型合同</td><td>功率</td></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr><tr><td><code>information</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr><tr><td><code>informationRealBridge[8]</code></td><td>Foundation.Interfaces.RealSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>实数因果输出到可扩展信息总线的无状态恒等桥实例</td></tr><tr><td><code>informationIntegerBridge[2]</code></td><td>Foundation.Interfaces.IntegerSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>整数因果输出到可扩展信息总线的无状态恒等桥实例</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>config</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.StarZComponentConfig</td><td>由所属N-System传入的硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>loadResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>starZ等效负载电阻；Excel单位Ω，当前设计基线</td><td><code>=config.LoadResistance</code></td></tr><tr><td><code>heatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>starZ等效热容；Excel单位J/K，当前设计基线</td><td><code>=config.HeatCapacity</code></td></tr><tr><td><code>thermalResistance</code></td><td>Real</td><td>starZ安装热阻；Excel单位K/W，当前设计基线</td><td><code>=config.ThermalResistance</code></td></tr><tr><td><code>emiResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>Z星敏EMI等效串联电阻；Excel单位Ω，当前设计基线</td><td><code>=config.EMIResistance</code></td></tr><tr><td><code>mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel单位kg，当前设计基线</td><td><code>=config.Mass</code></td></tr><tr><td><code>rcm_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel单位m，当前设计基线</td><td><code>=config.RCM_X</code></td></tr><tr><td><code>rcm_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel单位m，当前设计基线</td><td><code>=config.RCM_Y</code></td></tr><tr><td><code>rcm_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel单位m，当前设计基线</td><td><code>=config.RCM_Z</code></td></tr><tr><td><code>inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_XX</code></td></tr><tr><td><code>inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_YY</code></td></tr><tr><td><code>inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_ZZ</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>unused12Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused12Rail</td></tr><tr><td><code>unused33Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused33Rail</td></tr><tr><td><code>supplyCurrent</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Sensors.CurrentSensor\">Modelica.Electrical.Analog.Sensors.CurrentSensor</a></td><td>供给电流</td></tr><tr><td><code>detectorLoad</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.VariableConductor\">Modelica.Electrical.Analog.Basic.VariableConductor</a></td><td>系统级 task-gated star tracker Z load</td></tr><tr><td><code>emiFilter</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Resistor\">Modelica.Electrical.Analog.Basic.Resistor</a></td><td>emi滤波</td></tr><tr><td><code>starAngles</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngles\">Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngles</a></td><td>计算/接口量 starAngles</td></tr><tr><td><code>quaternionCalculation</code></td><td><a href=\"modelica://OneSatSim.Foundation.Calculations.StarQuaternionCalculation\">OneSatSim.Foundation.Calculations.StarQuaternionCalculation</a></td><td>沿用原旋转序列的星敏四元数计算实例</td></tr><tr><td><code>starAngularRate</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngularVelocity\">Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngularVelocity</a></td><td>starAngular速率</td></tr><tr><td><code>trackerCalculation</code></td><td><a href=\"modelica://OneSatSim.Foundation.Calculations.StarTrackerCalculation\">OneSatSim.Foundation.Calculations.StarTrackerCalculation</a></td><td>星敏任务门控与测量计算实例</td></tr><tr><td><code>packetType</code></td><td><a href=\"modelica://Modelica.Blocks.Sources.IntegerConstant\">Modelica.Blocks.Sources.IntegerConstant</a></td><td>计算/接口量 packetType</td></tr><tr><td><code>focalPlane</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a></td><td>计算/接口量 focalPlane</td></tr><tr><td><code>isolator</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalResistor\">Modelica.Thermal.HeatTransfer.Components.ThermalResistor</a></td><td>计算/接口量 isolator</td></tr><tr><td><code>trackerBody</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">Modelica.Mechanics.MultiBody.Parts.Body</a></td><td>tracker本体</td></tr></table></html>"
),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Optical sensor", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-48,-25},{-10,19}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Polygon(points={{-10,19},{18,31},{18,-34},{-10,-25},{-10,19}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Ellipse(extent={{5,-34},{31,31}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.75, startAngle=0, endAngle=360),
      Ellipse(extent={{11,-25},{25,22}}, lineColor={0,0,0}, fillColor={223,237,247}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{15,-14},{21,12}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Rectangle(extent={{-43,-31},{-16,-26}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, radius=0),
      Line(points={{31,27},{59,48}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Line(points={{31,-29},{69,-44}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Polygon(points={{55,35},{56.5,30.5},{61,29},{56.5,27.5},{55,23},{53.5,27.5},{49,29},{53.5,30.5},{55,35}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Polygon(points={{62,-7},{63.25,-10.75},{67,-12},{63.25,-13.25},{62,-17},{60.75,-13.25},{57,-12},{60.75,-10.75},{62,-7}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Polygon(points={{45,11},{46,8},{49,7},{46,6},{45,3},{44,6},{41,7},{44,8},{45,11}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Polygon(points={{-20,48},{-19,45},{-16,44},{-19,43},{-20,40},{-21,43},{-24,44},{-21,45},{-20,48}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5),
      Line(points={{-40,-11},{-17,-11}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-40,0},{-17,0}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Text(extent={{-67,19},{-47,40}}, textString="Z", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Z Star Tracker", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-404,-248},{404,462}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-205,169},{38.6,187}}, textString="Functional core and telemetry", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-330,374},{-229.2,392}}, textString="Power supply", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-325,-106},{-157,-88}}, textString="Thermal and mounting", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-392,417},{392,446}}, textString="Z star tracker: sensing and measurement model", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-392,409},{392,409}}, color={215,220,226}, thickness=0.25)
    }));
end StarTrackerZUnit;