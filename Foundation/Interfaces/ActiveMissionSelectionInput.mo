within OneSatSim.Foundation.Interfaces;
connector ActiveMissionSelectionInput "Narrow causal input for active target and station selection"
  input Integer targetIndex;
  input Integer groundStationIndex;
  annotation(Icon(graphics={Rectangle(extent={{-100,60},{100,-60}},lineColor={75,105,145},fillColor={235,243,250},fillPattern=FillPattern.Solid),Text(extent={{-94,18},{94,-18}},textString="ACTIVE SELECT IN")}),Documentation(info="<html><p>机械与轨道环境只通过该窄接口接收任务状态机锁存的活动目标和地面站编号。</p></html>"));
end ActiveMissionSelectionInput;
