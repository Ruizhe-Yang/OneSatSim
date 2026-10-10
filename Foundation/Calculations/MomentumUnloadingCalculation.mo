within OneSatSim.Foundation.Calculations;
model MomentumUnloadingCalculation "磁力矩器动量卸载与消旋计算"
  parameter Real safeModeActivationBodyRate(unit="rad/s")=0.02 "任务级参数: energize rods only for actual safe-mode detumbling [rad/s]" ;
  parameter Real detumbleDampingTorque(unit="N.m.s")=2e-5 "任务级参数: equivalent rate-damping gain [N.m.s]" ;
  parameter Real minimumFieldSquared(unit="T2")=4e-10 "配置项 minimumFieldSquared [T2]" ;
  parameter Modelica.Units.SI.Current coilCurrentLimit=0.28 "coil电流限制 [A]" ;
  parameter Real dipolePerAmpere[3]={3.571428571,3.571428571,3.571428571} "任务级参数: 1.0 A.m2 maximum moment per axis at 0.28 A" ;
  parameter Real momentumDumpTorque(unit="N.m")=3e-4 "配置项 momentumDumpTorque [N.m]" ;
  parameter Real normalRateDampingGain(unit="N.m.s")=5e-4 "normal速率Damping增益 [N.m.s]" ;
  parameter Real wheelInertia[4](each unit="kg.m2") "飞轮惯量 [kg.m2]" ;
  parameter Real wheelAxes[3,4] "飞轮Axes；Four body-frame mounting-axis columns";
  Modelica.Blocks.Interfaces.RealInput wheelSpeed[4](each unit="rad/s")  "四轮转速 [rad/s]" annotation(Placement(visible=true, transformation(origin={-270,130}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput bodyRateMagnitude(unit="rad/s")  "本体速率Magnitude [rad/s]" annotation(Placement(visible=true, transformation(origin={-270,104}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,60}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput bodyRate[3](each unit="rad/s")  "机体系陀螺角速率 [rad/s]" annotation(Placement(visible=true, transformation(origin={-270,78}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,40}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput magneticField[3](each unit="T")  "计算/接口量 magneticField [T]" annotation(Placement(visible=true, transformation(origin={-270,52}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,20}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput supplyVoltage(unit="V")  "供给电压 [V]" annotation(Placement(visible=true, transformation(origin={-270,0}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInput safeMode  "安全模式模式" annotation(Placement(visible=true, transformation(origin={-270,-52}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-20}, extent={{-6,-6},{6,6}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.ControlModeInput desiredControlMode  "desired控制模式" annotation(Placement(visible=true, transformation(origin={-270,-78}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-40}, extent={{-12,-12},{12,12}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInput momentumDumpLatched  "计算/接口量 momentumDumpLatched" annotation(Placement(visible=true, transformation(origin={-270,-104}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-60}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInput rateDampingLatched  "速率DampingLatched" annotation(Placement(visible=true, transformation(origin={-270,-130}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput maximumWheelSpeed(unit="rad/s")  "maximum飞轮速度 [rad/s]" annotation(Placement(visible=true, transformation(origin={270,-13}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput bodyRateForDamping(unit="rad/s")  "本体速率ForDamping [rad/s]" annotation(Placement(visible=true, transformation(origin={270,-39}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,53.333333}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput momentumDumpActive  "momentumDump激活" annotation(Placement(visible=true, transformation(origin={270,-65}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,26.666667}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput coilCurrentCommand[3](each unit="A")  "coil电流指令 [A]" annotation(Placement(visible=true, transformation(origin={270,91}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput coilConductanceCommand[3](each unit="S")  "coilConductance指令 [S]" annotation(Placement(visible=true, transformation(origin={270,65}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-26.666667}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput magneticTorque[3](each unit="N.m")  "计算/接口量 magneticTorque [N.m]" annotation(Placement(visible=true, transformation(origin={270,39}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-53.333333}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput safeDetumbleActive  "安全模式Detumble激活" annotation(Placement(visible=true, transformation(origin={270,-91}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-6,-6},{6,6}}, rotation=0)));
protected
  Real magneticFieldSquared(unit="T2") "计算/接口量 magneticFieldSquared [T2]" ;
  Boolean normalDumpEligible "计算/接口量 normalDumpEligible" ;
  Boolean normalMomentumDump "计算/接口量 normalMomentumDump" ;
  Boolean normalRateDamping "normal速率Damping" ;
  Boolean magneticControlEnabled "magnetic控制启用" ;
  Real wheelMomentumBody[3](each unit="kg.m2/s") "飞轮Momentum本体 [kg.m2/s]" ;
  Real wheelMomentumMagnitude(unit="kg.m2/s") "飞轮MomentumMagnitude [kg.m2/s]" ;
  Real unloadingTorque[3](each unit="N.m") "计算/接口量 unloadingTorque [N.m]" ;
  Real rateDampingTorque[3](each unit="N.m") "速率DampingTorque [N.m]" ;
  Real safeDampingTorque[3](each unit="N.m") "安全模式DampingTorque [N.m]" ;
  Real desiredMagneticTorque[3](each unit="N.m") "计算/接口量 desiredMagneticTorque [N.m]" ;
  Real inverseMappingDenominator[3] "计算/接口量 inverseMappingDenominator" ;
  Real rawCoilCurrent[3](each unit="A") "rawCoil电流 [A]" ;
  Real dipoleMoment[3](each unit="A.m2") "计算/接口量 dipoleMoment [A.m2]" ;
equation
  magneticFieldSquared=magneticField*magneticField;
  maximumWheelSpeed=max(abs(wheelSpeed));
  bodyRateForDamping=bodyRateMagnitude;
  safeDetumbleActive=safeMode and bodyRateMagnitude > safeModeActivationBodyRate and magneticFieldSquared > minimumFieldSquared;
  normalDumpEligible=desiredControlMode == OneSatSim.Foundation.Types.ControlMode.SunPointing and not safeMode and magneticFieldSquared > minimumFieldSquared;
  normalMomentumDump=momentumDumpLatched and normalDumpEligible;
  normalRateDamping=rateDampingLatched and normalDumpEligible;
  momentumDumpActive=normalMomentumDump or normalRateDamping;
  wheelMomentumBody={sum(wheelAxes[i,j]*wheelInertia[j]*wheelSpeed[j] for j in 1:4) for i in 1:3};
  wheelMomentumMagnitude=sqrt(wheelMomentumBody*wheelMomentumBody);
  unloadingTorque=if normalMomentumDump then -momentumDumpTorque*wheelMomentumBody/max(1e-6,wheelMomentumMagnitude) else {0,0,0};
  rateDampingTorque=if normalRateDamping then -normalRateDampingGain*bodyRate else {0,0,0};
  safeDampingTorque=if safeDetumbleActive then -detumbleDampingTorque*bodyRate else {0,0,0};
  desiredMagneticTorque=if safeDetumbleActive then safeDampingTorque else unloadingTorque+rateDampingTorque;
  magneticControlEnabled=safeDetumbleActive or momentumDumpActive;
  inverseMappingDenominator={max(minimumFieldSquared,magneticFieldSquared)*dipolePerAmpere[i] for i in 1:3};
  rawCoilCurrent={(magneticField[2]*desiredMagneticTorque[3]-magneticField[3]*desiredMagneticTorque[2])/inverseMappingDenominator[1],(magneticField[3]*desiredMagneticTorque[1]-magneticField[1]*desiredMagneticTorque[3])/inverseMappingDenominator[2],(magneticField[1]*desiredMagneticTorque[2]-magneticField[2]*desiredMagneticTorque[1])/inverseMappingDenominator[3]};
  coilCurrentCommand={if magneticControlEnabled then noEvent(max(-coilCurrentLimit,min(coilCurrentLimit,rawCoilCurrent[i]))) else 0 for i in 1:3};
  coilConductanceCommand={abs(coilCurrentCommand[i])/max(0.1,abs(supplyVoltage)) for i in 1:3};
  dipoleMoment={dipolePerAmpere[i]*coilCurrentCommand[i] for i in 1:3};
  magneticTorque={dipoleMoment[2]*magneticField[3]-dipoleMoment[3]*magneticField[2],dipoleMoment[3]*magneticField[1]-dipoleMoment[1]*magneticField[3],dipoleMoment[1]*magneticField[2]-dipoleMoment[2]*magneticField[1]};
  annotation(Documentation(info="<html><h2>磁力矩器动量卸载与消旋计算</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Calculations.MomentumUnloadingCalculation</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>磁力矩器动量卸载与消旋计算</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.MagnetorquerUnit\">OneSatSim.Components.MagnetorquerUnit</a> 的 <code>unloadingCalculation</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>wheelSpeed[4]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>rad/s</td><td>四轮转速 [rad/s]</td></tr><tr><td><code>bodyRateMagnitude</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>rad/s</td><td>本体速率Magnitude [rad/s]</td></tr><tr><td><code>bodyRate[3]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>rad/s</td><td>机体系陀螺角速率 [rad/s]</td></tr><tr><td><code>magneticField[3]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>T</td><td>计算/接口量 magneticField [T]</td></tr><tr><td><code>supplyVoltage</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>V</td><td>供给电压 [V]</td></tr><tr><td><code>safeMode</code></td><td>Modelica.Blocks.Interfaces.BooleanInput</td><td>public</td><td>按声明/类型合同</td><td>安全模式模式</td></tr><tr><td><code>desiredControlMode</code></td><td>OneSatSim.Foundation.Interfaces.ControlModeInput</td><td>public</td><td>按声明/类型合同</td><td>desired控制模式</td></tr><tr><td><code>momentumDumpLatched</code></td><td>Modelica.Blocks.Interfaces.BooleanInput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 momentumDumpLatched</td></tr><tr><td><code>rateDampingLatched</code></td><td>Modelica.Blocks.Interfaces.BooleanInput</td><td>public</td><td>按声明/类型合同</td><td>速率DampingLatched</td></tr><tr><td><code>maximumWheelSpeed</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>rad/s</td><td>maximum飞轮速度 [rad/s]</td></tr><tr><td><code>bodyRateForDamping</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>rad/s</td><td>本体速率ForDamping [rad/s]</td></tr><tr><td><code>momentumDumpActive</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>momentumDump激活</td></tr><tr><td><code>coilCurrentCommand[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>A</td><td>coil电流指令 [A]</td></tr><tr><td><code>coilConductanceCommand[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>S</td><td>coilConductance指令 [S]</td></tr><tr><td><code>magneticTorque[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>N.m</td><td>计算/接口量 magneticTorque [N.m]</td></tr><tr><td><code>safeDetumbleActive</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>安全模式Detumble激活</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>safeModeActivationBodyRate</code></td><td>Real</td><td>任务级参数: energize rods only for actual safe-mode detumbling [rad/s]</td><td><code>=0.02</code></td></tr><tr><td><code>detumbleDampingTorque</code></td><td>Real</td><td>任务级参数: equivalent rate-damping gain [N.m.s]</td><td><code>=2e-5</code></td></tr><tr><td><code>minimumFieldSquared</code></td><td>Real</td><td>配置项 minimumFieldSquared [T2]</td><td><code>=4e-10</code></td></tr><tr><td><code>coilCurrentLimit</code></td><td>Modelica.Units.SI.Current</td><td>coil电流限制 [A]</td><td><code>=0.28</code></td></tr><tr><td><code>dipolePerAmpere[3]</code></td><td>Real</td><td>任务级参数: 1.0 A.m2 maximum moment per axis at 0.28 A</td><td><code>={3.571428571,3.571428571,3.571428571}</code></td></tr><tr><td><code>momentumDumpTorque</code></td><td>Real</td><td>配置项 momentumDumpTorque [N.m]</td><td><code>=3e-4</code></td></tr><tr><td><code>normalRateDampingGain</code></td><td>Real</td><td>normal速率Damping增益 [N.m.s]</td><td><code>=5e-4</code></td></tr><tr><td><code>wheelInertia[4]</code></td><td>Real</td><td>飞轮惯量 [kg.m2]</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>wheelAxes[3,4]</code></td><td>Real</td><td>飞轮Axes；Four body-frame mounting-axis columns</td><td><code>由调用方、继承或默认声明提供</code></td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] magneticFieldSquared=magneticField*magneticField;\n[equation] maximumWheelSpeed=max(abs(wheelSpeed));\n[equation] bodyRateForDamping=bodyRateMagnitude;\n[equation] safeDetumbleActive=safeMode and bodyRateMagnitude &gt; safeModeActivationBodyRate and magneticFieldSquared &gt; minimumFieldSquared;\n[equation] normalDumpEligible=desiredControlMode == OneSatSim.Foundation.Types.ControlMode.SunPointing and not safeMode and magneticFieldSquared &gt; minimumFieldSquared;\n[equation] normalMomentumDump=momentumDumpLatched and normalDumpEligible;\n[equation] normalRateDamping=rateDampingLatched and normalDumpEligible;\n[equation] momentumDumpActive=normalMomentumDump or normalRateDamping;\n[equation] wheelMomentumBody={sum(wheelAxes[i,j]*wheelInertia[j]*wheelSpeed[j] for j in 1:4) for i in 1:3};\n[equation] wheelMomentumMagnitude=sqrt(wheelMomentumBody*wheelMomentumBody);</pre><p>本类另有11段语句；阅读完整源码可查看其余边界与逻辑。</p><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>magneticFieldSquared</code></td><td>Real</td><td>protected</td><td>T2</td><td>计算/接口量 magneticFieldSquared [T2]</td></tr><tr><td><code>normalDumpEligible</code></td><td>Boolean</td><td>protected</td><td>按声明/类型合同</td><td>计算/接口量 normalDumpEligible</td></tr><tr><td><code>normalMomentumDump</code></td><td>Boolean</td><td>protected</td><td>按声明/类型合同</td><td>计算/接口量 normalMomentumDump</td></tr><tr><td><code>normalRateDamping</code></td><td>Boolean</td><td>protected</td><td>按声明/类型合同</td><td>normal速率Damping</td></tr><tr><td><code>magneticControlEnabled</code></td><td>Boolean</td><td>protected</td><td>按声明/类型合同</td><td>magnetic控制启用</td></tr><tr><td><code>wheelMomentumBody[3]</code></td><td>Real</td><td>protected</td><td>kg.m2/s</td><td>飞轮Momentum本体 [kg.m2/s]</td></tr><tr><td><code>wheelMomentumMagnitude</code></td><td>Real</td><td>protected</td><td>kg.m2/s</td><td>飞轮MomentumMagnitude [kg.m2/s]</td></tr><tr><td><code>unloadingTorque[3]</code></td><td>Real</td><td>protected</td><td>N.m</td><td>计算/接口量 unloadingTorque [N.m]</td></tr><tr><td><code>rateDampingTorque[3]</code></td><td>Real</td><td>protected</td><td>N.m</td><td>速率DampingTorque [N.m]</td></tr><tr><td><code>safeDampingTorque[3]</code></td><td>Real</td><td>protected</td><td>N.m</td><td>安全模式DampingTorque [N.m]</td></tr><tr><td><code>desiredMagneticTorque[3]</code></td><td>Real</td><td>protected</td><td>N.m</td><td>计算/接口量 desiredMagneticTorque [N.m]</td></tr><tr><td><code>inverseMappingDenominator[3]</code></td><td>Real</td><td>protected</td><td>按声明/类型合同</td><td>计算/接口量 inverseMappingDenominator</td></tr><tr><td><code>rawCoilCurrent[3]</code></td><td>Real</td><td>protected</td><td>A</td><td>rawCoil电流 [A]</td></tr><tr><td><code>dipoleMoment[3]</code></td><td>Real</td><td>protected</td><td>A.m2</td><td>计算/接口量 dipoleMoment [A.m2]</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Attitude control", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-53.72,11.04},{-19.16,19.68}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{-48.68,9.6},{-50.84,21.12}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-45.08,9.6},{-47.24,21.12}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-41.48,9.6},{-43.64,21.12}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-37.88,9.6},{-40.04,21.12}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-34.28,9.6},{-36.44,21.12}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-30.68,9.6},{-32.84,21.12}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-27.08,9.6},{-29.24,21.12}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-58.04,15.36},{-53.72,15.36},{-53.72,4.56},{-17.72,4.56}}, color={0,0,0}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{-26.36,-4.8},{8.2,3.84}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{-21.32,-6.24},{-23.48,5.28}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-17.72,-6.24},{-19.88,5.28}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-14.12,-6.24},{-16.28,5.28}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-10.52,-6.24},{-12.68,5.28}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-6.92,-6.24},{-9.08,5.28}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-3.32,-6.24},{-5.48,5.28}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{0.28,-6.24},{-1.88,5.28}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-30.68,-0.48},{-26.36,-0.48},{-26.36,-11.28},{9.64,-11.28}}, color={0,0,0}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{-9.08,24},{25.48,32.64}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{-4.04,22.56},{-6.2,34.08}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-0.44,22.56},{-2.6,34.08}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{3.16,22.56},{1,34.08}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{6.76,22.56},{4.6,34.08}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{10.36,22.56},{8.2,34.08}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{13.96,22.56},{11.8,34.08}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{17.56,22.56},{15.4,34.08}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-13.4,28.32},{-9.08,28.32},{-9.08,17.52},{26.92,17.52}}, color={0,0,0}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-49.4,37.68},{-34.28,45.6},{-9.8,45.6},{10.36,41.28}}, color={76,128,143}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{19.72,-15.6},{34.84,-15.6}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{19.72,-15.6},{11.8576,-5.9232}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{19.72,-15.6},{19.72,-0.48}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{43,-31},{72,28}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{47,15},{68,15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,0},{68,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,-15},{68,-15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-57,-51},{37,-34}}, textString="m x B", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Momentum Unloading", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-344,-174},{343,234}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-78.32,-85.36},{78.32,83.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-66.88,56.32},{66.88,56.32}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-73.92,60.72},{-56.32,78.32}}, lineColor={0,0,0}, fillColor={76,128,143}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-53.68,62.48},{66.88,75.68}}, textString="Attitude control", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-47.2736,9.7152},{-16.8608,17.3184}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{-42.8384,8.448},{-44.7392,18.5856}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-39.6704,8.448},{-41.5712,18.5856}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-36.5024,8.448},{-38.4032,18.5856}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-33.3344,8.448},{-35.2352,18.5856}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-30.1664,8.448},{-32.0672,18.5856}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-26.9984,8.448},{-28.8992,18.5856}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-23.8304,8.448},{-25.7312,18.5856}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-51.0752,13.5168},{-47.2736,13.5168},{-47.2736,4.0128},{-15.5936,4.0128}}, color={0,0,0}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{-23.1968,-4.224},{7.216,3.3792}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{-18.7616,-5.4912},{-20.6624,4.6464}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-15.5936,-5.4912},{-17.4944,4.6464}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-12.4256,-5.4912},{-14.3264,4.6464}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-9.2576,-5.4912},{-11.1584,4.6464}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-6.0896,-5.4912},{-7.9904,4.6464}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-2.9216,-5.4912},{-4.8224,4.6464}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{0.2464,-5.4912},{-1.6544,4.6464}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-26.9984,-0.4224},{-23.1968,-0.4224},{-23.1968,-9.9264},{8.4832,-9.9264}}, color={0,0,0}, thickness=0.55, pattern=LinePattern.Solid),
      Rectangle(extent={{-7.9904,21.12},{22.4224,28.7232}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{-3.5552,19.8528},{-5.456,29.9904}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-0.3872,19.8528},{-2.288,29.9904}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{2.7808,19.8528},{0.88,29.9904}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{5.9488,19.8528},{4.048,29.9904}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{9.1168,19.8528},{7.216,29.9904}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{12.2848,19.8528},{10.384,29.9904}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{15.4528,19.8528},{13.552,29.9904}}, color={152,118,71}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-11.792,24.9216},{-7.9904,24.9216},{-7.9904,15.4176},{23.6896,15.4176}}, color={0,0,0}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-43.472,33.1584},{-30.1664,40.128},{-8.624,40.128},{9.1168,36.3264}}, color={76,128,143}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}, smooth=Smooth.Bezier),
      Line(points={{17.3536,-13.728},{30.6592,-13.728}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{17.3536,-13.728},{10.4347,-5.2124}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{17.3536,-13.728},{17.3536,-0.4224}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Rectangle(extent={{37.84,-27.28},{63.36,24.64}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{41.36,13.2},{59.84,13.2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{41.36,0},{59.84,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{41.36,-13.2},{59.84,-13.2}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-50.16,-44.88},{32.56,-29.92}}, textString="m x B", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-66.88,-51.04},{66.88,-51.04}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-70.4,-69.52},{70.4,-56.32}}, textString="Momentum Unloading", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-318,146},{-223,164}}, textString="SENSING", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-318,16},{-223,34}}, textString="SUPPLY", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-318,-36},{-223,-18}}, textString="CONTROL", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{222,107},{317,125}}, textString="ACTUATION", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{222,3},{317,21}}, textString="STATUS", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-332,189},{331,218}}, textString="Momentum Unloading", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-332,181},{331,181}}, color={215,220,226}, thickness=0.25)
    }));
end MomentumUnloadingCalculation;