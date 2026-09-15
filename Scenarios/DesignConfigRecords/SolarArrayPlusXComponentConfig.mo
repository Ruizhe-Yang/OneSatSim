within NISSA_12UCubeSat.Scenarios.DesignConfigRecords;
record SolarArrayPlusXComponentConfig "solarArrayPlusX硬件设计配置"
  parameter Modelica.Units.SI.Area ActiveArea
    "有效电池片面积；Excel工程单位m²";
  parameter Real CellEfficiency
    "太阳电池转换效率；Excel工程单位1";
  parameter Real SolarEOLFactor
    "太阳阵EOL性能系数；Excel工程单位1";
  parameter Boolean UseSolarEOL
    "启用太阳阵EOL；Excel工程单位Boolean";
  parameter Real MPPTDeliveryEfficiency
    "MPPT/线束交付效率；Excel工程单位1";
  parameter Real SolarAbsorptivity
    "太阳光吸收率；Excel工程单位1";
  parameter Real InfraredAbsorptivity
    "红外吸收率；Excel工程单位1";
  parameter Real Emissivity
    "红外发射率；Excel工程单位1";
  parameter Modelica.Units.SI.ThermalConductance MountConductance
    "面板安装导热；Excel工程单位W/K";
  parameter Modelica.Units.SI.Resistance HarnessResistance
    "太阳阵线束/阻断路径电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.HeatCapacity PanelHeatCapacity
    "面板等效热容；Excel工程单位J/K";
  parameter Real Normal_X
    "安装法向X；Excel工程单位1";
  parameter Real Normal_Y
    "安装法向Y；Excel工程单位1";
  parameter Real Normal_Z
    "安装法向Z；Excel工程单位1";
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
end SolarArrayPlusXComponentConfig;
