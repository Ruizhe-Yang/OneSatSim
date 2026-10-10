within OneSatSim.Foundation.Calculations;
model DataRecorderCalculation "星上数据记录器业务量计算"
  parameter Real capacity(unit="1")=128e9 "可用存储容量，byte";
  Modelica.Blocks.Interfaces.RealInput earthCameraWriteRate  "字节写入率，数值单位byte/s" annotation(Placement(visible=true, transformation(origin={-270,77}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput selfieCameraWriteRate  "字节写入率，数值单位byte/s" annotation(Placement(visible=true, transformation(origin={-270,45}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,40}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput downlinkReadRate  "字节读取率，数值单位byte/s" annotation(Placement(visible=true, transformation(origin={-270,-45}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput storedBytes  "有效存储量" annotation(Placement(visible=true, transformation(origin={-270,-77}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-40}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput imagingRequestId
    "成像请求Id；The existing mission request identifier, without a second counter" 
    annotation(Placement(visible=true, transformation(origin={-270,13}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput netRate  "net速率" annotation(Placement(visible=true, transformation(origin={270,-169}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-3.938462,-3.938462},{3.938462,3.938462}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput capacityBytes  "计算/接口量 capacityBytes" annotation(Placement(visible=true, transformation(origin={270,195}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,67.692308}, extent={{-3.938462,-3.938462},{3.938462,3.938462}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput remainingBytes  "计算/接口量 remainingBytes" annotation(Placement(visible=true, transformation(origin={270,169}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,55.384615}, extent={{-3.938462,-3.938462},{3.938462,3.938462}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput dataAvailable  "数据Available" annotation(Placement(visible=true, transformation(origin={270,143}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,43.076923}, extent={{-3.938462,-3.938462},{3.938462,3.938462}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput storageHigh  "计算/接口量 storageHigh" annotation(Placement(visible=true, transformation(origin={270,117}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,30.769231}, extent={{-3.938462,-3.938462},{3.938462,3.938462}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput storageFull  "计算/接口量 storageFull" annotation(Placement(visible=true, transformation(origin={270,91}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,18.461538}, extent={{-3.938462,-3.938462},{3.938462,3.938462}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput requestedWriteRate(unit="1/s") 
     "requestedWrite速率 [1/s]" annotation(Placement(visible=true, transformation(origin={270,39}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,6.153846}, extent={{-3.938462,-3.938462},{3.938462,3.938462}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput acceptedEarthCameraWriteRate(unit="1/s") 
     "acceptedEarthCameraWrite速率 [1/s]" annotation(Placement(visible=true, transformation(origin={270,13}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-6.153846}, extent={{-3.938462,-3.938462},{3.938462,3.938462}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput rejectedEarthCameraWriteRate(unit="1/s") 
     "rejectedEarthCameraWrite速率 [1/s]" annotation(Placement(visible=true, transformation(origin={270,-13}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-18.461538}, extent={{-3.938462,-3.938462},{3.938462,3.938462}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput acceptedSelfieWriteRate(unit="1/s") 
     "acceptedSelfieWrite速率 [1/s]" annotation(Placement(visible=true, transformation(origin={270,-39}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-30.769231}, extent={{-3.938462,-3.938462},{3.938462,3.938462}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput rejectedSelfieWriteRate(unit="1/s") 
     "rejectedSelfieWrite速率 [1/s]" annotation(Placement(visible=true, transformation(origin={270,-65}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-43.076923}, extent={{-3.938462,-3.938462},{3.938462,3.938462}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput actualDownlinkReadRate(unit="1/s") 
     "actual下传Read速率 [1/s]" annotation(Placement(visible=true, transformation(origin={270,-143}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-55.384615}, extent={{-3.938462,-3.938462},{3.938462,3.938462}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput discardedBytesRate(unit="1/s")
    "记录器显式丢弃已存字节速率；名义工况应为零 [1/s]；Removal of already stored invalid files; zero while no deletion behavior exists" 
    annotation(Placement(visible=true, transformation(origin={270,-91}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-67.692308}, extent={{-3.938462,-3.938462},{3.938462,3.938462}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput acceptedImagingRequestId 
     "accepted成像请求Id" annotation(Placement(visible=true, transformation(origin={270,-195}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-3.938462,-3.938462},{3.938462,3.938462}}, rotation=0)));
protected
  Real positiveEarthRate(unit="1/s") "positiveEarth速率 [1/s]" ;
  Real positiveSelfieRate(unit="1/s") "positiveSelfie速率 [1/s]" ;
  Real requestedReadRate(unit="1/s") "requestedRead速率 [1/s]" ;
equation
  positiveEarthRate=max(0,earthCameraWriteRate);
  positiveSelfieRate=max(0,selfieCameraWriteRate);
  requestedReadRate=max(0,downlinkReadRate);
  requestedWriteRate=positiveEarthRate+positiveSelfieRate;
  // At capacity, successful readout can free space at the same rate. Earth
  // imaging has priority over the independent selfie stream in this boundary case.
  acceptedEarthCameraWriteRate=if storedBytes >= capacity then 
    min(positiveEarthRate,requestedReadRate) else positiveEarthRate;
  acceptedSelfieWriteRate=if storedBytes >= capacity then 
    min(positiveSelfieRate,max(0,requestedReadRate-acceptedEarthCameraWriteRate)) 
    else positiveSelfieRate;
  rejectedEarthCameraWriteRate=positiveEarthRate-acceptedEarthCameraWriteRate;
  rejectedSelfieWriteRate=positiveSelfieRate-acceptedSelfieWriteRate;
  actualDownlinkReadRate=if storedBytes <= 0 then 
    min(requestedReadRate,acceptedEarthCameraWriteRate+acceptedSelfieWriteRate) 
    else requestedReadRate;
  discardedBytesRate=0;
  netRate=acceptedEarthCameraWriteRate+acceptedSelfieWriteRate-
    actualDownlinkReadRate-discardedBytesRate;
  acceptedImagingRequestId=if acceptedEarthCameraWriteRate > 0 then 
    imagingRequestId else 0;
  capacityBytes=capacity;
  remainingBytes=max(0,capacity-storedBytes);
  dataAvailable=storedBytes > 1;
  storageHigh=storedBytes >= 0.80*capacity;
  storageFull=storedBytes >= 0.90*capacity;
  assert(noEvent(storedBytes >= -1e-4 and storedBytes <= capacity+1e-4),
    "Recorder inventory outside supported physical bounds",level=AssertionLevel.error);
  annotation(Documentation(info="<html><h2>星上数据记录器业务量计算</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Calculations.DataRecorderCalculation</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>星上数据记录器业务量计算</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.DataRecorderUnit\">OneSatSim.Components.DataRecorderUnit</a> 的 <code>recorderCalculation</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>earthCameraWriteRate</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>按声明/类型合同</td><td>字节写入率，数值单位byte/s</td></tr><tr><td><code>selfieCameraWriteRate</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>按声明/类型合同</td><td>字节写入率，数值单位byte/s</td></tr><tr><td><code>downlinkReadRate</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>按声明/类型合同</td><td>字节读取率，数值单位byte/s</td></tr><tr><td><code>storedBytes</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>按声明/类型合同</td><td>有效存储量</td></tr><tr><td><code>imagingRequestId</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>成像请求Id；The existing mission request identifier, without a second counter</td></tr><tr><td><code>netRate</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>net速率</td></tr><tr><td><code>capacityBytes</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 capacityBytes</td></tr><tr><td><code>remainingBytes</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 remainingBytes</td></tr><tr><td><code>dataAvailable</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>数据Available</td></tr><tr><td><code>storageHigh</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 storageHigh</td></tr><tr><td><code>storageFull</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 storageFull</td></tr><tr><td><code>requestedWriteRate</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>1/s</td><td>requestedWrite速率 [1/s]</td></tr><tr><td><code>acceptedEarthCameraWriteRate</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>1/s</td><td>acceptedEarthCameraWrite速率 [1/s]</td></tr><tr><td><code>rejectedEarthCameraWriteRate</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>1/s</td><td>rejectedEarthCameraWrite速率 [1/s]</td></tr><tr><td><code>acceptedSelfieWriteRate</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>1/s</td><td>acceptedSelfieWrite速率 [1/s]</td></tr><tr><td><code>rejectedSelfieWriteRate</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>1/s</td><td>rejectedSelfieWrite速率 [1/s]</td></tr><tr><td><code>actualDownlinkReadRate</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>1/s</td><td>actual下传Read速率 [1/s]</td></tr><tr><td><code>discardedBytesRate</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>1/s</td><td>记录器显式丢弃已存字节速率；名义工况应为零 [1/s]；Removal of already stored invalid files; zero while no deletion behavior exists</td></tr><tr><td><code>acceptedImagingRequestId</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>accepted成像请求Id</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>capacity</code></td><td>Real</td><td>可用存储容量，byte</td><td><code>=128e9</code></td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] positiveEarthRate=max(0,earthCameraWriteRate);\n[equation] positiveSelfieRate=max(0,selfieCameraWriteRate);\n[equation] requestedReadRate=max(0,downlinkReadRate);\n[equation] requestedWriteRate=positiveEarthRate+positiveSelfieRate;\n[equation] acceptedEarthCameraWriteRate=if storedBytes &gt;= capacity then min(positiveEarthRate,requestedReadRate) else positiveEarthRate;\n[equation] acceptedSelfieWriteRate=if storedBytes &gt;= capacity then min(positiveSelfieRate,max(0,requestedReadRate-acceptedEarthCameraWriteRate)) else positiveSelfieRate;\n[equation] rejectedEarthCameraWriteRate=positiveEarthRate-acceptedEarthCameraWriteRate;\n[equation] rejectedSelfieWriteRate=positiveSelfieRate-acceptedSelfieWriteRate;\n[equation] actualDownlinkReadRate=if storedBytes &lt;= 0 then min(requestedReadRate,acceptedEarthCameraWriteRate+acceptedSelfieWriteRate) else requestedReadRate;\n[equation] discardedBytesRate=0;</pre><p>本类另有8段语句；阅读完整源码可查看其余边界与逻辑。</p><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>positiveEarthRate</code></td><td>Real</td><td>protected</td><td>1/s</td><td>positiveEarth速率 [1/s]</td></tr><tr><td><code>positiveSelfieRate</code></td><td>Real</td><td>protected</td><td>1/s</td><td>positiveSelfie速率 [1/s]</td></tr><tr><td><code>requestedReadRate</code></td><td>Real</td><td>protected</td><td>1/s</td><td>requestedRead速率 [1/s]</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={83,131,109}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Data calculation", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-53.72,-18.48},{11.8,32.64}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Rectangle(extent={{-45.08,-10.56},{-28.52,4.56}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{-47.96,-7.68},{-45.08,-7.68}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-28.52,-7.68},{-25.64,-7.68}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-47.96,-3.36},{-45.08,-3.36}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-28.52,-3.36},{-25.64,-3.36}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-47.96,0.96},{-45.08,0.96}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-28.52,0.96},{-25.64,0.96}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Rectangle(extent={{-45.08,10.32},{-28.52,25.44}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{-47.96,13.2},{-45.08,13.2}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-28.52,13.2},{-25.64,13.2}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-47.96,17.52},{-45.08,17.52}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-28.52,17.52},{-25.64,17.52}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-47.96,21.84},{-45.08,21.84}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-28.52,21.84},{-25.64,21.84}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Rectangle(extent={{-20.6,-10.56},{-4.04,4.56}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{-23.48,-7.68},{-20.6,-7.68}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-4.04,-7.68},{-1.16,-7.68}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-23.48,-3.36},{-20.6,-3.36}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-4.04,-3.36},{-1.16,-3.36}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-23.48,0.96},{-20.6,0.96}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-4.04,0.96},{-1.16,0.96}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Rectangle(extent={{-20.6,10.32},{-4.04,25.44}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{-23.48,13.2},{-20.6,13.2}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-4.04,13.2},{-1.16,13.2}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-23.48,17.52},{-20.6,17.52}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-4.04,17.52},{-1.16,17.52}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-23.48,21.84},{-20.6,21.84}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-4.04,21.84},{-1.16,21.84}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-67.4,22.56},{-56.6,22.56}}, color={83,131,109}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{14.68,-1.92},{32.68,-1.92}}, color={83,131,109}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{17.56,18.24},{31.96,22.56}}, lineColor={0,0,0}, fillColor={227,240,232}, fillPattern=FillPattern.Solid, lineThickness=0.4, radius=0),
      Rectangle(extent={{17.56,25.44},{31.96,29.76}}, lineColor={0,0,0}, fillColor={227,240,232}, fillPattern=FillPattern.Solid, lineThickness=0.4, radius=0),
      Rectangle(extent={{17.56,32.64},{31.96,36.96}}, lineColor={0,0,0}, fillColor={227,240,232}, fillPattern=FillPattern.Solid, lineThickness=0.4, radius=0),
      Line(points={{-47.96,-24.96},{6.04,-24.96}}, color={113,122,132}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-47.96,-24.96},{-11.24,-24.96}}, color={83,131,109}, thickness=2, pattern=LinePattern.Solid),
      Rectangle(extent={{43,-31},{72,28}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{47,15},{68,15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,0},{68,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,-15},{68,-15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-57,-51},{37,-34}}, textString="write - read", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Storage Flow Balance", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-314,-239},{348.8,299}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-78.32,-85.36},{78.32,83.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-66.88,56.32},{66.88,56.32}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-73.92,60.72},{-56.32,78.32}}, lineColor={0,0,0}, fillColor={83,131,109}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-53.68,62.48},{66.88,75.68}}, textString="Data calculation", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-47.2736,-16.2624},{10.384,28.7232}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Rectangle(extent={{-39.6704,-9.2928},{-25.0976,4.0128}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{-42.2048,-6.7584},{-39.6704,-6.7584}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-25.0976,-6.7584},{-22.5632,-6.7584}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42.2048,-2.9568},{-39.6704,-2.9568}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-25.0976,-2.9568},{-22.5632,-2.9568}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42.2048,0.8448},{-39.6704,0.8448}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-25.0976,0.8448},{-22.5632,0.8448}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Rectangle(extent={{-39.6704,9.0816},{-25.0976,22.3872}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{-42.2048,11.616},{-39.6704,11.616}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-25.0976,11.616},{-22.5632,11.616}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42.2048,15.4176},{-39.6704,15.4176}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-25.0976,15.4176},{-22.5632,15.4176}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42.2048,19.2192},{-39.6704,19.2192}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-25.0976,19.2192},{-22.5632,19.2192}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Rectangle(extent={{-18.128,-9.2928},{-3.5552,4.0128}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{-20.6624,-6.7584},{-18.128,-6.7584}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-3.5552,-6.7584},{-1.0208,-6.7584}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-20.6624,-2.9568},{-18.128,-2.9568}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-3.5552,-2.9568},{-1.0208,-2.9568}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-20.6624,0.8448},{-18.128,0.8448}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-3.5552,0.8448},{-1.0208,0.8448}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Rectangle(extent={{-18.128,9.0816},{-3.5552,22.3872}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{-20.6624,11.616},{-18.128,11.616}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-3.5552,11.616},{-1.0208,11.616}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-20.6624,15.4176},{-18.128,15.4176}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-3.5552,15.4176},{-1.0208,15.4176}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-20.6624,19.2192},{-18.128,19.2192}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-3.5552,19.2192},{-1.0208,19.2192}}, color={0,0,0}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-59.312,19.8528},{-49.808,19.8528}}, color={83,131,109}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{12.9184,-1.6896},{28.7584,-1.6896}}, color={83,131,109}, thickness=0.9, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{15.4528,16.0512},{28.1248,19.8528}}, lineColor={0,0,0}, fillColor={227,240,232}, fillPattern=FillPattern.Solid, lineThickness=0.4, radius=0),
      Rectangle(extent={{15.4528,22.3872},{28.1248,26.1888}}, lineColor={0,0,0}, fillColor={227,240,232}, fillPattern=FillPattern.Solid, lineThickness=0.4, radius=0),
      Rectangle(extent={{15.4528,28.7232},{28.1248,32.5248}}, lineColor={0,0,0}, fillColor={227,240,232}, fillPattern=FillPattern.Solid, lineThickness=0.4, radius=0),
      Line(points={{-42.2048,-21.9648},{5.3152,-21.9648}}, color={113,122,132}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-42.2048,-21.9648},{-9.8912,-21.9648}}, color={83,131,109}, thickness=2, pattern=LinePattern.Solid),
      Rectangle(extent={{37.84,-27.28},{63.36,24.64}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{41.36,13.2},{59.84,13.2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{41.36,0},{59.84,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{41.36,-13.2},{59.84,-13.2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-50.16,-44.88},{32.56,-29.92}}, textString="write - read", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-66.88,-51.04},{66.88,-51.04}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-70.4,-69.52},{70.4,-56.32}}, textString="Storage Flow Balance", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{222,211},{317,229}}, textString="CAPACITY", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{222,55},{317,73}}, textString="WRITE FLOW", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{222,-127},{322.8,-109}}, textString="READ / STATE", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-302,254},{336.8,283}}, textString="Data Recorder", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-302,246},{336.8,246}}, color={215,220,226}, thickness=0.25)
    }));
end DataRecorderCalculation;