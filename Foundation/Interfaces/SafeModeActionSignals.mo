within NISSA_12UCubeSat.Foundation.Interfaces;
connector SafeModeActionSignals "Safe-entry and recovery action events"
  BooleanSignal safeEntryComplete;
  BooleanSignal recoveryReady;
  BooleanSignal recoveryComplete;
  IntegerSignal safeEntryCompleteEventId;
  IntegerSignal recoveryCompleteEventId;
  annotation(Icon(graphics={Rectangle(extent={{-100,60},{100,-60}},lineColor={180,70,35},fillColor={253,238,228},fillPattern=FillPattern.Solid),Text(extent={{-94,18},{94,-18}},textString="SAFE ACTION")}),Documentation(info="<html><p>安全进入和恢复时序器向任务状态机返回的单向事件接口。</p></html>"));
end SafeModeActionSignals;
