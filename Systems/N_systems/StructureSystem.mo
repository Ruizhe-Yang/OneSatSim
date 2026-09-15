within NISSA_12UCubeSat.Systems.N_systems;
model StructureSystem "结构分系统"
  parameter NISSA_12UCubeSat.Scenarios.DesignConfigRecords.StructureDesignConfig designConfig "分系统硬件设计配置";
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-112,-10},{-92,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{92,-10},{112,10}})));
  Modelica.Electrical.Analog.Basic.Conductor unused12Rail(G=0) annotation(Placement(transformation(extent={{-80,62},{-60,78}})));
  Modelica.Electrical.Analog.Basic.Conductor unused5Rail(G=0) annotation(Placement(transformation(extent={{-10,62},{10,78}})));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=1e-9) annotation(Placement(transformation(extent={{60,62},{80,78}})));
  Components.StructureAssembly12U structure(config=designConfig.structure) annotation(Placement(transformation(extent={{-42,-47},{42,37}})));
equation
  connect(power.p12,unused12Rail.p) annotation(Line(points={{0,100},{-92,100},{-92,70},{-80,70}},color={0,0,255}));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{-60,70},{-54,70},{-54,88},{-6,88},{-6,100},{0,100}},color={0,0,255}));
  connect(power.p5,unused5Rail.p) annotation(Line(points={{0,100},{-20,100},{-20,70},{-10,70}},color={0,0,255}));
  connect(unused5Rail.n,power.n5) annotation(Line(points={{10,70},{20,70},{20,92},{4,92},{4,100},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{52,100},{52,70},{60,70}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{80,70},{92,70},{92,86},{8,86},{8,96},{0,96},{0,100}},color={0,0,255}));
  connect(thermal,structure.thermal) annotation(Line(points={{0,-100},{0,-47}},color={191,0,0}));
  connect(mechanical,structure.mechanical) annotation(Line(points={{-102,0},{-88,0},{-88,46},{0,46},{0,37}},color={95,95,95},thickness=0.5));
  connect(information,structure.information) annotation(Line(points={{102,0},{86,0},{86,-5},{42,-5}},color={0,90,180}));
  annotation(
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},
preserveAspectRatio=true,
grid={2,2}),graphics = {Polygon(origin={0,0},
lineColor={80,85,92},
fillColor={226,231,236},
fillPattern=FillPattern.Solid,
points={{-62,56},{30,56},{68,76},{-24,76},{-62,56}}), Polygon(origin={0,0},
lineColor={80,85,92},
fillColor={205,213,221},
fillPattern=FillPattern.Solid,
points={{30,56},{68,76},{68,-42},{30,-62},{30,56}}), Rectangle(origin={-16,-3},
lineColor={70,75,82},
fillColor={244,246,248},
fillPattern=FillPattern.Solid,
extent={{-46,59},{46,-59}}), Line(origin={0,0},
points={{-52,56},{-52,-62}},
color={95,100,108},
thickness=1), Line(origin={0,0},
points={{20,56},{20,-62}},
color={95,100,108},
thickness=1), Line(origin={0,-4},
points={{-62,18},{30,18}},
color={120,125,132},
thickness=0.75), Line(origin={0,-6},
points={{-62,-20},{30,-20}},
color={120,125,132},
thickness=0.75), Line(origin={0,-4},
points={{30,18},{68,38}},
color={120,125,132},
thickness=0.75), Line(origin={0,-6},
points={{30,-20},{68,0}},
color={120,125,132},
thickness=0.75), Ellipse(origin={-56,48},
lineColor={80,85,92},
fillColor={170,176,184},
fillPattern=FillPattern.Solid,
extent={{-3,3},{3,-3}}), Ellipse(origin={24,48},
lineColor={80,85,92},
fillColor={170,176,184},
fillPattern=FillPattern.Solid,
extent={{-3,3},{3,-3}}), Ellipse(origin={-56,-54},
lineColor={80,85,92},
fillColor={170,176,184},
fillPattern=FillPattern.Solid,
extent={{-3,3},{3,-3}}), Ellipse(origin={24,-54},
lineColor={80,85,92},
fillColor={170,176,184},
fillPattern=FillPattern.Solid,
extent={{-3,3},{3,-3}}), Text(origin={0,-83},
lineColor={70,75,82},
extent={{-92,-11},{92,11}},
textString="12U STRUCTURE",
textColor={70,75,82}), Line(origin={36,-1.77636e-15},
points={{-52,56},{-52,-62}},
color={95,100,108},
thickness=1), Line(origin={50,10},
points={{0,56},{0,-62}},
color={95,100,108},
thickness=1), Line(origin={4,66},
points={{-46,0},{46,0}},
color={95,100,108},
thickness=1), Line(origin={3,66},
points={{-19,-10},{19,10}},
color={95,100,108},
thickness=1), Line(origin={-33,66},
points={{-19,-10},{19,10}},
color={95,100,108},
thickness=1), Line(origin={39,66},
points={{-19,-10},{19,10}},
color={95,100,108},
thickness=1)}),
    Diagram(
      coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),
      graphics={
        Rectangle(extent={{-96,86},{96,52}},lineColor={170,182,194},
          fillColor={247,249,251},fillPattern=FillPattern.Solid),
        Text(extent={{-92,85},{92,76}},textString="UNUSED POWER RAIL TERMINATION",
          lineColor={75,90,105}),
        Text(extent={{-92,58},{92,51}},textString="Numerical closure only - no structural function",
          lineColor={110,115,120}),

        Rectangle(extent={{-58,46},{58,-58}},lineColor={145,150,158},
          fillColor={250,250,250},fillPattern=FillPattern.Solid),
        Text(extent={{-55,45},{55,38}},textString="PRIMARY 12U LOAD-BEARING STRUCTURE",
          lineColor={75,80,88}),
        Text(extent={{-54,-50},{54,-57}},textString="Mechanical reference & structural heat path",
          lineColor={105,105,110}),

        Text(extent={{-104,12},{-66,5}},textString="MECHANICAL",
          lineColor={95,95,95}),
        Text(extent={{64,11},{104,4}},textString="STRUCTURAL STATE",
          lineColor={0,90,180}),
        Text(extent={{28,-94},{86,-87}},textString="STRUCTURAL THERMAL NODE",
          lineColor={170,45,35})}),
    Documentation(info="<html><h4>分系统职责</h4><p><b>系统角色：</b>把12U主结构接入整星机械、热和信息总体</p><p><b>1+4+8位置：</b>八个N-System之一；上接四个Overall，下接专业Components</p><h4>白箱组成与连接</h4><p><b>实现：</b>StructureAssembly12U通过单组机械/热/信息端口连接，未使用额外框架或网关</p><p><b>内部设备：</b>unused12Rail（Conductor）、unused5Rail（Conductor）、unused33Rail（Conductor）、structure（StructureAssembly12U）</p><p><b>对外端口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、information（InformationPort）</p><p><b>运行行为：</b>提供全星公共机械安装基准与结构导热节点，零导纳/极小导纳支路只用于未用电源端的数值闭合</p><h4>状态与遥测</h4><p><b>关键对象：</b>结构质量惯量、安装偏置、导轨/面板热节点</p><p><b>关键状态：</b>本体机械状态和结构温度</p><p><b>遥测关系：</b>结构无专用主工程字段，温度和运动用于物理层诊断</p><p><b>建模约束：</b>本模型仅含connect语句；所有设备只保留一组信息、热和机械接口，适用时再增加电源或环境接口。</p></html>"));
end StructureSystem;
