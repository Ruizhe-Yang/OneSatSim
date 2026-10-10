within OneSatSim.Components;
model MEMSIMUUnit "MEMS惯性测量组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.MemsIMUComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance loadResistance=config.LoadResistance
    "memsIMU等效负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity heatCapacity=config.HeatCapacity
    "memsIMU等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountConductance=config.MountConductance
    "memsIMU安装导热；Excel单位W/K，当前设计基线";
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
  Modelica.Electrical.Analog.Basic.Conductor unused5Rail(G=0)  "计算/接口量 unused5Rail" annotation(Placement(visible=true, transformation(origin={-200,320}, extent={{-20,-20},{20,20}}, rotation=0)));
  Foundation.Interfaces.ThermalPort thermal  "热学" annotation(Placement(visible=true, transformation(origin={320,-238}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,-97}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(visible=true, transformation(origin={-410,-25}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-12,-12},{12,12}}, rotation=0)));
  Foundation.Interfaces.EnvironmentPort environment  "外部环境接口或实例" annotation(Placement(visible=true, transformation(origin={-410,130}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-12,-12},{12,12}}, rotation=0)));
  Foundation.Interfaces.InformationPort information  "计算/接口量 information" annotation(Placement(visible=true, transformation(origin={370,20}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngularVelocity gyro(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a)  "计算/接口量 gyro" annotation(Placement(visible=true, transformation(origin={-300,95}, extent={{-36,-36},{36,36}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation sensingPoint(r={rcm_X,rcm_Y,rcm_Z})
    "计算/接口量 sensingPoint；Effective sensing point at the configured package center of mass" 
    annotation(Placement(visible=true, transformation(origin={-300,-25}, extent={{-30,-30},{30,30}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Sensors.AbsoluteSensor specificForceSensor(
    get_a=true,resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a,
    animation=false)
    "specificForce传感器；Ideal body-frame specific force in the local NoGravity free-fall mechanics" 
    annotation(Placement(visible=true, transformation(origin={-170,-35}, extent={{-38,-38},{38,38}}, rotation=0)));
  Foundation.Interfaces.RealSignalReader positionInput[3]  "可扩展总线实数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-165,110}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Calculations.OrbitalAccelerationCalculation accelerationCalculation  "轨道中心引力加速度计算实例" annotation(Placement(visible=true, transformation(origin={25,55}, extent={{-22,-22},{22,22}}, rotation=0)));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor  "电流传感器" annotation(Placement(visible=true, transformation(origin={-240,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor sensorLoad(R=loadResistance,useHeatPort=true) "系统级 share of 3.3 V bus load" annotation(Placement(visible=true, transformation(origin={-125,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor packageNode(C=heatCapacity,T(start=294.15,fixed=false))  "计算/接口量 packageNode" annotation(Placement(visible=true, transformation(origin={-20,-210}, extent={{-28,-28},{28,28}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor pcbPath(G=mountConductance)  "计算/接口量 pcbPath" annotation(Placement(visible=true, transformation(origin={140,-238}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.Body imuBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ)  "imu本体" annotation(Placement(visible=true, transformation(origin={-300,-180}, extent={{-30,-30},{30,30}}, rotation=0)));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[7]  "实数因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={250,50}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.RealSignalBridge gravityDiagnosticBridge[3] 
     "实数因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={245,-90}, extent={{-16,-16},{16,16}}, rotation=0)));
equation
  connect(environment.position,positionInput.u) annotation(Line(points={{-410,130},{-410,141},{-212.38,141},{-212.38,110},{-179.24,110}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(positionInput.y,accelerationCalculation.position) annotation(Line(points={{-150.76,110},{-43.74,110},{-43.74,55},{-33.74,55}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p12,unused12Rail.p) annotation(Line(points={{-360,230},{-360,320},{-310,320}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{-270,320},{-260,320},{-260,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p5,unused5Rail.p) annotation(Line(points={{-360,230},{-360,264},{-230,264},{-230,320},{-220,320}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused5Rail.n,power.n5) annotation(Line(points={{-180,320},{-170,320},{-170,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,gyro.frame_a) annotation(Line(points={{-410,-25},{-410,95},{-336,95}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,sensingPoint.frame_a) annotation(Line(points={{-410,-25},{-330,-25}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(sensingPoint.frame_b,specificForceSensor.frame_a) annotation(Line(points={{-270,-25},{-218,-25},{-218,-35},{-208,-35}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,imuBody.frame_a) annotation(Line(points={{-410,-25},{-410,-180},{-330,-180}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(gyro.w[1],informationRealBridge[1].u) annotation(Line(points={{-260.4,95},{-250.4,95},{-250.4,159},{202.62,159},{202.62,50},{235.76,50}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[1].y,information.device.mems[1]) annotation(Line(points={{264.24,50},{370,50},{370,20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(gyro.w[2],informationRealBridge[2].u) annotation(Line(points={{-260.4,95},{-250.4,95},{-250.4,159},{202.62,159},{202.62,50},{235.76,50}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[2].y,information.device.mems[2]) annotation(Line(points={{264.24,50},{370,50},{370,20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(gyro.w[3],informationRealBridge[3].u) annotation(Line(points={{-260.4,95},{-250.4,95},{-250.4,159},{202.62,159},{202.62,50},{235.76,50}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[3].y,information.device.mems[3]) annotation(Line(points={{264.24,50},{370,50},{370,20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(specificForceSensor.a[1],informationRealBridge[4].u) annotation(Line(points={{-177.6,-76.8},{-177.6,-86.8},{199.4,-86.8},{199.4,50},{235.76,50}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[4].y,information.device.mems[4]) annotation(Line(points={{264.24,50},{370,50},{370,20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(specificForceSensor.a[2],informationRealBridge[5].u) annotation(Line(points={{-177.6,-76.8},{-177.6,-86.8},{199.4,-86.8},{199.4,50},{235.76,50}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[5].y,information.device.mems[5]) annotation(Line(points={{264.24,50},{370,50},{370,20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(specificForceSensor.a[3],informationRealBridge[6].u) annotation(Line(points={{-177.6,-76.8},{-177.6,-86.8},{199.4,-86.8},{199.4,50},{235.76,50}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[6].y,information.device.mems[6]) annotation(Line(points={{264.24,50},{370,50},{370,20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(accelerationCalculation.acceleration,gravityDiagnosticBridge.u) annotation(Line(points={{83.74,55},{199.4,55},{199.4,-90},{230.76,-90}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(gravityDiagnosticBridge.y,information.device.orbitalAccelerationGCRS) annotation(Line(points={{259.24,-90},{370,-90},{370,20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p33,currentSensor.p) annotation(Line(points={{-360,230},{-264,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(currentSensor.n,sensorLoad.p) annotation(Line(points={{-216,230},{-149,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(sensorLoad.n,power.n33) annotation(Line(points={{-101,230},{-91,230},{-91,197},{-360,197},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(currentSensor.i,informationRealBridge[7].u) annotation(Line(points={{-240,203.6},{-240,193.6},{202.62,193.6},{202.62,50},{235.76,50}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationRealBridge[7].y,information.device.pdCurrent[20]) annotation(Line(points={{264.24,50},{370,50},{370,20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(sensorLoad.heatPort,packageNode.port) annotation(Line(points={{-125,206},{-125,196},{-122,196},{-122,-248},{-20,-248},{-20,-238}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(packageNode.port,pcbPath.port_a) annotation(Line(points={{-20,-238},{-20,-248},{106,-248},{106,-238},{116,-238}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(pcbPath.port_b,thermal) annotation(Line(points={{164,-238},{320,-238}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>MEMS惯性测量组件</h2><p><b>类路径：</b><code>OneSatSim.Components.MEMSIMUUnit</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>MEMS惯性测量组件</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.N_systems.GNCSystem\">OneSatSim.Systems.N_systems.GNCSystem</a> 的 <code>mems</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>power</code></td><td>Foundation.Interfaces.PowerPort</td><td>public</td><td>按声明/类型合同</td><td>功率</td></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr><tr><td><code>environment</code></td><td>Foundation.Interfaces.EnvironmentPort</td><td>public</td><td>按声明/类型合同</td><td>外部环境接口或实例</td></tr><tr><td><code>information</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr><tr><td><code>positionInput[3]</code></td><td>Foundation.Interfaces.RealSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线实数信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>informationRealBridge[7]</code></td><td>Foundation.Interfaces.RealSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>实数因果输出到可扩展信息总线的无状态恒等桥实例</td></tr><tr><td><code>gravityDiagnosticBridge[3]</code></td><td>Foundation.Interfaces.RealSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>实数因果输出到可扩展信息总线的无状态恒等桥实例</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>config</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.MemsIMUComponentConfig</td><td>由所属N-System传入的硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>loadResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>memsIMU等效负载电阻；Excel单位Ω，当前设计基线</td><td><code>=config.LoadResistance</code></td></tr><tr><td><code>heatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>memsIMU等效热容；Excel单位J/K，当前设计基线</td><td><code>=config.HeatCapacity</code></td></tr><tr><td><code>mountConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>memsIMU安装导热；Excel单位W/K，当前设计基线</td><td><code>=config.MountConductance</code></td></tr><tr><td><code>mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel单位kg，当前设计基线</td><td><code>=config.Mass</code></td></tr><tr><td><code>rcm_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel单位m，当前设计基线</td><td><code>=config.RCM_X</code></td></tr><tr><td><code>rcm_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel单位m，当前设计基线</td><td><code>=config.RCM_Y</code></td></tr><tr><td><code>rcm_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel单位m，当前设计基线</td><td><code>=config.RCM_Z</code></td></tr><tr><td><code>inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_XX</code></td></tr><tr><td><code>inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_YY</code></td></tr><tr><td><code>inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_ZZ</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>unused12Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused12Rail</td></tr><tr><td><code>unused5Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused5Rail</td></tr><tr><td><code>gyro</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngularVelocity\">Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngularVelocity</a></td><td>计算/接口量 gyro</td></tr><tr><td><code>sensingPoint</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.FixedTranslation\">Modelica.Mechanics.MultiBody.Parts.FixedTranslation</a></td><td>计算/接口量 sensingPoint；Effective sensing point at the configured package center of mass</td></tr><tr><td><code>specificForceSensor</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Sensors.AbsoluteSensor\">Modelica.Mechanics.MultiBody.Sensors.AbsoluteSensor</a></td><td>specificForce传感器；Ideal body-frame specific force in the local NoGravity free-fall mechanics</td></tr><tr><td><code>accelerationCalculation</code></td><td><a href=\"modelica://OneSatSim.Foundation.Calculations.OrbitalAccelerationCalculation\">OneSatSim.Foundation.Calculations.OrbitalAccelerationCalculation</a></td><td>轨道中心引力加速度计算实例</td></tr><tr><td><code>currentSensor</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Sensors.CurrentSensor\">Modelica.Electrical.Analog.Sensors.CurrentSensor</a></td><td>电流传感器</td></tr><tr><td><code>sensorLoad</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Resistor\">Modelica.Electrical.Analog.Basic.Resistor</a></td><td>系统级 share of 3.3 V bus load</td></tr><tr><td><code>packageNode</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a></td><td>计算/接口量 packageNode</td></tr><tr><td><code>pcbPath</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">Modelica.Thermal.HeatTransfer.Components.ThermalConductor</a></td><td>计算/接口量 pcbPath</td></tr><tr><td><code>imuBody</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">Modelica.Mechanics.MultiBody.Parts.Body</a></td><td>imu本体</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Inertial sensor", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-39,-29},{29,29}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=3),
      Ellipse(extent={{-30,-23},{20,23}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{-30,-8},{20,8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{-13,-23},{3,23}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.6, startAngle=0, endAngle=360),
      Line(points={{-35,-21},{25,21}}, color={76,128,143}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-5,-34},{-5,35}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Ellipse(extent={{-10,-5},{0,5}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-31,39},{-7,48},{17,44},{31,33}}, color={76,128,143}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Ellipse(extent={{-35.6,-25.6},{-32.4,-22.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-34.8,-24},{-33.2,-24}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{22.4,-25.6},{25.6,-22.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{23.2,-24},{24.8,-24}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-35.6,22.4},{-32.4,25.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-34.8,24},{-33.2,24}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{22.4,22.4},{25.6,25.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{23.2,24},{24.8,24}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{41,-22},{66,18}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Rectangle(extent={{49,-6},{58,3}}, lineColor={0,0,0}, fillColor={225,235,242}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{53,3},{47,7},{59,11},{53,15}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{53,-6},{47,-11},{59,-16},{53,-20}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{30,0},{41,0}}, color={113,122,132}, thickness=0.55, pattern=LinePattern.Solid),
      Text(extent={{-34,-52},{38,-37}}, textString="6-DOF", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="MEMS IMU", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-454,-300},{414,462}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-115,169},{128.6,187}}, textString="Functional core and telemetry", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-330,374},{-229.2,392}}, textString="Power supply", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-385,-106},{-217,-88}}, textString="Thermal and mounting", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-442,417},{402,446}}, textString="MEMS IMU: motion sensing and orbit correction", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-442,409},{402,409}}, color={215,220,226}, thickness=0.25)
    }));
end MEMSIMUUnit;