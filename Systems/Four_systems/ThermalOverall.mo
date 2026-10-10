within OneSatSim.Systems.Four_systems;
model ThermalOverall "热学总体"
  parameter OneSatSim.Scenarios.DesignConfigRecords.OverallComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter OneSatSim.Foundation.Types.SurfaceGeometry surfaceGeometry
    "surface几何；Effective structure and panel coverage; passed by SpacecraftSystem";
  parameter Modelica.Units.SI.HeatCapacity busDeckHeatCapacity=config.BusDeckHeatCapacity
    "内部设备舱板热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity externalShellHeatCapacity=config.ExternalShellHeatCapacity
    "外表面热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance shellToBusConductance=config.ShellToBusConductance
    "外壳-舱板导热；Excel单位W/K，当前设计基线";
  parameter Modelica.Units.SI.Temperature initialBusDeckTemperature=304.31 "场景内部设备舱板初温";
  parameter Modelica.Units.SI.Temperature initialExternalShellTemperature=276.27 "场景外表面等效热节点初温";
  parameter Real bodySolarAbsorptivity(min=0,max=1)=config.BodySolarAbsorptivity "外表面对太阳与反照辐射的吸收率" ;
  parameter Real bodyInfraredAbsorptivity(min=0,max=1)=config.BodyInfraredAbsorptivity "外表面对地球红外的吸收率" ;
  parameter Real externalEmissivity(min=0,max=1)=config.ExternalEmissivity "配置项 externalEmissivity" ;
  final parameter Modelica.Units.SI.Area radiatingArea=surfaceGeometry.radiatingBareArea
    "配置项 radiatingArea [m2]；Structure dimensions minus all three actual panel coverage areas";
  Foundation.Interfaces.ThermalPort subsystem[8]  "计算/接口量 subsystem" annotation(Placement(transformation(origin={-195,-185},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={7.5,100.48},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Foundation.Interfaces.EnvironmentPort environment  "外部环境接口或实例" annotation(Placement(transformation(origin={-365,100},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={-100,-87.5},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor busDeck(
    C=busDeckHeatCapacity,T(start=initialBusDeckTemperature,fixed=true))
    "内部设备安装舱板热节点" annotation(Placement(visible=true, transformation(origin={-95,-105}, extent={{-45,-45},{45,45}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor externalShell(
    C=externalShellHeatCapacity,T(start=initialExternalShellTemperature,fixed=false))
    "直接接收太阳、反照和地球红外的外壳热节点" annotation(Placement(visible=true, transformation(origin={170,-10}, extent={{-45,-45},{45,45}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor shellToBus(G=shellToBusConductance)
    "外壳至设备舱板的有限安装导热" annotation(Placement(visible=true, transformation(origin={50,-100}, extent={{-28,-28},{28,28}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.BodyRadiation bodyRadiation(
    Gr=externalEmissivity*radiatingArea)
    "裸露外壳对深空Stefan-Boltzmann辐射路径" annotation(Placement(visible=true, transformation(origin={290,-55}, extent={{-28,-28},{28,28}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature deepSpace(T=3) 
     "计算/接口量 deepSpace" annotation(Placement(visible=true, transformation(origin={390,-55}, extent={{-28,-28},{28,28}}, rotation=180)));
  Foundation.Calculations.ExternalOrbitalHeatCalculation externalHeatCalculation(
    surfaceGeometry=surfaceGeometry,
    bodySolarAbsorptivity=bodySolarAbsorptivity,
    bodyInfraredAbsorptivity=bodyInfraredAbsorptivity)
    "太阳、反照与地球红外热流计算" annotation(Placement(visible=true, transformation(origin={-70,100}, extent={{-90,-90},{90,90}}, rotation=0)));
  Foundation.Interfaces.RealSignalReader sunVectorReader[3] 
     "可扩展总线实数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-260,260}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.RealSignalReader earthVectorReader[3] 
     "可扩展总线实数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-260,180}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.RealSignalReader solarFluxReader 
     "可扩展总线实数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-260,100}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.RealSignalReader albedoFluxReader 
     "可扩展总线实数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-260,20}, extent={{-16,-16},{16,16}}, rotation=0)));
  Foundation.Interfaces.RealSignalReader earthInfraredFluxReader 
     "可扩展总线实数信号到因果计算端口的无状态恒等读取器实例" annotation(Placement(visible=true, transformation(origin={-260,-60}, extent={{-16,-16},{16,16}}, rotation=0)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow externalHeat
    "external热流；Single external orbital heat-flow source; no added thermal state" annotation(Placement(visible=true, transformation(origin={100,100}, extent={{-25,-25},{25,25}}, rotation=0)));
equation
  connect(subsystem[1],subsystem[2]) annotation(Line(points={{-195,-185}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1],subsystem[3]) annotation(Line(points={{-195,-185}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1],subsystem[4]) annotation(Line(points={{-195,-185}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1],subsystem[5]) annotation(Line(points={{-195,-185}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1],subsystem[6]) annotation(Line(points={{-195,-185}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1],subsystem[7]) annotation(Line(points={{-195,-185}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1],subsystem[8]) annotation(Line(points={{-195,-185}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(subsystem[1],busDeck.port) annotation(Line(points={{-195,-185},{-95,-185},{-95,-150}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(busDeck.port,shellToBus.port_a) annotation(Line(points={{-95,-150},{-95,-160},{12,-160},{12,-100},{22,-100}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(shellToBus.port_b,externalShell.port) annotation(Line(points={{78,-100},{170,-100},{170,-55}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(externalShell.port,bodyRadiation.port_a) annotation(Line(points={{170,-55},{170,-65},{252,-65},{252,-55},{262,-55}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(bodyRadiation.port_b,deepSpace.port) annotation(Line(points={{318,-55},{362,-55}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(environment.sunVectorBody,sunVectorReader.u) annotation(Line(points={{-365,100},{-365,260},{-274.24,260}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(sunVectorReader.y,externalHeatCalculation.sunVectorBody) annotation(Line(points={{-245.76,260},{-227.75,260},{-227.75,172},{-150.1,172}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(environment.earthVectorBody,earthVectorReader.u) annotation(Line(points={{-365,100},{-365,180},{-274.24,180}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(earthVectorReader.y,externalHeatCalculation.earthVectorBody) annotation(Line(points={{-245.76,180},{-160.1,180},{-160.1,136},{-150.1,136}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(environment.solarFlux,solarFluxReader.u) annotation(Line(points={{-365,100},{-274.24,100}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(solarFluxReader.y,externalHeatCalculation.solarFlux) annotation(Line(points={{-245.76,100},{-150.1,100}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(environment.albedoFlux,albedoFluxReader.u) annotation(Line(points={{-365,100},{-365,20},{-274.24,20}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(albedoFluxReader.y,externalHeatCalculation.albedoFlux) annotation(Line(points={{-245.76,20},{-160.1,20},{-160.1,64},{-150.1,64}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(environment.earthInfraredFlux,earthInfraredFluxReader.u) annotation(Line(points={{-365,100},{-365,-60},{-274.24,-60}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(earthInfraredFluxReader.y,externalHeatCalculation.earthInfraredFlux) annotation(Line(points={{-245.76,-60},{-227.75,-60},{-227.75,28},{-150.1,28}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(externalHeatCalculation.externalHeatFlow,externalHeat.Q_flow) annotation(Line(points={{10.1,100},{75,100}}, color={0,0,127}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(externalHeat.port,externalShell.port) annotation(Line(points={{125,100},{225,100},{225,-65},{170,-65},{170,-55}}, color={191,0,0}, thickness=0.25, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>热学总体</h2><p><b>类路径：</b><code>OneSatSim.Systems.Four_systems.ThermalOverall</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>热学总体</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.SpacecraftSystem\">OneSatSim.Systems.SpacecraftSystem</a> 的 <code>thermalOverall</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>subsystem[8]</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 subsystem</td></tr><tr><td><code>environment</code></td><td>Foundation.Interfaces.EnvironmentPort</td><td>public</td><td>按声明/类型合同</td><td>外部环境接口或实例</td></tr><tr><td><code>sunVectorReader[3]</code></td><td>Foundation.Interfaces.RealSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线实数信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>earthVectorReader[3]</code></td><td>Foundation.Interfaces.RealSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线实数信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>solarFluxReader</code></td><td>Foundation.Interfaces.RealSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线实数信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>albedoFluxReader</code></td><td>Foundation.Interfaces.RealSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线实数信号到因果计算端口的无状态恒等读取器实例</td></tr><tr><td><code>earthInfraredFluxReader</code></td><td>Foundation.Interfaces.RealSignalReader</td><td>public</td><td>按声明/类型合同</td><td>可扩展总线实数信号到因果计算端口的无状态恒等读取器实例</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>config</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.OverallComponentConfig</td><td>由所属N-System传入的硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>surfaceGeometry</code></td><td>OneSatSim.Foundation.Types.SurfaceGeometry</td><td>surface几何；Effective structure and panel coverage; passed by SpacecraftSystem</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>busDeckHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>内部设备舱板热容；Excel单位J/K，当前设计基线</td><td><code>=config.BusDeckHeatCapacity</code></td></tr><tr><td><code>externalShellHeatCapacity</code></td><td>Modelica.Units.SI.HeatCapacity</td><td>外表面热容；Excel单位J/K，当前设计基线</td><td><code>=config.ExternalShellHeatCapacity</code></td></tr><tr><td><code>shellToBusConductance</code></td><td>Modelica.Units.SI.ThermalConductance</td><td>外壳-舱板导热；Excel单位W/K，当前设计基线</td><td><code>=config.ShellToBusConductance</code></td></tr><tr><td><code>initialBusDeckTemperature</code></td><td>Modelica.Units.SI.Temperature</td><td>场景内部设备舱板初温</td><td><code>=304.31</code></td></tr><tr><td><code>initialExternalShellTemperature</code></td><td>Modelica.Units.SI.Temperature</td><td>场景外表面等效热节点初温</td><td><code>=276.27</code></td></tr><tr><td><code>bodySolarAbsorptivity</code></td><td>Real</td><td>外表面对太阳与反照辐射的吸收率</td><td><code>=config.BodySolarAbsorptivity</code></td></tr><tr><td><code>bodyInfraredAbsorptivity</code></td><td>Real</td><td>外表面对地球红外的吸收率</td><td><code>=config.BodyInfraredAbsorptivity</code></td></tr><tr><td><code>externalEmissivity</code></td><td>Real</td><td>配置项 externalEmissivity</td><td><code>=config.ExternalEmissivity</code></td></tr><tr><td><code>radiatingArea</code></td><td>Modelica.Units.SI.Area</td><td>配置项 radiatingArea [m2]；Structure dimensions minus all three actual panel coverage areas</td><td><code>=surfaceGeometry.radiatingBareArea</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>busDeck</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a></td><td>内部设备安装舱板热节点</td></tr><tr><td><code>externalShell</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.HeatCapacitor\">Modelica.Thermal.HeatTransfer.Components.HeatCapacitor</a></td><td>直接接收太阳、反照和地球红外的外壳热节点</td></tr><tr><td><code>shellToBus</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalConductor\">Modelica.Thermal.HeatTransfer.Components.ThermalConductor</a></td><td>外壳至设备舱板的有限安装导热</td></tr><tr><td><code>bodyRadiation</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.BodyRadiation\">Modelica.Thermal.HeatTransfer.Components.BodyRadiation</a></td><td>裸露外壳对深空Stefan-Boltzmann辐射路径</td></tr><tr><td><code>deepSpace</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Sources.FixedTemperature\">Modelica.Thermal.HeatTransfer.Sources.FixedTemperature</a></td><td>计算/接口量 deepSpace</td></tr><tr><td><code>externalHeatCalculation</code></td><td><a href=\"modelica://OneSatSim.Foundation.Calculations.ExternalOrbitalHeatCalculation\">OneSatSim.Foundation.Calculations.ExternalOrbitalHeatCalculation</a></td><td>太阳、反照与地球红外热流计算</td></tr><tr><td><code>externalHeat</code></td><td><a href=\"modelica://Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow\">Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow</a></td><td>external热流；Single external orbital heat-flow source; no added thermal state</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={196,94,56}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Domain assembly", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-16.68,-30.48},{31.6,18.48}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Line(points={{-11.24,-22.32},{-3.08,-22.32},{-3.08,10.32},{5.76,10.32},{5.76,-22.32},{14.6,-22.32},{14.6,10.32},{23.44,10.32},{23.44,-22.32},{29.56,-22.32}}, color={196,94,56}, thickness=1, pattern=LinePattern.Solid),
      Rectangle(extent={{37.72,-30.48},{52.68,18.48}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{38.4,-25.04},{51.32,-25.04}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{38.4,-16.88},{51.32,-16.88}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{38.4,-8.72},{51.32,-8.72}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{38.4,-0.56},{51.32,-0.56}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{38.4,7.6},{51.32,7.6}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{38.4,15.76},{51.32,15.76}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{54.72,-19.6},{59.48,-16.2},{63.56,-19.6},{67.64,-16.2}}, color={196,94,56}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{54.72,-2.6},{59.48,0.8},{63.56,-2.6},{67.64,0.8}}, color={196,94,56}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{54.72,14.4},{59.48,17.8},{63.56,14.4},{67.64,17.8}}, color={196,94,56}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{-24.84,-22.32},{-16.68,-22.32}}, color={77,126,172}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-24.84,10.32},{-16.68,10.32}}, color={77,126,172}, thickness=0.8, pattern=LinePattern.Solid),
      Ellipse(extent={{-48.6,35.2},{-34.6,49.2}}, lineColor={0,0,0}, fillColor={255,246,210}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Line(points={{-32.5,42.2},{-29,42.2}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-35.165328,48.634672},{-32.690455,51.109545}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-41.6,51.3},{-41.6,54.8}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-48.034672,48.634672},{-50.509545,51.109545}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-50.7,42.2},{-54.2,42.2}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-48.034672,35.765328},{-50.509545,33.290455}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-41.6,33.1},{-41.6,29.6}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-35.165328,35.765328},{-32.690455,33.290455}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Thermal Network", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-409,-229},{456,402}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-340,314},{-172,332}}, textString="Environment sampling", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-175,239},{-23.8,257}}, textString="Orbital heat input", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-170,-27},{65.2,-9}}, textString="Thermal storage and exchange", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-397,357},{444,386}}, textString="Thermal Network", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-397,349},{444,349}}, color={215,220,226}, thickness=0.25)
    }));
end ThermalOverall;