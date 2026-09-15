within OneSatSim.Components;
model AntennaUnit "X波段贴片与测控天线组件"
  parameter OneSatSim.Scenarios.DesignConfigRecords.AntennaComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.HeatCapacity patchHeatCapacity=config.PatchHeatCapacity
    "天线贴片等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance rfDeckConductance=config.RFDeckConductance
    "天线射频舱板导热；Excel单位W/K，当前设计基线";
  parameter Modelica.Units.SI.Length mastOffsetZ=config.MastOffsetZ
    "天线桅杆Z向安装偏置；Excel单位m，当前设计基线";
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
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor patchNode(C=patchHeatCapacity,T(start=288.15,fixed=false)) annotation(Placement(transformation(extent={{-30,-25},{-10,-5}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor rfDeck(G=rfDeckConductance) annotation(Placement(transformation(extent={{10,-23},{30,-7}})));
  Modelica.Mechanics.MultiBody.Parts.Body antennaMass(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-52,0},{-32,20}})));
  Modelica.Mechanics.MultiBody.Parts.FixedTranslation antennaMast(r={0,0,mastOffsetZ}) annotation(Placement(transformation(extent={{-80,0},{-60,20}})));
equation
  connect(mechanical,antennaMast.frame_a) annotation(Line(points={{-100,0},{-94,0},{-94,10},{-80,10}},color={95,95,95},thickness=0.5));
  connect(antennaMast.frame_b,antennaMass.frame_a) annotation(Line(points={{-60,10},{-52,10}},color={95,95,95},thickness=0.5));
  connect(patchNode.port,rfDeck.port_a) annotation(Line(points={{-20,-25},{-20,-15},{10,-15}},color={191,0,0}));
  connect(rfDeck.port_b,thermal) annotation(Line(points={{30,-15},{30,-94},{0,-94},{0,-100}},color={191,0,0}));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={35,90,135},fillColor={230,241,248},fillPattern=FillPattern.Solid),Rectangle(extent={{-40,40},{40,-25}},fillColor={120,175,205},fillPattern=FillPattern.Solid),Line(points={{-40,40},{-75,72}},color={35,90,135},thickness=2),Line(points={{40,40},{75,72}},color={35,90,135},thickness=2),Line(points={{-40,-25},{-75,-65}},color={35,90,135},thickness=2),Line(points={{40,-25},{75,-65}},color={35,90,135},thickness=2),Text(extent={{-92,-74},{92,-52}},textString="X PATCH + 4 TTC")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Text(extent={{-90,72},{90,60}},textString="天线桅杆质量-贴片热节点")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>为通信分系统提供天线安装质量、射频舱板热节点和设备在位状态</p><p><b>建模层级：</b>Components层设备级白箱；主要由Modelica 4.0.0标准库元件和图形连线组成</p><h4>实现与接口</h4><p><b>白箱实现：</b>以HeatCapacitor和ThermalConductor描述贴片与射频舱板热惯性，以Body和FixedTranslation描述天线质量及桅杆偏置</p><p><b>关键内部元件：</b>patchNode（HeatCapacitor）、rfDeck（ThermalConductor）、antennaMass（Body）、antennaMast（FixedTranslation）</p><p><b>对外接口：</b>mechanical（MechanicalPort）、information（InformationPort）</p><h4>工作行为与状态</h4><p><b>运行行为：</b>无主动电负载；机械端随本体运动，热节点经安装路径交换热量，信息总线报告天线设备状态</p><p><b>关键参数：</b>贴片热容、射频舱板导热、0.24 kg天线质量和0.22 m安装偏置</p><p><b>关键状态：</b>贴片温度及多体机械状态</p><p><b>物理域：</b>机械、热、信息</p><h4>信息与遥测关系</h4><p><b>数据路径：</b>天线自身不形成独立工程字段，其状态经通信设备汇总后由信息总线进入通信状态项</p><p><b>使用说明：</b>设备测量与机器反馈均写入同一个InformationPort.device语义域；不存在平行的传感器遥测接口。应从N-System画布下钻本组件，并结合总体公共电/热/机械网络解释结果。</p></html>"));
end AntennaUnit;
