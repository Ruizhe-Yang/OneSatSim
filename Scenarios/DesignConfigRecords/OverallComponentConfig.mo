within OneSatSim.Scenarios.DesignConfigRecords;
record OverallComponentConfig "overall硬件设计配置"
  parameter Real BodySolarAbsorptivity
    "裸露本体太阳吸收率；Excel工程单位1";
  parameter Real BodyInfraredAbsorptivity
    "裸露本体红外吸收率；Excel工程单位1";
  parameter Real ExternalEmissivity
    "裸露本体发射率；Excel工程单位1";
  parameter Modelica.Units.SI.HeatCapacity BusDeckHeatCapacity
    "内部设备舱板热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.HeatCapacity ExternalShellHeatCapacity
    "外表面热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.ThermalConductance ShellToBusConductance
    "外壳-舱板导热；Excel工程单位W/K";
  annotation(Documentation(info="<html><h4>功能定位</h4><p>保存该设备可由设计配置层修改的硬件、功能、机械和热参数。记录本身不含数值默认值；统一默认值由DefaultSpacecraftDesignConfig给出。</p></html>"));
end OverallComponentConfig;
