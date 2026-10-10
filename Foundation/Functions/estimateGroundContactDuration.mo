within OneSatSim.Foundation.Functions;
function estimateGroundContactDuration
  "按当前相对运动估算预测时域内超过最低仰角的累计时长"
  input Real stationRelative[3] "地面站到航天器的相对位置";
  input Real stationRelativeVelocity[3] "相对速度";
  input Real stationPosition[3] "地面站地心位置";
  input Real stationVelocity[3] "地面站惯性速度";
  input Real minimumElevationSin "最低仰角正弦";
  input Real predictionHorizon(unit="s")=180 "计算/接口量 predictionHorizon [s]" ;
  output Real visibleDuration(unit="s") "计算/接口量 visibleDuration [s]" ;
protected
  constant Integer intervalCount=36 "5 s级局部预测，保持任务级低计算量";
  Real dt "计算/接口量 dt" ;
  Real tau0 "计算/接口量 tau0" ;
  Real tau1 "计算/接口量 tau1" ;
  Real relative0[3] "相对0" ;
  Real relative1[3] "相对1" ;
  Real position0[3] "位置0" ;
  Real position1[3] "位置1" ;
  Real spacecraftPosition[3] "spacecraft位置" ;
  Real spacecraftAcceleration[3] "计算/接口量 spacecraftAcceleration" ;
  Real stationAcceleration[3] "站点Acceleration" ;
  Real relativeAcceleration[3] "相对Acceleration" ;
  Real margin0 "计算/接口量 margin0" ;
  Real margin1 "计算/接口量 margin1" ;
algorithm
  dt:=predictionHorizon/intervalCount;
  visibleDuration:=0;
  spacecraftPosition:=stationPosition+stationRelative;
  spacecraftAcceleration:=-3.986004418e14*spacecraftPosition/
    max(1e-12,(spacecraftPosition*spacecraftPosition)^(1.5));
  stationAcceleration:={-(2*Modelica.Constants.pi/86164)^2*stationPosition[1],
    -(2*Modelica.Constants.pi/86164)^2*stationPosition[2],0};
  relativeAcceleration:=spacecraftAcceleration-stationAcceleration;
  for k in 0:intervalCount-1 loop
    tau0:=k*dt;
    tau1:=(k+1)*dt;
    relative0:=stationRelative+tau0*stationRelativeVelocity+0.5*tau0^2*relativeAcceleration;
    relative1:=stationRelative+tau1*stationRelativeVelocity+0.5*tau1^2*relativeAcceleration;
    position0:=stationPosition+tau0*stationVelocity+0.5*tau0^2*stationAcceleration;
    position1:=stationPosition+tau1*stationVelocity+0.5*tau1^2*stationAcceleration;
    margin0:=(relative0*position0)/sqrt(max(1e-12,(relative0*relative0)*(position0*position0)))-minimumElevationSin;
    margin1:=(relative1*position1)/sqrt(max(1e-12,(relative1*relative1)*(position1*position1)))-minimumElevationSin;
    if margin0 >= 0 and margin1 >= 0 then
      visibleDuration:=visibleDuration+dt;
    elseif margin0 < 0 and margin1 >= 0 then
      visibleDuration:=visibleDuration+dt*margin1/max(1e-12,margin1-margin0);
    elseif margin0 >= 0 and margin1 < 0 then
      visibleDuration:=visibleDuration+dt*margin0/max(1e-12,margin0-margin1);
    end if;
  end for;
  annotation(Documentation(info="<html><h2>按当前相对运动估算预测时域内超过最低仰角的累计时长</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Functions.estimateGroundContactDuration</code>　<b>类型：</b>function</p><h3>用途与定位</h3><p>按当前相对运动估算预测时域内超过最低仰角的累计时长</p><h3>调用方法</h3><p>通过函数名及声明的输入调用。输入输出与算法以本类及继承合同为准；函数调用不创建独立仿真实验。输入有效域和超界行为见下面的实现摘要与原始算法。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>stationRelative[3]</code></td><td>Real</td><td>input</td><td>按声明/类型合同</td><td>地面站到航天器的相对位置</td></tr><tr><td><code>stationRelativeVelocity[3]</code></td><td>Real</td><td>input</td><td>按声明/类型合同</td><td>相对速度</td></tr><tr><td><code>stationPosition[3]</code></td><td>Real</td><td>input</td><td>按声明/类型合同</td><td>地面站地心位置</td></tr><tr><td><code>stationVelocity[3]</code></td><td>Real</td><td>input</td><td>按声明/类型合同</td><td>地面站惯性速度</td></tr><tr><td><code>minimumElevationSin</code></td><td>Real</td><td>input</td><td>按声明/类型合同</td><td>最低仰角正弦</td></tr><tr><td><code>predictionHorizon</code></td><td>Real</td><td>input</td><td>s</td><td>计算/接口量 predictionHorizon [s]</td></tr><tr><td><code>visibleDuration</code></td><td>Real</td><td>output</td><td>s</td><td>计算/接口量 visibleDuration [s]</td></tr><tr><td><code>dt</code></td><td>Real</td><td>protected</td><td>按声明/类型合同</td><td>计算/接口量 dt</td></tr><tr><td><code>tau0</code></td><td>Real</td><td>protected</td><td>按声明/类型合同</td><td>计算/接口量 tau0</td></tr><tr><td><code>tau1</code></td><td>Real</td><td>protected</td><td>按声明/类型合同</td><td>计算/接口量 tau1</td></tr><tr><td><code>relative0[3]</code></td><td>Real</td><td>protected</td><td>按声明/类型合同</td><td>相对0</td></tr><tr><td><code>relative1[3]</code></td><td>Real</td><td>protected</td><td>按声明/类型合同</td><td>相对1</td></tr><tr><td><code>position0[3]</code></td><td>Real</td><td>protected</td><td>按声明/类型合同</td><td>位置0</td></tr><tr><td><code>position1[3]</code></td><td>Real</td><td>protected</td><td>按声明/类型合同</td><td>位置1</td></tr><tr><td><code>spacecraftPosition[3]</code></td><td>Real</td><td>protected</td><td>按声明/类型合同</td><td>spacecraft位置</td></tr><tr><td><code>spacecraftAcceleration[3]</code></td><td>Real</td><td>protected</td><td>按声明/类型合同</td><td>计算/接口量 spacecraftAcceleration</td></tr><tr><td><code>stationAcceleration[3]</code></td><td>Real</td><td>protected</td><td>按声明/类型合同</td><td>站点Acceleration</td></tr><tr><td><code>relativeAcceleration[3]</code></td><td>Real</td><td>protected</td><td>按声明/类型合同</td><td>相对Acceleration</td></tr><tr><td><code>margin0</code></td><td>Real</td><td>protected</td><td>按声明/类型合同</td><td>计算/接口量 margin0</td></tr><tr><td><code>margin1</code></td><td>Real</td><td>protected</td><td>按声明/类型合同</td><td>计算/接口量 margin1</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>intervalCount</code></td><td>Integer</td><td>5 s级局部预测，保持任务级低计算量</td><td><code>=36</code></td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[algorithm] dt:=predictionHorizon/intervalCount;\n[algorithm] visibleDuration:=0;\n[algorithm] spacecraftPosition:=stationPosition+stationRelative;\n[algorithm] spacecraftAcceleration:=-3.986004418e14*spacecraftPosition/ max(1e-12,(spacecraftPosition*spacecraftPosition)^(1.5));\n[algorithm] stationAcceleration:={-(2*Modelica.Constants.pi/86164)^2*stationPosition[1], -(2*Modelica.Constants.pi/86164)^2*stationPosition[2],0};\n[algorithm] relativeAcceleration:=spacecraftAcceleration-stationAcceleration;\n[algorithm] for k in 0:intervalCount-1 loop tau0:=k*dt;\n[algorithm] tau1:=(k+1)*dt;\n[algorithm] relative0:=stationRelative+tau0*stationRelativeVelocity+0.5*tau0^2*relativeAcceleration;\n[algorithm] relative1:=stationRelative+tau1*stationRelativeVelocity+0.5*tau1^2*relativeAcceleration;</pre><p>本类另有9段语句；阅读完整源码可查看其余边界与逻辑。</p></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Geometry function", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Ellipse(extent={{-42.2,-16.32},{-3.32,22.56}}, lineColor={0,0,0}, fillColor={239,246,250}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-30.536,-16.32},{-14.984,22.56}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Ellipse(extent={{-42.2,-3.684},{-3.32,9.924}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Line(points={{-42.2,3.12},{-3.32,3.12}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-22.76,-16.32},{-22.76,22.56}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-65.24,-19.92},{28.36,37.68}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.7, startAngle=0, endAngle=360),
      Rectangle(extent={{12.52,21.12},{19.72,28.32}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Rectangle(extent={{6.76,21.84},{11.8,27.6}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{20.44,21.84},{25.48,27.6}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{16.12,21.12},{-14.84,13.92}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Line(points={{16.12,21.12},{-6.2,-4.08}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Ellipse(extent={{-17,11.76},{-12.68,16.08}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Ellipse(extent={{-8.36,-6.24},{-4.04,-1.92}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Rectangle(extent={{43,-31},{72,28}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{47,15},{68,15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,0},{68,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,-15},{68,-15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-57,-51},{37,-34}}, textString="contact time", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Contact Duration", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Geometry function", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Ellipse(extent={{-42.2,-16.32},{-3.32,22.56}}, lineColor={0,0,0}, fillColor={239,246,250}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-30.536,-16.32},{-14.984,22.56}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Ellipse(extent={{-42.2,-3.684},{-3.32,9.924}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Line(points={{-42.2,3.12},{-3.32,3.12}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-22.76,-16.32},{-22.76,22.56}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-65.24,-19.92},{28.36,37.68}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.7, startAngle=0, endAngle=360),
      Rectangle(extent={{12.52,21.12},{19.72,28.32}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Rectangle(extent={{6.76,21.84},{11.8,27.6}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{20.44,21.84},{25.48,27.6}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{16.12,21.12},{-14.84,13.92}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Line(points={{16.12,21.12},{-6.2,-4.08}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Ellipse(extent={{-17,11.76},{-12.68,16.08}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Ellipse(extent={{-8.36,-6.24},{-4.04,-1.92}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Rectangle(extent={{43,-31},{72,28}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Line(points={{47,15},{68,15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,0},{68,0}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{47,-15},{68,-15}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Text(extent={{-57,-51},{37,-34}}, textString="contact time", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Contact Duration", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));
end estimateGroundContactDuration;