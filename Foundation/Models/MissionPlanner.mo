within OneSatSim.Foundation.Models;
model MissionPlanner "对象感知的任务规划器"
  OneSatSim.Foundation.Interfaces.OpportunitySignals opportunity annotation(Placement(transformation(extent={{-112,30},{-92,50}})));
  OneSatSim.Foundation.Interfaces.MissionFeedbackBus feedback annotation(Placement(transformation(extent={{-112,-50},{-92,-30}})));
  OneSatSim.Foundation.Interfaces.PlannerRequestSignals request annotation(Placement(transformation(extent={{92,-10},{112,10}})));
protected
  OneSatSim.Foundation.Types.CommandType candidate;
  Integer candidateTarget;
  Integer candidateStation;
  Integer candidateWindow;
  Integer id;
  discrete Boolean drainMode(start=false,fixed=true);
equation
  candidate=if drainMode then
      (if opportunity.downlinkOpportunityFeasible and feedback.dataAvailable then OneSatSim.Foundation.Types.CommandType.Downlink else
       if opportunity.imagingOpportunityFeasible and not feedback.storageHigh then OneSatSim.Foundation.Types.CommandType.Imaging else OneSatSim.Foundation.Types.CommandType.None)
    else
      (if opportunity.imagingOpportunityFeasible and not feedback.storageHigh then OneSatSim.Foundation.Types.CommandType.Imaging else
       if opportunity.downlinkOpportunityFeasible and feedback.dataAvailable then OneSatSim.Foundation.Types.CommandType.Downlink else OneSatSim.Foundation.Types.CommandType.None);
  candidateTarget=if candidate == OneSatSim.Foundation.Types.CommandType.Imaging then opportunity.earlyTargetPrePointIndex else 0;
  candidateStation=if candidate == OneSatSim.Foundation.Types.CommandType.Downlink then opportunity.groundPrePointIndex else 0;
  candidateWindow=if candidate == OneSatSim.Foundation.Types.CommandType.Imaging then opportunity.targetWindowId else
    if candidate == OneSatSim.Foundation.Types.CommandType.Downlink then opportunity.groundWindowId else 0;
  id=if candidate == OneSatSim.Foundation.Types.CommandType.Imaging then 1000000+1000*candidateWindow+candidateTarget else
    if candidate == OneSatSim.Foundation.Types.CommandType.Downlink then 2000000+1000*candidateWindow+candidateStation else 0;
  request.requestedCommand=candidate;
  request.requestedTargetIndex=candidateTarget;
  request.requestedGroundStationIndex=candidateStation;
  request.requestWindowId=candidateWindow;
  request.requestValid=candidate <> OneSatSim.Foundation.Types.CommandType.None;
  request.requestId=id;
  request.storageUtilization=feedback.storageUtilization;
  request.storageDrainMode=drainMode;
  request.planningRejectReason=if opportunity.earlyTargetPrePointOpportunity and not opportunity.imagingOpportunityFeasible then
      OneSatSim.Foundation.Types.RejectReason.InsufficientOpportunityTime else
    if opportunity.groundPrePointOpportunity and not opportunity.downlinkOpportunityFeasible then
      OneSatSim.Foundation.Types.RejectReason.InsufficientOpportunityTime else
      OneSatSim.Foundation.Types.RejectReason.None;
  request.requestedOpportunityTimeRemaining=if candidate == OneSatSim.Foundation.Types.CommandType.Imaging then opportunity.imagingOpportunityTimeRemaining else
    if candidate == OneSatSim.Foundation.Types.CommandType.Downlink then opportunity.downlinkOpportunityTimeRemaining else
    max(opportunity.imagingOpportunityTimeRemaining,opportunity.downlinkOpportunityTimeRemaining);
algorithm
  when {initial(),feedback.storageUtilization >= 0.50,feedback.storageUtilization <= 0.20} then
    if initial() then
      drainMode:=false;
    elseif feedback.storageUtilization >= 0.50 then
      drainMode:=true;
    elseif feedback.storageUtilization <= 0.20 then
      drainMode:=false;
    end if;
  end when;
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={90,65,145},fillColor={240,234,248},fillPattern=FillPattern.Solid),Polygon(points={{-65,28},{-25,28},{-25,48},{35,0},{-25,-48},{-25,-28},{-65,-28},{-65,28}},fillColor={135,105,185},fillPattern=FillPattern.Solid),Text(extent={{-94,-64},{94,-42}},textString="50/20 PLANNER")}),Documentation(info="<html><h4>功能定位</h4><p>依据原始目标/地面站机会、当前存储、电源和任务反馈提出成像或下传请求。</p><h4>输入与接口关系</h4><p>opportunity提供候选对象与窗口ID；feedback提供SOC、母线、温度、存储、数据可用和当前设备状态。</p><h4>内部职责与实现</h4><p>按安全许可与业务优先级形成对象相关请求，并使用存储高/低水位回差抑制下传需求在边界反复切换。</p><h4>输出</h4><p>PlannerRequestSignals包含请求类型、目标或地面站索引、请求ID和相关窗口标识，交给CommandArbiter。</p><h4>连续/离散状态</h4><p>含少量离散请求/回差状态，不含连续物理状态。新请求只在机会或需求变化时产生。</p><h4>使用与观察</h4><p>查看请求ID、类型、对象索引与反馈门限可解释为何有机会却未请求；最终是否执行由Arbiter和StateMachine决定。</p><h4>建模边界</h4><p>不执行动作、不控制设备、不计算姿态与轨道几何。</p></html>"));
end MissionPlanner;
