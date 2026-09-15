within OneSatSim.Foundation.Models;
model MissionOpportunityGenerator "原始机会与活动对象几何生成器"
  parameter Real requiredImagingOpportunityTime(unit="s")=126
    "96 s预转、相机准备、8 s驻留、10 s有效拍摄及余量";
  parameter Real requiredDownlinkOpportunityTime(unit="s")=30
    "上电、初始化、主视轴驻留、建链、最小有效发送和关机余量";
  OneSatSim.Foundation.Interfaces.EnvironmentPort environment annotation(Placement(transformation(extent={{-112,-10},{-92,10}})));
  OneSatSim.Foundation.Interfaces.OpportunitySignals opportunity annotation(Placement(transformation(extent={{92,30},{112,50}})));
  OneSatSim.Foundation.Interfaces.ActiveGeometrySignals activeGeometry annotation(Placement(transformation(extent={{92,-50},{112,-30}})));
protected
  discrete Integer targetWindow(start=0,fixed=true);
  discrete Integer groundWindow(start=0,fixed=true);
equation
  opportunity.imagingOpportunity=environment.earlyTargetPrePointOpportunity;
  opportunity.downlinkOpportunity=environment.groundPrePointOpportunity;
  opportunity.targetPrePointOpportunity=environment.targetPrePointOpportunity;
  opportunity.earlyTargetPrePointOpportunity=environment.earlyTargetPrePointOpportunity;
  opportunity.groundPrePointOpportunity=environment.groundPrePointOpportunity;
  opportunity.imagingOpportunityTimeRemaining=environment.targetOpportunityTimeRemaining;
  opportunity.downlinkOpportunityTimeRemaining=environment.groundOpportunityTimeRemaining;
  opportunity.imagingOpportunityFeasible=environment.earlyTargetPrePointOpportunity and
    environment.targetOpportunityTimeRemaining >= requiredImagingOpportunityTime;
  opportunity.downlinkOpportunityFeasible=environment.groundPrePointOpportunity and
    environment.groundOpportunityTimeRemaining >= requiredDownlinkOpportunityTime;
  opportunity.targetPrePointIndex=environment.targetPrePointIndex;
  opportunity.earlyTargetPrePointIndex=environment.earlyTargetPrePointIndex;
  opportunity.groundPrePointIndex=environment.groundPrePointIndex;
  opportunity.targetWindowId=targetWindow;
  opportunity.groundWindowId=groundWindow;
  opportunity.eclipse=environment.eclipse;
  opportunity.sunlightAvailable=not environment.eclipse and environment.solarFlux > 100;
  opportunity.groundContact=environment.groundContact;
  opportunity.targetVisible=environment.targetVisible;
  opportunity.groundStationIndex=environment.groundStationIndex;
  opportunity.targetIndex=environment.targetIndex;
  activeGeometry.activeTargetVisible=environment.activeTargetVisible;
  activeGeometry.activeTargetPreparationOpportunity=environment.activeTargetPreparationOpportunity;
  activeGeometry.activeTargetEarlyPrePointOpportunity=environment.activeTargetEarlyPrePointOpportunity;
  activeGeometry.activeGroundContact=environment.activeGroundContact;
  activeGeometry.targetElevationRate=environment.targetElevationRate;
  activeGeometry.groundElevationRate=environment.groundElevationRate;
  activeGeometry.targetElevationIncreasing=environment.targetElevationIncreasing;
  activeGeometry.groundElevationIncreasing=environment.groundElevationIncreasing;
  activeGeometry.offNadirAngle=environment.offNadirAngle;
  activeGeometry.cameraLookAngle=environment.cameraLookAngle;
  activeGeometry.targetSunElevation=environment.targetSunElevation;
  activeGeometry.offNadirValid=environment.offNadirValid;
  activeGeometry.cameraFOVValid=environment.cameraFOVValid;
  activeGeometry.targetIlluminationValid=environment.targetIlluminationValid;
  activeGeometry.imagingValid=environment.imagingValid;
algorithm
  when initial() then
    targetWindow:=0;
    groundWindow:=0;
  elsewhen edge(environment.earlyTargetPrePointOpportunity) or
      (environment.earlyTargetPrePointOpportunity and change(environment.earlyTargetPrePointIndex)) then
    targetWindow:=pre(targetWindow)+1;
  elsewhen edge(environment.groundPrePointOpportunity) or
      (environment.groundPrePointOpportunity and change(environment.groundPrePointIndex)) then
    groundWindow:=pre(groundWindow)+1;
  end when;
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={40,120,75},fillColor={232,247,238},fillPattern=FillPattern.Solid),Ellipse(extent={{-66,34},{-10,-22}},lineColor={40,120,75}),Line(points={{-10,6},{62,6}},color={40,120,75},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-94,-64},{94,-42}},textString="OPPORTUNITY")}),Documentation(info="<html><h4>功能定位</h4><p>把EnvironmentPort中的目标、地面站、日影和活动对象几何整理为任务规划机会与动作时序几何两套窄接口。</p><h4>输入与接口关系</h4><p>environment由OrbitalEnvironmentCore提供，包括原始机会、预指向索引、活动目标/站视线、可见性和成像资格。</p><h4>内部职责与实现</h4><p>原始全局机会进入OpportunitySignals供Planner读取；已锁存活动对象的几何进入ActiveGeometrySignals供Imaging/Downlink Sequencer验证。</p><h4>输出</h4><p>输出区分尚未接受任务的候选机会与已经接受任务的活动对象，避免任务中途因最优对象变化而跳转。</p><h4>连续/离散状态</h4><p>纯代数映射，无状态；活动对象锁存由MissionStateMachine及Mailbox链维护。</p><h4>使用与观察</h4><p>调试机会缺失看opportunity，调试动作中途资格看activeGeometry，两者不可混用。</p><h4>建模边界</h4><p>不做规划、仲裁和轨道传播，只整理环境核心已有字段。</p></html>"));
end MissionOpportunityGenerator;
