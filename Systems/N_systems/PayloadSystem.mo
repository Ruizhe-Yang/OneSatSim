within OneSatSim.Systems.N_systems;
model PayloadSystem "载荷分系统"
  parameter OneSatSim.Scenarios.DesignConfigRecords.PayloadDesignConfig designConfig "分系统硬件设计配置";
  parameter OneSatSim.Scenarios.InitialConditionConfig initialConditions "场景初始条件";
  parameter OneSatSim.Foundation.Types.ImagingCapabilities imagingCapabilities
    "成像Capabilities；Earth-camera capability from spacecraft design configuration";
  Foundation.Interfaces.PowerPort power  "功率" annotation(Placement(transformation(origin={15,255},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={-8.88178e-16,100.48},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true),__MWORKS(fontSize=33));
  Foundation.Interfaces.ThermalPort thermal  "热学" annotation(Placement(transformation(origin={15,-235},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={0,-97},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true),__MWORKS(fontSize=33));
  Foundation.Interfaces.MechanicalPort mechanical  "机械" annotation(Placement(transformation(origin={-280,-5},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={-100.96,-1},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Foundation.Interfaces.InformationPort information  "计算/接口量 information" annotation(Placement(transformation(origin={340,-5},
extent={{-12,-12},{12,12}}),
iconTransformation(origin={100.48,-1},
extent={{-11.52,-11.52},{11.52,11.52}}),
iconVisible=true));
  Components.EarthObservationCameraUnit earthCamera(config=designConfig.earthCamera,
    imagingCapabilities=imagingCapabilities,
    initialOpticalBenchTemperature=initialConditions.cameraOpticalBenchTemperature,
    initialFocalBoxTemperature=initialConditions.cameraFocalBoxTemperature)  "对地观测相机组件实例" annotation(Placement(visible=true, transformation(origin={-140,70}, extent={{-90,-90},{90,90}}, rotation=0)));
  Components.SelfieCameraUnit selfieCamera (config=designConfig.selfieCamera)  "自拍相机组件实例" annotation(Placement(visible=true, transformation(origin={-140,-110}, extent={{-45,-45},{45,45}}, rotation=0)));
  Components.NaviEnhancePayloadUnit naviEnhance (config=designConfig.naviEnhance)  "导航增强载荷组件实例" annotation(Placement(visible=true, transformation(origin={80,135}, extent={{-55,-55},{55,55}}, rotation=0)));
  Components.SpaceTimePayloadUnit spaceTime (config=designConfig.spaceTime)  "时空基准载荷组件实例" annotation(Placement(visible=true, transformation(origin={225,45}, extent={{-55,-55},{55,55}}, rotation=0)));
  Components.FotonAmurPayloadUnit fotonAmur (config=designConfig.fotonAmur)  "科学载荷组件实例" annotation(Placement(visible=true, transformation(origin={125,-120}, extent={{-55,-55},{55,55}}, rotation=0)));
equation
  connect(power,earthCamera.power) annotation(Line(points={{15,255},{15,165.5},{-140,165.5},{-140,155.5}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power,selfieCamera.power) annotation(Line(points={{15,255},{15,-57.25},{-140,-57.25},{-140,-67.25}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power,naviEnhance.power) annotation(Line(points={{15,255},{15,197.25},{80,197.25},{80,187.25}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power,spaceTime.power) annotation(Line(points={{15,255},{15,197.25},{225,197.25},{225,97.25}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(power,fotonAmur.power) annotation(Line(points={{15,255},{15,-57.75},{125,-57.75},{125,-67.75}}, color={245,158,11}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,earthCamera.thermal) annotation(Line(points={{15,-235},{15,-27.3},{-140,-27.3},{-140,-17.3}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,selfieCamera.thermal) annotation(Line(points={{15,-235},{-140,-235},{-140,-153.65}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,naviEnhance.thermal) annotation(Line(points={{15,-235},{15,71.65},{80,71.65},{80,81.65}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,spaceTime.thermal) annotation(Line(points={{15,-235},{225,-235},{225,-8.35}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(thermal,fotonAmur.thermal) annotation(Line(points={{15,-235},{125,-235},{125,-173.35}}, color={191,0,0}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,earthCamera.mechanical) annotation(Line(points={{-280,-5},{-280,70},{-220.1,70}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,selfieCamera.mechanical) annotation(Line(points={{-280,-5},{-280,-110},{-180.05,-110}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,naviEnhance.mechanical) annotation(Line(points={{-280,-5},{-280,165.5},{21.05,165.5},{21.05,135},{31.05,135}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,spaceTime.mechanical) annotation(Line(points={{-280,-5},{-280,-27.3},{166.05,-27.3},{166.05,45},{176.05,45}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(mechanical,fotonAmur.mechanical) annotation(Line(points={{-280,-5},{-280,-57.75},{66.05,-57.75},{66.05,-120},{76.05,-120}}, color={95,95,95}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,earthCamera.information) annotation(Line(points={{340,-5},{340,-18.35},{-49.9,-18.35},{-49.9,70},{-59.9,70}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,selfieCamera.information) annotation(Line(points={{340,-5},{340,-57.75},{-89.95,-57.75},{-89.95,-110},{-99.95,-110}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,naviEnhance.information) annotation(Line(points={{340,-5},{340,135},{128.95,135}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,spaceTime.information) annotation(Line(points={{340,-5},{340,45},{273.95,45}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(information,fotonAmur.information) annotation(Line(points={{340,-5},{340,-120},{173.95,-120}}, color={0,102,255}, thickness=0.5, pattern=LinePattern.Solid, smooth=Smooth.None));
  annotation(Documentation(info="<html><h2>载荷分系统</h2><p><b>类路径：</b><code>OneSatSim.Systems.N_systems.PayloadSystem</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>载荷分系统</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Systems.SpacecraftSystem\">OneSatSim.Systems.SpacecraftSystem</a> 的 <code>payloadSystem</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>power</code></td><td>Foundation.Interfaces.PowerPort</td><td>public</td><td>按声明/类型合同</td><td>功率</td></tr><tr><td><code>thermal</code></td><td>Foundation.Interfaces.ThermalPort</td><td>public</td><td>按声明/类型合同</td><td>热学</td></tr><tr><td><code>mechanical</code></td><td>Foundation.Interfaces.MechanicalPort</td><td>public</td><td>按声明/类型合同</td><td>机械</td></tr><tr><td><code>information</code></td><td>Foundation.Interfaces.InformationPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 information</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>designConfig</code></td><td>OneSatSim.Scenarios.DesignConfigRecords.PayloadDesignConfig</td><td>分系统硬件设计配置</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>initialConditions</code></td><td>OneSatSim.Scenarios.InitialConditionConfig</td><td>场景初始条件</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>imagingCapabilities</code></td><td>OneSatSim.Foundation.Types.ImagingCapabilities</td><td>成像Capabilities；Earth-camera capability from spacecraft design configuration</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table><h3>内部组成</h3><p>以下为本类直接声明的组成单元，继承类的内部结构另按其文档查看。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>实例</th><th>类</th><th>作用</th></tr><tr><td><code>earthCamera</code></td><td><a href=\"modelica://OneSatSim.Components.EarthObservationCameraUnit\">OneSatSim.Components.EarthObservationCameraUnit</a></td><td>对地观测相机组件实例</td></tr><tr><td><code>selfieCamera</code></td><td><a href=\"modelica://OneSatSim.Components.SelfieCameraUnit\">OneSatSim.Components.SelfieCameraUnit</a></td><td>自拍相机组件实例</td></tr><tr><td><code>naviEnhance</code></td><td><a href=\"modelica://OneSatSim.Components.NaviEnhancePayloadUnit\">OneSatSim.Components.NaviEnhancePayloadUnit</a></td><td>导航增强载荷组件实例</td></tr><tr><td><code>spaceTime</code></td><td><a href=\"modelica://OneSatSim.Components.SpaceTimePayloadUnit\">OneSatSim.Components.SpaceTimePayloadUnit</a></td><td>时空基准载荷组件实例</td></tr><tr><td><code>fotonAmur</code></td><td><a href=\"modelica://OneSatSim.Components.FotonAmurPayloadUnit\">OneSatSim.Components.FotonAmurPayloadUnit</a></td><td>科学载荷组件实例</td></tr></table><h3>使用边界</h3><p>本工程的轨道环境采用离线固化数据；任务、姿态、电热及信息边界按当前配置和接口使用。已有未完成任务目标与平台状态见根README，不由本次注释更新改写。</p></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={152,118,71}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Subsystem", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-47,-7.82},{-14,28.48}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Polygon(points={{-14,26.5},{2.5,33.76},{2.5,-13.1},{-14,-5.18},{-14,26.5}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Ellipse(extent={{-4.76,-13.1},{11.74,33.76}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.75, startAngle=0, endAngle=360),
      Ellipse(extent={{-1.46,-6.5},{8.44,26.5}}, lineColor={0,0,0}, fillColor={224,237,246}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{1.84,0.76},{5.8,19.9}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-44.36,-11.78},{-8.72,-11.78}}, color={0,0,0}, thickness=0.75, pattern=LinePattern.Solid),
      Rectangle(extent={{-39.08,13.3},{-22.58,22.54}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Ellipse(extent={{-43.568,-4.388},{-41.192,-2.012}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-42.974,-3.2},{-41.786,-3.2}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-21.128,-4.388},{-18.752,-2.012}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-20.534,-3.2},{-19.346,-3.2}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{17.0464,-13.7336},{34.1536,3.3736}}, lineColor={0,0,0}, fillColor={239,246,250}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{22.17856,-13.7336},{29.02144,3.3736}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Ellipse(extent={{17.0464,-8.17376},{34.1536,-2.18624}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Line(points={{17.0464,-5.18},{34.1536,-5.18}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{25.6,-13.7336},{25.6,3.3736}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{11.74,21.88},{30.88,2.74}}, color={73,112,158}, thickness=0.55, pattern=LinePattern.Dash),
      Line(points={{11.74,-3.2},{20.32,-14.42}}, color={73,112,158}, thickness=0.55, pattern=LinePattern.Dash),
      Line(points={{-39.08,17.92},{-30.5,17.92}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Rectangle(extent={{19.39,-38.73},{56.39,-14.68}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Ellipse(extent={{24.94,-34.29},{41.96,-17.27}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Line(points={{33.45,-19.49},{33.45,-25.78},{39,-28}}, color={0,0,0}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{40.11,-25.78},{41.22,-25.78}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{39.217729,-22.45},{40.179017,-21.895}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{36.78,-20.012271},{37.335,-19.050983}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{33.45,-19.12},{33.45,-18.01}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{30.12,-20.012271},{29.565,-19.050983}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{27.682271,-22.45},{26.720983,-21.895}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{26.79,-25.78},{25.68,-25.78}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{27.682271,-29.11},{26.720983,-29.665}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{30.12,-31.547729},{29.565,-32.509017}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{33.45,-32.44},{33.45,-33.55}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{36.78,-31.547729},{37.335,-32.509017}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{39.217729,-29.11},{40.179017,-29.665}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{46.77,-31.33},{52.32,-23.19}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{49.36,-34.66},{49.36,-31.33}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{49.36,-23.19},{49.36,-19.12}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{20.87,-43.91},{27.53,-43.91},{27.53,-40.58},{33.45,-40.58},{33.45,-43.91},{39.37,-43.91},{39.37,-40.58},{45.29,-40.58},{45.29,-43.91},{51.21,-43.91},{51.21,-40.58},{57.13,-40.58}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Payload System", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-324,-279},{384,343}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Text(extent={{-245,199},{-119,217}}, textString="Optical imaging", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{40,229},{300.4,247}}, textString="Navigation and science payloads", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-312,298},{372,327}}, textString="Payload System", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-312,290},{372,290}}, color={215,220,226}, thickness=0.25)
    }));
end PayloadSystem;