within OneSatSim.Foundation.Models;
model CommandArbiter "任务请求的单入口事件锁存仲裁器"
  OneSatSim.Foundation.Interfaces.PlannerRequestSignals request annotation(Placement(transformation(extent={{-112,50},{-92,70}})));
  OneSatSim.Foundation.Interfaces.SafetySignals safety annotation(Placement(transformation(extent={{-112,10},{-92,30}})));
  OneSatSim.Foundation.Interfaces.ArbiterDecisionSignals decision annotation(Placement(transformation(extent={{92,-10},{112,10}})));
protected
  discrete Integer decisionCounter(start=0,fixed=true);
  discrete Integer lastHandledRequest(start=-999,fixed=true);
  discrete Boolean acceptedLatch(start=false,fixed=true);
  discrete Boolean rejectedLatch(start=false,fixed=true);
  discrete OneSatSim.Foundation.Types.CommandType acceptedCommandLatch(
    start=OneSatSim.Foundation.Types.CommandType.None,fixed=true);
  discrete Integer acceptedCommandIdLatch(start=0,fixed=true);
  discrete Integer acceptedTargetLatch(start=0,fixed=true);
  discrete Integer acceptedStationLatch(start=0,fixed=true);
  discrete Real acceptedOpportunityTimeRemainingLatch(start=0,fixed=true);
  discrete OneSatSim.Foundation.Types.RejectReason rejectReasonLatch(
    start=OneSatSim.Foundation.Types.RejectReason.None,fixed=true);
equation
  decision.decisionId=decisionCounter;
  decision.accepted=acceptedLatch;
  decision.rejected=rejectedLatch;
  decision.acceptedCommand=acceptedCommandLatch;
  decision.acceptedCommandId=acceptedCommandIdLatch;
  decision.acceptedTargetIndex=acceptedTargetLatch;
  decision.acceptedGroundStationIndex=acceptedStationLatch;
  decision.acceptedOpportunityTimeRemaining=acceptedOpportunityTimeRemainingLatch;
  decision.rejectReason=rejectReasonLatch;
  decision.requestPending=request.requestValid and request.requestId <> lastHandledRequest;
algorithm
  when initial() then
    decisionCounter:=0;
    lastHandledRequest:=-999;
    acceptedLatch:=false;
    rejectedLatch:=false;
    acceptedCommandLatch:=OneSatSim.Foundation.Types.CommandType.None;
    acceptedCommandIdLatch:=0;
    acceptedTargetLatch:=0;
    acceptedStationLatch:=0;
    acceptedOpportunityTimeRemainingLatch:=0;
    rejectReasonLatch:=OneSatSim.Foundation.Types.RejectReason.None;
  elsewhen edge(safety.safeModeRequired) then
    decisionCounter:=pre(decisionCounter)+1;
    acceptedLatch:=true;
    rejectedLatch:=false;
    acceptedCommandLatch:=OneSatSim.Foundation.Types.CommandType.EnterSafeMode;
    acceptedCommandIdLatch:=-1;
    acceptedTargetLatch:=0;
    acceptedStationLatch:=0;
    acceptedOpportunityTimeRemainingLatch:=1e100;
    rejectReasonLatch:=OneSatSim.Foundation.Types.RejectReason.None;
  elsewhen change(request.requestId) then
    if request.requestValid and request.requestId <> pre(lastHandledRequest) then
      decisionCounter:=pre(decisionCounter)+1;
      lastHandledRequest:=request.requestId;
      acceptedLatch:=(request.requestedCommand == OneSatSim.Foundation.Types.CommandType.Imaging and safety.imagingAllowed) or
         (request.requestedCommand == OneSatSim.Foundation.Types.CommandType.Downlink and safety.downlinkAllowed);
      rejectedLatch:=not ((request.requestedCommand == OneSatSim.Foundation.Types.CommandType.Imaging and safety.imagingAllowed) or
         (request.requestedCommand == OneSatSim.Foundation.Types.CommandType.Downlink and safety.downlinkAllowed));
      acceptedCommandLatch:=if (request.requestedCommand == OneSatSim.Foundation.Types.CommandType.Imaging and safety.imagingAllowed) or
         (request.requestedCommand == OneSatSim.Foundation.Types.CommandType.Downlink and safety.downlinkAllowed) then request.requestedCommand
        else OneSatSim.Foundation.Types.CommandType.None;
      acceptedCommandIdLatch:=request.requestId;
      acceptedTargetLatch:=request.requestedTargetIndex;
      acceptedStationLatch:=request.requestedGroundStationIndex;
      acceptedOpportunityTimeRemainingLatch:=request.requestedOpportunityTimeRemaining;
      rejectReasonLatch:=if request.requestedCommand == OneSatSim.Foundation.Types.CommandType.Imaging and not safety.imagingAllowed then safety.safetyReason else
        if request.requestedCommand == OneSatSim.Foundation.Types.CommandType.Downlink and not safety.downlinkAllowed then safety.safetyReason else
        OneSatSim.Foundation.Types.RejectReason.InvalidState;
    else
      acceptedLatch:=false;
      rejectedLatch:=false;
    end if;
  end when;
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={105,65,145},fillColor={241,235,248},fillPattern=FillPattern.Solid),Polygon(points={{-65,42},{-10,42},{45,0},{-10,-42},{-65,-42},{-20,0},{-65,42}},fillColor={160,125,200},fillPattern=FillPattern.Solid),Text(extent={{-94,-64},{94,-42}},textString="ARBITER")}),Documentation(info="<html><h4>功能定位</h4><p>在安全约束下为成像、下传、安全进入或恢复请求提供唯一事件仲裁入口。</p><h4>输入与接口关系</h4><p>request来自MissionPlanner，safety来自SafetyMonitor；每个请求携带类型、对象索引和事件标识。</p><h4>内部职责与实现</h4><p>在离散事件边界锁存可接受请求，安全命令优先，任务动作只在状态允许且未被禁止时通过；输出拒绝原因与被接受对象。</p><h4>输出</h4><p>decision包含是否接受、命令类型、请求ID、目标/地面站索引及拒绝语义。</p><h4>连续/离散状态</h4><p>含离散锁存状态，只在请求或安全相关事件更新；不包含连续动态。</p><h4>使用与观察</h4><p>从MissionControlUnit查看request—decision连线。分析任务未执行时先检查accepted和rejectReason。</p><h4>建模边界</h4><p>只做单入口仲裁，不执行动作时序，也不计算轨道机会和物理完成条件。</p></html>"));
end CommandArbiter;
