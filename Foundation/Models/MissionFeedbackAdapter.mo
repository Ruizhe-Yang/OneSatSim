within OneSatSim.Foundation.Models;
model MissionFeedbackAdapter "物理状态到任务反馈的选择适配器"
  OneSatSim.Foundation.Interfaces.DeviceStatusBus device  "计算/接口量 device" annotation(Placement(visible=true, transformation(origin={-230,60}, extent={{-16,-16},{16,16}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.PayloadDataPort payload  "计算/接口量 payload" annotation(Placement(visible=true, transformation(origin={-230,-60}, extent={{-16,-16},{16,16}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.MissionFeedbackBus feedback  "反馈" annotation(Placement(visible=true, transformation(origin={230,0}, extent={{-18,-18},{18,18}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-12,-12},{12,12}}, rotation=0)));
protected
  Modelica.Blocks.Interfaces.RealOutput totalAvailableSolarPowerPublisher(unit="W")  "totalAvailableSolar功率Publisher [W]" annotation(Placement(visible=true, transformation(origin={110,55}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput totalDeliveredSolarPowerPublisher(unit="W")  "totalDeliveredSolar功率Publisher [W]" annotation(Placement(visible=true, transformation(origin={110,-55}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-6,-6},{6,6}}, rotation=0)));
equation
  feedback.batterySOC=device.batterySOC;
  feedback.busVoltage=device.busVoltage[1];
  feedback.generatedPower=sum(device.solarOutputPower[i] for i in 1:3);
  totalAvailableSolarPowerPublisher=sum(max(0,device.availableSolarPower[i]) for i in 1:3);
  totalDeliveredSolarPowerPublisher=sum(device.solarOutputPower[i] for i in 1:3);
  feedback.loadPower=device.threeRailOutputPower;
  feedback.batteryTemperature=0.5*(device.thermistorTemperature[31]+device.thermistorTemperature[32]);
  feedback.payloadTemperature=device.thermistorTemperature[30];
  feedback.transmitterTemperature=device.transmitterTemperature;
  feedback.attitudeError=device.attitudeError;
  feedback.attitudeSettled=device.attitudeSettled;
  feedback.imagingAttitudeReady=device.imagingAttitudeReady;
  feedback.groundLinkAttitudeReady=device.groundLinkAttitudeReady;
  feedback.attitudeEstimateValid=device.starStatus[1] > 0;
  feedback.wheelActuationAvailable=device.wheelStatus[1] > 0 and device.wheelStatus[2] > 0 and 
    device.wheelStatus[3] > 0 and device.wheelStatus[4] > 0;
  feedback.aocsAvailable=feedback.attitudeEstimateValid and feedback.wheelActuationAvailable;
  feedback.cameraReady=device.cameraStatus > 0;
  feedback.transmitterReady=device.transmitterStatus > 0;
  feedback.usedStorage=payload.storedBytes;
  feedback.capacityStorage=payload.capacityBytes;
  feedback.remainingStorage=payload.remainingBytes;
  feedback.storageUtilization=if payload.capacityBytes > 0 then max(0,min(1,payload.storedBytes/payload.capacityBytes)) else 0;
  feedback.downlinkReadRate=payload.downlinkReadRate;
  feedback.dataAvailable=payload.dataAvailable;
  feedback.storageHigh=payload.storageHigh;
  feedback.storageFull=payload.storageFull;
  connect(totalAvailableSolarPowerPublisher,device.totalAvailableSolarPower) annotation(Line(points={{110,55},{110,69.16},{-230,69.16},{-230,60}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));
  connect(totalDeliveredSolarPowerPublisher,device.totalDeliveredSolarPower) annotation(Line(points={{110,-55},{110,69.16},{-230,69.16},{-230,60}}, color={0,0,127}, thickness=0.35, pattern=LinePattern.Solid, smooth=Smooth.None));


  annotation(Documentation(info="<html><h2>物理状态到任务反馈的选择适配器</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Models.MissionFeedbackAdapter</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>物理状态到任务反馈的选择适配器</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.MissionControlUnit\">OneSatSim.Components.MissionControlUnit</a> 的 <code>physicalFeedback</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>device</code></td><td>OneSatSim.Foundation.Interfaces.DeviceStatusBus</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 device</td></tr><tr><td><code>payload</code></td><td>OneSatSim.Foundation.Interfaces.PayloadDataPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 payload</td></tr><tr><td><code>feedback</code></td><td>OneSatSim.Foundation.Interfaces.MissionFeedbackBus</td><td>public</td><td>按声明/类型合同</td><td>反馈</td></tr><tr><td><code>totalAvailableSolarPowerPublisher</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>protected</td><td>W</td><td>totalAvailableSolar功率Publisher [W]</td></tr><tr><td><code>totalDeliveredSolarPowerPublisher</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>protected</td><td>W</td><td>totalDeliveredSolar功率Publisher [W]</td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] feedback.batterySOC=device.batterySOC;\n[equation] feedback.busVoltage=device.busVoltage[1];\n[equation] feedback.generatedPower=sum(device.solarOutputPower[i] for i in 1:3);\n[equation] totalAvailableSolarPowerPublisher=sum(max(0,device.availableSolarPower[i]) for i in 1:3);\n[equation] totalDeliveredSolarPowerPublisher=sum(device.solarOutputPower[i] for i in 1:3);\n[equation] feedback.loadPower=device.threeRailOutputPower;\n[equation] feedback.batteryTemperature=0.5*(device.thermistorTemperature[31]+device.thermistorTemperature[32]);\n[equation] feedback.payloadTemperature=device.thermistorTemperature[30];\n[equation] feedback.transmitterTemperature=device.transmitterTemperature;\n[equation] feedback.attitudeError=device.attitudeError;</pre><p>本类另有16段语句；阅读完整源码可查看其余边界与逻辑。</p></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={83,131,109}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{60,-22},{39,-40}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{39,-31},{17,-31},{17,-15.5},{-3,-15.5}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{60,9},{39,-9}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{39,0},{17,0},{17,0},{-3,0}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{60,40},{39,22}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{39,31},{17,31},{17,15.5},{-3,15.5}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{-3,25},{-28,-25}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{-28,-15},{-45,-15},{-45,-30},{-68,-30}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-28,0},{-45,0},{-45,0},{-68,0}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-28,15},{-45,15},{-45,30},{-68,30}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-10,16},{-21,-16}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Mission Feedback", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-276,-106},{277,192}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-116.62,-56.26},{-13.38,55.1}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-109.08,37.12},{-20.92,37.12}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-113.72,40.02},{-102.12,51.62}}, lineColor={0,0,0}, fillColor={83,131,109}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-100.38,41.18},{-20.92,49.88}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-30.2,-12.76},{-42.38,-23.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{-42.38,-17.98},{-55.14,-17.98},{-55.14,-8.99},{-66.74,-8.99}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{-30.2,5.22},{-42.38,-5.22}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{-42.38,0},{-55.14,0},{-55.14,0},{-66.74,0}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{-30.2,23.2},{-42.38,12.76}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{-42.38,17.98},{-55.14,17.98},{-55.14,8.99},{-66.74,8.99}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{-66.74,14.5},{-81.24,-14.5}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{-81.24,-8.7},{-91.1,-8.7},{-91.1,-17.4},{-104.44,-17.4}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-81.24,0},{-91.1,0},{-91.1,0},{-104.44,0}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-81.24,8.7},{-91.1,8.7},{-91.1,17.4},{-104.44,17.4}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-70.8,9.28},{-77.18,-9.28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-109.08,-33.64},{-20.92,-33.64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-111.4,-45.82},{-18.6,-37.12}}, textString="Mission Feedback", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{75,104},{170,122}}, textString="SOLAR POWER", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-264,147},{265,176}}, textString="Mission Feedback Mapping", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-264,139},{265,139}}, color={215,220,226}, thickness=0.25)
    }));
end MissionFeedbackAdapter;