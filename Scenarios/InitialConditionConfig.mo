within OneSatSim.Scenarios;
record InitialConditionConfig "任务场景初始条件"
  import SI=Modelica.Units.SI;
  parameter SI.Angle roll "初始Roll";
  parameter SI.Angle pitch "初始Pitch";
  parameter SI.Angle yaw "初始Yaw";
  parameter SI.AngularVelocity wx "初始本体X角速度";
  parameter SI.AngularVelocity wy "初始本体Y角速度";
  parameter SI.AngularVelocity wz "初始本体Z角速度";
  parameter Real batterySOC "电池初始SOC，0..1";
  parameter SI.Temperature batteryCellTemperature "蓄电池电芯初温";
  parameter SI.Temperature batteryEnclosureTemperature "蓄电池外壳初温";
  parameter SI.Temperature obcCpuTemperature "OBC CPU初温";
  parameter SI.Temperature obcBoardTemperature "OBC电路板初温";
  parameter SI.Temperature busDeckTemperature "内部设备舱板初温";
  parameter SI.Temperature externalShellTemperature "外表面等效热节点初温";
  parameter SI.Temperature pcduBoardTemperature "PCDU电路板初温";
  parameter SI.Temperature cameraOpticalBenchTemperature "对地观测相机光机结构初温";
  parameter SI.Temperature cameraFocalBoxTemperature "对地观测相机焦面盒初温";
  parameter Real dataRecorderStoredBytes(unit="1") "数据记录器初始存储量，byte";
  parameter SI.AngularVelocity wheelSpeed[4] "X/Y/Z/S飞轮初始角速度";
  annotation(Documentation(info="<html><h2>任务场景初始条件</h2><p><b>类路径：</b><code>OneSatSim.Scenarios.InitialConditionConfig</code>　<b>类型：</b>record</p><h3>用途与定位</h3><p>任务场景初始条件</p><h3>配置与调用</h3><p>由使用者声明或传入本类型；记录与常量保存静态配置，不单独代表一套物理状态。修改设计输入后应通过项目既有离线配置入口生成生效快照。</p><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>roll</code></td><td>SI.Angle</td><td>初始Roll</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>pitch</code></td><td>SI.Angle</td><td>初始Pitch</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>yaw</code></td><td>SI.Angle</td><td>初始Yaw</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>wx</code></td><td>SI.AngularVelocity</td><td>初始本体X角速度</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>wy</code></td><td>SI.AngularVelocity</td><td>初始本体Y角速度</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>wz</code></td><td>SI.AngularVelocity</td><td>初始本体Z角速度</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>batterySOC</code></td><td>Real</td><td>电池初始SOC，0..1</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>batteryCellTemperature</code></td><td>SI.Temperature</td><td>蓄电池电芯初温</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>batteryEnclosureTemperature</code></td><td>SI.Temperature</td><td>蓄电池外壳初温</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>obcCpuTemperature</code></td><td>SI.Temperature</td><td>OBC CPU初温</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>obcBoardTemperature</code></td><td>SI.Temperature</td><td>OBC电路板初温</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>busDeckTemperature</code></td><td>SI.Temperature</td><td>内部设备舱板初温</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>externalShellTemperature</code></td><td>SI.Temperature</td><td>外表面等效热节点初温</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>pcduBoardTemperature</code></td><td>SI.Temperature</td><td>PCDU电路板初温</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>cameraOpticalBenchTemperature</code></td><td>SI.Temperature</td><td>对地观测相机光机结构初温</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>cameraFocalBoxTemperature</code></td><td>SI.Temperature</td><td>对地观测相机焦面盒初温</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>dataRecorderStoredBytes</code></td><td>Real</td><td>数据记录器初始存储量，byte</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>wheelSpeed[4]</code></td><td>SI.AngularVelocity</td><td>X/Y/Z/S飞轮初始角速度</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Configuration", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Polygon(points={{-23.28,23.868},{-1.896,28.62},{7.212,21.096},{-14.172,16.344},{-23.28,23.868}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-23.28,23.868},{-14.172,16.344},{-14.172,-7.416},{-23.28,0.108},{-23.28,23.868}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-14.172,16.344},{7.212,21.096},{7.212,-2.664},{-14.172,-7.416},{-14.172,16.344}}, lineColor={0,0,0}, fillColor={246,247,248}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{-23.28,15.948},{-14.172,8.424},{7.212,13.176}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-23.28,8.028},{-14.172,0.504},{7.212,5.256}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-12.46128,16.72416},{-12.46128,-7.03584}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{5.50128,20.71584},{5.50128,-3.04416}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-23.28,23.868},{-14.172,-7.416}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-14.172,16.344},{-23.28,0.108}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-14.172,16.344},{7.212,-2.664}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{7.212,21.096},{-14.172,-7.416}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Ellipse(extent={{-11.796,21.096},{-5.46,26.244}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{-10.212,22.284},{-7.044,25.056}}, lineColor={0,0,0}, fillColor={223,233,238}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Ellipse(extent={{-23.9532,23.1948},{-22.6068,24.5412}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-23.6166,23.868},{-22.9434,23.868}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-14.8452,15.6708},{-13.4988,17.0172}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-14.5086,16.344},{-13.8354,16.344}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{6.5388,20.4228},{7.8852,21.7692}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{6.8754,21.096},{7.5486,21.096}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-23.9532,-0.5652},{-22.6068,0.7812}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-23.6166,0.108},{-22.9434,0.108}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-14.8452,-8.0892},{-13.4988,-6.7428}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-14.5086,-7.416},{-13.8354,-7.416}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{6.5388,-3.3372},{7.8852,-1.9908}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{6.8754,-2.664},{7.5486,-2.664}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{21,-3},{37.2,-3}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{21,-3},{12.576,7.368}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{21,-3},{21,13.2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-30,30.6},{-15,41.4},{2.4,40.2},{13.2,31.2}}, color={76,128,143}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{-37.8,10.2},{-35.4,-3.6},{-23.4,-13.2}}, color={76,128,143}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{7.8,12},{21.6,19.8},{37.2,19.8}}, color={76,128,143}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{7.8,12},{27,36.6}}, color={113,122,132}, thickness=0.55, pattern=LinePattern.Dash),
      Ellipse(extent={{25.8,33},{33,40.2}}, lineColor={76,128,143}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, startAngle=0, endAngle=360),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Initial Conditions", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Configuration", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Polygon(points={{-23.28,23.868},{-1.896,28.62},{7.212,21.096},{-14.172,16.344},{-23.28,23.868}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-23.28,23.868},{-14.172,16.344},{-14.172,-7.416},{-23.28,0.108},{-23.28,23.868}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-14.172,16.344},{7.212,21.096},{7.212,-2.664},{-14.172,-7.416},{-14.172,16.344}}, lineColor={0,0,0}, fillColor={246,247,248}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{-23.28,15.948},{-14.172,8.424},{7.212,13.176}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-23.28,8.028},{-14.172,0.504},{7.212,5.256}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-12.46128,16.72416},{-12.46128,-7.03584}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{5.50128,20.71584},{5.50128,-3.04416}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-23.28,23.868},{-14.172,-7.416}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-14.172,16.344},{-23.28,0.108}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-14.172,16.344},{7.212,-2.664}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{7.212,21.096},{-14.172,-7.416}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Ellipse(extent={{-11.796,21.096},{-5.46,26.244}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, startAngle=0, endAngle=360),
      Ellipse(extent={{-10.212,22.284},{-7.044,25.056}}, lineColor={0,0,0}, fillColor={223,233,238}, fillPattern=FillPattern.Solid, lineThickness=0.5, startAngle=0, endAngle=360),
      Ellipse(extent={{-23.9532,23.1948},{-22.6068,24.5412}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-23.6166,23.868},{-22.9434,23.868}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-14.8452,15.6708},{-13.4988,17.0172}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-14.5086,16.344},{-13.8354,16.344}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{6.5388,20.4228},{7.8852,21.7692}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{6.8754,21.096},{7.5486,21.096}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-23.9532,-0.5652},{-22.6068,0.7812}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-23.6166,0.108},{-22.9434,0.108}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-14.8452,-8.0892},{-13.4988,-6.7428}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{-14.5086,-7.416},{-13.8354,-7.416}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{6.5388,-3.3372},{7.8852,-1.9908}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.45, startAngle=0, endAngle=360),
      Line(points={{6.8754,-2.664},{7.5486,-2.664}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{21,-3},{37.2,-3}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{21,-3},{12.576,7.368}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{21,-3},{21,13.2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-30,30.6},{-15,41.4},{2.4,40.2},{13.2,31.2}}, color={76,128,143}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{-37.8,10.2},{-35.4,-3.6},{-23.4,-13.2}}, color={76,128,143}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{7.8,12},{21.6,19.8},{37.2,19.8}}, color={76,128,143}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{7.8,12},{27,36.6}}, color={113,122,132}, thickness=0.55, pattern=LinePattern.Dash),
      Ellipse(extent={{25.8,33},{33,40.2}}, lineColor={76,128,143}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, startAngle=0, endAngle=360),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Initial Conditions", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));
end InitialConditionConfig;