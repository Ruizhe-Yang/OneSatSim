within OneSatSim.Components;
model FotonAmurPayloadUnit "科学载荷组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.FotonAmurComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance electronicsResistance=config.ElectronicsResistance
    "FotonAmur电子学负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.Resistance emiResistance=config.EMIResistance
    "FotonAmur EMI等效串联电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity heatCapacity=config.HeatCapacity
    "FotonAmur热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountConductance=config.MountConductance
    "FotonAmur安装导热；Excel单位W/K，当前设计基线";
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
  parameter Boolean fotonAmurMissionEnabled=config.MissionEnabled
    "任务级参数: dedicated Foton-Amur campaign is disabled in the nominal Earth-observation scenario";
  Foundation.Interfaces.PowerPort power  "功率" annotation(Placement(visible=true, transformation(origin={-360,230}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,95}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Conductor unused5Rail(G=0)  "计算/接口量 unused5Rail" annotation(Placement(visible=true, transformation(origin={-200,320}, extent={{-20,-20},{20,20}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0)  "计算/接口量 unused33Rail" annotation(Placement(visible=true, transformation(origin={-290,320}, extent={{-20,-20},{20,20}}, rotation=0)));
  Foundation.Interfaces.ThermalPort thermal  "热学" annotation(Placement(visible=true, transformation(origin={300,-148}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={0,-97}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(visible=true, transformation(origin={-360,-160}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.InformationPort information  "计算/接口量 information" annotation(Placement(visible=true, transformation(origin={360,30}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
  Foundation.Interfaces.BooleanSignalReader missionOn  "可扩展总线布尔信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-155,65}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Calculations.FotonAmurCalculation missionCalculation(missionEnabled=fotonAmurMissionEnabled) 
     "科学载荷任务门控计算实例" annotation(Placement(visible=true, transformation(origin={15,55}, extent={{-22,-22},{22,22}}, rotation=0)));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch instrumentEnable  "计算/接口量 instrumentEnable" annotation(Placement(visible=true, transformation(origin={-240,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor sensorElectronics(R=electronicsResistance,useHeatPort=true)  "传感器Electronics" annotation(Placement(visible=true, transformation(origin={-125,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Electrical.Analog.Basic.Resistor emiChoke(R=emiResistance)  "计算/接口量 emiChoke" annotation(Placement(visible=true, transformation(origin={-10,230}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor sensorHead(C=heatCapacity,T(start=292.15,fixed=false))  "传感器Head" annotation(Placement(visible=true, transformation(origin={15,-120}, extent={{-28,-28},{28,28}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor deckPath(G=mountConductance)  "计算/接口量 deckPath" annotation(Placement(visible=true, transformation(origin={165,-148}, extent={{-24,-24},{24,24}}, rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.Body payloadBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ)  "payload本体" annotation(Placement(visible=true, transformation(origin={-260,-160}, extent={{-30,-30},{30,30}}, rotation=0)));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[1]  "整数因果输出到可扩展信息总线的无状态恒等桥实例" annotation(Placement(visible=true, transformation(origin={235,55}, extent={{-16,-16},{16,16}}, rotation=0)));
equation
  connect(information.command.missionOn,missionOn.u) annotation(Line(points={{360,30},{360,-19.02},{-202.38,-19.02},{-202.38,65},{-169.24,65}}, color={255,0,255}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(missionOn.y,missionCalculation.missionOn) annotation(Line(points={{-140.76,65},{-53.74,65},{-53.74,55},{-4.58,55}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p5,unused5Rail.p) annotation(Line(points={{-360,230},{-360,264},{-230,264},{-230,320},{-220,320}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused5Rail.n,power.n5) annotation(Line(points={{-180,320},{-170,320},{-170,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{-360,230},{-360,320},{-310,320}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{-270,320},{-260,320},{-260,264},{-360,264},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(missionCalculation.active,instrumentEnable.control) annotation(Line(points={{34.58,72.6},{83.74,72.6},{83.74,264},{-240,264},{-240,268.8},{-240,258.8}}, color={255,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power.p12,instrumentEnable.p) annotation(Line(points={{-360,230},{-264,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(instrumentEnable.n,sensorElectronics.p) annotation(Line(points={{-216,230},{-149,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(sensorElectronics.n,emiChoke.p) annotation(Line(points={{-101,230},{-34,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(emiChoke.n,power.n12) annotation(Line(points={{14,230},{24,230},{24,197},{-360,197},{-360,230}}, color={0,0,255}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(missionCalculation.status,informationIntegerBridge[1].u) annotation(Line(points={{34.58,37.4},{83.74,37.4},{83.74,55},{220.76,55}}, color={255,127,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(informationIntegerBridge[1].y,information.device.fotonAmurStatus) annotation(Line(points={{249.24,55},{360,55},{360,30}}, color={255,127,0}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(sensorElectronics.heatPort,sensorHead.port) annotation(Line(points={{-125,206},{-125,196},{83.74,196},{83.74,-158},{15,-158},{15,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(sensorHead.port,deckPath.port_a) annotation(Line(points={{15,-148},{15,-158},{131,-158},{131,-148},{141,-148}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(deckPath.port_b,thermal) annotation(Line(points={{189,-148},{300,-148}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(payloadBody.frame_a,mechanical) annotation(Line(points={{-290,-160},{-360,-160}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>科学载荷组件</h2><p><b>类路径：</b><code>OneSatSim.Components.FotonAmurPayloadUnit</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>科学载荷组件</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.N_systems.PayloadSystem\">OneSatSim.Systems.N_systems.PayloadSystem</a> 的 <code>fotonAmur</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>power</code></td><td>Foundation.Interfaces.PowerPort</td><td>public</td><td>按声明/类型合同</td><td>功率</td></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr><tr><td><code>information</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr><tr><td><code>missionOn</code></td><td>Foundation.Interfaces.BooleanSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线布尔信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>informationIntegerBridge[1]</code></td><td>Foundation.Interfaces.IntegerSignalBridge</td><td>public</td><td>按声明/类型合同</td><td>整数因果输出到可扩展信息总线的无状态恒等桥实例</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>config</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.FotonAmurComponentConfig</td><td>由所属N-System传入的硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>electronicsResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>FotonAmur电子学负载电阻；Excel单位Ω，当前设计基线</td><td><code>=config.ElectronicsResistance</code></td></tr><tr><td><code>emiResistance</code></td><td>Modelica.Units.SI.Resistance</td><td>FotonAmur EMI等效串联电阻；Excel单位Ω，当前设计基线</td><td><code>=config.EMIResistance</code></td></tr><tr><td><code>heatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>FotonAmur热容；Excel单位J/K，当前设计基线</td><td><code>=config.HeatCapacity</code></td></tr><tr><td><code>mountConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>FotonAmur安装导热；Excel单位W/K，当前设计基线</td><td><code>=config.MountConductance</code></td></tr><tr><td><code>mass</code></td><td>Modelica.Units.SI.Mass</td><td>质量；Excel单位kg，当前设计基线</td><td><code>=config.Mass</code></td></tr><tr><td><code>rcm_X</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置X；Excel单位m，当前设计基线</td><td><code>=config.RCM_X</code></td></tr><tr><td><code>rcm_Y</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Y；Excel单位m，当前设计基线</td><td><code>=config.RCM_Y</code></td></tr><tr><td><code>rcm_Z</code></td><td>Modelica.Units.SI.Length</td><td>质心偏置Z；Excel单位m，当前设计基线</td><td><code>=config.RCM_Z</code></td></tr><tr><td><code>inertia_XX</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Ixx；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_XX</code></td></tr><tr><td><code>inertia_YY</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Iyy；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_YY</code></td></tr><tr><td><code>inertia_ZZ</code></td><td>Modelica.Units.SI.Inertia</td><td>局部惯量 Izz；Excel单位kg·m²，当前设计基线</td><td><code>=config.Inertia_ZZ</code></td></tr><tr><td><code>fotonAmurMissionEnabled</code></td><td>Boolean</td><td>任务级参数: dedicated Foton-Amur campaign is disabled in the nominal Earth-observation scenario</td><td><code>=config.MissionEnabled</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>unused5Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused5Rail</td></tr><tr><td><code>unused33Rail</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Conductor\">Modelica.Electrical.Analog.Basic.Conductor</a></td><td>计算/接口量 unused33Rail</td></tr><tr><td><code>missionCalculation</code></td><td><a href=\"modelica://OneSatSim.Foundation.Calculations.FotonAmurCalculation\">OneSatSim.Foundation.Calculations.FotonAmurCalculation</a></td><td>科学载荷任务门控计算实例</td></tr><tr><td><code>instrumentEnable</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Ideal.IdealClosingSwitch\">Modelica.Electrical.Analog.Ideal.IdealClosingSwitch</a></td><td>计算/接口量 instrumentEnable</td></tr><tr><td><code>sensorElectronics</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Resistor\">Modelica.Electrical.Analog.Basic.Resistor</a></td><td>传感器Electronics</td></tr><tr><td><code>emiChoke</code></td><td><a href=\"modelica://Modelica.Electrical.Analog.Basic.Resistor\">Modelica.Electrical.Analog.Basic.Resistor</a></td><td>计算/接口量 emiChoke</td></tr><tr><td><code>sensorHead</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a></td><td>传感器Head</td></tr><tr><td><code>deckPath</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">Modelica.Thermal.HeatTransfer.Components.ThermalConductor</a></td><td>计算/接口量 deckPath</td></tr><tr><td><code>payloadBody</code></td><td><a href=\"modelica://Modelica.Mechanics.MultiBody.Parts.Body\">Modelica.Mechanics.MultiBody.Parts.Body</a></td><td>payload本体</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={152,118,71}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Science payload", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-36,-29},{36,29}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Rectangle(extent={{-24,-16},{24,18}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Polygon(points={{-23,18},{-13,31},{13,31},{23,18},{-23,18}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.6),
      Ellipse(extent={{-10,-8},{10,12}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Line(points={{-48,0},{-36,0}}, color={77,126,172}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{36,0},{55,0},{55,19},{70,19}}, color={83,131,109}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Ellipse(extent={{-31.7,-24.7},{-28.3,-21.3}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-30.85,-23},{-29.15,-23}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{28.3,-24.7},{31.7,-21.3}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{29.15,-23},{30.85,-23}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-31.7,21.3},{-28.3,24.7}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-30.85,23},{-29.15,23}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{28.3,21.3},{31.7,24.7}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{29.15,23},{30.85,23}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-59,42},{-42,42},{-42,49},{-25,49},{-25,42},{-9,42}}, color={152,118,71}, thickness=0.75, pattern=LinePattern.Solid),
      Text(extent={{-44,-51},{44,-34}}, textString="SCIENCE", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Foton-Amur Payload", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-404,-228},{404,462}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-295,169},{-51.4,187}}, textString="Functional core and telemetry", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-330,374},{-229.2,392}}, textString="Power supply", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-325,-106},{-157,-88}}, textString="Thermal and mounting", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-392,417},{392,446}}, textString="Foton-Amur: activation and instrument load", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-392,409},{392,409}}, color={215,220,226}, thickness=0.25)
    }));
end FotonAmurPayloadUnit;