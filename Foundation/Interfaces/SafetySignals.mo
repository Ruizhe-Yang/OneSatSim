within OneSatSim.Foundation.Interfaces;
connector SafetySignals "Mission safety permissions and safe-mode demand"
  BooleanSignal spacecraftHealthy "计算/接口量 spacecraftHealthy" ;
  BooleanSignal imagingAllowed "成像Allowed" ;
  BooleanSignal downlinkAllowed "下传Allowed" ;
  BooleanSignal powerHealthy "功率Healthy" ;
  BooleanSignal thermalHealthy "热学Healthy" ;
  BooleanSignal attitudeHealthy "姿态Healthy" ;
  BooleanSignal storageHealthy "计算/接口量 storageHealthy" ;
  BooleanSignal safeModeRequired "安全模式模式Required" ;
  BooleanSignal recoveryAllowed "计算/接口量 recoveryAllowed" ;
  RejectReasonSignal safetyReason "计算/接口量 safetyReason" ;
  annotation(Documentation(info="<html><h2>Safety信号组</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.SafetySignals</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>Safety信号组。原源码功能描述：Mission safety permissions and safe-mode demand</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>spacecraftHealthy</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 spacecraftHealthy</td></tr><tr><td><code>imagingAllowed</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>成像Allowed</td></tr><tr><td><code>downlinkAllowed</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>下传Allowed</td></tr><tr><td><code>powerHealthy</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>功率Healthy</td></tr><tr><td><code>thermalHealthy</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>热学Healthy</td></tr><tr><td><code>attitudeHealthy</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>姿态Healthy</td></tr><tr><td><code>storageHealthy</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 storageHealthy</td></tr><tr><td><code>safeModeRequired</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>安全模式模式Required</td></tr><tr><td><code>recoveryAllowed</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 recoveryAllowed</td></tr><tr><td><code>safetyReason</code></td><td>RejectReasonSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 safetyReason</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={198,40,40},lineColor={198,40,40},lineThickness=0,radius=0),
      Polygon(points={{0,56},{46,35},{35,-26},{0,-56},{-35,-26},{-46,35},{0,56}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4),
      Line(points={{-22,0},{-4,-18},{25,20}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={198,40,40},lineColor={198,40,40},lineThickness=0,radius=0),
      Polygon(points={{0,56},{46,35},{35,-26},{0,-56},{-35,-26},{-46,35},{0,56}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4),
      Line(points={{-22,0},{-4,-18},{25,20}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }));
end SafetySignals;