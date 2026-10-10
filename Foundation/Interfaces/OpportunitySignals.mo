within OneSatSim.Foundation.Interfaces;
connector OpportunitySignals "Raw mission opportunities generated from the orbit environment"
  BooleanSignal imagingOpportunity "成像几何机会" ;
  BooleanSignal downlinkOpportunity "地面站机会" ;
  BooleanSignal targetPrePointOpportunity "目标PrePointOpportunity" ;
  BooleanSignal earlyTargetPrePointOpportunity "early目标PrePointOpportunity" ;
  BooleanSignal groundPrePointOpportunity "地面PrePointOpportunity" ;
  RealSignal imagingOpportunityTimeRemaining(unit="s") "成像Opportunity时间Remaining [s]" ;
  RealSignal downlinkOpportunityTimeRemaining(unit="s") "下传Opportunity时间Remaining [s]" ;
  BooleanSignal imagingOpportunityFeasible "成像OpportunityFeasible" ;
  BooleanSignal downlinkOpportunityFeasible "下传OpportunityFeasible" ;
  IntegerSignal targetPrePointIndex "目标PrePointIndex" ;
  IntegerSignal earlyTargetPrePointIndex "early目标PrePointIndex" ;
  IntegerSignal groundPrePointIndex "地面PrePointIndex" ;
  IntegerSignal targetWindowId "目标WindowId" ;
  IntegerSignal groundWindowId "地面WindowId" ;
  BooleanSignal eclipse "计算/接口量 eclipse" ;
  BooleanSignal sunlightAvailable "计算/接口量 sunlightAvailable" ;
  BooleanSignal groundContact "地面Contact" ;
  BooleanSignal targetVisible "目标Visible" ;
  IntegerSignal groundStationIndex "地面站点Index" ;
  IntegerSignal targetIndex "目标Index" ;
  annotation(Documentation(info="<html><h2>Opportunity信号组</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.OpportunitySignals</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>Opportunity信号组。原源码功能描述：Raw mission opportunities generated from the orbit environment</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>imagingOpportunity</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>成像几何机会</td></tr><tr><td><code>downlinkOpportunity</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>地面站机会</td></tr><tr><td><code>targetPrePointOpportunity</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>目标PrePointOpportunity</td></tr><tr><td><code>earlyTargetPrePointOpportunity</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>early目标PrePointOpportunity</td></tr><tr><td><code>groundPrePointOpportunity</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>地面PrePointOpportunity</td></tr><tr><td><code>imagingOpportunityTimeRemaining</code></td><td>RealSignal</td><td>public</td><td>s</td><td>成像Opportunity时间Remaining [s]</td></tr><tr><td><code>downlinkOpportunityTimeRemaining</code></td><td>RealSignal</td><td>public</td><td>s</td><td>下传Opportunity时间Remaining [s]</td></tr><tr><td><code>imagingOpportunityFeasible</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>成像OpportunityFeasible</td></tr><tr><td><code>downlinkOpportunityFeasible</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>下传OpportunityFeasible</td></tr><tr><td><code>targetPrePointIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>目标PrePointIndex</td></tr><tr><td><code>earlyTargetPrePointIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>early目标PrePointIndex</td></tr><tr><td><code>groundPrePointIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>地面PrePointIndex</td></tr><tr><td><code>targetWindowId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>目标WindowId</td></tr><tr><td><code>groundWindowId</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>地面WindowId</td></tr><tr><td><code>eclipse</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 eclipse</td></tr><tr><td><code>sunlightAvailable</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 sunlightAvailable</td></tr><tr><td><code>groundContact</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>地面Contact</td></tr><tr><td><code>targetVisible</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>目标Visible</td></tr><tr><td><code>groundStationIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>地面站点Index</td></tr><tr><td><code>targetIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>目标Index</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={118,184,0},lineColor={118,184,0},lineThickness=0,radius=0),
      Ellipse(extent={{-48,-48},{48,48}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Line(points={{0,32},{0,0},{26,-16}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={118,184,0},lineColor={118,184,0},lineThickness=0,radius=0),
      Ellipse(extent={{-48,-48},{48,48}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Line(points={{0,32},{0,0},{26,-16}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }));
end OpportunitySignals;