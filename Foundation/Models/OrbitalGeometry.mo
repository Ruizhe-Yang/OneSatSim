within OneSatSim.Foundation.Models;
model OrbitalGeometry "真实历元轨道、多地面站与多目标环境核心"
  import SI=Modelica.Units.SI;
  parameter OneSatSim.Scenarios.OrbitConfig orbit "真实历元轨道输入及生成环境资源";
  parameter OneSatSim.Scenarios.GroundStationConfig groundStations[8] "最多8个地面站";
  parameter OneSatSim.Scenarios.ImagingTargetConfig imagingTargets[32] "最多32个拍摄目标";
  parameter SI.Length earthRadius=6378137 "地球参考半径 [m]" ;
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
  Modelica.Blocks.Interfaces.RealInput euler[3] 
     "计算/接口量 euler" annotation(Placement(visible=true, transformation(origin={-465,115}, extent={{-7,-7},{7,7}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealInput bodyRate[3] 
     "机体系陀螺角速率" annotation(Placement(visible=true, transformation(origin={-465,45}, extent={{-7,-7},{7,7}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,57.142857}, extent={{-6,-6},{6,6}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.ActiveMissionSelectionInput activeMissionSelection
    "来自OBC的任务对象锁存索引" 
    annotation(Placement(visible=true, transformation(origin={-465,-45}, extent={{-14,-14},{14,14}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,34.285714}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.EnvironmentPort environment  "外部环境接口或实例" annotation(Placement(visible=true, transformation(origin={620,0}, extent={{-20,-20},{20,20}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,11.428571}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.EphemerisPort ephemeris 
     "计算/接口量 ephemeris" annotation(Placement(visible=true, transformation(origin={-465,-115}, extent={{-16,-16},{16,16}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-11.428571}, extent={{-12,-12},{12,12}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput positionPublisher[3](each unit="m")  "位置Publisher [m]" annotation(Placement(visible=true, transformation(origin={60,280}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput velocityPublisher[3](each unit="m/s")  "计算/接口量 velocityPublisher [m/s]" annotation(Placement(visible=true, transformation(origin={60,256}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,74.074074}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput quaternionPublisher[4]  "四元数Publisher" annotation(Placement(visible=true, transformation(origin={60,232}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,68.148148}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput eulerPublisher[3](each unit="rad")  "计算/接口量 eulerPublisher [rad]" annotation(Placement(visible=true, transformation(origin={60,208}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,62.222222}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput bodyRatePublisher[3](each unit="rad/s")  "本体速率Publisher [rad/s]" annotation(Placement(visible=true, transformation(origin={60,184}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,56.296296}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput sunVectorBodyPublisher[3]  "sunVector本体Publisher" annotation(Placement(visible=true, transformation(origin={60,-70}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,50.37037}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput earthVectorBodyPublisher[3]  "earthVector本体Publisher" annotation(Placement(visible=true, transformation(origin={60,-94}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,44.444444}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput targetVectorBodyPublisher[3]  "目标Vector本体Publisher" annotation(Placement(visible=true, transformation(origin={275,280}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,38.518519}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput groundStationVectorBodyPublisher[3]  "地面站点Vector本体Publisher" annotation(Placement(visible=true, transformation(origin={475,280}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,32.592593}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput targetPrePointOpportunityPublisher  "目标PrePointOpportunityPublisher" annotation(Placement(visible=true, transformation(origin={275,256}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,26.666667}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput earlyTargetPrePointOpportunityPublisher  "early目标PrePointOpportunityPublisher" annotation(Placement(visible=true, transformation(origin={275,232}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,20.740741}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput groundPrePointOpportunityPublisher  "地面PrePointOpportunityPublisher" annotation(Placement(visible=true, transformation(origin={475,256}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,14.814815}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput targetPrePointIndexPublisher  "目标PrePointIndexPublisher" annotation(Placement(visible=true, transformation(origin={275,208}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,8.888889}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput earlyTargetPrePointIndexPublisher  "early目标PrePointIndexPublisher" annotation(Placement(visible=true, transformation(origin={275,184}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,2.962963}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput groundPrePointIndexPublisher  "地面PrePointIndexPublisher" annotation(Placement(visible=true, transformation(origin={475,232}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-2.962963}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput targetOpportunityTimeRemainingPublisher(unit="s")  "目标Opportunity时间RemainingPublisher [s]" annotation(Placement(visible=true, transformation(origin={275,160}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-8.888889}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput groundOpportunityTimeRemainingPublisher(unit="s")  "地面Opportunity时间RemainingPublisher [s]" annotation(Placement(visible=true, transformation(origin={475,208}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-14.814815}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput activeTargetVectorBodyPublisher[3]  "激活目标Vector本体Publisher" annotation(Placement(visible=true, transformation(origin={275,136}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-20.740741}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput activeGroundStationVectorBodyPublisher[3]  "激活地面站点Vector本体Publisher" annotation(Placement(visible=true, transformation(origin={475,184}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-26.666667}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput activeTargetTrackingRateBodyPublisher[3](each unit="rad/s")  "激活目标跟踪速率本体Publisher [rad/s]" annotation(Placement(visible=true, transformation(origin={275,112}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-32.592593}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput activeGroundTrackingRateBodyPublisher[3](each unit="rad/s")  "激活地面跟踪速率本体Publisher [rad/s]" annotation(Placement(visible=true, transformation(origin={475,160}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-38.518519}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput activeTargetVisiblePublisher  "激活目标VisiblePublisher" annotation(Placement(visible=true, transformation(origin={275,88}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-44.444444}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput activeTargetPreparationOpportunityPublisher  "激活目标PreparationOpportunityPublisher" annotation(Placement(visible=true, transformation(origin={275,64}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-50.37037}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput activeTargetEarlyPrePointOpportunityPublisher  "激活目标EarlyPrePointOpportunityPublisher" annotation(Placement(visible=true, transformation(origin={275,40}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-56.296296}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput activeGroundContactPublisher  "激活地面ContactPublisher" annotation(Placement(visible=true, transformation(origin={475,136}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-62.222222}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput targetElevationRatePublisher(unit="1/s")  "目标Elevation速率Publisher [1/s]" annotation(Placement(visible=true, transformation(origin={275,16}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-68.148148}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput groundElevationRatePublisher(unit="1/s")  "地面Elevation速率Publisher [1/s]" annotation(Placement(visible=true, transformation(origin={475,112}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-74.074074}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput targetElevationIncreasingPublisher  "目标ElevationIncreasingPublisher" annotation(Placement(visible=true, transformation(origin={275,-8}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-1.896296,-1.896296},{1.896296,1.896296}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput groundElevationIncreasingPublisher  "地面ElevationIncreasingPublisher" annotation(Placement(visible=true, transformation(origin={475,88}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={80,-97}, extent={{-6,-6},{6,6}}, rotation=270)));
  Modelica.Blocks.Interfaces.RealOutput offNadirAnglePublisher(unit="rad")  "计算/接口量 offNadirAnglePublisher [rad]" annotation(Placement(visible=true, transformation(origin={275,-32}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={80,95}, extent={{-6,-6},{6,6}}, rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput cameraLookAnglePublisher(unit="rad")  "计算/接口量 cameraLookAnglePublisher [rad]" annotation(Placement(visible=true, transformation(origin={275,-56}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-6,-6},{6,6}}, rotation=180)));
  Modelica.Blocks.Interfaces.RealOutput targetSunElevationPublisher(unit="rad")  "目标SunElevationPublisher [rad]" annotation(Placement(visible=true, transformation(origin={275,-80}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={57.142857,-97}, extent={{-6,-6},{6,6}}, rotation=270)));
  Modelica.Blocks.Interfaces.BooleanOutput offNadirValidPublisher  "计算/接口量 offNadirValidPublisher" annotation(Placement(visible=true, transformation(origin={275,-104}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={57.142857,95}, extent={{-6,-6},{6,6}}, rotation=90)));
  Modelica.Blocks.Interfaces.BooleanOutput cameraFOVValidPublisher  "计算/接口量 cameraFOVValidPublisher" annotation(Placement(visible=true, transformation(origin={275,-128}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-57.142857}, extent={{-6,-6},{6,6}}, rotation=180)));
  Modelica.Blocks.Interfaces.BooleanOutput targetIlluminationValidPublisher  "目标IlluminationValidPublisher" annotation(Placement(visible=true, transformation(origin={275,-152}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={34.285714,-97}, extent={{-6,-6},{6,6}}, rotation=270)));
  Modelica.Blocks.Interfaces.BooleanOutput imagingValidPublisher  "成像ValidPublisher" annotation(Placement(visible=true, transformation(origin={275,-176}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={34.285714,95}, extent={{-6,-6},{6,6}}, rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput sunIncidenceAnglePublisher(unit="rad")  "计算/接口量 sunIncidenceAnglePublisher [rad]" annotation(Placement(visible=true, transformation(origin={60,-118}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-34.285714}, extent={{-6,-6},{6,6}}, rotation=180)));
  Modelica.Blocks.Interfaces.RealOutput solarFluxPublisher(unit="W/m2")  "solar通量Publisher [W/m2]" annotation(Placement(visible=true, transformation(origin={60,-142}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={11.428571,-97}, extent={{-6,-6},{6,6}}, rotation=270)));
  Modelica.Blocks.Interfaces.RealOutput earthInfraredFluxPublisher(unit="W/m2")  "earthInfrared通量Publisher [W/m2]" annotation(Placement(visible=true, transformation(origin={60,-166}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={11.428571,95}, extent={{-6,-6},{6,6}}, rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput albedoFluxPublisher(unit="W/m2")  "albedo通量Publisher [W/m2]" annotation(Placement(visible=true, transformation(origin={60,-190}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-11.428571,-97}, extent={{-6,-6},{6,6}}, rotation=270)));
  Modelica.Blocks.Interfaces.BooleanOutput eclipsePublisher  "计算/接口量 eclipsePublisher" annotation(Placement(visible=true, transformation(origin={60,-214}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-11.428571,95}, extent={{-6,-6},{6,6}}, rotation=90)));
  Modelica.Blocks.Interfaces.BooleanOutput targetVisiblePublisher  "目标VisiblePublisher" annotation(Placement(visible=true, transformation(origin={275,-200}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-34.285714,-97}, extent={{-6,-6},{6,6}}, rotation=270)));
  Modelica.Blocks.Interfaces.IntegerOutput targetIndexPublisher  "目标IndexPublisher" annotation(Placement(visible=true, transformation(origin={275,-224}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-34.285714,95}, extent={{-6,-6},{6,6}}, rotation=90)));
  Modelica.Blocks.Interfaces.BooleanOutput groundContactPublisher  "地面ContactPublisher" annotation(Placement(visible=true, transformation(origin={475,64}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-57.142857,-97}, extent={{-6,-6},{6,6}}, rotation=270)));
  Modelica.Blocks.Interfaces.IntegerOutput groundStationIndexPublisher  "地面站点IndexPublisher" annotation(Placement(visible=true, transformation(origin={475,40}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-57.142857,95}, extent={{-6,-6},{6,6}}, rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput referenceAltitudePublisher(unit="m")  "计算/接口量 referenceAltitudePublisher [m]" annotation(Placement(visible=true, transformation(origin={60,160}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-80,-97}, extent={{-6,-6},{6,6}}, rotation=270)));
  Modelica.Blocks.Interfaces.RealOutput instantaneousAltitudePublisher(unit="m")  "计算/接口量 instantaneousAltitudePublisher [m]" annotation(Placement(visible=true, transformation(origin={60,136}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-80,95}, extent={{-6,-6},{6,6}}, rotation=90)));
  final parameter Real cosMaxOffNadir=cos(maxOffNadir_deg) "配置项 cosMaxOffNadir" ;
  final parameter Real cosCameraHalfFOV=cos(cameraHalfFOV_deg) "配置项 cosCameraHalfFOV" ;
  final parameter Real sinMinTargetSunElevation=sin(minTargetSunElevation_deg) "sinMin目标SunElevation" ;
  final parameter Real stationSinLatitude[8]={sin(groundStations[i].latitude) for i in 1:8} "站点SinLatitude" ;
  final parameter Real stationCosLatitude[8]={cos(groundStations[i].latitude) for i in 1:8} "站点CosLatitude" ;
  final parameter Real stationSinLongitude[8]={sin(groundStations[i].longitude) for i in 1:8} "站点SinLongitude" ;
  final parameter Real stationCosLongitude[8]={cos(groundStations[i].longitude) for i in 1:8} "站点CosLongitude" ;
  final parameter Real stationRadius[8]={earthRadius+groundStations[i].altitude for i in 1:8} "站点Radius" ;
  final parameter Real stationMinimumElevationSin[8]={sin(groundStations[i].minimumElevation) for i in 1:8} "站点MinimumElevationSin" ;
  final parameter Real stationPrePointElevationSin[8]={sin(max(-Modelica.Constants.pi/2,
    groundStations[i].minimumElevation-groundPrePointingMargin)) for i in 1:8} "站点PrePointElevationSin" ;
  final parameter Real targetSinLatitude[32]={sin(imagingTargets[i].latitude) for i in 1:32} "目标SinLatitude" ;
  final parameter Real targetCosLatitude[32]={cos(imagingTargets[i].latitude) for i in 1:32} "目标CosLatitude" ;
  final parameter Real targetSinLongitude[32]={sin(imagingTargets[i].longitude) for i in 1:32} "目标SinLongitude" ;
  final parameter Real targetCosLongitude[32]={cos(imagingTargets[i].longitude) for i in 1:32} "目标CosLongitude" ;
  final parameter Real targetRadius[32]={earthRadius+imagingTargets[i].altitude for i in 1:32} "目标Radius" ;
  final parameter Real targetMinimumElevationSin[32]={sin(imagingTargets[i].minimumElevation) for i in 1:32} "目标MinimumElevationSin" ;
  final parameter Real targetPrePointElevationSin[32]={sin(max(-Modelica.Constants.pi/2,
    imagingTargets[i].minimumElevation-targetPrePointingMargin)) for i in 1:32} "目标PrePointElevationSin" ;
  Real sunECI[3] "计算/接口量 sunECI；Normalized inertial Sun direction";
  Real earthVectorECI[3]
    "计算/接口量 earthVectorECI；Unit vector from spacecraft toward Earth center in inertial axes";
  Real spacecraftRange2 "计算/接口量 spacecraftRange2" ;
  Real spacecraftInvRange "计算/接口量 spacecraftInvRange" ;
  Real worldToBody[3,3]
    "world转换为本体；MSL rotation matrix using the same {1,2,3} sequence as AbsoluteAngles";
  Real halfRollCos "计算/接口量 halfRollCos" ;
  Real halfRollSin "计算/接口量 halfRollSin" ;
  Real halfPitchCos "计算/接口量 halfPitchCos" ;
  Real halfPitchSin "计算/接口量 halfPitchSin" ;
  Real halfYawCos "计算/接口量 halfYawCos" ;
  Real halfYawSin "计算/接口量 halfYawSin" ;
  Real stationUnitEarth[8,3] "球形ITRS站点单位矢量";
  Real stationUnit[8,3] "站点Unit" ;
  Real stationPosition[8,3] "地面站地心位置" ;
  Real stationRelative[8,3] "地面站到航天器的相对位置" ;
  Real stationVelocity[8,3] "地面站惯性速度" ;
  Real stationRelativeVelocity[8,3] "相对速度" ;
  Real stationElevationSin[8] "站点ElevationSin" ;
  Real stationElevationRate[8] "站点Elevation速率" ;
  Real stationRange2[8] "站点Range2" ;
  Real stationInvRange[8] "站点InvRange" ;
  Real stationRelativeDotVelocity[8] "站点相对DotVelocity" ;
  Real stationClosestTime[8] "站点Closest时间" ;
  Real stationPredictedRelative[8,3] "站点Predicted相对" ;
  Real stationPredictedPosition[8,3] "站点Predicted位置" ;
  Real stationPredictedRange2[8] "站点PredictedRange2" ;
  Real stationPredictedRadius2[8] "站点PredictedRadius2" ;
  Real stationPredictedElevationSin[8] "站点PredictedElevationSin" ;
  Boolean stationVisible[8] "站点Visible" ;
  Boolean stationPrePoint[8] "站点PrePoint" ;
  Integer stationBestPriority[8] "站点BestPriority" ;
  Integer stationSelectedIndex[8] "站点选定Index" ;
  Integer stationPrePointBestPriority[8] "站点PrePointBestPriority" ;
  Integer stationPrePointSelectedIndex[8] "站点PrePoint选定Index" ;
  Real selectedGroundVectorECI[3]
    "选定地面VectorECI；Unit line of sight from spacecraft to selected ground station";
  Integer selectedGroundIndex "选定地面Index" ;
  Boolean selectedGroundIndexValid "选定地面IndexValid" ;
  Integer activeGroundIndex "激活地面Index" ;
  Boolean activeGroundIndexValid "激活地面IndexValid" ;
  Boolean activeGroundEnabled "激活地面启用" ;
  Real activeGroundVectorECI[3]
    "激活地面VectorECI；LOS to the command-latched station, independent of live top-priority selection";
  Real activeGroundVectorRateECI[3] "激活地面Vector速率ECI" ;
  Real activeGroundTrackingRateECI[3] "激活地面跟踪速率ECI" ;
  Real targetUnitEarth[32,3] "球形ITRS目标单位矢量";
  Real targetUnit[32,3] "目标Unit" ;
  Real targetPosition[32,3] "目标位置" ;
  Real targetRelative[32,3] "目标相对" ;
  Real targetVelocity[32,3] "目标Velocity" ;
  Real targetRelativeVelocity[32,3] "目标相对Velocity" ;
  Real targetElevationSin[32] "目标ElevationSin" ;
  Real targetElevationRate[32] "目标Elevation速率" ;
  Real targetRange2[32] "目标Range2" ;
  Real targetInvRange[32] "目标InvRange" ;
  Real targetRelativeDotVelocity[32] "目标相对DotVelocity" ;
  Real targetOffNadirCos[32] "目标OffNadirCos" ;
  Real targetSunElevationSin[32] "目标SunElevationSin" ;
  Real targetClosestTime[32]
    "目标Closest时间；Clamped constant-velocity time to closest relative approach";
  Real targetPredictedRelative[32,3] "目标Predicted相对" ;
  Real targetPredictedSpacecraft[32,3] "目标PredictedSpacecraft" ;
  Real targetPredictedRange2[32] "目标PredictedRange2" ;
  Real targetPredictedSpacecraftRange2[32] "目标PredictedSpacecraftRange2" ;
  Real targetPredictedOffNadirCos[32]
    "目标PredictedOffNadirCos；Predicted best off-nadir cosine without a new orbit state or search loop";
  Real targetEarlyClosestTime[32] "目标EarlyClosest时间" ;
  Real targetEarlyPredictedRelative[32,3] "目标EarlyPredicted相对" ;
  Real targetEarlyPredictedSpacecraft[32,3] "目标EarlyPredictedSpacecraft" ;
  Real targetEarlyPredictedRange2[32] "目标EarlyPredictedRange2" ;
  Real targetEarlyPredictedSpacecraftRange2[32] "目标EarlyPredictedSpacecraftRange2" ;
  Real targetEarlyPredictedOffNadirCos[32] "目标EarlyPredictedOffNadirCos" ;
  Boolean targetVisibleInternal[32] "目标VisibleInternal" ;
  Boolean targetPrePoint[32] "目标PrePoint" ;
  Boolean targetEarlyPrePoint[32] "目标EarlyPrePoint" ;
  Integer targetBestPriority[32] "目标BestPriority" ;
  Integer targetSelectedIndex[32] "目标选定Index" ;
  Integer targetPrePointBestPriority[32] "目标PrePointBestPriority" ;
  Integer targetPrePointSelectedIndex[32] "目标PrePoint选定Index" ;
  Integer targetEarlyPrePointBestPriority[32] "目标EarlyPrePointBestPriority" ;
  Integer targetEarlyPrePointSelectedIndex[32] "目标EarlyPrePoint选定Index" ;
  Real selectedTargetVectorECI[3]
    "选定目标VectorECI；Unit line of sight from spacecraft to selected imaging target";
  Integer selectedTargetIndex "选定目标Index" ;
  Boolean selectedTargetIndexValid "选定目标IndexValid" ;
  Integer activeTargetIndex "锁存目标ID" ;
  Boolean activeTargetIndexValid "激活目标IndexValid" ;
  Boolean activeTargetEnabled "激活目标启用" ;
  Real activeTargetVectorECI[3]
    "激活目标VectorECI；LOS to the command-latched target, independent of live top-priority selection";
  Real activeTargetVectorRateECI[3] "激活目标Vector速率ECI" ;
  Real activeTargetTrackingRateECI[3] "激活目标跟踪速率ECI" ;
  Real activeTargetOffNadirCos "激活目标OffNadirCos" ;
  Real activeTargetSunElevationSin "激活目标SunElevationSin" ;
  Modelica.Blocks.Interfaces.RealOutput sunVectorGCRSPublisher[3]  "计算/接口量 sunVectorGCRSPublisher" annotation(Placement(visible=true, transformation(origin={60,-238}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-68.571429,95}, extent={{-2.5,-2.5},{2.5,2.5}}, rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput activeTargetVectorGCRSPublisher[3]  "激活目标VectorGCRSPublisher" annotation(Placement(visible=true, transformation(origin={275,-248}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-45.714286,95}, extent={{-2.5,-2.5},{2.5,2.5}}, rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput activeGroundStationVectorGCRSPublisher[3]  "激活地面站点VectorGCRSPublisher" annotation(Placement(visible=true, transformation(origin={475,16}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-22.857143,95}, extent={{-2.5,-2.5},{2.5,2.5}}, rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput activeTargetTrackingRateGCRSPublisher[3]  "激活目标跟踪速率GCRSPublisher" annotation(Placement(visible=true, transformation(origin={275,-272}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={0,95}, extent={{-2.5,-2.5},{2.5,2.5}}, rotation=90)));
  Modelica.Blocks.Interfaces.RealOutput activeGroundTrackingRateGCRSPublisher[3]  "激活地面跟踪速率GCRSPublisher" annotation(Placement(visible=true, transformation(origin={475,-8}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={22.857143,95}, extent={{-2.5,-2.5},{2.5,2.5}}, rotation=90)));
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
  positionPublisher=ephemeris.position;
  velocityPublisher=ephemeris.velocity;
  sunECI=ephemeris.sunDirection;
  sunVectorGCRSPublisher=sunECI;
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
    stationUnit[i,:]=ephemeris.earthToInertial*stationUnitEarth[i,:];
    stationPosition[i,:]=stationRadius[i]*stationUnit[i,:];
    stationRelative[i,:]=environment.position-stationPosition[i,:];
    stationVelocity[i,:]=stationRadius[i]*(ephemeris.earthToInertialRate*stationUnitEarth[i,:]);
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
    OneSatSim.Foundation.Functions.estimateGroundContactDuration(
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
  activeGroundStationVectorGCRSPublisher=activeGroundVectorECI;
  activeGroundTrackingRateECI=cross(activeGroundVectorECI,activeGroundVectorRateECI);
  activeGroundTrackingRateBodyPublisher=Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve2(worldToBody,activeGroundTrackingRateECI);
  activeGroundTrackingRateGCRSPublisher=activeGroundTrackingRateECI;
  for i in 1:32 loop
    targetUnitEarth[i,:]={targetCosLatitude[i]*targetCosLongitude[i],
      targetCosLatitude[i]*targetSinLongitude[i],targetSinLatitude[i]};
    targetUnit[i,:]=ephemeris.earthToInertial*targetUnitEarth[i,:];
    targetPosition[i,:]=targetRadius[i]*targetUnit[i,:];
    targetRelative[i,:]=environment.position-targetPosition[i,:];
    targetVelocity[i,:]=targetRadius[i]*(ephemeris.earthToInertialRate*targetUnitEarth[i,:]);
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
  activeTargetVectorGCRSPublisher=activeTargetVectorECI;
  activeTargetTrackingRateECI=cross(activeTargetVectorECI,activeTargetVectorRateECI);
  activeTargetTrackingRateBodyPublisher=Modelica.Mechanics.MultiBody.Frames.TransformationMatrices.resolve2(worldToBody,activeTargetTrackingRateECI);
  activeTargetTrackingRateGCRSPublisher=activeTargetTrackingRateECI;
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
  annotation(Documentation(info="<html><h2>真实历元轨道、多地面站与多目标环境核心</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Models.OrbitalGeometry</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>真实历元轨道、多地面站与多目标环境核心</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Simulation.OrbitalEnvironment\">OneSatSim.Simulation.OrbitalEnvironment</a> 的 <code>geometry</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>euler[3]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 euler</td></tr><tr><td><code>bodyRate[3]</code></td><td>Modelica.Blocks.Interfaces.RealInput</td><td>public</td><td>按声明/类型合同</td><td>机体系陀螺角速率</td></tr><tr><td><code>activeMissionSelection</code></td><td>OneSatSim.Foundation.Interfaces.ActiveMissionSelectionInput</td><td>public</td><td>按声明/类型合同</td><td>来自OBC的任务对象锁存索引</td></tr><tr><td><code>environment</code></td><td>OneSatSim.Foundation.Interfaces.EnvironmentPort</td><td>public</td><td>按声明/类型合同</td><td>外部环境接口或实例</td></tr><tr><td><code>ephemeris</code></td><td>OneSatSim.Foundation.Interfaces.EphemerisPort</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 ephemeris</td></tr><tr><td><code>positionPublisher[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>m</td><td>位置Publisher [m]</td></tr><tr><td><code>velocityPublisher[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>m/s</td><td>计算/接口量 velocityPublisher [m/s]</td></tr><tr><td><code>quaternionPublisher[4]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>四元数Publisher</td></tr><tr><td><code>eulerPublisher[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>rad</td><td>计算/接口量 eulerPublisher [rad]</td></tr><tr><td><code>bodyRatePublisher[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>rad/s</td><td>本体速率Publisher [rad/s]</td></tr><tr><td><code>sunVectorBodyPublisher[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>sunVector本体Publisher</td></tr><tr><td><code>earthVectorBodyPublisher[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>earthVector本体Publisher</td></tr><tr><td><code>targetVectorBodyPublisher[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>目标Vector本体Publisher</td></tr><tr><td><code>groundStationVectorBodyPublisher[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>地面站点Vector本体Publisher</td></tr><tr><td><code>targetPrePointOpportunityPublisher</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>目标PrePointOpportunityPublisher</td></tr><tr><td><code>earlyTargetPrePointOpportunityPublisher</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>early目标PrePointOpportunityPublisher</td></tr><tr><td><code>groundPrePointOpportunityPublisher</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>地面PrePointOpportunityPublisher</td></tr><tr><td><code>targetPrePointIndexPublisher</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>目标PrePointIndexPublisher</td></tr><tr><td><code>earlyTargetPrePointIndexPublisher</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>early目标PrePointIndexPublisher</td></tr><tr><td><code>groundPrePointIndexPublisher</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>地面PrePointIndexPublisher</td></tr><tr><td><code>targetOpportunityTimeRemainingPublisher</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>s</td><td>目标Opportunity时间RemainingPublisher [s]</td></tr><tr><td><code>groundOpportunityTimeRemainingPublisher</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>s</td><td>地面Opportunity时间RemainingPublisher [s]</td></tr><tr><td><code>activeTargetVectorBodyPublisher[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>激活目标Vector本体Publisher</td></tr><tr><td><code>activeGroundStationVectorBodyPublisher[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>激活地面站点Vector本体Publisher</td></tr><tr><td><code>activeTargetTrackingRateBodyPublisher[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>rad/s</td><td>激活目标跟踪速率本体Publisher [rad/s]</td></tr><tr><td><code>activeGroundTrackingRateBodyPublisher[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>rad/s</td><td>激活地面跟踪速率本体Publisher [rad/s]</td></tr><tr><td><code>activeTargetVisiblePublisher</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>激活目标VisiblePublisher</td></tr><tr><td><code>activeTargetPreparationOpportunityPublisher</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>激活目标PreparationOpportunityPublisher</td></tr><tr><td><code>activeTargetEarlyPrePointOpportunityPublisher</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>激活目标EarlyPrePointOpportunityPublisher</td></tr><tr><td><code>activeGroundContactPublisher</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>激活地面ContactPublisher</td></tr><tr><td><code>targetElevationRatePublisher</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>1/s</td><td>目标Elevation速率Publisher [1/s]</td></tr><tr><td><code>groundElevationRatePublisher</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>1/s</td><td>地面Elevation速率Publisher [1/s]</td></tr><tr><td><code>targetElevationIncreasingPublisher</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>目标ElevationIncreasingPublisher</td></tr><tr><td><code>groundElevationIncreasingPublisher</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>地面ElevationIncreasingPublisher</td></tr><tr><td><code>offNadirAnglePublisher</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>rad</td><td>计算/接口量 offNadirAnglePublisher [rad]</td></tr><tr><td><code>cameraLookAnglePublisher</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>rad</td><td>计算/接口量 cameraLookAnglePublisher [rad]</td></tr><tr><td><code>targetSunElevationPublisher</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>rad</td><td>目标SunElevationPublisher [rad]</td></tr><tr><td><code>offNadirValidPublisher</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 offNadirValidPublisher</td></tr><tr><td><code>cameraFOVValidPublisher</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 cameraFOVValidPublisher</td></tr><tr><td><code>targetIlluminationValidPublisher</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>目标IlluminationValidPublisher</td></tr><tr><td><code>imagingValidPublisher</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>成像ValidPublisher</td></tr><tr><td><code>sunIncidenceAnglePublisher</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>rad</td><td>计算/接口量 sunIncidenceAnglePublisher [rad]</td></tr><tr><td><code>solarFluxPublisher</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>W/m2</td><td>solar通量Publisher [W/m2]</td></tr><tr><td><code>earthInfraredFluxPublisher</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>W/m2</td><td>earthInfrared通量Publisher [W/m2]</td></tr><tr><td><code>albedoFluxPublisher</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>W/m2</td><td>albedo通量Publisher [W/m2]</td></tr><tr><td><code>eclipsePublisher</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 eclipsePublisher</td></tr><tr><td><code>targetVisiblePublisher</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>目标VisiblePublisher</td></tr><tr><td><code>targetIndexPublisher</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>目标IndexPublisher</td></tr><tr><td><code>groundContactPublisher</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>地面ContactPublisher</td></tr><tr><td><code>groundStationIndexPublisher</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>地面站点IndexPublisher</td></tr><tr><td><code>referenceAltitudePublisher</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>m</td><td>计算/接口量 referenceAltitudePublisher [m]</td></tr><tr><td><code>instantaneousAltitudePublisher</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>m</td><td>计算/接口量 instantaneousAltitudePublisher [m]</td></tr><tr><td><code>sunVectorGCRSPublisher[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 sunVectorGCRSPublisher</td></tr><tr><td><code>activeTargetVectorGCRSPublisher[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>激活目标VectorGCRSPublisher</td></tr><tr><td><code>activeGroundStationVectorGCRSPublisher[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>激活地面站点VectorGCRSPublisher</td></tr><tr><td><code>activeTargetTrackingRateGCRSPublisher[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>激活目标跟踪速率GCRSPublisher</td></tr><tr><td><code>activeGroundTrackingRateGCRSPublisher[3]</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>激活地面跟踪速率GCRSPublisher</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>orbit</code></td><td>OneSatSim.Scenarios.OrbitConfig</td><td>真实历元轨道输入及生成环境资源</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>groundStations[8]</code></td><td>OneSatSim.Scenarios.GroundStationConfig</td><td>最多8个地面站</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>imagingTargets[32]</code></td><td>OneSatSim.Scenarios.ImagingTargetConfig</td><td>最多32个拍摄目标</td><td><code>由调用方、继承或默认声明提供</code></td></tr><tr><td><code>earthRadius</code></td><td>SI.Length</td><td>地球参考半径 [m]</td><td><code>=6378137</code></td></tr><tr><td><code>referenceAltitude</code></td><td>SI.Length</td><td>标称轨道高度，不代表椭圆轨道瞬时高度</td><td><code>=orbit.referenceSemiMajorAxis-earthRadius</code></td></tr><tr><td><code>orbitPeriod</code></td><td>SI.Time</td><td>起点状态对应的圆轨道等效周期</td><td><code>=2*Modelica.Constants.pi*sqrt(orbit.referenceSemiMajorAxis^3/3.986004418e14)</code></td></tr><tr><td><code>targetPrePointingMargin</code></td><td>SI.Angle</td><td>任务级参数：正式目标可见前的高度角余量</td><td><code>=18*Modelica.Constants.pi/180</code></td></tr><tr><td><code>groundPrePointingMargin</code></td><td>SI.Angle</td><td>任务级参数：正式地面站可见前的高度角余量</td><td><code>=4*Modelica.Constants.pi/180</code></td></tr><tr><td><code>targetPredictionHorizon</code></td><td>SI.Time</td><td>代数前视时域；在90 s准备时限内为线性化误差保留6 s</td><td><code>=84</code></td></tr><tr><td><code>earlyTargetPredictionHorizon</code></td><td>SI.Time</td><td>仅供相机关闭状态下目标预机动使用的提前前视时域</td><td><code>=180</code></td></tr><tr><td><code>groundPredictionHorizon</code></td><td>SI.Time</td><td>排除无法在准备时限内进入正式可见区的掠过预指向机会</td><td><code>=180</code></td></tr><tr><td><code>maxOffNadir_deg</code></td><td>SI.Angle</td><td>任务级参数：对地观测最大偏离天底角</td><td><code>=30*Modelica.Constants.pi/180</code></td></tr><tr><td><code>cameraHalfFOV_deg</code></td><td>SI.Angle</td><td>任务级参数：+X对地相机半视场角；全视场角按14 deg设置</td><td><code>=7*Modelica.Constants.pi/180</code></td></tr><tr><td><code>minTargetSunElevation_deg</code></td><td>SI.Angle</td><td>任务级参数：目标照明的最小太阳高度角</td><td><code>=0*Modelica.Constants.pi/180</code></td></tr><tr><td><code>cosMaxOffNadir</code></td><td>Real</td><td>配置项 cosMaxOffNadir</td><td><code>=cos(maxOffNadir_deg)</code></td></tr><tr><td><code>cosCameraHalfFOV</code></td><td>Real</td><td>配置项 cosCameraHalfFOV</td><td><code>=cos(cameraHalfFOV_deg)</code></td></tr><tr><td><code>sinMinTargetSunElevation</code></td><td>Real</td><td>sinMin目标SunElevation</td><td><code>=sin(minTargetSunElevation_deg)</code></td></tr><tr><td><code>stationSinLatitude[8]</code></td><td>Real</td><td>站点SinLatitude</td><td><code>={sin(groundStations[i].latitude) for i in 1:8}</code></td></tr><tr><td><code>stationCosLatitude[8]</code></td><td>Real</td><td>站点CosLatitude</td><td><code>={cos(groundStations[i].latitude) for i in 1:8}</code></td></tr><tr><td><code>stationSinLongitude[8]</code></td><td>Real</td><td>站点SinLongitude</td><td><code>={sin(groundStations[i].longitude) for i in 1:8}</code></td></tr><tr><td><code>stationCosLongitude[8]</code></td><td>Real</td><td>站点CosLongitude</td><td><code>={cos(groundStations[i].longitude) for i in 1:8}</code></td></tr><tr><td><code>stationRadius[8]</code></td><td>Real</td><td>站点Radius</td><td><code>={earthRadius+groundStations[i].altitude for i in 1:8}</code></td></tr><tr><td><code>stationMinimumElevationSin[8]</code></td><td>Real</td><td>站点MinimumElevationSin</td><td><code>={sin(groundStations[i].minimumElevation) for i in 1:8}</code></td></tr><tr><td><code>stationPrePointElevationSin[8]</code></td><td>Real</td><td>站点PrePointElevationSin</td><td><code>={sin(max(-Modelica.Constants.pi/2, groundStations[i].minimumElevation-groundPrePointingMargin)) for i in 1:8}</code></td></tr><tr><td><code>targetSinLatitude[32]</code></td><td>Real</td><td>目标SinLatitude</td><td><code>={sin(imagingTargets[i].latitude) for i in 1:32}</code></td></tr><tr><td><code>targetCosLatitude[32]</code></td><td>Real</td><td>目标CosLatitude</td><td><code>={cos(imagingTargets[i].latitude) for i in 1:32}</code></td></tr><tr><td><code>targetSinLongitude[32]</code></td><td>Real</td><td>目标SinLongitude</td><td><code>={sin(imagingTargets[i].longitude) for i in 1:32}</code></td></tr><tr><td><code>targetCosLongitude[32]</code></td><td>Real</td><td>目标CosLongitude</td><td><code>={cos(imagingTargets[i].longitude) for i in 1:32}</code></td></tr><tr><td><code>targetRadius[32]</code></td><td>Real</td><td>目标Radius</td><td><code>={earthRadius+imagingTargets[i].altitude for i in 1:32}</code></td></tr><tr><td><code>targetMinimumElevationSin[32]</code></td><td>Real</td><td>目标MinimumElevationSin</td><td><code>={sin(imagingTargets[i].minimumElevation) for i in 1:32}</code></td></tr><tr><td><code>targetPrePointElevationSin[32]</code></td><td>Real</td><td>目标PrePointElevationSin</td><td><code>={sin(max(-Modelica.Constants.pi/2, imagingTargets[i].minimumElevation-targetPrePointingMargin)) for i in 1:32}</code></td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[initial equation] assert(orbit.eccentricity &gt;= 0 and orbit.eccentricity &lt; 1,&quot;Orbit eccentricity must satisfy 0 &lt;= e &lt; 1&quot;);\n[initial equation] assert(orbit.semiMajorAxis &gt; earthRadius + 100000 and orbit.semiMajorAxis &lt; earthRadius + 100000000,&quot;Orbit semi-major axis is outside the supported low-Earth/system-level range&quot;);\n[initial equation] for i in 1:8 loop assert(not groundStations[i].enabled or groundStations[i].id &gt; 0,&quot;Enabled ground-station ID must be positive&quot;);\n[initial equation] assert(not groundStations[i].enabled or (groundStations[i].latitude &gt;= -Modelica.Constants.pi/2 and groundStations[i].latitude &lt;= Modelica.Constants.pi/2),&quot;Ground-station latitude must be within [-pi/2, pi/2]&quot;);\n[initial equation] assert(not groundStations[i].enabled or (groundStations[i].longitude &gt;= -Modelica.Constants.pi and groundStations[i].longitude &lt;= Modelica.Constants.pi),&quot;Ground-station longitude must be within [-pi, pi]&quot;);\n[initial equation] end for;\n[initial equation] for i in 1:32 loop assert(not imagingTargets[i].enabled or imagingTargets[i].id &gt; 0,&quot;Enabled imaging-target ID must be positive&quot;);\n[initial equation] assert(not imagingTargets[i].enabled or (imagingTargets[i].latitude &gt;= -Modelica.Constants.pi/2 and imagingTargets[i].latitude &lt;= Modelica.Constants.pi/2),&quot;Imaging-target latitude must be within [-pi/2, pi/2]&quot;);\n[initial equation] assert(not imagingTargets[i].enabled or (imagingTargets[i].longitude &gt;= -Modelica.Constants.pi and imagingTargets[i].longitude &lt;= Modelica.Constants.pi),&quot;Imaging-target longitude must be within [-pi, pi]&quot;);\n[initial equation] end for;</pre><p>本类另有162段语句；阅读完整源码可查看其余边界与逻辑。</p><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>sunECI[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 sunECI；Normalized inertial Sun direction</td></tr><tr><td><code>earthVectorECI[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 earthVectorECI；Unit vector from spacecraft toward Earth center in inertial axes</td></tr><tr><td><code>spacecraftRange2</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 spacecraftRange2</td></tr><tr><td><code>spacecraftInvRange</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 spacecraftInvRange</td></tr><tr><td><code>worldToBody[3,3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>world转换为本体；MSL rotation matrix using the same {1,2,3} sequence as AbsoluteAngles</td></tr><tr><td><code>halfRollCos</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 halfRollCos</td></tr><tr><td><code>halfRollSin</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 halfRollSin</td></tr><tr><td><code>halfPitchCos</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 halfPitchCos</td></tr><tr><td><code>halfPitchSin</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 halfPitchSin</td></tr><tr><td><code>halfYawCos</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 halfYawCos</td></tr><tr><td><code>halfYawSin</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 halfYawSin</td></tr><tr><td><code>stationUnitEarth[8,3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>球形ITRS站点单位矢量</td></tr><tr><td><code>stationUnit[8,3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>站点Unit</td></tr><tr><td><code>stationPosition[8,3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>地面站地心位置</td></tr><tr><td><code>stationRelative[8,3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>地面站到航天器的相对位置</td></tr><tr><td><code>stationVelocity[8,3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>地面站惯性速度</td></tr><tr><td><code>stationRelativeVelocity[8,3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>相对速度</td></tr><tr><td><code>stationElevationSin[8]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>站点ElevationSin</td></tr><tr><td><code>stationElevationRate[8]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>站点Elevation速率</td></tr><tr><td><code>stationRange2[8]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>站点Range2</td></tr><tr><td><code>stationInvRange[8]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>站点InvRange</td></tr><tr><td><code>stationRelativeDotVelocity[8]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>站点相对DotVelocity</td></tr><tr><td><code>stationClosestTime[8]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>站点Closest时间</td></tr><tr><td><code>stationPredictedRelative[8,3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>站点Predicted相对</td></tr><tr><td><code>stationPredictedPosition[8,3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>站点Predicted位置</td></tr><tr><td><code>stationPredictedRange2[8]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>站点PredictedRange2</td></tr><tr><td><code>stationPredictedRadius2[8]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>站点PredictedRadius2</td></tr><tr><td><code>stationPredictedElevationSin[8]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>站点PredictedElevationSin</td></tr><tr><td><code>stationVisible[8]</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>站点Visible</td></tr><tr><td><code>stationPrePoint[8]</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>站点PrePoint</td></tr><tr><td><code>stationBestPriority[8]</code></td><td>Integer</td><td>public</td><td>按声明/类型合同</td><td>站点BestPriority</td></tr><tr><td><code>stationSelectedIndex[8]</code></td><td>Integer</td><td>public</td><td>按声明/类型合同</td><td>站点选定Index</td></tr><tr><td><code>stationPrePointBestPriority[8]</code></td><td>Integer</td><td>public</td><td>按声明/类型合同</td><td>站点PrePointBestPriority</td></tr><tr><td><code>stationPrePointSelectedIndex[8]</code></td><td>Integer</td><td>public</td><td>按声明/类型合同</td><td>站点PrePoint选定Index</td></tr><tr><td><code>selectedGroundVectorECI[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>选定地面VectorECI；Unit line of sight from spacecraft to selected ground station</td></tr><tr><td><code>selectedGroundIndex</code></td><td>Integer</td><td>public</td><td>按声明/类型合同</td><td>选定地面Index</td></tr><tr><td><code>selectedGroundIndexValid</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>选定地面IndexValid</td></tr><tr><td><code>activeGroundIndex</code></td><td>Integer</td><td>public</td><td>按声明/类型合同</td><td>激活地面Index</td></tr><tr><td><code>activeGroundIndexValid</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>激活地面IndexValid</td></tr><tr><td><code>activeGroundEnabled</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>激活地面启用</td></tr><tr><td><code>activeGroundVectorECI[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>激活地面VectorECI；LOS to the command-latched station, independent of live top-priority selection</td></tr><tr><td><code>activeGroundVectorRateECI[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>激活地面Vector速率ECI</td></tr><tr><td><code>activeGroundTrackingRateECI[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>激活地面跟踪速率ECI</td></tr><tr><td><code>targetUnitEarth[32,3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>球形ITRS目标单位矢量</td></tr><tr><td><code>targetUnit[32,3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标Unit</td></tr><tr><td><code>targetPosition[32,3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标位置</td></tr><tr><td><code>targetRelative[32,3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标相对</td></tr><tr><td><code>targetVelocity[32,3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标Velocity</td></tr><tr><td><code>targetRelativeVelocity[32,3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标相对Velocity</td></tr><tr><td><code>targetElevationSin[32]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标ElevationSin</td></tr><tr><td><code>targetElevationRate[32]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标Elevation速率</td></tr><tr><td><code>targetRange2[32]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标Range2</td></tr><tr><td><code>targetInvRange[32]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标InvRange</td></tr><tr><td><code>targetRelativeDotVelocity[32]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标相对DotVelocity</td></tr><tr><td><code>targetOffNadirCos[32]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标OffNadirCos</td></tr><tr><td><code>targetSunElevationSin[32]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标SunElevationSin</td></tr><tr><td><code>targetClosestTime[32]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标Closest时间；Clamped constant-velocity time to closest relative approach</td></tr><tr><td><code>targetPredictedRelative[32,3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标Predicted相对</td></tr><tr><td><code>targetPredictedSpacecraft[32,3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标PredictedSpacecraft</td></tr><tr><td><code>targetPredictedRange2[32]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标PredictedRange2</td></tr><tr><td><code>targetPredictedSpacecraftRange2[32]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标PredictedSpacecraftRange2</td></tr><tr><td><code>targetPredictedOffNadirCos[32]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标PredictedOffNadirCos；Predicted best off-nadir cosine without a new orbit state or search loop</td></tr><tr><td><code>targetEarlyClosestTime[32]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标EarlyClosest时间</td></tr><tr><td><code>targetEarlyPredictedRelative[32,3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标EarlyPredicted相对</td></tr><tr><td><code>targetEarlyPredictedSpacecraft[32,3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标EarlyPredictedSpacecraft</td></tr><tr><td><code>targetEarlyPredictedRange2[32]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标EarlyPredictedRange2</td></tr><tr><td><code>targetEarlyPredictedSpacecraftRange2[32]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标EarlyPredictedSpacecraftRange2</td></tr><tr><td><code>targetEarlyPredictedOffNadirCos[32]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>目标EarlyPredictedOffNadirCos</td></tr><tr><td><code>targetVisibleInternal[32]</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>目标VisibleInternal</td></tr><tr><td><code>targetPrePoint[32]</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>目标PrePoint</td></tr><tr><td><code>targetEarlyPrePoint[32]</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>目标EarlyPrePoint</td></tr><tr><td><code>targetBestPriority[32]</code></td><td>Integer</td><td>public</td><td>按声明/类型合同</td><td>目标BestPriority</td></tr><tr><td><code>targetSelectedIndex[32]</code></td><td>Integer</td><td>public</td><td>按声明/类型合同</td><td>目标选定Index</td></tr><tr><td><code>targetPrePointBestPriority[32]</code></td><td>Integer</td><td>public</td><td>按声明/类型合同</td><td>目标PrePointBestPriority</td></tr><tr><td><code>targetPrePointSelectedIndex[32]</code></td><td>Integer</td><td>public</td><td>按声明/类型合同</td><td>目标PrePoint选定Index</td></tr><tr><td><code>targetEarlyPrePointBestPriority[32]</code></td><td>Integer</td><td>public</td><td>按声明/类型合同</td><td>目标EarlyPrePointBestPriority</td></tr><tr><td><code>targetEarlyPrePointSelectedIndex[32]</code></td><td>Integer</td><td>public</td><td>按声明/类型合同</td><td>目标EarlyPrePoint选定Index</td></tr><tr><td><code>selectedTargetVectorECI[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>选定目标VectorECI；Unit line of sight from spacecraft to selected imaging target</td></tr><tr><td><code>selectedTargetIndex</code></td><td>Integer</td><td>public</td><td>按声明/类型合同</td><td>选定目标Index</td></tr><tr><td><code>selectedTargetIndexValid</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>选定目标IndexValid</td></tr><tr><td><code>activeTargetIndex</code></td><td>Integer</td><td>public</td><td>按声明/类型合同</td><td>锁存目标ID</td></tr><tr><td><code>activeTargetIndexValid</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>激活目标IndexValid</td></tr><tr><td><code>activeTargetEnabled</code></td><td>Boolean</td><td>public</td><td>按声明/类型合同</td><td>激活目标启用</td></tr><tr><td><code>activeTargetVectorECI[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>激活目标VectorECI；LOS to the command-latched target, independent of live top-priority selection</td></tr><tr><td><code>activeTargetVectorRateECI[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>激活目标Vector速率ECI</td></tr><tr><td><code>activeTargetTrackingRateECI[3]</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>激活目标跟踪速率ECI</td></tr><tr><td><code>activeTargetOffNadirCos</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>激活目标OffNadirCos</td></tr><tr><td><code>activeTargetSunElevationSin</code></td><td>Real</td><td>public</td><td>按声明/类型合同</td><td>激活目标SunElevationSin</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Ellipse(extent={{-35,-31},{19,23}}, lineColor={0,0,0}, fillColor={239,246,250}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-18.8,-31},{2.8,23}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Ellipse(extent={{-35,-13.45},{19,5.45}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Line(points={{-35,-4},{19,-4}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-8,-31},{-8,23}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-67,-36},{63,44}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.7, startAngle=0, endAngle=360),
      Rectangle(extent={{41,21},{51,31}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Rectangle(extent={{33,22},{40,30}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{52,22},{59,30}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{46,21},{3,11}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Line(points={{46,21},{15,-14}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Ellipse(extent={{0,8},{6,14}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Ellipse(extent={{12,-17},{18,-11}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Orbit and Visibility", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-511,-316},{668,410}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-286.88,-89.24},{-123.12,87.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-274.92,58.88},{-135.08,58.88}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-282.28,63.48},{-263.88,81.88}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-261.12,65.32},{-135.08,79.12}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Ellipse(extent={{-237.2,-28.52},{-187.52,21.16}}, lineColor={0,0,0}, fillColor={239,246,250}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-222.296,-28.52},{-202.424,21.16}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Ellipse(extent={{-237.2,-12.374},{-187.52,5.014}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Line(points={{-237.2,-3.68},{-187.52,-3.68}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-212.36,-28.52},{-212.36,21.16}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-266.64,-33.12},{-147.04,40.48}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.7, startAngle=0, endAngle=360),
      Rectangle(extent={{-167.28,19.32},{-158.08,28.52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Rectangle(extent={{-174.64,20.24},{-168.2,27.6}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{-157.16,20.24},{-150.72,27.6}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-162.68,19.32},{-202.24,10.12}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Line(points={{-162.68,19.32},{-191.2,-12.88}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Ellipse(extent={{-205,7.36},{-199.48,12.88}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Ellipse(extent={{-193.96,-15.64},{-188.44,-10.12}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Line(points={{-274.92,-53.36},{-135.08,-53.36}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-278.6,-72.68},{-131.4,-58.88}}, textString="Orbit and Visibility", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{24,322},{158.4,340}}, textString="ORBIT / ATTITUDE", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{24,-28},{119,-10}}, textString="RADIATION", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{239,322},{365,340}}, textString="TARGET GEOMETRY", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{439,322},{534,340}}, textString="GROUND LINK", fontSize=0, lineColor={79,89,100}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Text(extent={{-499,365},{656,394}}, textString="Orbital Geometry and Opportunities", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-499,357},{656,357}}, color={215,220,226}, thickness=0.25)
    }));
end OrbitalGeometry;