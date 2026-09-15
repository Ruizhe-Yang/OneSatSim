within OneSatSim.Scenarios.DesignConfigRecords;
record BatteryComponentConfig "battery硬件设计配置"
  parameter Integer SeriesCellCount
    "串联电芯数；Excel工程单位1";
  parameter Integer ParallelCellCount
    "并联支路数；Excel工程单位1";
  parameter Modelica.Units.SI.ElectricCharge CellCapacity_Ah
    "单并支路电芯容量；Excel工程单位Ah";
  parameter Modelica.Units.SI.Voltage CellOCVMax
    "单体最高开路电压；Excel工程单位V";
  parameter Modelica.Units.SI.Voltage CellOCVMin
    "单体最低开路电压；Excel工程单位V";
  parameter Modelica.Units.SI.Resistance CellInternalResistance
    "单体内阻；Excel工程单位Ω";
  parameter Real CellSOCMin
    "电芯模型SOC下界；Excel工程单位1";
  parameter Real CellSOCMax
    "电芯模型SOC上界；Excel工程单位1";
  parameter Real EOLCapacityFactor
    "寿命末期容量系数；Excel工程单位1";
  parameter Boolean UseEOLCapacity
    "启用EOL容量；Excel工程单位Boolean";
  parameter Modelica.Units.SI.Resistance ContactResistance
    "电池主路径接触电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.Resistance HeaterResistance
    "电池加热器电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.HeatCapacity CellHeatCapacity
    "电芯等效热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.HeatCapacity EnclosureHeatCapacity
    "电池壳体等效热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.ThermalConductance InternalThermalConductance
    "电芯-壳体导热；Excel工程单位W/K";
  parameter Modelica.Units.SI.ThermalConductance MountThermalConductance
    "电池安装导热；Excel工程单位W/K";
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
end BatteryComponentConfig;
