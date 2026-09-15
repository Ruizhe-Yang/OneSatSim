within OneSatSim.Scenarios.DesignConfigRecords;
record WheelXComponentConfig "wheelX硬件设计配置"
  parameter Modelica.Units.SI.AngularVelocity SpeedLimit
    "飞轮最大转速；Excel工程单位rad/s";
  parameter Real MotorEfficiency
    "平均电机效率；Excel工程单位1";
  parameter Modelica.Units.SI.Resistance StandbyResistance
    "飞轮驱动电子学待机电阻；Excel工程单位Ω";
  parameter Modelica.Units.SI.Torque MaxTorque
    "飞轮最大轴力矩；Excel工程单位N·m";
  parameter Modelica.Units.SI.Inertia RotorInertia
    "飞轮转子惯量；Excel工程单位kg·m²";
  parameter Real BearingDamping(unit="N.m.s/rad")
    "轴承等效黏性阻尼；Excel工程单位N·m·s/rad";
  parameter Modelica.Units.SI.HeatCapacity HeatCapacity
    "飞轮等效热容；Excel工程单位J/K";
  parameter Modelica.Units.SI.ThermalConductance MountConductance
    "飞轮安装导热；Excel工程单位W/K";
  parameter Real Axis_X
    "飞轮转轴方向X；Excel工程单位1";
  parameter Real Axis_Y
    "飞轮转轴方向Y；Excel工程单位1";
  parameter Real Axis_Z
    "飞轮转轴方向Z；Excel工程单位1";
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
end WheelXComponentConfig;
