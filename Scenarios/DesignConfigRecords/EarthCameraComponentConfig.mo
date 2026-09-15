within OneSatSim.Scenarios.DesignConfigRecords;
record EarthCameraComponentConfig "earthCamera硬件设计配置"
  parameter Real RawImageSize(unit="1")
    "单景原始数据量；Excel工程单位byte";
  parameter Real StoredImageSize(unit="1")
    "单景存储数据量；Excel工程单位byte";
  parameter Modelica.Units.SI.Time CaptureDuration
    "成像持续时间；Excel工程单位s";
  parameter Modelica.Units.SI.Resistance FocalElectronicsResistance
    "焦面电子学负载电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.Resistance FocalHeaterResistance
    "焦面加热器电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.HeatCapacity OpticalBenchHeatCapacity
    "光机结构热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.HeatCapacity FocalBoxHeatCapacity
    "焦面盒热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.ThermalConductance OpticalMountConductance
    "光机结构安装导热；Excel工程单位W/K";
  parameter Modelica.Units.SI.ThermalConductance FocalCouplingConductance
    "焦面-光机耦合导热；Excel工程单位W/K";
  parameter Modelica.Units.SI.ThermalConductance FocalMountConductance
    "焦面盒安装导热；Excel工程单位W/K";
  parameter Modelica.Units.SI.Mass Mass
    "质量；Excel工程单位kg";
  parameter Modelica.Units.SI.Length RCM_X
    "质心偏置X；Excel工程单位m";
  parameter Modelica.Units.SI.Length RCM_Y
    "质心偏置Y；Excel工程单位m";
  parameter Modelica.Units.SI.Length RCM_Z
    "质心偏置Z；Excel工程单位m";
  parameter Modelica.Units.SI.Inertia Inertia_XX
    "局部惯量 Ixx；Excel工程单位kg·m²";
  parameter Modelica.Units.SI.Inertia Inertia_YY
    "局部惯量 Iyy；Excel工程单位kg·m²";
  parameter Modelica.Units.SI.Inertia Inertia_ZZ
    "局部惯量 Izz；Excel工程单位kg·m²";
  annotation(Documentation(info="<html><h4>功能定位</h4><p>保存该设备可由设计配置层修改的硬件、功能、机械和热参数。记录本身不含数值默认值；统一默认值由DefaultSpacecraftDesignConfig给出。</p></html>"));
end EarthCameraComponentConfig;
