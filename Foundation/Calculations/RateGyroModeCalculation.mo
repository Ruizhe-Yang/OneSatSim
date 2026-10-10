within OneSatSim.Foundation.Calculations;
model RateGyroModeCalculation "高精度角速率陀螺工作模式计算"
  OneSatSim.Foundation.Interfaces.ControlModeInput desiredControlMode  "desired控制模式" annotation(Placement(visible=true, transformation(origin={-89,0}, extent={{-32.465455,-32.465455},{32.465455,32.465455}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-32.465455,-32.465455},{32.465455,32.465455}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput precisionEnabled  "precision启用" annotation(Placement(visible=true, transformation(origin={89,0}, extent={{-16.232727,-16.232727},{16.232727,16.232727}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-16.232727,-16.232727},{16.232727,16.232727}}, rotation=0)));
equation
  precisionEnabled=desiredControlMode == OneSatSim.Foundation.Types.ControlMode.TargetPointing or 
    desiredControlMode == OneSatSim.Foundation.Types.ControlMode.GroundPointing;
  annotation(Documentation(info="<html><h2>高精度角速率陀螺工作模式计算</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Calculations.RateGyroModeCalculation</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>高精度角速率陀螺工作模式计算</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.RateGyroUnit\">OneSatSim.Components.RateGyroUnit</a> 的 <code>modeCalculation</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>desiredControlMode</code></td><td>OneSatSim.Foundation.Interfaces.ControlModeInput</td><td>public</td><td>按声明/类型合同</td><td>desired控制模式</td></tr><tr><td><code>precisionEnabled</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>precision启用</td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] precisionEnabled=desiredControlMode == OneSatSim.Foundation.Types.ControlMode.TargetPointing or desiredControlMode == OneSatSim.Foundation.Types.ControlMode.GroundPointing;</pre></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={124,58,237},lineColor={124,58,237},lineThickness=0,radius=0),
      Line(points={{-54,-40},{-18,-40},{-18,0},{18,0},{18,40},{54,40}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={124,58,237},lineColor={124,58,237},lineThickness=0,radius=0),
      Line(points={{-54,-40},{-18,-40},{-18,0},{18,0},{18,40},{54,40}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }));
end RateGyroModeCalculation;