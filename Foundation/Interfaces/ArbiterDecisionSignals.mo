within NISSA_12UCubeSat.Foundation.Interfaces;
connector ArbiterDecisionSignals "Discrete command-arbitration decision"
  IntegerSignal decisionId;
  BooleanSignal accepted;
  BooleanSignal rejected;
  CommandTypeSignal acceptedCommand;
  IntegerSignal acceptedCommandId;
  IntegerSignal acceptedTargetIndex;
  IntegerSignal acceptedGroundStationIndex;
  RealSignal acceptedOpportunityTimeRemaining(unit="s");
  RejectReasonSignal rejectReason;
  BooleanSignal requestPending;
  annotation(Icon(graphics={Rectangle(extent={{-100,60},{100,-60}},lineColor={125,70,155},fillColor={244,235,249},fillPattern=FillPattern.Solid),Text(extent={{-94,18},{94,-18}},textString="DECISION")}),Documentation(info="<html><p>仲裁器对每个新requestId只发布一次锁存决策，decisionId用于状态机的离散握手。</p></html>"));
end ArbiterDecisionSignals;
