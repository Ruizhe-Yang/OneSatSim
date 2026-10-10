within OneSatSim.Foundation.Interfaces;
connector ActiveGeometrySignals "Geometry evaluated for the currently selected mission object"
  BooleanSignal activeTargetVisible "激活目标Visible" ;
  BooleanSignal activeTargetPreparationOpportunity "激活目标PreparationOpportunity" ;
  BooleanSignal activeTargetEarlyPrePointOpportunity "激活目标EarlyPrePointOpportunity" ;
  BooleanSignal activeGroundContact "激活地面Contact" ;
  RealSignal targetElevationRate(unit="1/s") "目标Elevation速率 [1/s]" ;
  RealSignal groundElevationRate(unit="1/s") "地面Elevation速率 [1/s]" ;
  BooleanSignal targetElevationIncreasing "目标ElevationIncreasing" ;
  BooleanSignal groundElevationIncreasing "地面ElevationIncreasing" ;
  RealSignal offNadirAngle(unit="rad") "计算/接口量 offNadirAngle [rad]" ;
  RealSignal cameraLookAngle(unit="rad") "计算/接口量 cameraLookAngle [rad]" ;
  RealSignal targetSunElevation(unit="rad") "目标SunElevation [rad]" ;
  BooleanSignal offNadirValid "计算/接口量 offNadirValid" ;
  BooleanSignal cameraFOVValid "计算/接口量 cameraFOVValid" ;
  BooleanSignal targetIlluminationValid "目标IlluminationValid" ;
  BooleanSignal imagingValid "成像Valid" ;
  annotation(Documentation(info="<html><h2>激活几何信号组</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.ActiveGeometrySignals</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>激活几何信号组。原源码功能描述：Geometry evaluated for the currently selected mission object</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>activeTargetVisible</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>激活目标Visible</td></tr><tr><td><code>activeTargetPreparationOpportunity</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>激活目标PreparationOpportunity</td></tr><tr><td><code>activeTargetEarlyPrePointOpportunity</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>激活目标EarlyPrePointOpportunity</td></tr><tr><td><code>activeGroundContact</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>激活地面Contact</td></tr><tr><td><code>targetElevationRate</code></td><td>RealSignal</td><td>public</td><td>1/s</td><td>目标Elevation速率 [1/s]</td></tr><tr><td><code>groundElevationRate</code></td><td>RealSignal</td><td>public</td><td>1/s</td><td>地面Elevation速率 [1/s]</td></tr><tr><td><code>targetElevationIncreasing</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>目标ElevationIncreasing</td></tr><tr><td><code>groundElevationIncreasing</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>地面ElevationIncreasing</td></tr><tr><td><code>offNadirAngle</code></td><td>RealSignal</td><td>public</td><td>rad</td><td>计算/接口量 offNadirAngle [rad]</td></tr><tr><td><code>cameraLookAngle</code></td><td>RealSignal</td><td>public</td><td>rad</td><td>计算/接口量 cameraLookAngle [rad]</td></tr><tr><td><code>targetSunElevation</code></td><td>RealSignal</td><td>public</td><td>rad</td><td>目标SunElevation [rad]</td></tr><tr><td><code>offNadirValid</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 offNadirValid</td></tr><tr><td><code>cameraFOVValid</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 cameraFOVValid</td></tr><tr><td><code>targetIlluminationValid</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>目标IlluminationValid</td></tr><tr><td><code>imagingValid</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>成像Valid</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,150,136},lineColor={0,150,136},lineThickness=0,radius=0),
      Ellipse(extent={{-33,-33},{33,33}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Line(points={{-56,0},{56,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{0,-56},{0,56}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,150,136},lineColor={0,150,136},lineThickness=0,radius=0),
      Ellipse(extent={{-33,-33},{33,33}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Line(points={{-56,0},{56,0}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{0,-56},{0,56}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }));
end ActiveGeometrySignals;