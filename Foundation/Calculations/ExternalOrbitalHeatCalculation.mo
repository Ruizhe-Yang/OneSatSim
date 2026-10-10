within OneSatSim.Foundation.Calculations;
model ExternalOrbitalHeatCalculation "整星外表面轨道热流计算"
  parameter OneSatSim.Foundation.Types.SurfaceGeometry surfaceGeometry "surface几何" ;
  parameter Real bodySolarAbsorptivity(min=0,max=1)=0.60 "外表面对太阳与反照辐射的吸收率";
  parameter Real bodyInfraredAbsorptivity(min=0,max=1)=0.80 "外表面对地球红外的吸收率";
  Modelica.Blocks.Interfaces.RealInput sunVectorBody[3]
    "太阳方向在本体系中的单位向量" annotation(Placement(visible=true, transformation(origin={-225,77}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput earthVectorBody[3]
    "地心方向在本体系中的单位向量" annotation(Placement(visible=true, transformation(origin={-225,45}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,40}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput solarFlux(unit="W/m2")
    "太阳辐照通量" annotation(Placement(visible=true, transformation(origin={-225,-13}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput albedoFlux(unit="W/m2")
    "地球反照通量" annotation(Placement(visible=true, transformation(origin={-225,-45}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-40}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput earthInfraredFlux(unit="W/m2")
    "地球红外通量" annotation(Placement(visible=true, transformation(origin={-225,-77}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput externalHeatFlow(unit="W")
    "外表面总吸收热流" annotation(Placement(visible=true, transformation(origin={225,0}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-5.76,-5.76},{5.76,5.76}}, rotation=0)));
  Modelica.Units.SI.Area bareProjectedAreaToSun "裸露本体对太阳的投影面积";
  Modelica.Units.SI.Area bareProjectedAreaToEarth "扣除太阳电池覆盖区后的裸露本体对地投影面积";
  Modelica.Units.SI.HeatFlowRate solarBodyHeatFlow "裸露本体吸收的太阳热流";
  Modelica.Units.SI.HeatFlowRate albedoHeatFlow "吸收的地球反照热流";
  Modelica.Units.SI.HeatFlowRate earthIRHeatFlow "吸收的地球红外热流";
equation
  bareProjectedAreaToSun=noEvent(
    surfaceGeometry.barePlusXArea*max(0,sunVectorBody[1])+
    surfaceGeometry.bareMinusXArea*max(0,-sunVectorBody[1])+
    surfaceGeometry.barePlusYArea*max(0,sunVectorBody[2])+
    surfaceGeometry.bareMinusYArea*max(0,-sunVectorBody[2])+
    surfaceGeometry.barePlusZArea*max(0,sunVectorBody[3])+
    surfaceGeometry.bareMinusZArea*max(0,-sunVectorBody[3]));
  bareProjectedAreaToEarth=noEvent(
    surfaceGeometry.barePlusXArea*max(0,earthVectorBody[1])+
    surfaceGeometry.bareMinusXArea*max(0,-earthVectorBody[1])+
    surfaceGeometry.barePlusYArea*max(0,earthVectorBody[2])+
    surfaceGeometry.bareMinusYArea*max(0,-earthVectorBody[2])+
    surfaceGeometry.barePlusZArea*max(0,earthVectorBody[3])+
    surfaceGeometry.bareMinusZArea*max(0,-earthVectorBody[3]));
  solarBodyHeatFlow=bodySolarAbsorptivity*solarFlux*bareProjectedAreaToSun;
  albedoHeatFlow=bodySolarAbsorptivity*albedoFlux*bareProjectedAreaToEarth;
  earthIRHeatFlow=bodyInfraredAbsorptivity*earthInfraredFlux*bareProjectedAreaToEarth;
  externalHeatFlow=solarBodyHeatFlow+albedoHeatFlow+earthIRHeatFlow;
initial equation
  assert(surfaceGeometry.width > 0 and surfaceGeometry.height > 0 and 
    surfaceGeometry.length > 0 and 
    surfaceGeometry.barePlusXArea >= 0 and 
    surfaceGeometry.barePlusYArea >= 0 and 
    surfaceGeometry.bareMinusXArea >= 0,
    "Panel coverage exceeds structural face area or structure dimensions are invalid.");
  annotation(Documentation(info="<html><h2>整星外表面轨道热流计算</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Calculations.ExternalOrbitalHeatCalculation</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>整星外表面轨道热流计算</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.Four_systems.ThermalOverall\">OneSatSim.Systems.Four_systems.ThermalOverall</a> 的 <code>externalHeatCalculation</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>sunVectorBody[3]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>按声明/类型合同</td><td>太阳方向在本体系中的单位向量</td></tr><tr><td><code>earthVectorBody[3]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>按声明/类型合同</td><td>地心方向在本体系中的单位向量</td></tr><tr><td><code>solarFlux</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>W/m2</td><td>太阳辐照通量</td></tr><tr><td><code>albedoFlux</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>W/m2</td><td>地球反照通量</td></tr><tr><td><code>earthInfraredFlux</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>W/m2</td><td>地球红外通量</td></tr><tr><td><code>externalHeatFlow</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>W</td><td>外表面总吸收热流</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>surfaceGeometry</code></td><td>OneSatSim.Foundation.Types.SurfaceGeometry</td><td>surface几何</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>bodySolarAbsorptivity</code></td><td>Real</td><td>外表面对太阳与反照辐射的吸收率</td><td><code>=0.60</code></td></tr><tr><td><code>bodyInfraredAbsorptivity</code></td><td>Real</td><td>外表面对地球红外的吸收率</td><td><code>=0.80</code></td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] bareProjectedAreaToSun=noEvent( surfaceGeometry.barePlusXArea*max(0,sunVectorBody[1])+ surfaceGeometry.bareMinusXArea*max(0,-sunVectorBody[1])+ surfaceGeometry.barePlusYArea*max(0,sunVectorBody[2])+ surfaceGeometry.bareMinusYArea*max(0,-sunVectorBody[2])+ surfaceGeometry.barePlusZArea*max(0,sunVectorBody[3])+ surfaceGeometry.bareMinusZArea*max(0,-sunVectorBody[3]));\n[equation] bareProjectedAreaToEarth=noEvent( surfaceGeometry.barePlusXArea*max(0,earthVectorBody[1])+ surfaceGeometry.bareMinusXArea*max(0,-earthVectorBody[1])+ surfaceGeometry.barePlusYArea*max(0,earthVectorBody[2])+ surfaceGeometry.bareMinusYArea*max(0,-earthVectorBody[2])+ surfaceGeometry.barePlusZArea*max(0,earthVectorBody[3])+ surfaceGeometry.bareMinusZArea*max(0,-earthVectorBody[3]));\n[equation] solarBodyHeatFlow=bodySolarAbsorptivity*solarFlux*bareProjectedAreaToSun;\n[equation] albedoHeatFlow=bodySolarAbsorptivity*albedoFlux*bareProjectedAreaToEarth;\n[equation] earthIRHeatFlow=bodyInfraredAbsorptivity*earthInfraredFlux*bareProjectedAreaToEarth;\n[equation] externalHeatFlow=solarBodyHeatFlow+albedoHeatFlow+earthIRHeatFlow;\n[initial equation] assert(surfaceGeometry.width &gt; 0 and surfaceGeometry.height &gt; 0 and surfaceGeometry.length &gt; 0 and surfaceGeometry.barePlusXArea &gt;= 0 and surfaceGeometry.barePlusYArea &gt;= 0 and surfaceGeometry.bareMinusXArea &gt;= 0, &quot;Panel coverage exceeds structural face area or structure dimensions are invalid.&quot;);</pre><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>bareProjectedAreaToSun</code></td><td>Modelica.Units.SI.Area</td><td>public</td><td>m2</td><td>裸露本体对太阳的投影面积</td></tr><tr><td><code>bareProjectedAreaToEarth</code></td><td>Modelica.Units.SI.Area</td><td>public</td><td>m2</td><td>扣除太阳电池覆盖区后的裸露本体对地投影面积</td></tr><tr><td><code>solarBodyHeatFlow</code></td><td>Modelica.Units.SI.HeatFlowRate</td><td>public</td><td>W</td><td>裸露本体吸收的太阳热流</td></tr><tr><td><code>albedoHeatFlow</code></td><td>Modelica.Units.SI.HeatFlowRate</td><td>public</td><td>W</td><td>吸收的地球反照热流</td></tr><tr><td><code>earthIRHeatFlow</code></td><td>Modelica.Units.SI.HeatFlowRate</td><td>public</td><td>W</td><td>吸收的地球红外热流</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={196,94,56}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Thermal analysis", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Ellipse(extent={{-42.2,-16.32},{-3.32,22.56}}, lineColor={0,0,0}, fillColor={239,246,250}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-30.536,-16.32},{-14.984,22.56}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Ellipse(extent={{-42.2,-3.684},{-3.32,9.924}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Line(points={{-42.2,3.12},{-3.32,3.12}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-22.76,-16.32},{-22.76,22.56}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-65.24,-19.92},{28.36,37.68}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.7, startAngle=0, endAngle=360),
      Rectangle(extent={{12.52,21.12},{19.72,28.32}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Rectangle(extent={{6.76,21.84},{11.8,27.6}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{20.44,21.84},{25.48,27.6}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Ellipse(extent={{-60.2,28.32},{-50.12,38.4}}, lineColor={0,0,0}, fillColor={255,246,210}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Line(points={{-47.96,33.36},{-44.36,33.36}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-50.068831,38.451169},{-47.523247,40.996753}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-55.16,40.56},{-55.16,44.16}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-60.251169,38.451169},{-62.796753,40.996753}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-62.36,33.36},{-65.96,33.36}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-60.251169,28.268831},{-62.796753,25.723247}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-55.16,26.16},{-55.16,22.56}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-50.068831,28.268831},{-47.523247,25.723247}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-45.8,28.32},{-34.28,21.12}}, color={212,109,62}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-10.52,18.96},{13.24,22.56}}, color={196,94,56}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{43,-31},{72,28}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{47,15},{68,15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,0},{68,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,-15},{68,-15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-57,-51},{37,-34}}, textString="solar + IR", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="External Orbital Heat", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-269,-121},{269,165}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-66.75,-72.75},{66.75,71.25}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-57,48},{57,48}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-63,51.75},{-48,66.75}}, lineColor={0,0,0}, fillColor={196,94,56}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-45.75,53.25},{57,64.5}}, textString="Thermal analysis", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Ellipse(extent={{-31.65,-12.24},{-2.49,16.92}}, lineColor={0,0,0}, fillColor={239,246,250}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-22.902,-12.24},{-11.238,16.92}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Ellipse(extent={{-31.65,-2.763},{-2.49,7.443}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Line(points={{-31.65,2.34},{-2.49,2.34}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-17.07,-12.24},{-17.07,16.92}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-48.93,-14.94},{21.27,28.26}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.7, startAngle=0, endAngle=360),
      Rectangle(extent={{9.39,15.84},{14.79,21.24}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Rectangle(extent={{5.07,16.38},{8.85,20.7}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{15.33,16.38},{19.11,20.7}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Ellipse(extent={{-45.15,21.24},{-37.59,28.8}}, lineColor={0,0,0}, fillColor={255,246,210}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Line(points={{-35.97,25.02},{-33.27,25.02}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-37.5516,28.8384},{-35.6424,30.7476}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-41.37,30.42},{-41.37,33.12}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-45.1884,28.8384},{-47.0976,30.7476}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-46.77,25.02},{-49.47,25.02}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-45.1884,21.2016},{-47.0976,19.2924}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-41.37,19.62},{-41.37,16.92}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-37.5516,21.2016},{-35.6424,19.2924}}, color={212,109,62}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-34.35,21.24},{-25.71,15.84}}, color={212,109,62}, thickness=0.8, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-7.89,14.22},{9.93,16.92}}, color={196,94,56}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{32.25,-23.25},{54,21}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{35.25,11.25},{51,11.25}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{35.25,0},{51,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{35.25,-11.25},{51,-11.25}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-42.75,-38.25},{27.75,-25.5}}, textString="solar + IR", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-57,-43.5},{57,-43.5}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-60,-59.25},{60,-48}}, textString="External Orbital Heat", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-257,120},{257,149}}, textString="External Orbital Heat", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-257,112},{257,112}}, color={215,220,226}, thickness=0.25)
    }));
end ExternalOrbitalHeatCalculation;