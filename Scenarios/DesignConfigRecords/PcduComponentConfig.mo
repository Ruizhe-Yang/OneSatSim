within OneSatSim.Scenarios.DesignConfigRecords;
record PcduComponentConfig "pcdu硬件设计配置"
  parameter Real RegulatorEfficiency12
    "12V主变换效率；Excel工程单位1";
  parameter Modelica.Units.SI.Voltage MinimumInputVoltage12
    "12V变换最低输入电压；Excel工程单位V";
  parameter Modelica.Units.SI.Current MaximumInputCurrent12
    "12V主变换最大输入电流；Excel工程单位A";
  parameter Modelica.Units.SI.Current MaximumOutputCurrent12
    "12V主变换最大输出电流；Excel工程单位A";
  parameter Modelica.Units.SI.Power MaximumOutputPower12
    "12V主变换最大输出功率；Excel工程单位W";
  parameter Modelica.Units.SI.Resistance OutputResistance12
    "12V输出等效内阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.Resistance OverloadDroop12
    "12V过载压降系数；Excel工程单位Ω";
  parameter Real Efficiency5V
    "5V变换效率；Excel工程单位1";
  parameter Modelica.Units.SI.Current CurrentLimit5V
    "5V电流上限；Excel工程单位A";
  parameter Modelica.Units.SI.Voltage NominalVoltage5V
    "5V名义输出电压；Excel工程单位V";
  parameter Modelica.Units.SI.Power PowerLimit5V
    "5V输出功率上限；Excel工程单位W";
  parameter Modelica.Units.SI.Voltage MinimumInputVoltage5V
    "5V变换最低输入电压；Excel工程单位V";
  parameter Modelica.Units.SI.Resistance OutputResistance5V
    "5V输出等效内阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.Resistance OverloadDroop5V
    "5V过载压降系数；Excel工程单位Ω";
  parameter Real Efficiency3V3
    "3.3V变换效率；Excel工程单位1";
  parameter Modelica.Units.SI.Current CurrentLimit3V3
    "3.3V电流上限；Excel工程单位A";
  parameter Modelica.Units.SI.Voltage NominalVoltage3V3
    "3.3V名义输出电压；Excel工程单位V";
  parameter Modelica.Units.SI.Power PowerLimit3V3
    "3.3V输出功率上限；Excel工程单位W";
  parameter Modelica.Units.SI.Voltage MinimumInputVoltage3V3
    "3.3V变换最低输入电压；Excel工程单位V";
  parameter Modelica.Units.SI.Resistance OutputResistance3V3
    "3.3V输出等效内阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.Resistance OverloadDroop3V3
    "3.3V过载压降系数；Excel工程单位Ω";
  parameter Modelica.Units.SI.Resistance HousekeepingResistance12
    "PCDU自耗等效电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.HeatCapacity BoardHeatCapacity
    "PCDU板等效热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.ThermalConductance MountConductance
    "PCDU安装导热；Excel工程单位W/K";
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
end PcduComponentConfig;
