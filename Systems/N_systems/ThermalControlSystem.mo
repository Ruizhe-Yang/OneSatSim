within OneSatSim.Systems.N_systems;
model ThermalControlSystem "热控分系统"
  parameter OneSatSim.Scenarios.DesignConfigRecords.ThermalControlDesignConfig designConfig "分系统硬件设计配置";
  Foundation.Interfaces.PowerPort power  "功率" annotation(Placement(transformation(origin={0,145},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={7.5,100.48},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Foundation.Interfaces.ThermalPort thermal  "热学" annotation(Placement(transformation(origin={0,-135},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={-2.22045e-16,-100.48},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(transformation(origin={-195,20},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={-100,-1},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Foundation.Interfaces.InformationPort information  "计算/接口量 information" annotation(Placement(transformation(origin={215,20},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={99.52,-1},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Components.ThermalControllerUnit controller (config=designConfig.controller)  "热控控制器组件实例" annotation(Placement(visible=true, transformation(origin={-80,20}, extent={{-70,-70},{70,70}}, rotation=0)));
  Components.HeaterRadiatorUnit heaters (config=designConfig.heaters)  "加热器与散热执行组件实例" annotation(Placement(visible=true, transformation(origin={105,-20}, extent={{-55,-55},{55,55}}, rotation=0)));
equation
  connect(power,controller.power) annotation(Line(points={{0,145},{0,96.5},{-80,96.5},{-80,86.5}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power,heaters.power) annotation(Line(points={{0,145},{0,42.25},{105,42.25},{105,32.25}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,controller.thermal) annotation(Line(points={{0,-135},{-80,-135},{-80,-47.9}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,heaters.thermal) annotation(Line(points={{0,-135},{105,-135},{105,-73.35}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,controller.mechanical) annotation(Line(points={{-195,20},{-142.3,20}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,heaters.mechanical) annotation(Line(points={{-195,20},{-195,-57.9},{46.05,-57.9},{46.05,-20},{56.05,-20}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,controller.information) annotation(Line(points={{215,20},{215,42.25},{-7.7,42.25},{-7.7,20},{-17.7,20}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,heaters.information) annotation(Line(points={{215,20},{215,-20},{153.95,-20}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>热控分系统</h2><p><b>类路径：</b><code>OneSatSim.Systems.N_systems.ThermalControlSystem</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>热控分系统</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.SpacecraftSystem\">OneSatSim.Systems.SpacecraftSystem</a> 的 <code>thermalControlSystem</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>power</code></td><td>Foundation.Interfaces.PowerPort</td><td>public</td><td>按声明/类型合同</td><td>功率</td></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr><tr><td><code>information</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>designConfig</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.ThermalControlDesignConfig</td><td>分系统硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>controller</code></td><td><a href=\"modelica://OneSatSim.Components.ThermalControllerUnit\">OneSatSim.Components.ThermalControllerUnit</a></td><td>热控控制器组件实例</td></tr><tr><td><code>heaters</code></td><td><a href=\"modelica://OneSatSim.Components.HeaterRadiatorUnit\">OneSatSim.Components.HeaterRadiatorUnit</a></td><td>加热器与散热执行组件实例</td></tr></table><h3>使用边界</h3><p>本工程的轨道环境采用离线固化数据；任务、姿态、电热及信息边界按当前配置和接口使用。已有未完成任务目标与平台状态见根README，不由本次注释更新改写。</p></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={196,94,56}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Subsystem", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Ellipse(extent={{-65.2,-15.46},{-54.04,-4.3}}, lineColor={0,0,0}, fillColor={247,220,207}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Rectangle(extent={{-62.1,-5.54},{-57.14,23.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=2),
      Line(points={{-59.62,-8.02},{-59.62,14.92}}, color={196,94,56}, thickness=1.7, pattern=LinePattern.Solid),
      Rectangle(extent={{-37.92,-12.36},{7.34,26.08}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Line(points={{-33.58,-5.54},{0.52,-5.54}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-33.58,-5.54},{-33.58,20.5}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-33.58,-0.58},{-22.42,-0.58},{-22.42,14.92},{-3.2,14.92}}, color={196,94,56}, thickness=0.9, pattern=LinePattern.Solid),
      Line(points={{-3.2,14.92},{-12.5,14.92},{-12.5,-0.58},{-28.62,-0.58}}, color={196,94,56}, thickness=0.9, pattern=LinePattern.Solid),
      Line(points={{-54.04,1.28},{-39.16,1.28}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{9.2,8.1},{16.64,8.1}}, color={77,126,172}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{15.52,-20.28},{49.6,14.28}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Line(points={{19.36,-14.52},{25.12,-14.52},{25.12,8.52},{31.36,8.52},{31.36,-14.52},{37.6,-14.52},{37.6,8.52},{43.84,8.52},{43.84,-14.52},{48.16,-14.52}}, color={196,94,56}, thickness=1, pattern=LinePattern.Solid),
      Rectangle(extent={{53.92,-20.28},{64.48,14.28}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{54.4,-16.44},{63.52,-16.44}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{54.4,-10.68},{63.52,-10.68}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{54.4,-4.92},{63.52,-4.92}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{54.4,0.84},{63.52,0.84}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{54.4,6.6},{63.52,6.6}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{54.4,12.36},{63.52,12.36}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{65.92,-12.6},{69.28,-10.2},{72.16,-12.6},{75.04,-10.2}}, color={196,94,56}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{65.92,-0.6},{69.28,1.8},{72.16,-0.6},{75.04,1.8}}, color={196,94,56}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{65.92,11.4},{69.28,13.8},{72.16,11.4},{75.04,13.8}}, color={196,94,56}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{9.76,-14.52},{15.52,-14.52}}, color={77,126,172}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{9.76,8.52},{15.52,8.52}}, color={77,126,172}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Thermal Control System", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-239,-179},{259,233}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-195,124},{-43.8,142}}, textString="Thermal regulation", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{35,79},{211.4,97}}, textString="Heating and rejection", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-227,188},{247,217}}, textString="Thermal Control System", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-227,180},{247,180}}, color={215,220,226}, thickness=0.25)
    }));
end ThermalControlSystem;