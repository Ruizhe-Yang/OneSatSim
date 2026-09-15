within NISSA_12UCubeSat.Scenarios.DesignConfigRecords;
record StructureComponentConfig "structure硬件设计配置"
  parameter Modelica.Units.SI.Mass PrimaryStructureMass
    "主结构总质量；Excel工程单位kg";
  parameter Modelica.Units.SI.Length PrimaryFrameWidth
    "主框架宽度；Excel工程单位m";
  parameter Modelica.Units.SI.Length PrimaryFrameHeight
    "主框架高度；Excel工程单位m";
  parameter Modelica.Units.SI.Length PrimaryFrameLength
    "主框架长度；Excel工程单位m";
  parameter Modelica.Units.SI.Length PayloadDeckOffsetZ
    "载荷舱板安装偏置Z；Excel工程单位m";
  parameter Modelica.Units.SI.Length AvionicsDeckOffsetZ
    "电子舱板安装偏置Z；Excel工程单位m";
  parameter Modelica.Units.SI.Length LowerDeckWidth
    "下舱板宽度；Excel工程单位m";
  parameter Modelica.Units.SI.Length LowerDeckHeight
    "下舱板高度；Excel工程单位m";
  parameter Modelica.Units.SI.Length LowerDeckThickness
    "下舱板厚度；Excel工程单位m";
  parameter Modelica.Units.SI.Density LowerDeckDensity
    "下舱板等效密度；Excel工程单位kg/m³";
  parameter Modelica.Units.SI.HeatCapacity RailHeatCapacity
    "导轨热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.HeatCapacity PanelHeatCapacity
    "结构面板热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.ThermalConductance RailPanelConductance
    "导轨-面板导热；Excel工程单位W/K";
  parameter Modelica.Units.SI.ThermalConductance MountInterfaceConductance
    "结构安装界面导热；Excel工程单位W/K";
  annotation(Documentation(info="<html><h4>功能定位</h4><p>保存该设备可由设计配置层修改的硬件、功能、机械和热参数。记录本身不含数值默认值；统一默认值由DefaultSpacecraftDesignConfig给出。</p></html>"));
end StructureComponentConfig;
