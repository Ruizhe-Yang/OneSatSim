within OneSatSim.Scenarios.DesignConfigRecords;
record StarZComponentConfig "starZ硬件设计配置"
  parameter Modelica.Units.SI.Resistance LoadResistance
    "starZ等效负载电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.HeatCapacity HeatCapacity
    "starZ等效热容；Excel工程单位J/K";
  parameter Real ThermalResistance(unit="K/W")
    "starZ安装热阻；Excel工程单位K/W";
  parameter Modelica.Units.SI.Resistance EMIResistance
    "Z星敏EMI等效串联电阻；Excel工程单位Ω";
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
end StarZComponentConfig;
