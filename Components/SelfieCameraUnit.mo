within NISSA_12UCubeSat.Components;
model SelfieCameraUnit "自拍相机组件"
  parameter NISSA_12UCubeSat.Scenarios.DesignConfigRecords.SelfieCameraComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance cmosLoadResistance=config.CMOSLoadResistance
    "CMOS相机负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity imagerHeatCapacity=config.ImagerHeatCapacity
    "自拍相机热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountConductance=config.MountConductance
    "自拍相机安装导热；Excel单位W/K，当前设计基线";
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
  Foundation.Interfaces.PowerPort power annotation(Placement(transformation(extent={{-10,90},{10,110}}),iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Analog.Basic.Conductor unused12Rail(G=0) annotation(Placement(transformation(extent={{42,76},{54,88}})));
  Modelica.Electrical.Analog.Basic.Conductor unused33Rail(G=0) annotation(Placement(transformation(extent={{66,76},{78,88}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  parameter Real imagingDataRate(unit="1/s")=config.ImagingDataRate "系统级自拍图像写入率；数值单位：byte/s";
  Foundation.Interfaces.BooleanSignalReader imagingCommand annotation(Placement(transformation(extent={{-96,68},{-76,84}})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch shutterPower annotation(Placement(transformation(extent={{-72,38},{-52,58}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor cameraCurrent annotation(Placement(transformation(extent={{-42,38},{-22,58}})));
  Modelica.Electrical.Analog.Basic.Resistor cmosLoad(R=cmosLoadResistance,useHeatPort=true) "系统级 nominal 5 V CMOS load" annotation(Placement(transformation(extent={{-12,38},{8,58}})));
  Foundation.Calculations.PayloadCaptureCalculation captureCalculation(imagingDataRate=imagingDataRate) annotation(Placement(transformation(extent={{44,24},{68,56}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor imager(C=imagerHeatCapacity,T(start=300.15,fixed=false)) annotation(Placement(transformation(extent={{-20,-42},{0,-22}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor bracket(G=mountConductance) annotation(Placement(transformation(extent={{20,-40},{40,-24}})));
  Modelica.Mechanics.MultiBody.Parts.Body cameraBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-82,2},{-62,22}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[2] annotation(Placement(transformation(extent={{78,20},{86,28}})));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[1] annotation(Placement(transformation(extent={{78,0},{86,8}})));
equation
  connect(information.command.selfieCaptureCommand,imagingCommand.u) annotation(Line(points={{100,0},{94,0},{94,76},{-96,76}},color={255,0,255}));
  connect(imagingCommand.y,captureCalculation.captureCommand) annotation(Line(points={{-76,76},{40,76},{40,40},{44,40}},color={255,0,255}));
  connect(power.p12,unused12Rail.p) annotation(Line(points={{0,100},{0,94},{42,94},{42,82}},color={0,0,255}));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{54,82},{54,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p33,unused33Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,82}},color={0,0,255}));
  connect(unused33Rail.n,power.n33) annotation(Line(points={{78,82},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(imagingCommand.y,shutterPower.control) annotation(Line(points={{-76,76},{-62,76},{-62,60}},color={255,0,255}));
  connect(power.p5,shutterPower.p) annotation(Line(points={{0,100},{0,94},{-72,94},{-72,48}},color={0,0,255}));
  connect(shutterPower.n,cameraCurrent.p) annotation(Line(points={{-52,48},{-42,48}},color={0,0,255}));
  connect(cameraCurrent.n,cmosLoad.p) annotation(Line(points={{-22,48},{-12,48}},color={0,0,255}));
  connect(cmosLoad.n,power.n5) annotation(Line(points={{8,48},{8,94},{0,94},{0,100}},color={0,0,255}));
  connect(cameraCurrent.i,informationRealBridge[1].u) annotation(Line(points={{-32,38},{-32,22.5},{78,22.5},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.pdCurrent[19]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(captureCalculation.status,informationIntegerBridge[1].u) annotation(Line(points={{66.8,45.6},{78,45.6},{78,4}},color={255,127,0}));
  connect(informationIntegerBridge[1].y,information.device.cmosStatus) annotation(Line(points={{86,4},{94,4},{94,0},{100,0}},color={255,127,0}));
  connect(captureCalculation.payloadWriteRate,informationRealBridge[2].u) annotation(Line(points={{66.8,34.4},{78,34.4},{78,24}},color={0,90,180}));
  connect(informationRealBridge[2].y,information.payload.selfieCameraWriteRate) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,90,180}));
  connect(cmosLoad.heatPort,imager.port) annotation(Line(points={{-2,38},{-2,-22},{-10,-22}},color={191,0,0}));
  connect(imager.port,bracket.port_a) annotation(Line(points={{-10,-42},{-10,-32},{20,-32}},color={191,0,0}));
  connect(bracket.port_b,thermal) annotation(Line(points={{40,-32},{40,-94},{0,-94},{0,-100}},color={191,0,0}));
  connect(cameraBody.frame_a,mechanical) annotation(Line(points={{-82,12},{-94,12},{-94,0},{-100,0}},color={95,95,95},thickness=0.5));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={70,80,110},fillColor={238,241,247},fillPattern=FillPattern.Solid),Rectangle(extent={{-48,40},{48,-40}},fillColor={165,175,200},fillPattern=FillPattern.Solid),Ellipse(extent={{-25,25},{25,-25}},fillColor={35,45,70},fillPattern=FillPattern.Solid),Text(extent={{-92,-74},{92,-52}},textString="CMOS / PD19")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Text(extent={{-90,72},{90,60}},textString="拍摄指令-供电开关-CMOS热节点")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>接收独立自拍指令，生成辅助图像数据并刻画CMOS相机负载</p><p><b>建模层级：</b>Components层设备级白箱；主要由Modelica 4.0.0标准库元件和图形连线组成</p><h4>实现与接口</h4><p><b>白箱实现：</b>selfieCaptureCommand驱动理想开关，CMOS阻性负载、电流传感、热容、支架导热和刚体构成；普通对地成像指令不会误触发本机</p><p><b>关键内部元件：</b>unused12Rail（Conductor）、unused33Rail（Conductor）、imagingCommand（BooleanSignalReader）、shutterPower（IdealClosingSwitch）、cameraCurrent（CurrentSensor）、cmosLoad（Resistor）、captureCalculation（PayloadCaptureCalculation）、imager（HeatCapacitor）、bracket（ThermalConductor）、cameraBody（Body）</p><p><b>对外接口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、information（InformationPort）</p><h4>工作行为与状态</h4><p><b>运行行为：</b>独立自拍指令有效时相机上电、状态置位并按设定速率写入数据记录器；当前默认任务表未设置自拍任务</p><p><b>关键参数：</b>图像写入率、CMOS负载、成像热容和支架导热</p><p><b>关键状态：</b>开关、图像写入状态、相机温度和电流</p><p><b>物理域：</b>光学等效、电、热、机械、信息、业务数据</p><h4>信息与遥测关系</h4><p><b>数据路径：</b>CMOS状态保存在设备状态层；写入率进入PayloadDataPort用于存储量计算</p><p><b>使用说明：</b>设备测量与机器反馈均写入同一个InformationPort.device语义域；不存在平行的传感器遥测接口。应从N-System画布下钻本组件，并结合总体公共电/热/机械网络解释结果。</p></html>"));
end SelfieCameraUnit;
