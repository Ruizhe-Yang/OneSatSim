within NISSA_12UCubeSat.Foundation.Interfaces;
expandable connector EnvironmentPort "轨道与空间环境接口"
  RealSignal position[3](each unit="m") "卫星相对地心的GCRS位置";
  RealSignal velocity[3](each unit="m/s") "卫星相对地心的GCRS速度";
  RealSignal quaternion[4];
  RealSignal euler[3](each unit="rad");
  RealSignal bodyRate[3](each unit="rad/s");
  RealSignal sunVectorBody[3];
  RealSignal earthVectorBody[3]
    "Unit vector from spacecraft toward Earth center, expressed in body axes";
  RealSignal targetVectorBody[3]
    "Unit line-of-sight vector from spacecraft to selected imaging target, expressed in body axes; zero when unavailable";
  RealSignal groundStationVectorBody[3]
    "Unit line-of-sight vector from spacecraft to selected ground station, expressed in body axes; zero when unavailable";
  BooleanSignal targetPrePointOpportunity;
  BooleanSignal earlyTargetPrePointOpportunity "180 s class early target pre-slew opportunity";
  BooleanSignal groundPrePointOpportunity;
  IntegerSignal targetPrePointIndex;
  IntegerSignal earlyTargetPrePointIndex;
  IntegerSignal groundPrePointIndex;
  RealSignal targetOpportunityTimeRemaining(unit="s")
    "当前提前成像候选到最佳几何时刻的保守剩余时间";
  RealSignal groundOpportunityTimeRemaining(unit="s")
    "当前地面站候选按局部对称过站估算的剩余机会时间";
  RealSignal activeTargetVectorBody[3]
    "LOS of the command-latched target; available before formal visibility";
  RealSignal activeGroundStationVectorBody[3]
    "LOS of the command-latched station; available before formal contact";
  RealSignal activeTargetTrackingRateBody[3](each unit="rad/s")
    "Feed-forward angular rate of the latched target LOS, resolved in body axes";
  RealSignal activeGroundTrackingRateBody[3](each unit="rad/s")
    "Feed-forward angular rate of the latched ground-station LOS, resolved in body axes";
  BooleanSignal activeTargetVisible;
  BooleanSignal activeTargetPreparationOpportunity "Formal short-horizon preparation condition for the latched target";
  BooleanSignal activeTargetEarlyPrePointOpportunity "Early pre-slew condition for the latched target";
  BooleanSignal activeGroundContact;
  RealSignal targetElevationRate(unit="1/s")
    "Time derivative of sine(target elevation) for the command-latched target";
  RealSignal groundElevationRate(unit="1/s")
    "Time derivative of sine(station elevation) for the command-latched station";
  BooleanSignal targetElevationIncreasing;
  BooleanSignal groundElevationIncreasing;
  RealSignal offNadirAngle(unit="rad")
    "Angle between nadir and the command-latched target line of sight";
  RealSignal cameraLookAngle(unit="rad")
    "Angle between +X camera boresight and the command-latched target line of sight";
  RealSignal targetSunElevation(unit="rad")
    "Solar elevation above the command-latched target local horizon";
  BooleanSignal offNadirValid;
  BooleanSignal cameraFOVValid;
  BooleanSignal targetIlluminationValid;
  BooleanSignal imagingValid
    "Formal target access AND off-nadir limit AND camera FOV AND target illumination";
  RealSignal sunIncidenceAngle(unit="rad");
  RealSignal solarFlux(unit="W/m2");
  RealSignal earthInfraredFlux(unit="W/m2");
  RealSignal albedoFlux(unit="W/m2");
  BooleanSignal eclipse;
  BooleanSignal targetVisible;
  IntegerSignal targetIndex;
  BooleanSignal groundContact;
  IntegerSignal groundStationIndex;
  RealSignal referenceAltitude(unit="m") "标称半长轴减参考地球半径";
  RealSignal instantaneousAltitude(unit="m") "瞬时ECI位置模长减参考地球半径";
  annotation(Icon(graphics={Ellipse(extent={{-82,82},{82,-82}},lineColor={0,110,70},fillColor={220,245,230},fillPattern=FillPattern.Solid),Ellipse(extent={{-20,20},{20,-20}},fillColor={30,130,210},fillPattern=FillPattern.Solid),Line(points={{-72,55},{-30,20}},color={240,170,0},thickness=1),Text(extent={{-70,-35},{70,-65}},textString="ORBIT",textColor={0,100,60})}));
  annotation(Documentation(info="<html><h4>接口语义</h4><p><b>用途：</b>分发位置速度、姿态、太阳/地心方向、热流、地影以及当前选中的目标和地面站。</p><p><b>窄接口：</b>最多8站和32目标的完整可见数组只保留在OrbitalEnvironmentCore内部；总体仅传播选择结果及对应的机体系单位视线向量。</p><p><b>坐标：</b>position和velocity是卫星相对地心的GCRS状态，不是地球日心位置；机体系向量由同一惯性参考和实时姿态转换得到。</p><p><b>高度：</b>referenceAltitude是生效起点状态推导半长轴减参考地球半径；instantaneousAltitude是瞬时GCRS位置模长减参考地球半径。二者不得混用。</p><p><b>变化率：</b>targetElevationRate和groundElevationRate是仰角正弦的时间导数，单位1/s，不是角速度。</p><p><b>信号方向语义：</b>MechanicsOverall/OrbitalEnvironmentCore提供；体装太阳电池阵、热总体、导航、姿控和任务逻辑读取。</p></html>"));
end EnvironmentPort;
