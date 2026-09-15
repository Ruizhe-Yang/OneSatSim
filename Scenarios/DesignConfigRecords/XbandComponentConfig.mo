within NISSA_12UCubeSat.Scenarios.DesignConfigRecords;
record XbandComponentConfig "xband硬件设计配置"
  parameter Real NominalDataRate(unit="1/s")
    "X波段名义数据率；Excel工程单位byte/s";
  parameter Real HighPerformanceDataRate(unit="1/s")
    "X波段高性能数据率；Excel工程单位byte/s";
  parameter Boolean UseHighPerformanceDataRate
    "启用高性能数据率；Excel工程单位Boolean";
  parameter Modelica.Units.SI.Resistance PowerAmplifierResistance
    "功率放大器等效负载电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.Resistance OutputMatchResistance
    "输出匹配串联损耗；Excel工程单位Ω";
  parameter Modelica.Units.SI.HeatCapacity PAHeatCapacity
    "功放等效热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.ThermalConductance RadiatorConductance
    "功放散热导热；Excel工程单位W/K";
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
end XbandComponentConfig;
