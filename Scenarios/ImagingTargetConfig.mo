within OneSatSim.Scenarios;
record ImagingTargetConfig "单个拍摄目标配置"
  import SI=Modelica.Units.SI;
  parameter Boolean enabled "是否参与可见性计算";
  parameter Integer id "用户定义的正整数标识";
  parameter String name "目标名称";
  parameter SI.Angle latitude "地理纬度";
  parameter SI.Angle longitude "地理经度";
  parameter SI.Length altitude "目标高度";
  parameter SI.Angle minimumElevation "最低仰角";
  parameter Integer priority "选择优先级；数值越大越优先";
  annotation(Documentation(info="<html><p>定义单个拍摄目标字段，不保存数值默认值。最多32个实例；经纬度和最低仰角为rad，高度为m；选择结果使用数组槽位1..32。</p></html>"));
end ImagingTargetConfig;
