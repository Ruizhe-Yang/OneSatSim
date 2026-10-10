within OneSatSim.Foundation.Interfaces;
expandable connector PayloadDataPort "载荷业务数据接口"
  RealSignal earthCameraWriteRate(unit="1/s") "字节写入率，数值单位byte/s";
  RealSignal acceptedEarthCameraWriteRate(unit="1/s") "acceptedEarthCameraWrite速率 [1/s]；Recorder-accepted Earth-image bytes per second";
  RealSignal rejectedEarthCameraWriteRate(unit="1/s") "rejectedEarthCameraWrite速率 [1/s]；Requested Earth-image bytes rejected before storage";
  IntegerSignal acceptedImagingRequestId "accepted成像请求Id；Existing mission request ID corresponding to accepted Earth-image writes";
  RealSignal selfieCameraWriteRate(unit="1/s") "字节写入率，数值单位byte/s";
  RealSignal acceptedSelfieWriteRate(unit="1/s") "acceptedSelfieWrite速率 [1/s]" ;
  RealSignal rejectedSelfieWriteRate(unit="1/s") "rejectedSelfieWrite速率 [1/s]" ;
  RealSignal downlinkReadRate(unit="1/s") "字节读取率，数值单位byte/s";
  RealSignal actualDownlinkReadRate(unit="1/s") "actual下传Read速率 [1/s]；Bytes successfully removed from payload storage after downlink";
  RealSignal requestedWriteRate(unit="1/s") "requestedWrite速率 [1/s]；Sum of requested camera write rates";
  RealSignal discardedBytesRate(unit="1/s") "记录器显式丢弃已存字节速率；名义工况应为零 [1/s]；Already stored invalid bytes removed per second; zero until explicit deletion exists";
  RealSignal storedBytes(unit="1") "存储量，数值单位byte";
  RealSignal capacityBytes(unit="1") "计算/接口量 capacityBytes [1]；Operational payload-buffer capacity in byte; may be a partition of installed NAND";
  RealSignal remainingBytes(unit="1") "计算/接口量 remainingBytes [1]；Remaining payload storage in byte";
  BooleanSignal dataAvailable "数据Available" ;
  BooleanSignal storageHigh "计算/接口量 storageHigh" ;
  BooleanSignal storageFull "计算/接口量 storageFull" ;
  annotation(Documentation(info="<html><h2>载荷业务数据接口</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.PayloadDataPort</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>载荷业务数据接口</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>earthCameraWriteRate</code></td><td>RealSignal</td><td>public</td><td>1/s</td><td>字节写入率，数值单位byte/s</td></tr><tr><td><code>acceptedEarthCameraWriteRate</code></td><td>RealSignal</td><td>public</td><td>1/s</td><td>acceptedEarthCameraWrite速率 [1/s]；Recorder-accepted Earth-image bytes per second</td></tr><tr><td><code>rejectedEarthCameraWriteRate</code></td><td>RealSignal</td><td>public</td><td>1/s</td><td>rejectedEarthCameraWrite速率 [1/s]；Requested Earth-image bytes rejected before storage</td></tr><tr><td><code>acceptedImagingRequestId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>accepted成像请求Id；Existing mission request ID corresponding to accepted Earth-image writes</td></tr><tr><td><code>selfieCameraWriteRate</code></td><td>RealSignal</td><td>public</td><td>1/s</td><td>字节写入率，数值单位byte/s</td></tr><tr><td><code>acceptedSelfieWriteRate</code></td><td>RealSignal</td><td>public</td><td>1/s</td><td>acceptedSelfieWrite速率 [1/s]</td></tr><tr><td><code>rejectedSelfieWriteRate</code></td><td>RealSignal</td><td>public</td><td>1/s</td><td>rejectedSelfieWrite速率 [1/s]</td></tr><tr><td><code>downlinkReadRate</code></td><td>RealSignal</td><td>public</td><td>1/s</td><td>字节读取率，数值单位byte/s</td></tr><tr><td><code>actualDownlinkReadRate</code></td><td>RealSignal</td><td>public</td><td>1/s</td><td>actual下传Read速率 [1/s]；Bytes successfully removed from payload storage after downlink</td></tr><tr><td><code>requestedWriteRate</code></td><td>RealSignal</td><td>public</td><td>1/s</td><td>requestedWrite速率 [1/s]；Sum of requested camera write rates</td></tr><tr><td><code>discardedBytesRate</code></td><td>RealSignal</td><td>public</td><td>1/s</td><td>记录器显式丢弃已存字节速率；名义工况应为零 [1/s]；Already stored invalid bytes removed per second; zero until explicit deletion exists</td></tr><tr><td><code>storedBytes</code></td><td>RealSignal</td><td>public</td><td>1</td><td>存储量，数值单位byte</td></tr><tr><td><code>capacityBytes</code></td><td>RealSignal</td><td>public</td><td>1</td><td>计算/接口量 capacityBytes [1]；Operational payload-buffer capacity in byte; may be a partition of installed NAND</td></tr><tr><td><code>remainingBytes</code></td><td>RealSignal</td><td>public</td><td>1</td><td>计算/接口量 remainingBytes [1]；Remaining payload storage in byte</td></tr><tr><td><code>dataAvailable</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>数据Available</td></tr><tr><td><code>storageHigh</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 storageHigh</td></tr><tr><td><code>storageFull</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 storageFull</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,82,204},lineColor={0,82,204},lineThickness=0,radius=0),
      Rectangle(extent={{-48,30},{48,46}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Rectangle(extent={{-48,-8},{48,8}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Rectangle(extent={{-48,-46},{48,-30}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,82,204},lineColor={0,82,204},lineThickness=0,radius=0),
      Rectangle(extent={{-48,30},{48,46}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Rectangle(extent={{-48,-8},{48,8}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0),
      Rectangle(extent={{-48,-46},{48,-30}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0)
    }));
end PayloadDataPort;