within OneSatSim.Foundation.Interfaces;
expandable connector EnvironmentPort "轨道与空间环境接口"
  RealSignal position[3](each unit="m") "卫星相对地心的GCRS位置";
  RealSignal velocity[3](each unit="m/s") "卫星相对地心的GCRS速度";
  RealSignal quaternion[4] "四元数" ;
  RealSignal euler[3](each unit="rad") "计算/接口量 euler [rad]" ;
  RealSignal bodyRate[3](each unit="rad/s") "机体系陀螺角速率 [rad/s]" ;
  IntegerSignal activeTargetIndex "锁存目标ID；Command-latched target; 0 means none";
  IntegerSignal activeGroundStationIndex "当前任务锁存的地面站；零表示无下传站；Command-latched station; 0 means none";
  RealSignal sunVectorBody[3] "太阳方向在本体系中的单位向量" ;
  RealSignal sunVectorGCRS[3] "计算/接口量 sunVectorGCRS；Known inertial Sun reference for sensor-frame control";
  RealSignal earthVectorBody[3]
    "地心方向在本体系中的单位向量；Unit vector from spacecraft toward Earth center, expressed in body axes";
  RealSignal targetVectorBody[3]
    "目标Vector本体；Unit line-of-sight vector from spacecraft to selected imaging target, expressed in body axes; zero when unavailable";
  RealSignal groundStationVectorBody[3]
    "地面站点Vector本体；Unit line-of-sight vector from spacecraft to selected ground station, expressed in body axes; zero when unavailable";
  BooleanSignal targetPrePointOpportunity "目标PrePointOpportunity" ;
  BooleanSignal earlyTargetPrePointOpportunity "early目标PrePointOpportunity；180 s class early target pre-slew opportunity";
  BooleanSignal groundPrePointOpportunity "地面PrePointOpportunity" ;
  IntegerSignal targetPrePointIndex "目标PrePointIndex" ;
  IntegerSignal earlyTargetPrePointIndex "early目标PrePointIndex" ;
  IntegerSignal groundPrePointIndex "地面PrePointIndex" ;
  RealSignal targetOpportunityTimeRemaining(unit="s")
    "当前提前成像候选到最佳几何时刻的保守剩余时间";
  RealSignal groundOpportunityTimeRemaining(unit="s")
    "当前地面站候选按局部对称过站估算的剩余机会时间";
  RealSignal activeTargetVectorBody[3]
    "激活目标Vector本体；LOS of the command-latched target; available before formal visibility";
  RealSignal activeTargetVectorGCRS[3]
    "激活目标VectorGCRS；Known inertial LOS of the command-latched target";
  RealSignal activeGroundStationVectorBody[3]
    "激活地面站点Vector本体；LOS of the command-latched station; available before formal contact";
  RealSignal activeGroundStationVectorGCRS[3]
    "激活地面站点VectorGCRS；Known inertial LOS of the command-latched station";
  RealSignal activeTargetTrackingRateBody[3](each unit="rad/s")
    "激活目标跟踪速率本体 [rad/s]；Feed-forward angular rate of the latched target LOS, resolved in body axes";
  RealSignal activeGroundTrackingRateBody[3](each unit="rad/s")
    "激活地面跟踪速率本体 [rad/s]；Feed-forward angular rate of the latched ground-station LOS, resolved in body axes";
  RealSignal activeTargetTrackingRateGCRS[3](each unit="rad/s")
    "激活目标跟踪速率GCRS [rad/s]；Known inertial angular rate of the latched target LOS";
  RealSignal activeGroundTrackingRateGCRS[3](each unit="rad/s")
    "激活地面跟踪速率GCRS [rad/s]；Known inertial angular rate of the latched station LOS";
  BooleanSignal activeTargetVisible "激活目标Visible" ;
  BooleanSignal activeTargetPreparationOpportunity "激活目标PreparationOpportunity；Formal short-horizon preparation condition for the latched target";
  BooleanSignal activeTargetEarlyPrePointOpportunity "激活目标EarlyPrePointOpportunity；Early pre-slew condition for the latched target";
  BooleanSignal activeGroundContact "激活地面Contact" ;
  RealSignal targetElevationRate(unit="1/s")
    "目标Elevation速率 [1/s]；Time derivative of sine(target elevation) for the command-latched target";
  RealSignal groundElevationRate(unit="1/s")
    "地面Elevation速率 [1/s]；Time derivative of sine(station elevation) for the command-latched station";
  BooleanSignal targetElevationIncreasing "目标ElevationIncreasing" ;
  BooleanSignal groundElevationIncreasing "地面ElevationIncreasing" ;
  RealSignal offNadirAngle(unit="rad")
    "计算/接口量 offNadirAngle [rad]；Angle between nadir and the command-latched target line of sight";
  RealSignal cameraLookAngle(unit="rad")
    "计算/接口量 cameraLookAngle [rad]；Angle between +X camera boresight and the command-latched target line of sight";
  RealSignal targetSunElevation(unit="rad")
    "目标SunElevation [rad]；Solar elevation above the command-latched target local horizon";
  BooleanSignal offNadirValid "计算/接口量 offNadirValid" ;
  BooleanSignal cameraFOVValid "计算/接口量 cameraFOVValid" ;
  BooleanSignal targetIlluminationValid "目标IlluminationValid" ;
  BooleanSignal imagingValid
    "成像Valid；Formal target access AND off-nadir limit AND camera FOV AND target illumination";
  RealSignal sunIncidenceAngle(unit="rad") "计算/接口量 sunIncidenceAngle [rad]" ;
  RealSignal solarFlux(unit="W/m2") "太阳辐照通量 [W/m2]" ;
  RealSignal earthInfraredFlux(unit="W/m2") "地球红外通量 [W/m2]" ;
  RealSignal albedoFlux(unit="W/m2") "地球反照通量 [W/m2]" ;
  BooleanSignal eclipse "计算/接口量 eclipse" ;
  BooleanSignal targetVisible "目标Visible" ;
  IntegerSignal targetIndex "目标Index" ;
  BooleanSignal groundContact "地面Contact" ;
  IntegerSignal groundStationIndex "地面站点Index" ;
  RealSignal referenceAltitude(unit="m") "标称半长轴减参考地球半径";
  RealSignal instantaneousAltitude(unit="m") "瞬时ECI位置模长减参考地球半径";

  annotation(Documentation(info="<html><h2>轨道与空间环境接口</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Interfaces.EnvironmentPort</code>　<b>类型：</b>connector</p><h3>用途与定位</h3><p>轨道与空间环境接口</p><h3>连接方法</h3><p>在拥有该边界的模型中实例化，使用真实端口连接。类型、数组维数和成员应与对端一致；字段名相同不自动保证单位、参考系和生产者兼容。input/output、flow/stream及普通字段分别保留原声明语义。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>position[3]</code></td><td>RealSignal</td><td>public</td><td>m</td><td>卫星相对地心的GCRS位置</td></tr><tr><td><code>velocity[3]</code></td><td>RealSignal</td><td>public</td><td>m/s</td><td>卫星相对地心的GCRS速度</td></tr><tr><td><code>quaternion[4]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>四元数</td></tr><tr><td><code>euler[3]</code></td><td>RealSignal</td><td>public</td><td>rad</td><td>计算/接口量 euler [rad]</td></tr><tr><td><code>bodyRate[3]</code></td><td>RealSignal</td><td>public</td><td>rad/s</td><td>机体系陀螺角速率 [rad/s]</td></tr><tr><td><code>activeTargetIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>锁存目标ID；Command-latched target; 0 means none</td></tr><tr><td><code>activeGroundStationIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>当前任务锁存的地面站；零表示无下传站；Command-latched station; 0 means none</td></tr><tr><td><code>sunVectorBody[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>太阳方向在本体系中的单位向量</td></tr><tr><td><code>sunVectorGCRS[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 sunVectorGCRS；Known inertial Sun reference for sensor-frame control</td></tr><tr><td><code>earthVectorBody[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>地心方向在本体系中的单位向量；Unit vector from spacecraft toward Earth center, expressed in body axes</td></tr><tr><td><code>targetVectorBody[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>目标Vector本体；Unit line-of-sight vector from spacecraft to selected imaging target, expressed in body axes; zero when unavailable</td></tr><tr><td><code>groundStationVectorBody[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>地面站点Vector本体；Unit line-of-sight vector from spacecraft to selected ground station, expressed in body axes; zero when unavailable</td></tr><tr><td><code>targetPrePointOpportunity</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>目标PrePointOpportunity</td></tr><tr><td><code>earlyTargetPrePointOpportunity</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>early目标PrePointOpportunity；180 s class early target pre-slew opportunity</td></tr><tr><td><code>groundPrePointOpportunity</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>地面PrePointOpportunity</td></tr><tr><td><code>targetPrePointIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>目标PrePointIndex</td></tr><tr><td><code>earlyTargetPrePointIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>early目标PrePointIndex</td></tr><tr><td><code>groundPrePointIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>地面PrePointIndex</td></tr><tr><td><code>targetOpportunityTimeRemaining</code></td><td>RealSignal</td><td>public</td><td>s</td><td>当前提前成像候选到最佳几何时刻的保守剩余时间</td></tr><tr><td><code>groundOpportunityTimeRemaining</code></td><td>RealSignal</td><td>public</td><td>s</td><td>当前地面站候选按局部对称过站估算的剩余机会时间</td></tr><tr><td><code>activeTargetVectorBody[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>激活目标Vector本体；LOS of the command-latched target; available before formal visibility</td></tr><tr><td><code>activeTargetVectorGCRS[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>激活目标VectorGCRS；Known inertial LOS of the command-latched target</td></tr><tr><td><code>activeGroundStationVectorBody[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>激活地面站点Vector本体；LOS of the command-latched station; available before formal contact</td></tr><tr><td><code>activeGroundStationVectorGCRS[3]</code></td><td>RealSignal</td><td>public</td><td>按声明/类型合同</td><td>激活地面站点VectorGCRS；Known inertial LOS of the command-latched station</td></tr><tr><td><code>activeTargetTrackingRateBody[3]</code></td><td>RealSignal</td><td>public</td><td>rad/s</td><td>激活目标跟踪速率本体 [rad/s]；Feed-forward angular rate of the latched target LOS, resolved in body axes</td></tr><tr><td><code>activeGroundTrackingRateBody[3]</code></td><td>RealSignal</td><td>public</td><td>rad/s</td><td>激活地面跟踪速率本体 [rad/s]；Feed-forward angular rate of the latched ground-station LOS, resolved in body axes</td></tr><tr><td><code>activeTargetTrackingRateGCRS[3]</code></td><td>RealSignal</td><td>public</td><td>rad/s</td><td>激活目标跟踪速率GCRS [rad/s]；Known inertial angular rate of the latched target LOS</td></tr><tr><td><code>activeGroundTrackingRateGCRS[3]</code></td><td>RealSignal</td><td>public</td><td>rad/s</td><td>激活地面跟踪速率GCRS [rad/s]；Known inertial angular rate of the latched station LOS</td></tr><tr><td><code>activeTargetVisible</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>激活目标Visible</td></tr><tr><td><code>activeTargetPreparationOpportunity</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>激活目标PreparationOpportunity；Formal short-horizon preparation condition for the latched target</td></tr><tr><td><code>activeTargetEarlyPrePointOpportunity</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>激活目标EarlyPrePointOpportunity；Early pre-slew condition for the latched target</td></tr><tr><td><code>activeGroundContact</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>激活地面Contact</td></tr><tr><td><code>targetElevationRate</code></td><td>RealSignal</td><td>public</td><td>1/s</td><td>目标Elevation速率 [1/s]；Time derivative of sine(target elevation) for the command-latched target</td></tr><tr><td><code>groundElevationRate</code></td><td>RealSignal</td><td>public</td><td>1/s</td><td>地面Elevation速率 [1/s]；Time derivative of sine(station elevation) for the command-latched station</td></tr><tr><td><code>targetElevationIncreasing</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>目标ElevationIncreasing</td></tr><tr><td><code>groundElevationIncreasing</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>地面ElevationIncreasing</td></tr><tr><td><code>offNadirAngle</code></td><td>RealSignal</td><td>public</td><td>rad</td><td>计算/接口量 offNadirAngle [rad]；Angle between nadir and the command-latched target line of sight</td></tr><tr><td><code>cameraLookAngle</code></td><td>RealSignal</td><td>public</td><td>rad</td><td>计算/接口量 cameraLookAngle [rad]；Angle between +X camera boresight and the command-latched target line of sight</td></tr><tr><td><code>targetSunElevation</code></td><td>RealSignal</td><td>public</td><td>rad</td><td>目标SunElevation [rad]；Solar elevation above the command-latched target local horizon</td></tr><tr><td><code>offNadirValid</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 offNadirValid</td></tr><tr><td><code>cameraFOVValid</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 cameraFOVValid</td></tr><tr><td><code>targetIlluminationValid</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>目标IlluminationValid</td></tr><tr><td><code>imagingValid</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>成像Valid；Formal target access AND off-nadir limit AND camera FOV AND target illumination</td></tr><tr><td><code>sunIncidenceAngle</code></td><td>RealSignal</td><td>public</td><td>rad</td><td>计算/接口量 sunIncidenceAngle [rad]</td></tr><tr><td><code>solarFlux</code></td><td>RealSignal</td><td>public</td><td>W/m2</td><td>太阳辐照通量 [W/m2]</td></tr><tr><td><code>earthInfraredFlux</code></td><td>RealSignal</td><td>public</td><td>W/m2</td><td>地球红外通量 [W/m2]</td></tr><tr><td><code>albedoFlux</code></td><td>RealSignal</td><td>public</td><td>W/m2</td><td>地球反照通量 [W/m2]</td></tr><tr><td><code>eclipse</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 eclipse</td></tr><tr><td><code>targetVisible</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>目标Visible</td></tr><tr><td><code>targetIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>目标Index</td></tr><tr><td><code>groundContact</code></td><td>BooleanSignal</td><td>public</td><td>按声明/类型合同</td><td>地面Contact</td></tr><tr><td><code>groundStationIndex</code></td><td>IntegerSignal</td><td>public</td><td>按声明/类型合同</td><td>地面站点Index</td></tr><tr><td><code>referenceAltitude</code></td><td>RealSignal</td><td>public</td><td>m</td><td>标称半长轴减参考地球半径</td></tr><tr><td><code>instantaneousAltitude</code></td><td>RealSignal</td><td>public</td><td>m</td><td>瞬时ECI位置模长减参考地球半径</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,166,81},lineColor={0,166,81},lineThickness=0,radius=0),
      Ellipse(extent={{-48,-48},{48,48}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Line(points={{-55,-25},{55,25}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{0,-48},{0,48}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={0,166,81},lineColor={0,166,81},lineThickness=0,radius=0),
      Ellipse(extent={{-48,-48},{48,48}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Line(points={{-55,-25},{55,25}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None),
      Line(points={{0,-48},{0,48}},color={255,255,255},thickness=1.4,pattern=LinePattern.Solid,smooth=Smooth.None)
    }));
end EnvironmentPort;