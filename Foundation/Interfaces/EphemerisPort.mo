within OneSatSim.Foundation.Interfaces;
connector EphemerisPort "One generated GCRS and Earth-orientation data stream"
  RealSignal position[3](each unit="m") "卫星相对地心的GCRS位置 [m]" ;
  RealSignal velocity[3](each unit="m/s") "卫星相对地心的GCRS速度 [m/s]" ;
  RealSignal sunDirection[3](each unit="1") "sun方向 [1]" ;
  RealSignal earthToInertial[3,3](each unit="1") "earth转换为Inertial [1]" ;
  RealSignal earthToInertialRate[3,3](each unit="1/s") "earth转换为Inertial速率 [1/s]" ;
  annotation(Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,172,193},lineColor={0,172,193},lineThickness=0,radius=0),
      Ellipse(extent={{-58,-30},{58,30}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Ellipse(extent={{27,12},{49,34}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,startAngle=0,endAngle=360),
      Line(points={{-8,-50},{-8,50}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,172,193},lineColor={0,172,193},lineThickness=0,radius=0),
      Ellipse(extent={{-58,-30},{58,30}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Ellipse(extent={{27,12},{49,34}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,startAngle=0,endAngle=360),
      Line(points={{-8,-50},{-8,50}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }), Documentation(info="<html><h2>Ephemeris接口</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.EphemerisPort</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>Ephemeris接口。原源码功能描述：One generated GCRS and Earth-orientation data stream</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>position[3]</code></td><td>RealSignal</td><td>public</td><td>m</td><td>卫星相对地心的GCRS位置 [m]</td></tr><tr><td><code>velocity[3]</code></td><td>RealSignal</td><td>public</td><td>m/s</td><td>卫星相对地心的GCRS速度 [m/s]</td></tr><tr><td><code>sunDirection[3]</code></td><td>RealSignal</td><td>public</td><td>1</td><td>sun方向 [1]</td></tr><tr><td><code>earthToInertial[3,3]</code></td><td>RealSignal</td><td>public</td><td>1</td><td>earth转换为Inertial [1]</td></tr><tr><td><code>earthToInertialRate[3,3]</code></td><td>RealSignal</td><td>public</td><td>1/s</td><td>earth转换为Inertial速率 [1/s]</td></tr></table></html>"));
end EphemerisPort;