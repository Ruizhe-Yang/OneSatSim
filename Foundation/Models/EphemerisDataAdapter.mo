within OneSatSim.Foundation.Models;
model EphemerisDataAdapter "Derivative-consistent table signal conditioning"
  import SI=Modelica.Units.SI;
  parameter SI.Time simulationDuration "生成环境覆盖的仿真时长 [s]" ;
  parameter Integer tableRows(min=2) "配置项 tableRows" ;
  Modelica.Blocks.Interfaces.RealInput positionData[3](each unit="m") 
     "位置数据 [m]" annotation(Placement(visible=true, transformation(origin={-185,32}, extent={{-7,-7},{7,7}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,40}, extent={{-5.76,-5.76},{5.76,5.76}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput sunDirectionData[3](each unit="1") 
     "sun方向数据 [1]" annotation(Placement(visible=true, transformation(origin={-185,0}, extent={{-7,-7},{7,7}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-5.76,-5.76},{5.76,5.76}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput earthToInertialData[9](each unit="1") 
     "earth转换为Inertial数据 [1]" annotation(Placement(visible=true, transformation(origin={-185,-32}, extent={{-7,-7},{7,7}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-40}, extent={{-5.76,-5.76},{5.76,5.76}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.EphemerisPort ephemeris 
     "计算/接口量 ephemeris" annotation(Placement(visible=true, transformation(origin={185,0}, extent={{-14,-14},{14,14}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-11.52,-11.52},{11.52,11.52}}, rotation=0)));
protected
  Real sunNorm(unit="1") "计算/接口量 sunNorm [1]" ;
initial equation
  assert(simulationDuration > 0,"Generated environment duration must be positive");
  assert(tableRows >= 3,"Generated environment table must contain at least three rows");
equation
  ephemeris.position=positionData;
  ephemeris.velocity={der(positionData[1]),der(positionData[2]),der(positionData[3])};
  sunNorm=sqrt(max(1e-24,sunDirectionData[1]^2+sunDirectionData[2]^2+sunDirectionData[3]^2));
  ephemeris.sunDirection=sunDirectionData/sunNorm;
  ephemeris.earthToInertial={{earthToInertialData[1],earthToInertialData[2],earthToInertialData[3]},
    {earthToInertialData[4],earthToInertialData[5],earthToInertialData[6]},
    {earthToInertialData[7],earthToInertialData[8],earthToInertialData[9]}};
  for i in 1:3 loop
    for j in 1:3 loop
      ephemeris.earthToInertialRate[i,j]=der(ephemeris.earthToInertial[i,j]);
    end for;
  end for;
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Ellipse(extent={{-42.2,-16.32},{-3.32,22.56}}, lineColor={0,0,0}, fillColor={239,246,250}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-30.536,-16.32},{-14.984,22.56}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Ellipse(extent={{-42.2,-3.684},{-3.32,9.924}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Line(points={{-42.2,3.12},{-3.32,3.12}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-22.76,-16.32},{-22.76,22.56}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-65.24,-19.92},{28.36,37.68}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.7, startAngle=0, endAngle=360),
      Rectangle(extent={{12.52,21.12},{19.72,28.32}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Rectangle(extent={{6.76,21.84},{11.8,27.6}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{20.44,21.84},{25.48,27.6}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{25.48,10.32},{30.52,3.84},{28.36,-2.64}}, color={73,112,158}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Rectangle(extent={{43,-31},{72,28}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{47,15},{68,15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,0},{68,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,-15},{68,-15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-57,-51},{37,-34}}, textString="r -> dr/dt", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Ephemeris Adapter", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-230,-89.8},{230,133.8}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-51.62,-56.26},{51.62,55.1}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-44.08,37.12},{44.08,37.12}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-48.72,40.02},{-37.12,51.62}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-35.38,41.18},{44.08,49.88}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Ellipse(extent={{-24.476,-9.4656},{-1.9256,13.0848}}, lineColor={0,0,0}, fillColor={239,246,250}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-17.7109,-9.4656},{-8.6907,13.0848}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Ellipse(extent={{-24.476,-2.1367},{-1.9256,5.7559}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Line(points={{-24.476,1.8096},{-1.9256,1.8096}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-13.2008,-9.4656},{-13.2008,13.0848}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-37.8392,-11.5536},{16.4488,21.8544}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.7, startAngle=0, endAngle=360),
      Rectangle(extent={{7.2616,12.2496},{11.4376,16.4256}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Rectangle(extent={{3.9208,12.6672},{6.844,16.008}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{11.8552,12.6672},{14.7784,16.008}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{14.7784,5.9856},{17.7016,2.2272},{16.4488,-1.5312}}, color={73,112,158}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Rectangle(extent={{24.94,-17.98},{41.76,16.24}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{27.26,8.7},{39.44,8.7}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{27.26,0},{39.44,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{27.26,-8.7},{39.44,-8.7}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-33.06,-29.58},{21.46,-19.72}}, textString="r -> dr/dt", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-44.08,-33.64},{44.08,-33.64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-46.4,-45.82},{46.4,-37.12}}, textString="Ephemeris Adapter", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-218,88.8},{218,117.8}}, textString="Ephemeris Data Adapter", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-218,80.8},{218,80.8}}, color={215,220,226}, thickness=0.25)
    }), Documentation(info="<html><h2>星历表信号与导数一致适配</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Models.EphemerisDataAdapter</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>星历表信号与导数一致适配。原源码功能描述：Derivative-consistent table signal conditioning</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Foundation.Models.EphemerisEnvironmentReader\">OneSatSim.Foundation.Models.EphemerisEnvironmentReader</a> 的 <code>adapter</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>positionData[3]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>m</td><td>位置数据 [m]</td></tr><tr><td><code>sunDirectionData[3]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>1</td><td>sun方向数据 [1]</td></tr><tr><td><code>earthToInertialData[9]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>1</td><td>earth转换为Inertial数据 [1]</td></tr><tr><td><code>ephemeris</code></td><td>OneSatSim.Foundation.Interfaces.EphemerisPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 ephemeris</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>simulationDuration</code></td><td>SI.Time</td><td>生成环境覆盖的仿真时长 [s]</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>tableRows</code></td><td>Integer</td><td>配置项 tableRows</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table><h3>状态与初始化</h3><p>本类源码中显式出现的导数对象或离散声明：<code>positionData[1], positionData[2], positionData[3], ephemeris.earthToInertial[i,j]</code>。初始化取当前声明的 start/fixed、initial 方程/算法及继承设置。此处是源码级说明，不等同于编译后连续状态统计。</p><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[initial equation] assert(simulationDuration &gt; 0,&quot;Generated environment duration must be positive&quot;);\n[initial equation] assert(tableRows &gt;= 3,&quot;Generated environment table must contain at least three rows&quot;);\n[equation] ephemeris.position=positionData;\n[equation] ephemeris.velocity={der(positionData[1]),der(positionData[2]),der(positionData[3])};\n[equation] sunNorm=sqrt(max(1e-24,sunDirectionData[1]^2+sunDirectionData[2]^2+sunDirectionData[3]^2));\n[equation] ephemeris.sunDirection=sunDirectionData/sunNorm;\n[equation] ephemeris.earthToInertial={{earthToInertialData[1],earthToInertialData[2],earthToInertialData[3]}, {earthToInertialData[4],earthToInertialData[5],earthToInertialData[6]}, {earthToInertialData[7],earthToInertialData[8],earthToInertialData[9]}};\n[equation] for i in 1:3 loop for j in 1:3 loop ephemeris.earthToInertialRate[i,j]=der(ephemeris.earthToInertial[i,j]);\n[equation] end for;\n[equation] end for;</pre><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>sunNorm</code></td><td>Real</td><td>protected</td><td>1</td><td>计算/接口量 sunNorm [1]</td></tr></table></html>"));
end EphemerisDataAdapter;