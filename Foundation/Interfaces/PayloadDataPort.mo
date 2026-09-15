within OneSatSim.Foundation.Interfaces;
expandable connector PayloadDataPort "载荷业务数据接口"
  RealSignal earthCameraWriteRate(unit="1/s") "字节写入率，数值单位byte/s";
  RealSignal selfieCameraWriteRate(unit="1/s") "字节写入率，数值单位byte/s";
  RealSignal downlinkReadRate(unit="1/s") "字节读取率，数值单位byte/s";
  RealSignal storedBytes(unit="1") "存储量，数值单位byte";
  RealSignal capacityBytes(unit="1") "Operational payload-buffer capacity in byte; may be a partition of installed NAND";
  RealSignal remainingBytes(unit="1") "Remaining payload storage in byte";
  BooleanSignal dataAvailable;
  BooleanSignal storageHigh;
  BooleanSignal storageFull;
  annotation(Icon(graphics={Rectangle(extent={{-100,60},{100,-60}},lineColor={120,90,35},fillColor={249,241,224},fillPattern=FillPattern.Solid),Text(extent={{-90,22},{90,-18}},textString="PAYLOAD DATA")}),Documentation(info="<html><h4>接口语义</h4><p><b>用途：</b>描述图像/文件数据的写入、读出和存储量，不与传感器工程遥测分设总线</p><p><b>字段与单位：</b>earthCameraWriteRate、selfieCameraWriteRate、downlinkReadRate单位byte/s；storedBytes单位byte</p><p><b>信号方向语义：</b>相机提供写入率，X波段发射机提供读出率，记录器提供存储量</p><p><b>典型连接：</b>PayloadSystem、DataHandlingSystem、CommunicationSystem，经InformationOverall共总线</p><p><b>建模注意：</b>该接口是可扩展业务数据总线，不包含伪造flow变量；字段名称表达工程语义，不能仅凭曲线数组序号判断来源。</p></html>"));
end PayloadDataPort;
