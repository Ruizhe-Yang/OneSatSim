within NISSA_12UCubeSat.Foundation.Interfaces;
connector DownlinkActionSignals "Downlink action state and event identifiers"
  DownlinkPhaseSignal phase;
  BooleanSignal communicationPowerCommand;
  BooleanSignal transmitCommand;
  BooleanSignal busy;
  BooleanSignal active;
  BooleanSignal completed;
  BooleanSignal failed;
  BooleanSignal aborted;
  BooleanSignal timeout;
  IntegerSignal startedEventId;
  IntegerSignal completedEventId;
  IntegerSignal failedEventId;
  IntegerSignal abortedEventId;
  IntegerSignal timeoutEventId;
  annotation(Icon(graphics={Rectangle(extent={{-100,60},{100,-60}},lineColor={25,90,160},fillColor={230,240,251},fillPattern=FillPattern.Solid),Text(extent={{-94,18},{94,-18}},textString="DOWNLINK")}),Documentation(info="<html><p>高速下行动作时序器的状态与单调事件标识。状态机仅通过事件标识接收动作结果。</p></html>"));
end DownlinkActionSignals;
