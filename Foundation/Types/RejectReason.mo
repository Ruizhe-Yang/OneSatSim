within OneSatSim.Foundation.Types;
type RejectReason = enumeration(None, LowSOC, LowBusVoltage, ThermalLimit, StorageFull, NoData, AttitudeUnavailable, Busy, InvalidState, Timeout, SafetyPreempted, TargetVisibilityLost, OffNadirLimit, CameraFOVLimit, TargetNotIlluminated, InsufficientOpportunityTime, StaleOpportunity, CameraUnavailable, DataWriteIncomplete, PreSlewOpportunityLost, TargetPreparationLost) "任务请求拒绝或中止原因" 
  annotation(Documentation(info="<html><h2>任务请求拒绝或中止原因</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Types.RejectReason</code>　<b>类型：</b>type</p><h3>用途与定位</h3><p>任务请求拒绝或中止原因</p><h3>配置与调用</h3><p>由使用者声明或传入本类型；记录与常量保存静态配置，不单独代表一套物理状态。修改设计输入后应通过项目既有离线配置入口生成生效快照。</p><h3>继承与复用</h3><p>本类的继承/别名声明如下。继承得到的端口、参数、状态和算法仍由被引用类定义，不重复增加一套行为。</p><pre>enumeration(None, LowSOC, LowBusVoltage, ThermalLimit, StorageFull, NoData, AttitudeUnavailable, Busy, InvalidState, Timeout, SafetyPreempted, TargetVisibilityLost, OffNadirLimit, CameraFOVLimit, TargetNotIlluminated, InsufficientOpportunityTime, StaleOpportunity, CameraUnavailable, DataWriteIncomplete, PreSlewOpportunityLost, TargetPreparationLost)</pre></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={196,94,56}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Type definition", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-72,23},{-29,23},{0,1}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-72,-23},{-29,-23},{0,1}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Polygon(points={{0,23},{23,1},{0,-21},{-23,1},{0,23}}, lineColor={0,0,0}, fillColor={239,232,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{23,1},{38,1},{38,26},{65,26}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{38,1},{38,-27},{65,-27}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{58,34},{63,30},{71,40}}, color={83,131,109}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{60,-40},{70,-30}}, color={196,94,56}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{60,-30},{70,-40}}, color={196,94,56}, thickness=0.8, pattern=LinePattern.Solid),
      Polygon(points={{-19,47},{0,55},{19,47},{14,29},{0,20},{-14,29},{-19,47}}, lineColor={196,94,56}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{-8,39},{-1,32},{10,45}}, color={83,131,109}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Rejection Reasons", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={196,94,56}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Type definition", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-72,23},{-29,23},{0,1}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-72,-23},{-29,-23},{0,1}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Polygon(points={{0,23},{23,1},{0,-21},{-23,1},{0,23}}, lineColor={0,0,0}, fillColor={239,232,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Line(points={{23,1},{38,1},{38,26},{65,26}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{38,1},{38,-27},{65,-27}}, color={0,0,0}, thickness=0.7, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{58,34},{63,30},{71,40}}, color={83,131,109}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{60,-40},{70,-30}}, color={196,94,56}, thickness=0.8, pattern=LinePattern.Solid),
      Line(points={{60,-30},{70,-40}}, color={196,94,56}, thickness=0.8, pattern=LinePattern.Solid),
      Polygon(points={{-19,47},{0,55},{19,47},{14,29},{0,20},{-14,29},{-19,47}}, lineColor={196,94,56}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{-8,39},{-1,32},{10,45}}, color={83,131,109}, thickness=0.75, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Rejection Reasons", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));