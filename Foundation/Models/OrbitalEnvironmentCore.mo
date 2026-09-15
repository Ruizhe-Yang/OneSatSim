within NISSA_12UCubeSat.Foundation.Models;
model OrbitalEnvironmentCore "真实历元轨道、多地面站与多目标环境核心"
  import SI=Modelica.Units.SI;
  parameter NISSA_12UCubeSat.Scenarios.OrbitConfig orbit "真实历元轨道输入及生成环境资源";
  parameter NISSA_12UCubeSat.Scenarios.GroundStationConfig groundStations[8] "最多8个地面站";
  parameter NISSA_12UCubeSat.Scenarios.ImagingTargetConfig imagingTargets[32] "最多32个拍摄目标";
  parameter SI.Length earthRadius=6378137;
  final parameter SI.Length referenceAltitude=orbit.referenceSemiMajorAxis-earthRadius
    "标称轨道高度，不代表椭圆轨道瞬时高度";
  parameter SI.Time orbitPeriod=2*Modelica.Constants.pi*sqrt(orbit.referenceSemiMajorAxis^3/3.986004418e14) "起点状态对应的圆轨道等效周期";
  parameter SI.Angle targetPrePointingMargin=18*Modelica.Constants.pi/180
    "任务级参数：正式目标可见前的高度角余量";
  parameter SI.Angle groundPrePointingMargin=4*Modelica.Constants.pi/180
    "任务级参数：正式地面站可见前的高度角余量";
  parameter SI.Time targetPredictionHorizon=84
    "代数前视时域；在90 s准备时限内为线性化误差保留6 s";
  parameter SI.Time earlyTargetPredictionHorizon=180
    "仅供相机关闭状态下目标预机动使用的提前前视时域";
  parameter SI.Time groundPredictionHorizon=180
    "排除无法在准备时限内进入正式可见区的掠过预指向机会";
  parameter SI.Angle maxOffNadir_deg=30*Modelica.Constants.pi/180
    "任务级参数：对地观测最大偏离天底角";
  parameter SI.Angle cameraHalfFOV_deg=7*Modelica.Constants.pi/180
    "任务级参数：+X对地相机半视场角；全视场角按14 deg设置";
  parameter SI.Angle minTargetSunElevation_deg=0*Modelica.Constants.pi/180
    "任务级参数：目标照明的最小太阳高度角";
  Modelica.Blocks.Interfaces.RealInput euler[3];
  Modelica.Blocks.Interfaces.RealInput bodyRate[3];
  NISSA_12UCubeSat.Foundation.Interfaces.ActiveMissionSelectionInput activeMissionSelection
    "来自OBC的任务对象锁存索引";
  NISSA_12UCubeSat.Foundation.Interfaces.EnvironmentPort environment annotation(Placement(transformation(extent={{90,-10},{110,10}})));
protected
  Foundation.Models.EphemerisEnvironmentReader environmentData(
    dataURI=orbit.environmentDataURI,
    tableName=orbit.environmentTableName,
    simulationDuration=orbit.simulationDuration,
    tableRows=orbit.environmentTableRows) annotation(Placement(transformation(extent={{-88,70},{-62,88}})));
  Modelica.Blocks.Interfaces.RealOutput positionPublisher[3](each unit="m") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput velocityPublisher[3](each unit="m/s") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput quaternionPublisher[4] annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput eulerPublisher[3](each unit="rad") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput bodyRatePublisher[3](each unit="rad/s") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput sunVectorBodyPublisher[3] annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput earthVectorBodyPublisher[3] annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput targetVectorBodyPublisher[3] annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput groundStationVectorBodyPublisher[3] annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput targetPrePointOpportunityPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput earlyTargetPrePointOpportunityPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput groundPrePointOpportunityPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.IntegerOutput targetPrePointIndexPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.IntegerOutput earlyTargetPrePointIndexPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.IntegerOutput groundPrePointIndexPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput targetOpportunityTimeRemainingPublisher(unit="s") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput groundOpportunityTimeRemainingPublisher(unit="s") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput activeTargetVectorBodyPublisher[3] annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput activeGroundStationVectorBodyPublisher[3] annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput activeTargetTrackingRateBodyPublisher[3](each unit="rad/s") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput activeGroundTrackingRateBodyPublisher[3](each unit="rad/s") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput activeTargetVisiblePublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput activeTargetPreparationOpportunityPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput activeTargetEarlyPrePointOpportunityPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput activeGroundContactPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput targetElevationRatePublisher(unit="1/s") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput groundElevationRatePublisher(unit="1/s") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput targetElevationIncreasingPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput groundElevationIncreasingPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput offNadirAnglePublisher(unit="rad") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput cameraLookAnglePublisher(unit="rad") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput targetSunElevationPublisher(unit="rad") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput offNadirValidPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput cameraFOVValidPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput targetIlluminationValidPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput imagingValidPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput sunIncidenceAnglePublisher(unit="rad") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput solarFluxPublisher(unit="W/m2") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput earthInfraredFluxPublisher(unit="W/m2") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput albedoFluxPublisher(unit="W/m2") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput eclipsePublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput targetVisiblePublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.IntegerOutput targetIndexPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.BooleanOutput groundContactPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.IntegerOutput groundStationIndexPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput referenceAltitudePublisher(unit="m") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.RealOutput instantaneousAltitudePublisher(unit="m") annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  final parameter Real cosMaxOffNadir=cos(maxOffNadir_deg);
  final parameter Real cosCameraHalfFOV=cos(cameraHalfFOV_deg);
  final parameter Real sinMinTargetSunElevation=sin(minTargetSunElevation_deg);
  final parameter Real stationSinLatitude[8]={sin(groundStations[i].latitude) for i in 1:8};
  final parameter Real stationCosLatitude[8]={cos(groundStations[i].latitude) for i in 1:8};
  final parameter Real stationSinLongitude[8]={sin(groundStations[i].longitude) for i in 1:8};
  final parameter Real stationCosLongitude[8]={cos(groundStations[i].longitude) for i in 1:8};
  final parameter Real stationRadius[8]={earthRadius+groundStations[i].altitude for i in 1:8};
  final parameter Real stationMinimumElevationSin[8]={sin(groundStations[i].minimumElevation) for i in 1:8};
  final parameter Real stationPrePointElevationSin[8]={sin(max(-Modelica.Constants.pi/2,
    groundStations[i].minimumElevation-groundPrePointingMargin)) for i in 1:8};
  final parameter Real targetSinLatitude[32]={sin(imagingTargets[i].latitude) for i in 1:32};
  final parameter Real targetCosLatitude[32]={cos(imagingTargets[i].latitude) for i in 1:32};
  final parameter Real targetSinLongitude[32]={sin(imagingTargets[i].longitude) for i in 1:32};
  final parameter Real targetCosLongitude[32]={cos(imagingTargets[i].longitude) for i in 1:32};
  final parameter Real targetRadius[32]={earthRadius+imagingTargets[i].altitude for i in 1:32};
  final parameter Real targetMinimumElevationSin[32]={sin(imagingTargets[i].minimumElevation) for i in 1:32};
  final parameter Real targetPrePointElevationSin[32]={sin(max(-Modelica.Constants.pi/2,
    imagingTargets[i].minimumElevation-targetPrePointingMargin)) for i in 1:32};
  Real sunECI[3] "Normalized inertial Sun direction";
  Real earthVectorECI[3]
    "Unit vector from spacecraft toward Earth center in inertial axes";
  Real spacecraftRange2;
  Real spacecraftInvRange;
  Real worldToBody[3,3]
    "MSL rotation matrix using the same {1,2,3} sequence as AbsoluteAngles";
  Real halfRollCos;
  Real halfRollSin;
  Real halfPitchCos;
  Real halfPitchSin;
  Real halfYawCos;
  Real halfYawSin;
  Real stationUnitEarth[8,3] "球形ITRS站点单位矢量";
  Real stationUnit[8,3];
  Real stationPosition[8,3];
  Real stationRelative[8,3];
  Real stationVelocity[8,3];
  Real stationRelativeVelocity[8,3];
  Real stationElevationSin[8];
  Real stationElevationRate[8];
  Real stationRange2[8];
  Real stationInvRange[8];
  Real stationRelativeDotVelocity[8];
  Real stationClosestTime[8];
  Real stationPredictedRelative[8,3];
  Real stationPredictedPosition[8,3];
  Real stationPredictedRange2[8];
  Real stationPredictedRadius2[8];
  Real stationPredictedElevationSin[8];
  Boolean stationVisible[8];
  Boolean stationPrePoint[8];
  Integer stationBestPriority[8];
  Integer stationSelectedIndex[8];
  Integer stationPrePointBestPriority[8];
  Integer stationPrePointSelectedIndex[8];
  Real selectedGroundVectorECI[3]
    "Unit line of sight from spacecraft to selected ground station";
  Integer selectedGroundIndex;
  Boolean selectedGroundIndexValid;
  Integer activeGroundIndex;
  Boolean activeGroundIndexValid;
  Boolean activeGroundEnabled;
  Real activeGroundVectorECI[3]
    "LOS to the command-latched station, independent of live top-priority selection";
  Real activeGroundVectorRateECI[3];
  Real activeGroundTrackingRateECI[3];
  Real targetUnitEarth[32,3] "球形ITRS目标单位矢量";
  Real targetUnit[32,3];
  Real targetPosition[32,3];
  Real targetRelative[32,3];
  Real targetVelocity[32,3];
  Real targetRelativeVelocity[32,3];
  Real targetElevationSin[32];
  Real targetElevationRate[32];
  Real targetRange2[32];
  Real targetInvRange[32];
  Real targetRelativeDotVelocity[32];
  Real targetOffNadirCos[32];
  Real targetSunElevationSin[32];
  Real targetClosestTime[32]
    "Clamped constant-velocity time to closest relative approach";
  Real targetPredictedRelative[32,3];
  Real targetPredictedSpacecraft[32,3];
  Real targetPredictedRange2[32];
  Real targetPredictedSpacecraftRange2[32];
  Real targetPredictedOffNadirCos[32]
    "Predicted best off-nadir cosine without a new orbit state or search loop";
  Real targetEarlyClosestTime[32];
  Real targetEarlyPredictedRelative[32,3];
  Real targetEarlyPredictedSpacecraft[32,3];
  Real targetEarlyPredictedRange2[32];
  Real targetEarlyPredictedSpacecraftRange2[32];
  Real targetEarlyPredictedOffNadirCos[32];
  Boolean targetVisibleInternal[32];
  Boolean targetPrePoint[32];
  Boolean targetEarlyPrePoint[32];
  Integer targetBestPriority[32];
  Integer targetSelectedIndex[32];
  Integer targetPrePointBestPriority[32];
  Integer targetPrePointSelectedIndex[32];
  Integer targetEarlyPrePointBestPriority[32];
  Integer targetEarlyPrePointSelectedIndex[32];
  Real selectedTargetVectorECI[3]
    "Unit line of sight from spacecraft to selected imaging target";
  Integer selectedTargetIndex;
  Boolean selectedTargetIndexValid;
  Integer activeTargetIndex;
  Boolean activeTargetIndexValid;
  Boolean activeTargetEnabled;
  Real activeTargetVectorECI[3]
    "LOS to the command-latched target, independent of live top-priority selection";
  Real activeTargetVectorRateECI[3];
  Real activeTargetTrackingRateECI[3];
  Real activeTargetOffNadirCos;
  Real activeTargetSunElevationSin;
  Foundation.Interfaces.RealSignalBridge informationRealBridge[53] annotation(Placement(transformation(extent={{58,-92},{66,-84}})));
  Foundation.Interfaces.IntegerSignalBridge informationIntegerBridge[5] annotation(Placement(transformation(extent={{70,-92},{78,-84}})));
  Foundation.Interfaces.BooleanSignalBridge informationBooleanBridge[16] annotation(Placement(transformation(extent={{82,-92},{90,-84}})));
initial equation
  assert(orbit.eccentricity >= 0 and orbit.eccentricity < 1,"Orbit eccentricity must satisfy 0 <= e < 1");
  assert(orbit.semiMajorAxis > earthRadius + 100000 and orbit.semiMajorAxis < earthRadius + 100000000,"Orbit semi-major axis is outside the supported low-Earth/system-level range");
  for i in 1:8 loop
    assert(not groundStations[i].enabled or groundStations[i].id > 0,"Enabled ground-station ID must be positive");
    assert(not groundStations[i].enabled or (groundStations[i].latitude >= -Modelica.Constants.pi/2 and groundStations[i].latitude <= Modelica.Constants.pi/2),"Ground-station latitude must be within [-pi/2, pi/2]");
    assert(not groundStations[i].enabled or (groundStations[i].longitude >= -Modelica.Constants.pi and groundStations[i].longitude <= Modelica.Constants.pi),"Ground-station longitude must be within [-pi, pi]");
  end for;
  for i in 1:32 loop
    assert(not imagingTargets[i].enabled or imagingTargets[i].id > 0,"Enabled imaging-target ID must be positive");
    assert(not imagingTargets[i].enabled or (imagingTargets[i].latitude >= -Modelica.Constants.pi/2 and imagingTargets[i].latitude <= Modelica.Constants.pi/2),"Imaging-target latitude must be within [-pi/2, pi/2]");
    assert(not imagingTargets[i].enabled or (imagingTargets[i].longitude >= -Modelica.Constants.pi and imagingTargets[i].longitude <= Modelica.Constants.pi),"Imaging-target longitude must be within [-pi, pi]");
  end for;
equation
  positionPublisher=environmentData.position;
  velocityPublisher=environmentData.velocity;
  sunECI=environmentData.sunDirection;
  spacecraftRange2=max(1e-12,environment.position*environment.position);
  spacecraftInvRange=1/sqrt(spacecraftRange2);
  earthVectorECI=-environment.position*spacecraftInvRange;
  eclipsePublisher=environment.position*sunECI < -sqrt(max(0,spacecraftRange2-earthRadius^2));
  solarFluxPublisher=if environment.eclipse then 0 else 1361;
  earthInfraredFluxPublisher=237;
  albedoFluxPublisher=if environment.eclipse then 0 else 0.30*1361*earthRadius^2/spacecraftRange2;
  eulerPublisher=euler;
  bodyRatePublisher=bodyRate;
  worldToBody=Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.axesRotations({1,2,3},euler);
  halfRollCos=cos(0.5*euler[1]);
  halfRollSin=sin(0.5*euler[1]);
  halfPitchCos=cos(0.5*euler[2]);
  halfPitchSin=sin(0.5*euler[2]);
  halfYawCos=cos(0.5*euler[3]);
  halfYawSin=sin(0.5*euler[3]);
  quaternionPublisher[1]=halfRollCos*halfPitchCos*halfYawCos-halfRollSin*halfPitchSin*halfYawSin;
  quaternionPublisher[2]=halfRollSin*halfPitchCos*halfYawCos+halfRollCos*halfPitchSin*halfYawSin;
  quaternionPublisher[3]=halfRollCos*halfPitchSin*halfYawCos-halfRollSin*halfPitchCos*halfYawSin;
  quaternionPublisher[4]=halfRollCos*halfPitchCos*halfYawSin+halfRollSin*halfPitchSin*halfYawCos;
  sunVectorBodyPublisher=Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve2(worldToBody,sunECI);
  earthVectorBodyPublisher=Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve2(worldToBody,earthVectorECI);
  sunIncidenceAnglePublisher=acos(max(-1,min(1,environment.sunVectorBody[1])));
  for i in 1:8 loop
    stationUnitEarth[i,:]={stationCosLatitude[i]*stationCosLongitude[i],
      stationCosLatitude[i]*stationSinLongitude[i],stationSinLatitude[i]};
    stationUnit[i,:]=environmentData.earthToInertial*stationUnitEarth[i,:];
    stationPosition[i,:]=stationRadius[i]*stationUnit[i,:];
    stationRelative[i,:]=environment.position-stationPosition[i,:];
    stationVelocity[i,:]=stationRadius[i]*(environmentData.earthToInertialRate*stationUnitEarth[i,:]);
    stationRelativeVelocity[i,:]=environment.velocity-stationVelocity[i,:];
    stationRange2[i]=max(1e-12,stationRelative[i,:]*stationRelative[i,:]);
    stationInvRange[i]=1/sqrt(stationRange2[i]);
    stationRelativeDotVelocity[i]=stationRelative[i,:]*stationRelativeVelocity[i,:];
    stationElevationSin[i]=(stationRelative[i,:]*stationUnit[i,:])*stationInvRange[i];
    stationElevationRate[i]=(stationRelativeVelocity[i,:]*stationUnit[i,:]+
      stationRelative[i,:]*stationVelocity[i,:]/stationRadius[i])*stationInvRange[i]-
      stationElevationSin[i]*stationRelativeDotVelocity[i]/stationRange2[i];
    stationClosestTime[i]=noEvent(max(0,min(groundPredictionHorizon,
      -stationRelativeDotVelocity[i]/max(1e-9,stationRelativeVelocity[i,:]*stationRelativeVelocity[i,:]))));
    stationPredictedRelative[i,:]=stationRelative[i,:]+stationClosestTime[i]*stationRelativeVelocity[i,:];
    stationPredictedPosition[i,:]=stationPosition[i,:]+stationClosestTime[i]*stationVelocity[i,:];
    stationPredictedRange2[i]=max(1e-12,stationPredictedRelative[i,:]*stationPredictedRelative[i,:]);
    stationPredictedRadius2[i]=max(1e-12,stationPredictedPosition[i,:]*stationPredictedPosition[i,:]);
    stationPredictedElevationSin[i]=(stationPredictedRelative[i,:]*stationPredictedPosition[i,:])/
      sqrt(stationPredictedRange2[i]*stationPredictedRadius2[i]);
    stationVisible[i]=groundStations[i].enabled and stationElevationSin[i] > stationMinimumElevationSin[i];
    stationPrePoint[i]=groundStations[i].enabled and stationElevationSin[i] > stationPrePointElevationSin[i] and
      stationElevationRate[i] > 0 and stationPredictedElevationSin[i] >= stationMinimumElevationSin[i];
  end for;
  stationBestPriority[1]=if stationVisible[1] then groundStations[1].priority else -1000000000;
  stationSelectedIndex[1]=if stationVisible[1] then 1 else 0;
  for i in 2:8 loop
    stationBestPriority[i]=if stationVisible[i] and (stationSelectedIndex[i-1] == 0 or groundStations[i].priority > stationBestPriority[i-1]) then groundStations[i].priority else stationBestPriority[i-1];
    stationSelectedIndex[i]=if stationVisible[i] and (stationSelectedIndex[i-1] == 0 or groundStations[i].priority > stationBestPriority[i-1]) then i else stationSelectedIndex[i-1];
  end for;
  stationPrePointBestPriority[1]=if stationPrePoint[1] then groundStations[1].priority else -1000000000;
  stationPrePointSelectedIndex[1]=if stationPrePoint[1] then 1 else 0;
  for i in 2:8 loop
    stationPrePointBestPriority[i]=if stationPrePoint[i] and (stationPrePointSelectedIndex[i-1] == 0 or groundStations[i].priority > stationPrePointBestPriority[i-1]) then groundStations[i].priority else stationPrePointBestPriority[i-1];
    stationPrePointSelectedIndex[i]=if stationPrePoint[i] and (stationPrePointSelectedIndex[i-1] == 0 or groundStations[i].priority > stationPrePointBestPriority[i-1]) then i else stationPrePointSelectedIndex[i-1];
  end for;
  groundPrePointIndexPublisher=stationPrePointSelectedIndex[8];
  groundPrePointOpportunityPublisher=environment.groundPrePointIndex > 0;
  groundOpportunityTimeRemainingPublisher=noEvent(if environment.groundPrePointIndex > 0 then
    NISSA_12UCubeSat.Foundation.Functions.estimateGroundContactDuration(
      stationRelative[environment.groundPrePointIndex,:],
      stationRelativeVelocity[environment.groundPrePointIndex,:],
      stationPosition[environment.groundPrePointIndex,:],
      stationVelocity[environment.groundPrePointIndex,:],
      stationMinimumElevationSin[environment.groundPrePointIndex],
      groundPredictionHorizon) else 0);
  groundStationIndexPublisher=stationSelectedIndex[8];
  groundContactPublisher=environment.groundStationIndex > 0;
  selectedGroundIndex=stationSelectedIndex[8];
  selectedGroundIndexValid=selectedGroundIndex >= 1 and selectedGroundIndex <= 8;
  activeGroundIndex=activeMissionSelection.groundStationIndex;
  activeGroundIndexValid=activeGroundIndex >= 1 and activeGroundIndex <= 8;
  activeGroundEnabled=if activeGroundIndexValid then groundStations[activeGroundIndex].enabled else false;
  for j in 1:3 loop
    selectedGroundVectorECI[j]=if selectedGroundIndexValid then
      -stationRelative[selectedGroundIndex,j]*stationInvRange[selectedGroundIndex] else 0;
    activeGroundVectorECI[j]=if activeGroundEnabled then
      -stationRelative[activeGroundIndex,j]*stationInvRange[activeGroundIndex] else 0;
    activeGroundVectorRateECI[j]=if activeGroundEnabled then
      -stationRelativeVelocity[activeGroundIndex,j]*stationInvRange[activeGroundIndex]+
      stationRelative[activeGroundIndex,j]*stationRelativeDotVelocity[activeGroundIndex]*
      stationInvRange[activeGroundIndex]^3 else 0;
  end for;
  groundStationVectorBodyPublisher=Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve2(worldToBody,selectedGroundVectorECI);
  activeGroundContactPublisher=if activeGroundIndexValid then stationVisible[activeGroundIndex] else false;
  groundElevationRatePublisher=if activeGroundIndexValid then stationElevationRate[activeGroundIndex] else 0;
  groundElevationIncreasingPublisher=environment.groundElevationRate > 0;
  activeGroundStationVectorBodyPublisher=Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve2(worldToBody,activeGroundVectorECI);
  activeGroundTrackingRateECI=cross(activeGroundVectorECI,activeGroundVectorRateECI);
  activeGroundTrackingRateBodyPublisher=Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve2(worldToBody,activeGroundTrackingRateECI);
  for i in 1:32 loop
    targetUnitEarth[i,:]={targetCosLatitude[i]*targetCosLongitude[i],
      targetCosLatitude[i]*targetSinLongitude[i],targetSinLatitude[i]};
    targetUnit[i,:]=environmentData.earthToInertial*targetUnitEarth[i,:];
    targetPosition[i,:]=targetRadius[i]*targetUnit[i,:];
    targetRelative[i,:]=environment.position-targetPosition[i,:];
    targetVelocity[i,:]=targetRadius[i]*(environmentData.earthToInertialRate*targetUnitEarth[i,:]);
    targetRelativeVelocity[i,:]=environment.velocity-targetVelocity[i,:];
    targetRange2[i]=max(1e-12,targetRelative[i,:]*targetRelative[i,:]);
    targetInvRange[i]=1/sqrt(targetRange2[i]);
    targetRelativeDotVelocity[i]=targetRelative[i,:]*targetRelativeVelocity[i,:];
    targetElevationSin[i]=(targetRelative[i,:]*targetUnit[i,:])*targetInvRange[i];
    targetElevationRate[i]=(targetRelativeVelocity[i,:]*targetUnit[i,:]+
      targetRelative[i,:]*targetVelocity[i,:]/targetRadius[i])*targetInvRange[i]-
      targetElevationSin[i]*targetRelativeDotVelocity[i]/targetRange2[i];
    targetOffNadirCos[i]=(targetRelative[i,:]*environment.position)*targetInvRange[i]*spacecraftInvRange;
    targetSunElevationSin[i]=targetUnit[i,:]*sunECI;
    targetClosestTime[i]=noEvent(max(0,min(targetPredictionHorizon,
      -targetRelativeDotVelocity[i]/max(1e-9,targetRelativeVelocity[i,:]*targetRelativeVelocity[i,:]))));
    targetPredictedRelative[i,:]=targetRelative[i,:]+targetClosestTime[i]*targetRelativeVelocity[i,:];
    targetPredictedSpacecraft[i,:]=environment.position+targetClosestTime[i]*environment.velocity;
    targetPredictedRange2[i]=max(1e-12,targetPredictedRelative[i,:]*targetPredictedRelative[i,:]);
    targetPredictedSpacecraftRange2[i]=max(1e-12,targetPredictedSpacecraft[i,:]*targetPredictedSpacecraft[i,:]);
    targetPredictedOffNadirCos[i]=(targetPredictedRelative[i,:]*targetPredictedSpacecraft[i,:])/
      sqrt(targetPredictedRange2[i]*targetPredictedSpacecraftRange2[i]);
    targetEarlyClosestTime[i]=noEvent(max(0,min(earlyTargetPredictionHorizon,
      -targetRelativeDotVelocity[i]/max(1e-9,targetRelativeVelocity[i,:]*targetRelativeVelocity[i,:]))));
    targetEarlyPredictedRelative[i,:]=targetRelative[i,:]+targetEarlyClosestTime[i]*targetRelativeVelocity[i,:];
    targetEarlyPredictedSpacecraft[i,:]=environment.position+targetEarlyClosestTime[i]*environment.velocity;
    targetEarlyPredictedRange2[i]=max(1e-12,targetEarlyPredictedRelative[i,:]*targetEarlyPredictedRelative[i,:]);
    targetEarlyPredictedSpacecraftRange2[i]=max(1e-12,targetEarlyPredictedSpacecraft[i,:]*targetEarlyPredictedSpacecraft[i,:]);
    targetEarlyPredictedOffNadirCos[i]=(targetEarlyPredictedRelative[i,:]*targetEarlyPredictedSpacecraft[i,:])/
      sqrt(targetEarlyPredictedRange2[i]*targetEarlyPredictedSpacecraftRange2[i]);
    targetVisibleInternal[i]=imagingTargets[i].enabled and targetElevationSin[i] > targetMinimumElevationSin[i];
    targetPrePoint[i]=imagingTargets[i].enabled and targetElevationSin[i] > targetPrePointElevationSin[i] and
      targetElevationRate[i] > 0 and targetPredictedOffNadirCos[i] >= cosMaxOffNadir and
      targetSunElevationSin[i] >= sinMinTargetSunElevation;
    targetEarlyPrePoint[i]=imagingTargets[i].enabled and
      targetElevationSin[i] > targetPrePointElevationSin[i] and targetElevationRate[i] > 0 and
      targetEarlyPredictedOffNadirCos[i] >= cosMaxOffNadir and
      targetSunElevationSin[i] >= sinMinTargetSunElevation;
  end for;
  targetBestPriority[1]=if targetVisibleInternal[1] then imagingTargets[1].priority else -1000000000;
  targetSelectedIndex[1]=if targetVisibleInternal[1] then 1 else 0;
  for i in 2:32 loop
    targetBestPriority[i]=if targetVisibleInternal[i] and (targetSelectedIndex[i-1] == 0 or imagingTargets[i].priority > targetBestPriority[i-1]) then imagingTargets[i].priority else targetBestPriority[i-1];
    targetSelectedIndex[i]=if targetVisibleInternal[i] and (targetSelectedIndex[i-1] == 0 or imagingTargets[i].priority > targetBestPriority[i-1]) then i else targetSelectedIndex[i-1];
  end for;
  targetPrePointBestPriority[1]=if targetPrePoint[1] then imagingTargets[1].priority else -1000000000;
  targetPrePointSelectedIndex[1]=if targetPrePoint[1] then 1 else 0;
  for i in 2:32 loop
    targetPrePointBestPriority[i]=if targetPrePoint[i] and (targetPrePointSelectedIndex[i-1] == 0 or imagingTargets[i].priority > targetPrePointBestPriority[i-1]) then imagingTargets[i].priority else targetPrePointBestPriority[i-1];
    targetPrePointSelectedIndex[i]=if targetPrePoint[i] and (targetPrePointSelectedIndex[i-1] == 0 or imagingTargets[i].priority > targetPrePointBestPriority[i-1]) then i else targetPrePointSelectedIndex[i-1];
  end for;
  targetEarlyPrePointBestPriority[1]=if targetEarlyPrePoint[1] then imagingTargets[1].priority else -1000000000;
  targetEarlyPrePointSelectedIndex[1]=if targetEarlyPrePoint[1] then 1 else 0;
  for i in 2:32 loop
    targetEarlyPrePointBestPriority[i]=if targetEarlyPrePoint[i] and
      (targetEarlyPrePointSelectedIndex[i-1] == 0 or imagingTargets[i].priority > targetEarlyPrePointBestPriority[i-1]) then
      imagingTargets[i].priority else targetEarlyPrePointBestPriority[i-1];
    targetEarlyPrePointSelectedIndex[i]=if targetEarlyPrePoint[i] and
      (targetEarlyPrePointSelectedIndex[i-1] == 0 or imagingTargets[i].priority > targetEarlyPrePointBestPriority[i-1]) then
      i else targetEarlyPrePointSelectedIndex[i-1];
  end for;
  earlyTargetPrePointIndexPublisher=targetEarlyPrePointSelectedIndex[32];
  earlyTargetPrePointOpportunityPublisher=environment.earlyTargetPrePointIndex > 0;
  targetOpportunityTimeRemainingPublisher=if environment.earlyTargetPrePointIndex > 0 then
    targetEarlyClosestTime[environment.earlyTargetPrePointIndex] else 0;
  targetPrePointIndexPublisher=targetPrePointSelectedIndex[32];
  targetPrePointOpportunityPublisher=environment.targetPrePointIndex > 0;
  targetIndexPublisher=targetSelectedIndex[32];
  targetVisiblePublisher=environment.targetIndex > 0;
  selectedTargetIndex=targetSelectedIndex[32];
  selectedTargetIndexValid=selectedTargetIndex >= 1 and selectedTargetIndex <= 32;
  activeTargetIndex=activeMissionSelection.targetIndex;
  activeTargetIndexValid=activeTargetIndex >= 1 and activeTargetIndex <= 32;
  activeTargetEnabled=if activeTargetIndexValid then imagingTargets[activeTargetIndex].enabled else false;
  for j in 1:3 loop
    selectedTargetVectorECI[j]=if selectedTargetIndexValid then
      -targetRelative[selectedTargetIndex,j]*targetInvRange[selectedTargetIndex] else 0;
    activeTargetVectorECI[j]=if activeTargetEnabled then
      -targetRelative[activeTargetIndex,j]*targetInvRange[activeTargetIndex] else 0;
    activeTargetVectorRateECI[j]=if activeTargetEnabled then
      -targetRelativeVelocity[activeTargetIndex,j]*targetInvRange[activeTargetIndex]+
      targetRelative[activeTargetIndex,j]*targetRelativeDotVelocity[activeTargetIndex]*
      targetInvRange[activeTargetIndex]^3 else 0;
  end for;
  targetVectorBodyPublisher=Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve2(worldToBody,selectedTargetVectorECI);
  activeTargetVisiblePublisher=if activeTargetIndexValid then targetVisibleInternal[activeTargetIndex] else false;
  activeTargetPreparationOpportunityPublisher=if activeTargetIndexValid then targetPrePoint[activeTargetIndex] else false;
  activeTargetEarlyPrePointOpportunityPublisher=if activeTargetIndexValid then targetEarlyPrePoint[activeTargetIndex] else false;
  targetElevationRatePublisher=if activeTargetIndexValid then targetElevationRate[activeTargetIndex] else 0;
  targetElevationIncreasingPublisher=environment.targetElevationRate > 0;
  activeTargetVectorBodyPublisher=Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve2(worldToBody,activeTargetVectorECI);
  activeTargetTrackingRateECI=cross(activeTargetVectorECI,activeTargetVectorRateECI);
  activeTargetTrackingRateBodyPublisher=Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve2(worldToBody,activeTargetTrackingRateECI);
  activeTargetOffNadirCos=if activeTargetEnabled then targetOffNadirCos[activeTargetIndex] else 0;
  activeTargetSunElevationSin=if activeTargetEnabled then targetSunElevationSin[activeTargetIndex] else 0;
  offNadirAnglePublisher=if activeMissionSelection.targetIndex > 0 then acos(max(-1,min(1,activeTargetOffNadirCos))) else Modelica.Constants.pi;
  cameraLookAnglePublisher=if activeMissionSelection.targetIndex > 0 then acos(max(-1,min(1,environment.activeTargetVectorBody[1]))) else Modelica.Constants.pi;
  targetSunElevationPublisher=if activeMissionSelection.targetIndex > 0 then asin(max(-1,min(1,activeTargetSunElevationSin))) else -Modelica.Constants.pi/2;
  offNadirValidPublisher=activeMissionSelection.targetIndex > 0 and activeTargetOffNadirCos >= cosMaxOffNadir;
  cameraFOVValidPublisher=activeMissionSelection.targetIndex > 0 and environment.activeTargetVectorBody[1] >= cosCameraHalfFOV;
  targetIlluminationValidPublisher=activeMissionSelection.targetIndex > 0 and activeTargetSunElevationSin >= sinMinTargetSunElevation;
  imagingValidPublisher=environment.activeTargetVisible and environment.offNadirValid and
    environment.cameraFOVValid and environment.targetIlluminationValid;
  referenceAltitudePublisher=referenceAltitude;
  instantaneousAltitudePublisher=sqrt(positionPublisher*positionPublisher)-earthRadius;
  connect(positionPublisher[1],informationRealBridge[1].u) annotation(Line(points={{78,-60},{102,-60},{102,0}},color={0,0,127}));
  connect(informationRealBridge[1].y,environment.position[1]) annotation(Line(points={{78,-60},{102,-60},{102,0}},color={0,0,127}));
  connect(positionPublisher[2],informationRealBridge[2].u) annotation(Line(points={{78,-60},{102,-60},{102,0}},color={0,0,127}));
  connect(informationRealBridge[2].y,environment.position[2]) annotation(Line(points={{78,-60},{102,-60},{102,0}},color={0,0,127}));
  connect(positionPublisher[3],informationRealBridge[3].u) annotation(Line(points={{78,-60},{102,-60},{102,0}},color={0,0,127}));
  connect(informationRealBridge[3].y,environment.position[3]) annotation(Line(points={{78,-60},{102,-60},{102,0}},color={0,0,127}));
  connect(velocityPublisher[1],informationRealBridge[4].u) annotation(Line(points={{78,-54},{102,-54},{102,0}},color={0,0,127}));
  connect(informationRealBridge[4].y,environment.velocity[1]) annotation(Line(points={{78,-54},{102,-54},{102,0}},color={0,0,127}));
  connect(velocityPublisher[2],informationRealBridge[5].u) annotation(Line(points={{78,-54},{102,-54},{102,0}},color={0,0,127}));
  connect(informationRealBridge[5].y,environment.velocity[2]) annotation(Line(points={{78,-54},{102,-54},{102,0}},color={0,0,127}));
  connect(velocityPublisher[3],informationRealBridge[6].u) annotation(Line(points={{78,-54},{102,-54},{102,0}},color={0,0,127}));
  connect(informationRealBridge[6].y,environment.velocity[3]) annotation(Line(points={{78,-54},{102,-54},{102,0}},color={0,0,127}));
  connect(quaternionPublisher[1],informationRealBridge[7].u) annotation(Line(points={{78,-48},{102,-48},{102,0}},color={0,0,127}));
  connect(informationRealBridge[7].y,environment.quaternion[1]) annotation(Line(points={{78,-48},{102,-48},{102,0}},color={0,0,127}));
  connect(quaternionPublisher[2],informationRealBridge[8].u) annotation(Line(points={{78,-48},{102,-48},{102,0}},color={0,0,127}));
  connect(informationRealBridge[8].y,environment.quaternion[2]) annotation(Line(points={{78,-48},{102,-48},{102,0}},color={0,0,127}));
  connect(quaternionPublisher[3],informationRealBridge[9].u) annotation(Line(points={{78,-48},{102,-48},{102,0}},color={0,0,127}));
  connect(informationRealBridge[9].y,environment.quaternion[3]) annotation(Line(points={{78,-48},{102,-48},{102,0}},color={0,0,127}));
  connect(quaternionPublisher[4],informationRealBridge[10].u) annotation(Line(points={{78,-48},{102,-48},{102,0}},color={0,0,127}));
  connect(informationRealBridge[10].y,environment.quaternion[4]) annotation(Line(points={{78,-48},{102,-48},{102,0}},color={0,0,127}));
  connect(eulerPublisher[1],informationRealBridge[11].u) annotation(Line(points={{78,-42},{102,-42},{102,0}},color={0,0,127}));
  connect(informationRealBridge[11].y,environment.euler[1]) annotation(Line(points={{78,-42},{102,-42},{102,0}},color={0,0,127}));
  connect(eulerPublisher[2],informationRealBridge[12].u) annotation(Line(points={{78,-42},{102,-42},{102,0}},color={0,0,127}));
  connect(informationRealBridge[12].y,environment.euler[2]) annotation(Line(points={{78,-42},{102,-42},{102,0}},color={0,0,127}));
  connect(eulerPublisher[3],informationRealBridge[13].u) annotation(Line(points={{78,-42},{102,-42},{102,0}},color={0,0,127}));
  connect(informationRealBridge[13].y,environment.euler[3]) annotation(Line(points={{78,-42},{102,-42},{102,0}},color={0,0,127}));
  connect(bodyRatePublisher[1],informationRealBridge[14].u) annotation(Line(points={{78,-36},{102,-36},{102,0}},color={0,0,127}));
  connect(informationRealBridge[14].y,environment.bodyRate[1]) annotation(Line(points={{78,-36},{102,-36},{102,0}},color={0,0,127}));
  connect(bodyRatePublisher[2],informationRealBridge[15].u) annotation(Line(points={{78,-36},{102,-36},{102,0}},color={0,0,127}));
  connect(informationRealBridge[15].y,environment.bodyRate[2]) annotation(Line(points={{78,-36},{102,-36},{102,0}},color={0,0,127}));
  connect(bodyRatePublisher[3],informationRealBridge[16].u) annotation(Line(points={{78,-36},{102,-36},{102,0}},color={0,0,127}));
  connect(informationRealBridge[16].y,environment.bodyRate[3]) annotation(Line(points={{78,-36},{102,-36},{102,0}},color={0,0,127}));
  connect(sunVectorBodyPublisher[1],informationRealBridge[17].u) annotation(Line(points={{78,-30},{102,-30},{102,0}},color={0,0,127}));
  connect(informationRealBridge[17].y,environment.sunVectorBody[1]) annotation(Line(points={{78,-30},{102,-30},{102,0}},color={0,0,127}));
  connect(sunVectorBodyPublisher[2],informationRealBridge[18].u) annotation(Line(points={{78,-30},{102,-30},{102,0}},color={0,0,127}));
  connect(informationRealBridge[18].y,environment.sunVectorBody[2]) annotation(Line(points={{78,-30},{102,-30},{102,0}},color={0,0,127}));
  connect(sunVectorBodyPublisher[3],informationRealBridge[19].u) annotation(Line(points={{78,-30},{102,-30},{102,0}},color={0,0,127}));
  connect(informationRealBridge[19].y,environment.sunVectorBody[3]) annotation(Line(points={{78,-30},{102,-30},{102,0}},color={0,0,127}));
  connect(earthVectorBodyPublisher[1],informationRealBridge[20].u) annotation(Line(points={{78,-24},{102,-24},{102,0}},color={0,0,127}));
  connect(informationRealBridge[20].y,environment.earthVectorBody[1]) annotation(Line(points={{78,-24},{102,-24},{102,0}},color={0,0,127}));
  connect(earthVectorBodyPublisher[2],informationRealBridge[21].u) annotation(Line(points={{78,-24},{102,-24},{102,0}},color={0,0,127}));
  connect(informationRealBridge[21].y,environment.earthVectorBody[2]) annotation(Line(points={{78,-24},{102,-24},{102,0}},color={0,0,127}));
  connect(earthVectorBodyPublisher[3],informationRealBridge[22].u) annotation(Line(points={{78,-24},{102,-24},{102,0}},color={0,0,127}));
  connect(informationRealBridge[22].y,environment.earthVectorBody[3]) annotation(Line(points={{78,-24},{102,-24},{102,0}},color={0,0,127}));
  connect(targetVectorBodyPublisher[1],informationRealBridge[23].u) annotation(Line(points={{78,-18},{102,-18},{102,0}},color={0,0,127}));
  connect(informationRealBridge[23].y,environment.targetVectorBody[1]) annotation(Line(points={{78,-18},{102,-18},{102,0}},color={0,0,127}));
  connect(targetVectorBodyPublisher[2],informationRealBridge[24].u) annotation(Line(points={{78,-18},{102,-18},{102,0}},color={0,0,127}));
  connect(informationRealBridge[24].y,environment.targetVectorBody[2]) annotation(Line(points={{78,-18},{102,-18},{102,0}},color={0,0,127}));
  connect(targetVectorBodyPublisher[3],informationRealBridge[25].u) annotation(Line(points={{78,-18},{102,-18},{102,0}},color={0,0,127}));
  connect(informationRealBridge[25].y,environment.targetVectorBody[3]) annotation(Line(points={{78,-18},{102,-18},{102,0}},color={0,0,127}));
  connect(groundStationVectorBodyPublisher[1],informationRealBridge[26].u) annotation(Line(points={{78,-12},{102,-12},{102,0}},color={0,0,127}));
  connect(informationRealBridge[26].y,environment.groundStationVectorBody[1]) annotation(Line(points={{78,-12},{102,-12},{102,0}},color={0,0,127}));
  connect(groundStationVectorBodyPublisher[2],informationRealBridge[27].u) annotation(Line(points={{78,-12},{102,-12},{102,0}},color={0,0,127}));
  connect(informationRealBridge[27].y,environment.groundStationVectorBody[2]) annotation(Line(points={{78,-12},{102,-12},{102,0}},color={0,0,127}));
  connect(groundStationVectorBodyPublisher[3],informationRealBridge[28].u) annotation(Line(points={{78,-12},{102,-12},{102,0}},color={0,0,127}));
  connect(informationRealBridge[28].y,environment.groundStationVectorBody[3]) annotation(Line(points={{78,-12},{102,-12},{102,0}},color={0,0,127}));
  connect(targetPrePointOpportunityPublisher,informationBooleanBridge[1].u) annotation(Line(points={{78,-6},{102,-6},{102,0}},color={255,0,255}));
  connect(informationBooleanBridge[1].y,environment.targetPrePointOpportunity) annotation(Line(points={{78,-6},{102,-6},{102,0}},color={255,0,255}));
  connect(earlyTargetPrePointOpportunityPublisher,informationBooleanBridge[2].u) annotation(Line(points={{78,0},{102,0}},color={255,0,255}));
  connect(informationBooleanBridge[2].y,environment.earlyTargetPrePointOpportunity) annotation(Line(points={{78,0},{102,0}},color={255,0,255}));
  connect(groundPrePointOpportunityPublisher,informationBooleanBridge[3].u) annotation(Line(points={{78,6},{102,6},{102,0}},color={255,0,255}));
  connect(informationBooleanBridge[3].y,environment.groundPrePointOpportunity) annotation(Line(points={{78,6},{102,6},{102,0}},color={255,0,255}));
  connect(targetPrePointIndexPublisher,informationIntegerBridge[1].u) annotation(Line(points={{78,12},{102,12},{102,0}},color={255,127,0}));
  connect(informationIntegerBridge[1].y,environment.targetPrePointIndex) annotation(Line(points={{78,12},{102,12},{102,0}},color={255,127,0}));
  connect(earlyTargetPrePointIndexPublisher,informationIntegerBridge[2].u) annotation(Line(points={{78,18},{102,18},{102,0}},color={255,127,0}));
  connect(informationIntegerBridge[2].y,environment.earlyTargetPrePointIndex) annotation(Line(points={{78,18},{102,18},{102,0}},color={255,127,0}));
  connect(groundPrePointIndexPublisher,informationIntegerBridge[3].u) annotation(Line(points={{78,24},{102,24},{102,0}},color={255,127,0}));
  connect(informationIntegerBridge[3].y,environment.groundPrePointIndex) annotation(Line(points={{78,24},{102,24},{102,0}},color={255,127,0}));
  connect(activeTargetVectorBodyPublisher[1],informationRealBridge[29].u) annotation(Line(points={{78,30},{102,30},{102,0}},color={0,0,127}));
  connect(informationRealBridge[29].y,environment.activeTargetVectorBody[1]) annotation(Line(points={{78,30},{102,30},{102,0}},color={0,0,127}));
  connect(activeTargetVectorBodyPublisher[2],informationRealBridge[30].u) annotation(Line(points={{78,30},{102,30},{102,0}},color={0,0,127}));
  connect(informationRealBridge[30].y,environment.activeTargetVectorBody[2]) annotation(Line(points={{78,30},{102,30},{102,0}},color={0,0,127}));
  connect(activeTargetVectorBodyPublisher[3],informationRealBridge[31].u) annotation(Line(points={{78,30},{102,30},{102,0}},color={0,0,127}));
  connect(informationRealBridge[31].y,environment.activeTargetVectorBody[3]) annotation(Line(points={{78,30},{102,30},{102,0}},color={0,0,127}));
  connect(activeGroundStationVectorBodyPublisher[1],informationRealBridge[32].u) annotation(Line(points={{78,36},{102,36},{102,0}},color={0,0,127}));
  connect(informationRealBridge[32].y,environment.activeGroundStationVectorBody[1]) annotation(Line(points={{78,36},{102,36},{102,0}},color={0,0,127}));
  connect(activeGroundStationVectorBodyPublisher[2],informationRealBridge[33].u) annotation(Line(points={{78,36},{102,36},{102,0}},color={0,0,127}));
  connect(informationRealBridge[33].y,environment.activeGroundStationVectorBody[2]) annotation(Line(points={{78,36},{102,36},{102,0}},color={0,0,127}));
  connect(activeGroundStationVectorBodyPublisher[3],informationRealBridge[34].u) annotation(Line(points={{78,36},{102,36},{102,0}},color={0,0,127}));
  connect(informationRealBridge[34].y,environment.activeGroundStationVectorBody[3]) annotation(Line(points={{78,36},{102,36},{102,0}},color={0,0,127}));
  connect(activeTargetTrackingRateBodyPublisher[1],informationRealBridge[35].u) annotation(Line(points={{78,42},{102,42},{102,0}},color={0,0,127}));
  connect(informationRealBridge[35].y,environment.activeTargetTrackingRateBody[1]) annotation(Line(points={{78,42},{102,42},{102,0}},color={0,0,127}));
  connect(activeTargetTrackingRateBodyPublisher[2],informationRealBridge[36].u) annotation(Line(points={{78,42},{102,42},{102,0}},color={0,0,127}));
  connect(informationRealBridge[36].y,environment.activeTargetTrackingRateBody[2]) annotation(Line(points={{78,42},{102,42},{102,0}},color={0,0,127}));
  connect(activeTargetTrackingRateBodyPublisher[3],informationRealBridge[37].u) annotation(Line(points={{78,42},{102,42},{102,0}},color={0,0,127}));
  connect(informationRealBridge[37].y,environment.activeTargetTrackingRateBody[3]) annotation(Line(points={{78,42},{102,42},{102,0}},color={0,0,127}));
  connect(activeGroundTrackingRateBodyPublisher[1],informationRealBridge[38].u) annotation(Line(points={{78,48},{102,48},{102,0}},color={0,0,127}));
  connect(informationRealBridge[38].y,environment.activeGroundTrackingRateBody[1]) annotation(Line(points={{78,48},{102,48},{102,0}},color={0,0,127}));
  connect(activeGroundTrackingRateBodyPublisher[2],informationRealBridge[39].u) annotation(Line(points={{78,48},{102,48},{102,0}},color={0,0,127}));
  connect(informationRealBridge[39].y,environment.activeGroundTrackingRateBody[2]) annotation(Line(points={{78,48},{102,48},{102,0}},color={0,0,127}));
  connect(activeGroundTrackingRateBodyPublisher[3],informationRealBridge[40].u) annotation(Line(points={{78,48},{102,48},{102,0}},color={0,0,127}));
  connect(informationRealBridge[40].y,environment.activeGroundTrackingRateBody[3]) annotation(Line(points={{78,48},{102,48},{102,0}},color={0,0,127}));
  connect(activeTargetVisiblePublisher,informationBooleanBridge[4].u) annotation(Line(points={{78,54},{102,54},{102,0}},color={255,0,255}));
  connect(informationBooleanBridge[4].y,environment.activeTargetVisible) annotation(Line(points={{78,54},{102,54},{102,0}},color={255,0,255}));
  connect(activeTargetPreparationOpportunityPublisher,informationBooleanBridge[5].u) annotation(Line(points={{78,60},{102,60},{102,0}},color={255,0,255}));
  connect(informationBooleanBridge[5].y,environment.activeTargetPreparationOpportunity) annotation(Line(points={{78,60},{102,60},{102,0}},color={255,0,255}));
  connect(activeTargetEarlyPrePointOpportunityPublisher,informationBooleanBridge[6].u) annotation(Line(points={{78,-60},{102,-60},{102,0}},color={255,0,255}));
  connect(informationBooleanBridge[6].y,environment.activeTargetEarlyPrePointOpportunity) annotation(Line(points={{78,-60},{102,-60},{102,0}},color={255,0,255}));
  connect(activeGroundContactPublisher,informationBooleanBridge[7].u) annotation(Line(points={{78,-54},{102,-54},{102,0}},color={255,0,255}));
  connect(informationBooleanBridge[7].y,environment.activeGroundContact) annotation(Line(points={{78,-54},{102,-54},{102,0}},color={255,0,255}));
  connect(targetElevationRatePublisher,informationRealBridge[41].u) annotation(Line(points={{78,-48},{102,-48},{102,0}},color={0,0,127}));
  connect(informationRealBridge[41].y,environment.targetElevationRate) annotation(Line(points={{78,-48},{102,-48},{102,0}},color={0,0,127}));
  connect(groundElevationRatePublisher,informationRealBridge[42].u) annotation(Line(points={{78,-42},{102,-42},{102,0}},color={0,0,127}));
  connect(informationRealBridge[42].y,environment.groundElevationRate) annotation(Line(points={{78,-42},{102,-42},{102,0}},color={0,0,127}));
  connect(targetElevationIncreasingPublisher,informationBooleanBridge[8].u) annotation(Line(points={{78,-36},{102,-36},{102,0}},color={255,0,255}));
  connect(informationBooleanBridge[8].y,environment.targetElevationIncreasing) annotation(Line(points={{78,-36},{102,-36},{102,0}},color={255,0,255}));
  connect(groundElevationIncreasingPublisher,informationBooleanBridge[9].u) annotation(Line(points={{78,-30},{102,-30},{102,0}},color={255,0,255}));
  connect(informationBooleanBridge[9].y,environment.groundElevationIncreasing) annotation(Line(points={{78,-30},{102,-30},{102,0}},color={255,0,255}));
  connect(offNadirAnglePublisher,informationRealBridge[43].u) annotation(Line(points={{78,-24},{102,-24},{102,0}},color={0,0,127}));
  connect(informationRealBridge[43].y,environment.offNadirAngle) annotation(Line(points={{78,-24},{102,-24},{102,0}},color={0,0,127}));
  connect(cameraLookAnglePublisher,informationRealBridge[44].u) annotation(Line(points={{78,-18},{102,-18},{102,0}},color={0,0,127}));
  connect(informationRealBridge[44].y,environment.cameraLookAngle) annotation(Line(points={{78,-18},{102,-18},{102,0}},color={0,0,127}));
  connect(targetSunElevationPublisher,informationRealBridge[45].u) annotation(Line(points={{78,-12},{102,-12},{102,0}},color={0,0,127}));
  connect(informationRealBridge[45].y,environment.targetSunElevation) annotation(Line(points={{78,-12},{102,-12},{102,0}},color={0,0,127}));
  connect(offNadirValidPublisher,informationBooleanBridge[10].u) annotation(Line(points={{78,-6},{102,-6},{102,0}},color={255,0,255}));
  connect(informationBooleanBridge[10].y,environment.offNadirValid) annotation(Line(points={{78,-6},{102,-6},{102,0}},color={255,0,255}));
  connect(cameraFOVValidPublisher,informationBooleanBridge[11].u) annotation(Line(points={{78,0},{102,0}},color={255,0,255}));
  connect(informationBooleanBridge[11].y,environment.cameraFOVValid) annotation(Line(points={{78,0},{102,0}},color={255,0,255}));
  connect(targetIlluminationValidPublisher,informationBooleanBridge[12].u) annotation(Line(points={{78,6},{102,6},{102,0}},color={255,0,255}));
  connect(informationBooleanBridge[12].y,environment.targetIlluminationValid) annotation(Line(points={{78,6},{102,6},{102,0}},color={255,0,255}));
  connect(imagingValidPublisher,informationBooleanBridge[13].u) annotation(Line(points={{78,12},{102,12},{102,0}},color={255,0,255}));
  connect(informationBooleanBridge[13].y,environment.imagingValid) annotation(Line(points={{78,12},{102,12},{102,0}},color={255,0,255}));
  connect(sunIncidenceAnglePublisher,informationRealBridge[46].u) annotation(Line(points={{78,18},{102,18},{102,0}},color={0,0,127}));
  connect(informationRealBridge[46].y,environment.sunIncidenceAngle) annotation(Line(points={{78,18},{102,18},{102,0}},color={0,0,127}));
  connect(solarFluxPublisher,informationRealBridge[47].u) annotation(Line(points={{78,24},{102,24},{102,0}},color={0,0,127}));
  connect(informationRealBridge[47].y,environment.solarFlux) annotation(Line(points={{78,24},{102,24},{102,0}},color={0,0,127}));
  connect(earthInfraredFluxPublisher,informationRealBridge[48].u) annotation(Line(points={{78,30},{102,30},{102,0}},color={0,0,127}));
  connect(informationRealBridge[48].y,environment.earthInfraredFlux) annotation(Line(points={{78,30},{102,30},{102,0}},color={0,0,127}));
  connect(albedoFluxPublisher,informationRealBridge[49].u) annotation(Line(points={{78,36},{102,36},{102,0}},color={0,0,127}));
  connect(informationRealBridge[49].y,environment.albedoFlux) annotation(Line(points={{78,36},{102,36},{102,0}},color={0,0,127}));
  connect(eclipsePublisher,informationBooleanBridge[14].u) annotation(Line(points={{78,42},{102,42},{102,0}},color={255,0,255}));
  connect(informationBooleanBridge[14].y,environment.eclipse) annotation(Line(points={{78,42},{102,42},{102,0}},color={255,0,255}));
  connect(targetVisiblePublisher,informationBooleanBridge[15].u) annotation(Line(points={{78,48},{102,48},{102,0}},color={255,0,255}));
  connect(informationBooleanBridge[15].y,environment.targetVisible) annotation(Line(points={{78,48},{102,48},{102,0}},color={255,0,255}));
  connect(targetIndexPublisher,informationIntegerBridge[4].u) annotation(Line(points={{78,54},{102,54},{102,0}},color={255,127,0}));
  connect(informationIntegerBridge[4].y,environment.targetIndex) annotation(Line(points={{78,54},{102,54},{102,0}},color={255,127,0}));
  connect(groundContactPublisher,informationBooleanBridge[16].u) annotation(Line(points={{78,60},{102,60},{102,0}},color={255,0,255}));
  connect(informationBooleanBridge[16].y,environment.groundContact) annotation(Line(points={{78,60},{102,60},{102,0}},color={255,0,255}));
  connect(groundStationIndexPublisher,informationIntegerBridge[5].u) annotation(Line(points={{78,-60},{102,-60},{102,0}},color={255,127,0}));
  connect(informationIntegerBridge[5].y,environment.groundStationIndex) annotation(Line(points={{78,-60},{102,-60},{102,0}},color={255,127,0}));
  connect(referenceAltitudePublisher,informationRealBridge[50].u) annotation(Line(points={{78,-54},{102,-54},{102,0}},color={0,0,127}));
  connect(informationRealBridge[50].y,environment.referenceAltitude) annotation(Line(points={{78,-54},{102,-54},{102,0}},color={0,0,127}));
  connect(instantaneousAltitudePublisher,informationRealBridge[51].u) annotation(Line(points={{78,-48},{102,-48},{102,0}},color={0,0,127}));
  connect(informationRealBridge[51].y,environment.instantaneousAltitude) annotation(Line(points={{78,-48},{102,-48},{102,0}},color={0,0,127}));
  connect(targetOpportunityTimeRemainingPublisher,informationRealBridge[52].u) annotation(Line(points={{78,-42},{82,-42}},color={0,0,127}));
  connect(informationRealBridge[52].y,environment.targetOpportunityTimeRemaining) annotation(Line(points={{90,-42},{102,-42},{102,0}},color={0,0,127}));
  connect(groundOpportunityTimeRemainingPublisher,informationRealBridge[53].u) annotation(Line(points={{78,-36},{82,-36}},color={0,0,127}));
  connect(informationRealBridge[53].y,environment.groundOpportunityTimeRemaining) annotation(Line(points={{90,-36},{102,-36},{102,0}},color={0,0,127}));
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={20,80,120},fillColor={225,238,245},fillPattern=FillPattern.Solid),Ellipse(extent={{-24,24},{24,-24}},fillColor={30,120,200},fillPattern=FillPattern.Solid),Ellipse(extent={{-80,55},{80,-55}},lineColor={230,140,0}),Text(extent={{-92,-64},{92,-38}},textString="8 GS / 32 TARGETS")}),Documentation(info="<html><h4>功能定位</h4><p>读取真实历元驱动的GCRS轨道、JPL太阳方向与IERS地球定向，继续实时计算最多32个目标和8个地面站的任务几何。</p><h4>输入与接口关系</h4><p>OrbitConfig定位离线环境表；GroundStationConfig和ImagingTargetConfig保持原球形地理数据库；euler/bodyRate把惯性参考转换到机体系；activeMissionSelection锁存任务对象。</p><h4>内部职责与实现</h4><p>EphemerisEnvironmentReader提供连续位置、速度、太阳方向、ITRS到GCRS旋转及其一致导数。本模型保留原阴影、辐射、最低仰角、预指向、光照及局部线性预测判据。</p><h4>输出</h4><p>EnvironmentPort继续发布地心惯性位置速度、姿态环境、太阳/地心/活动对象向量、热流、机会、索引与高度；接口语义未改变。</p><h4>建模边界</h4><p>离线轨道是给定初始状态在中心引力、J2和日月第三体下的预报，不是实测或精密定轨结果；忽略阻力、太阳光压、高阶重力和轨道机动。地面点仍采用原球形地球构造。</p></html>"));
end OrbitalEnvironmentCore;
