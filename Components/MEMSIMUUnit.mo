within NISSA_12UCubeSat.Components;
model MEMSIMUUnit "MEMS惯性测量组件"
  parameter NISSA_12UCubeSat.Scenarios.DesignConfigRecords.MemsIMUComponentConfig config
    "由所属N-System传入的硬件设计配置";
  parameter Modelica.Units.SI.Resistance loadResistance=config.LoadResistance
    "memsIMU等效负载电阻；Excel单位Ω，当前设计基线";
  parameter Modelica.Units.SI.HeatCapacity heatCapacity=config.HeatCapacity
    "memsIMU等效热容；Excel单位J/K，当前设计基线";
  parameter Modelica.Units.SI.ThermalConductance mountConductance=config.MountConductance
    "memsIMU安装导热；Excel单位W/K，当前设计基线";
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
  Modelica.Electrical.Analog.Basic.Conductor unused5Rail(G=0) annotation(Placement(transformation(extent={{66,76},{78,88}})));
  Foundation.Interfaces.ThermalPort thermal annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(extent={{-10,-110},{10,-90}})));
  Foundation.Interfaces.MechanicalPort mechanical annotation(Placement(transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={{-110,-10},{-90,10}})));
  Foundation.Interfaces.EnvironmentPort environment annotation(Placement(transformation(extent={{-110,-62},{-90,-42}}),iconTransformation(extent={{-110,-62},{-90,-42}})));
  Foundation.Interfaces.InformationPort information annotation(Placement(transformation(extent={{90,-10},{110,10}}),iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Mechanics.MultiBody.Sensors.AbsoluteAngularVelocity gyro(resolveInFrame=Modelica.Mechanics.MultiBody.Types.ResolveInFrameA.frame_a) annotation(Placement(transformation(extent={{-87,-31},{-57,-1}})));
  Foundation.Interfaces.RealSignalReader positionInput[3] annotation(Placement(transformation(extent={{-8,66},{10,80}})));
  Foundation.Calculations.OrbitalAccelerationCalculation accelerationCalculation annotation(Placement(transformation(extent={{15,42},{40,58}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor annotation(Placement(transformation(extent={{-75,5},{-55,25}})));
  Modelica.Electrical.Analog.Basic.Resistor sensorLoad(R=loadResistance,useHeatPort=true) "系统级 share of 3.3 V bus load" annotation(Placement(transformation(extent={{-42,5},{-22,25}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor packageNode(C=heatCapacity,T(start=294.15,fixed=false)) annotation(Placement(transformation(extent={{-25,-45},{-5,-25}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor pcbPath(G=mountConductance) annotation(Placement(transformation(extent={{15,-43},{35,-27}})));
  Modelica.Mechanics.MultiBody.Parts.Body imuBody(m=mass,r_CM={rcm_X,rcm_Y,rcm_Z},I_11=inertia_XX,I_22=inertia_YY,I_33=inertia_ZZ) annotation(Placement(transformation(extent={{-52,-26},{-32,-6}})));
  Foundation.Interfaces.RealSignalBridge informationRealBridge[7] annotation(Placement(transformation(extent={{78,20},{86,28}})));
equation
  connect(environment.position,positionInput.u) annotation(Line(points={{-100,-52},{-53.5,-52},{-53.5,73},{-8,73}},color={0,0,127}));
  connect(positionInput.y,accelerationCalculation.position) annotation(Line(points={{10,73},{12,73},{12,50},{15,50}},color={0,0,127}));
  connect(power.p12,unused12Rail.p) annotation(Line(points={{0,100},{0,94},{42,94},{42,82}},color={0,0,255}));
  connect(unused12Rail.n,power.n12) annotation(Line(points={{54,82},{54,94},{0,94},{0,100}},color={0,0,255}));
  connect(power.p5,unused5Rail.p) annotation(Line(points={{0,100},{0,94},{66,94},{66,82}},color={0,0,255}));
  connect(unused5Rail.n,power.n5) annotation(Line(points={{78,82},{78,94},{0,94},{0,100}},color={0,0,255}));
  connect(mechanical,gyro.frame_a) annotation(Line(points={{-100,0},{-94,0},{-94,-16},{-87,-16}},color={95,95,95},thickness=0.5));
  connect(mechanical,imuBody.frame_a) annotation(Line(points={{-100,0},{-100,0.5},{-52,0.5},{-52,-16}},color={95,95,95},thickness=0.5));
  connect(gyro.w[1],informationRealBridge[1].u) annotation(Line(points={{-55.5,-16},{-55.5,3.5},{78,3.5},{78,24}},color={0,0,127}));
  connect(informationRealBridge[1].y,information.device.mems[1]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(gyro.w[2],informationRealBridge[2].u) annotation(Line(points={{-55.5,-16},{-55.5,3.5},{78,3.5},{78,24}},color={0,0,127}));
  connect(informationRealBridge[2].y,information.device.mems[2]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(gyro.w[3],informationRealBridge[3].u) annotation(Line(points={{-55.5,-16},{-55.5,3.5},{78,3.5},{78,24}},color={0,0,127}));
  connect(informationRealBridge[3].y,information.device.mems[3]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(accelerationCalculation.acceleration[1],informationRealBridge[4].u) annotation(Line(points={{38.75,50},{78,50},{78,24}},color={0,0,127}));
  connect(informationRealBridge[4].y,information.device.mems[4]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(accelerationCalculation.acceleration[2],informationRealBridge[5].u) annotation(Line(points={{38.75,50},{78,50},{78,24}},color={0,0,127}));
  connect(informationRealBridge[5].y,information.device.mems[5]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(accelerationCalculation.acceleration[3],informationRealBridge[6].u) annotation(Line(points={{38.75,50},{78,50},{78,24}},color={0,0,127}));
  connect(informationRealBridge[6].y,information.device.mems[6]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(power.p33,currentSensor.p) annotation(Line(points={{0,100},{0,94},{-75,94},{-75,15}},color={0,0,255}));
  connect(currentSensor.n,sensorLoad.p) annotation(Line(points={{-55,15},{-42,15}},color={0,0,255}));
  connect(sensorLoad.n,power.n33) annotation(Line(points={{-22,15},{-22,94},{0,94},{0,100}},color={0,0,255}));
  connect(currentSensor.i,informationRealBridge[7].u) annotation(Line(points={{-65,5},{78,5},{78,24}},color={0,0,127}));
  connect(informationRealBridge[7].y,information.device.pdCurrent[20]) annotation(Line(points={{86,24},{94,24},{94,0},{100,0}},color={0,0,127}));
  connect(sensorLoad.heatPort,packageNode.port) annotation(Line(points={{-32,5},{-32,-25},{-15,-25}},color={191,0,0}));
  connect(packageNode.port,pcbPath.port_a) annotation(Line(points={{-15,-45},{-15,-35},{15,-35}},color={191,0,0}));
  connect(pcbPath.port_b,thermal) annotation(Line(points={{35,-35},{35,-94},{0,-94},{0,-100}},color={191,0,0}));
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={50,95,125},fillColor={230,243,246},fillPattern=FillPattern.Solid),Rectangle(extent={{-48,45},{48,-45}},fillColor={135,190,200},fillPattern=FillPattern.Solid),Line(points={{-65,0},{65,0}},color={190,45,40},thickness=1),Line(points={{0,-60},{0,60}},color={40,120,70},thickness=1),Text(extent={{-92,-74},{92,-52}},textString="6-AXIS MEMS / PD20")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}},preserveAspectRatio=true),graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={205,205,205},pattern=LinePattern.Dot),Text(extent={{-92,72},{92,60}},textString="角速度传感器+轨道重力加速度")}),Documentation(info="<html><h4>用途与系统角色</h4><p><b>用途：</b>提供三轴角速度和三轴加速度工程测量</p><p><b>建模层级：</b>Components层设备级白箱；主要由Modelica 4.0.0标准库元件和图形连线组成</p><h4>实现与接口</h4><p><b>白箱实现：</b>AbsoluteAngularVelocity读取多体机械运动，OrbitalAccelerationCalculation生成加速度近似，配套传感负载、热容和刚体</p><p><b>关键内部元件：</b>unused12Rail（Conductor）、unused5Rail（Conductor）、gyro（AbsoluteAngularVelocity）、positionInput（RealSignalReader）、accelerationCalculation（OrbitalAccelerationCalculation）、currentSensor（CurrentSensor）、sensorLoad（Resistor）、packageNode（HeatCapacitor）、pcbPath（ThermalConductor）、imuBody（Body）</p><p><b>对外接口：</b>thermal（ThermalPort）、mechanical（MechanicalPort）、environment（EnvironmentPort）、information（InformationPort）</p><h4>工作行为与状态</h4><p><b>运行行为：</b>角速度随本体机械状态变化；加速度采用系统级低阶表示，传感器持续取电并经PCB导热</p><p><b>关键参数：</b>传感器阻性负载、封装热容和PCB导热</p><p><b>关键状态：</b>机械测量、传感器温度和电流</p><p><b>物理域：</b>机械、惯性测量、电、热、信息</p><h4>信息与遥测关系</h4><p><b>数据路径：</b>三轴MEMS陀螺以deg/s、三轴加速度以m/s2进入SAT-S2</p><p><b>使用说明：</b>设备测量与机器反馈均写入同一个InformationPort.device语义域；不存在平行的传感器遥测接口。应从N-System画布下钻本组件，并结合总体公共电/热/机械网络解释结果。</p><h4>缩写与功能边界</h4><p>MEMS IMU指微机电惯性测量组件，当前类名MEMSIMUUnit为稳定公开名称。模型把多体机械角速度与轨道中心引力加速度转换为三轴工程测量，并同时刻画传感器板的5 V负载、温度和安装质量。</p><h4>结果使用与简化</h4><p>position经RealSignalReader进入OrbitalAccelerationCalculation，AbsoluteAngularVelocity读取机械框架速率。重点查看三轴gyro、accelerationCalculation.acceleration、currentSensor.i和sensorNode.T。模型未叠加噪声、零偏、温漂、量程饱和和导航积分，因此适合总体真值/接口验证，不代表可直接用于误差传播与惯导精度评估的IMU模型。</p></html>"));
end MEMSIMUUnit;
