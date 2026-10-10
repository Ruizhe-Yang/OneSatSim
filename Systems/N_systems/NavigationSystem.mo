within OneSatSim.Systems.N_systems;
model NavigationSystem "导航分系统"
  parameter OneSatSim.Scenarios.DesignConfigRecords.NavigationDesignConfig designConfig "分系统硬件设计配置";
  Foundation.Interfaces.PowerPort power  "功率" annotation(Placement(transformation(origin={0,125},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={0,101.52},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Foundation.Interfaces.ThermalPort thermal  "热学" annotation(Placement(transformation(origin={0,-125},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={-4.44089e-16,-101.52},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(transformation(origin={-125,64},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={-100,0},
extent={{-12,-12},{12,12}}),
iconVisible=true));
  Foundation.Interfaces.InformationPort information  "计算/接口量 information" annotation(Placement(transformation(origin={125,0},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={100.48,-1},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Foundation.Interfaces.EnvironmentPort environment  "外部环境接口或实例" annotation(Placement(transformation(origin={-125,-64},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={-100,-87.5},
extent={{-12,-12},{12,12}}),
iconVisible=true));
  Components.GPSReceiverUnit gnss (config=designConfig.gnss)  "GNSS接收机组件实例" annotation(Placement(visible=true, transformation(origin={0,0}, extent={{-80,-80},{80,80}}, rotation=0)));
equation
  connect(power,gnss.power) annotation(Line(points={{0,125},{0,76}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,gnss.thermal) annotation(Line(points={{0,-125},{0,-77.6}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,gnss.mechanical) annotation(Line(points={{-125,64},{-71.2,64}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,gnss.information) annotation(Line(points={{125,0},{71.2,0}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(environment,gnss.environment) annotation(Line(points={{-125,-64},{-71.2,-64}}, color={0,166,81}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>导航分系统</h2><p><b>类路径：</b><code>OneSatSim.Systems.N_systems.NavigationSystem</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>导航分系统</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.SpacecraftSystem\">OneSatSim.Systems.SpacecraftSystem</a> 的 <code>navigationSystem</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>power</code></td><td>Foundation.Interfaces.PowerPort</td><td>public</td><td>按声明/类型合同</td><td>功率</td></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr><tr><td><code>information</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr><tr><td><code>environment</code></td><td>Foundation.Interfaces.EnvironmentPort</td><td>public</td><td>按声明/类型合同</td><td>外部环境接口或实例</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>designConfig</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.NavigationDesignConfig</td><td>分系统硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>gnss</code></td><td><a href=\"modelica://OneSatSim.Components.GPSReceiverUnit\">OneSatSim.Components.GPSReceiverUnit</a></td><td>GNSS接收机组件实例</td></tr></table><h3>使用边界</h3><p>本工程的轨道环境采用离线固化数据；任务、姿态、电热及信息边界按当前配置和接口使用。已有未完成任务目标与平台状态见根README，不由本次注释更新改写。</p></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Subsystem", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-29,-29},{31,12}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Ellipse(extent={{-15,-17},{17,4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Line(points={{-13,-7},{15,-7}}, color={76,128,143}, thickness=0.6, pattern=LinePattern.Solid),
      Rectangle(extent={{-56,34},{-46,44}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, radius=0),
      Rectangle(extent={{-65,35},{-57,43}}, lineColor={0,0,0}, fillColor={230,239,245}, fillPattern=FillPattern.Solid, lineThickness=0.5, radius=0),
      Rectangle(extent={{-45,35},{-37,43}}, lineColor={0,0,0}, fillColor={230,239,245}, fillPattern=FillPattern.Solid, lineThickness=0.5, radius=0),
      Line(points={{-51,31},{-15.3,15}}, color={73,112,158}, thickness=0.55, pattern=LinePattern.Dash),
      Rectangle(extent={{-5,41},{5,51}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, radius=0),
      Rectangle(extent={{-14,42},{-6,50}}, lineColor={0,0,0}, fillColor={230,239,245}, fillPattern=FillPattern.Solid, lineThickness=0.5, radius=0),
      Rectangle(extent={{6,42},{14,50}}, lineColor={0,0,0}, fillColor={230,239,245}, fillPattern=FillPattern.Solid, lineThickness=0.5, radius=0),
      Line(points={{0,38},{0,15}}, color={73,112,158}, thickness=0.55, pattern=LinePattern.Dash),
      Rectangle(extent={{47,31},{57,41}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.5, radius=0),
      Rectangle(extent={{38,32},{46,40}}, lineColor={0,0,0}, fillColor={230,239,245}, fillPattern=FillPattern.Solid, lineThickness=0.5, radius=0),
      Rectangle(extent={{58,32},{66,40}}, lineColor={0,0,0}, fillColor={230,239,245}, fillPattern=FillPattern.Solid, lineThickness=0.5, radius=0),
      Line(points={{52,28},{15.6,15}}, color={73,112,158}, thickness=0.55, pattern=LinePattern.Dash),
      Line(points={{-50,-44},{47,-44}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{-32,-40},{-27,-44},{-22,-40}}, color={76,128,143}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{48,-22},{68,-22}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{48,-22},{37.6,-9.2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{48,-22},{48,-2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Navigation System", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-169,-169},{169,213}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-157,168},{157,197}}, textString="Navigation System", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-157,160},{157,160}}, color={215,220,226}, thickness=0.25)
    }));
end NavigationSystem;