within NISSA_12UCubeSat.Components;
model FotonAmurPayloadUnit "科学载荷组件"
  parameter NISSA_12UCubeSat.Scenarios.DesignConfigRecords.FotonAmurComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance electronicsResistance=config.ElectronicsResistance
    "FotonAmur电子学负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.Resistance emiResistance=config.EMIResistance
    "FotonAmur EMI等效串联电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity heatCapacity=config.HeatCapacity
    "FotonAmur热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountConductance=config.MountConductance
    "FotonAmur安装导热；Excel单位W/K，当前设计基线";
  parameter Modelica.Units.SI.Mass mass=config.Mass
    "质量；Excel单位kg，当前设计基线";
  parameter Modelica.Units.SI.Length rcm_X=config.RCM_X
    "质心偏置X；Excel单位m，当前设计基线";
  parameter Modelica.Units.SI.Length rcm_Y=config.RCM_Y
    "质心偏置Y；Excel单位m，当前设计基线";
  parameter Modelica.Units.SI.Length rcm_Z=config.RCM_Z
    "质心偏置Z；Excel单位m，当前设计基线";
  parameter Modelica.Units.SI.Inertia inertia_XX=config.Inertia_XX
    "局部惯量 Ixx；Excel单位kg·m²，当前设计基线";
  parameter Modelica.Units.SI.Inertia inertia_YY=config.Inertia_YY
    "局部惯量 Iyy；Excel单位kg·m²，当前设计基线";
  parameter Modelica.Units.SI.Inertia inertia_ZZ=config.Inertia_ZZ
    "局部惯量 Izz；Excel单位kg·m²，当前设计基线";
  parameter Boolean fotonAmurMissionEnabled=config.MissionEnabled
    "任务级参数: dedicated Foton-Amur campaign is disabled in the nominal Earth-observation scenario";
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}}),iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Basic.Conductor unused5Rail(G=0) annotation(Placement(transformation(extent={{42,76},{54,88}})));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0) annotation(Placement(transformation(extent={{66,76},{78,88}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  Foundation.Interfaces.BooleanSignalReader missionOn annotation(Placement(transformation(extent={{-96,68},{-76,84}})));
  Foundation.Calculations.FotonAmurCalculation missionCalculation(missionEnabled=fotonAmurMissionEnabled)
    annotation(Placement(transformation(extent={{-68,64},{-42,86}})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch instrumentEnable annotation(Placement(transformation(extent={{-70,38},{-50,58}})));
  Modelica.Electrical.Analog.Basic.Resistor sensorElectronics(R=electronicsResistance,useHeatPort=true) annotation(Placement(transformation(extent={{-35,38},{-15,58}})));
  Modelica.Electrical.Analog.Basic.Resistor emiChoke(R=emiResistance) annotation(Placement(transformation(extent={{0,38},{20,58}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor sensorHead(C=heatCapacity,T(start=292.15,fixed=false)) annotation(Placement(transformation(extent={{-20,-45},{0,-25}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor deckPath(G=mountConductance) annotation(Placement(transformation(extent={{20,-43},{40,-27}})));
  Modelica.Mechanics.MultiBody.Parts.Body payloadBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-82,2},{-62,22}})));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[1] annotation(Placement(transformation(extent={{78,0},{86,8}})));
equation
  connect(information.command.missionOn,missionOn.u) annotation(Line(points={{100,0},{100,23.5},{-96,23.5},{-96,76}},color={255,0,255}));
  connect(missionOn.y,missionCalculation.missionOn) annotation(Line(points={{-76,76},{-68,76}},color={255,0,255}));
  connect(power.p5,unused5Rail.p) annotation(Line(points={{0,100},{0,94},{42,94},{42,82}},color={0,0,255}));
  connect(unused5Rail.n,power.n5) annotation(Line(points={{54,82},{54,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,82}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{78,82},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(missionCalculation.active,instrumentEnable.control) annotation(Line(points={{-43.3,77.85},{-38,77.85},{-38,62},{-60,62},{-60,60}},color={255,0,255}));
  connect(power.p12,instrumentEnable.p) annotation(Line(points={{0,100},{0,94},{-70,94},{-70,48}},color={0,0,255}));
  connect(instrumentEnable.n,sensorElectronics.p) annotation(Line(points={{-50,48},{-35,48}},color={0,0,255}));
  connect(sensorElectronics.n,emiChoke.p) annotation(Line(points={{-15,48},{0,48}},color={0,0,255}));
  connect(emiChoke.n,power.n12) annotation(Line(points={{20,48},{20,94},{0,94},{0,100}},color={0,0,255}));
  connect(missionCalculation.status,informationIntegerBridge[1].u) annotation(Line(points={{-43.3,70.15},{78,70.15},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[1].y,information.device.fotonAmurStatus) annotation(Line(points={{86,4},{94,4},{94,0},{100,0}},color={255,127,0}));
  connect(sensorElectronics.heatPort,sensorHead.port) annotation(Line(points={{-25,38},{-25,-25},{-10,-25}},color={191,0,0}));
  connect(sensorHead.port,deckPath.port_a) annotation(Line(points={{-10,-45},{-10,-35},{20,-35}},color={191,0,0}));
  connect(deckPath.port_b,thermal) annotation(Line(points={{40,-35},{40,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(payloadBody.frame_a,mechanical) annotation(Line(points={{-82,12},{-94,12},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={100,80,45},fillColor={247,240,225},fillPattern=FillPattern.Solid),Polygon(points={{-55,45},{55,45},{72,0},{55,-45},{-55,-45},{-72,0},{-55,45}},fillColor={205,180,125},fillPattern=FillPattern.Solid),Text(extent={{-92,-74},{92,-52}},textString="FOTON-AMUR / nID AF")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Text(extent={{-92,72},{92,58}},textString="专项任务门控-12 W有源负载-热容-安装导热")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>表示任务控制下工作的独立科学载荷及其电磁、热和机械特性</p><p><b>建模层级：</b>Components层设备级白箱；主要由Modelica 4.0.0标准库元件和图形连线组成</p><h4>实现与接口</h4><p><b>白箱实现：</b>由专项任务配置、任务开关、约12 W传感电子学电阻、EMI串联损耗、热容、安装导热和刚体组成</p><p><b>对外接口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、information（InformationPort）</p><h4>工作行为与状态</h4><p><b>运行行为：</b>只有fotonAmurMissionEnabled=true且missionOn有效时仪器上电；默认Earth-observation场景保持断电，不把独立科学载荷错误解释为非Safe即常开。额定Active功耗未降低。</p><p><b>关键参数：</b>专项任务使能、12 ohm有源负载、热容和安装导热</p><p><b>关键状态：</b>设备使能、电流和传感头温度</p><p><b>信息路径：</b>设备状态经唯一InformationPort供OBC采集。</p></html>"));
end FotonAmurPayloadUnit;
