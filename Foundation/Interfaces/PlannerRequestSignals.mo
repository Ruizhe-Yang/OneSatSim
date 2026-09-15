within NISSA_12UCubeSat.Foundation.Interfaces;
connector PlannerRequestSignals "Latched planner request"
  BooleanSignal requestValid;
  CommandTypeSignal requestedCommand;
  IntegerSignal requestedTargetIndex;
  IntegerSignal requestedGroundStationIndex;
  IntegerSignal requestWindowId;
  IntegerSignal requestId;
  RealSignal storageUtilization;
  BooleanSignal storageDrainMode;
  RejectReasonSignal planningRejectReason;
  RealSignal requestedOpportunityTimeRemaining(unit="s");
  annotation(Icon(graphics={Rectangle(extent={{-100,60},{100,-60}},lineColor={85,90,145},fillColor={239,239,249},fillPattern=FillPattern.Solid),Text(extent={{-94,18},{94,-18}},textString="REQUEST")}),Documentation(info="<html><p>规划器发布的候选任务请求。requestId是仲裁器识别新请求的唯一事件标识。</p></html>"));
end PlannerRequestSignals;
