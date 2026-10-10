within OneSatSim.Systems.N_systems;
model CommunicationSystem "测控数传分系统"
  parameter OneSatSim.Scenarios.DesignConfigRecords.CommunicationDesignConfig designConfig "分系统硬件设计配置";
  Foundation.Interfaces.PowerPort power  "功率" annotation(Placement(transformation(origin={-10,200},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={0,101.52},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Foundation.Interfaces.ThermalPort thermal  "热学" annotation(Placement(transformation(origin={10,-195},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={-4.44089e-16,-99.52},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(transformation(origin={-265,0},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={-100.48,0.23},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Foundation.Interfaces.InformationPort information  "计算/接口量 information" annotation(Placement(transformation(origin={305,15},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={100.48,-1},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Components.RadioReceiverUnit ttc (config=designConfig.ttcReceiver)  "测控接收机组件实例" annotation(Placement(visible=true, transformation(origin={-150,90}, extent={{-55,-55},{55,55}}, rotation=0)));
  Components.LowRateTelemetryTransmitterUnit baseband (config=designConfig.baseband)  "低速遥测基带组件实例" annotation(Placement(visible=true, transformation(origin={-150,-80}, extent={{-50,-50},{50,50}}, rotation=0)));
  Components.XBandTransmitterUnit xband (config=designConfig.xband)  "X波段数传发射机组件实例" annotation(Placement(visible=true, transformation(origin={80,80}, extent={{-75,-75},{75,75}}, rotation=0)));
  Components.AntennaUnit antenna (config=designConfig.antenna)  "X波段贴片与测控天线组件实例" annotation(Placement(visible=true, transformation(origin={205,-70}, extent={{-55,-55},{55,55}}, rotation=0)));
equation
  connect(power,ttc.power) annotation(Line(points={{-10,200},{-150,200},{-150,142.25}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power,baseband.power) annotation(Line(points={{-10,200},{-10,-22.5},{-150,-22.5},{-150,-32.5}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power,xband.power) annotation(Line(points={{-10,200},{-10,161.25},{80,161.25},{80,151.25}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,ttc.thermal) annotation(Line(points={{10,-195},{10,-22.5},{-150,-22.5},{-150,36.65}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,baseband.thermal) annotation(Line(points={{10,-195},{-150,-195},{-150,-128.5}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,xband.thermal) annotation(Line(points={{10,-195},{80,-195},{80,7.25}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,antenna.thermal) annotation(Line(points={{10,-195},{205,-195},{205,-123.35}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,ttc.mechanical) annotation(Line(points={{-265,0},{-265,90},{-198.95,90}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,baseband.mechanical) annotation(Line(points={{-265,0},{-265,-80},{-194.5,-80}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,xband.mechanical) annotation(Line(points={{-265,0},{3.25,0},{3.25,80},{13.25,80}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,antenna.mechanical) annotation(Line(points={{-265,0},{-265,-22.5},{146.05,-22.5},{146.05,-70},{156.05,-70}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,ttc.information) annotation(Line(points={{305,15},{305,-2.75},{-91.05,-2.75},{-91.05,90},{-101.05,90}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,baseband.information) annotation(Line(points={{305,15},{305,-7.75},{-95.5,-7.75},{-95.5,-80},{-105.5,-80}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,xband.information) annotation(Line(points={{305,15},{305,80},{146.75,80}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info = "<html><h2>测控数传分系统</h2><p><b>类路径：</b><code>OneSatSim.Systems.N_systems.CommunicationSystem</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>测控数传分系统</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.SpacecraftSystem\">OneSatSim.Systems.SpacecraftSystem</a> 的 <code>communicationSystem</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>power</code></td><td>Foundation.Interfaces.PowerPort</td><td>public</td><td>按声明/类型合同</td><td>功率</td></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr><tr><td><code>information</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>designConfig</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.CommunicationDesignConfig</td><td>分系统硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>ttc</code></td><td><a href=\"modelica://OneSatSim.Components.RadioReceiverUnit\">OneSatSim.Components.RadioReceiverUnit</a></td><td>测控接收机组件实例</td></tr><tr><td><code>baseband</code></td><td><a href=\"modelica://OneSatSim.Components.LowRateTelemetryTransmitterUnit\">OneSatSim.Components.LowRateTelemetryTransmitterUnit</a></td><td>低速遥测基带组件实例</td></tr><tr><td><code>xband</code></td><td><a href=\"modelica://OneSatSim.Components.XBandTransmitterUnit\">OneSatSim.Components.XBandTransmitterUnit</a></td><td>X波段数传发射机组件实例</td></tr><tr><td><code>antenna</code></td><td><a href=\"modelica://OneSatSim.Components.AntennaUnit\">OneSatSim.Components.AntennaUnit</a></td><td>X波段贴片与测控天线组件实例</td></tr></table><h3>使用边界</h3><p>本工程的轨道环境采用离线固化数据；任务、姿态、电热及信息边界按当前配置和接口使用。已有未完成任务目标与平台状态见根README，不由本次注释更新改写。</p></html>"
),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Subsystem", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-42,-15.25},{3.75,22.25}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Rectangle(extent={{-36,-8.5},{-3,14.75}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Polygon(points={{-27.75,-4},{-27.75,11.75},{-12.75,3.5},{-27.75,-4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{-38.25,3.5},{-27.75,3.5}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-12.75,3.5},{3,3.5}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{4.5,3.5},{27,3.5},{27,27.5}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Polygon(points={{17.25,35},{27,21.5},{36.75,35},{17.25,35}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Ellipse(extent={{15.75,10.25},{38.25,32.75}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.65, startAngle=-35, endAngle=35),
      Ellipse(extent={{9,3.5},{45,39.5}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.65, startAngle=-35, endAngle=35),
      Ellipse(extent={{2.25,-3.25},{51.75,46.25}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.65, startAngle=-35, endAngle=35),
      Line(points={{15.75,-18.25},{49.5,-18.25}}, color={73,112,158}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Text(extent={{-36.75,26},{-19.5,41.75}}, textString="X", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Line(points={{-60,-43},{60,-43}}, color={83,131,109}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Communication System", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-309,-239},{349,315}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-280,227},{5.6,245}}, textString="Telecommand and low-rate telemetry", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{20,194},{288.8,212}}, textString="Payload downlink and RF aperture", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-297,270},{337,299}}, textString="Communication System", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-297,262},{337,262}}, color={215,220,226}, thickness=0.25)
    }));
end CommunicationSystem;