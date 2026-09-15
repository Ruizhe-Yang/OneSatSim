within OneSatSim.Foundation.Interfaces;
connector ActiveMissionSelectionOutput "Narrow causal output for active target and station selection"
  output Integer targetIndex;
  output Integer groundStationIndex;
  annotation(Icon(graphics={Rectangle(extent={{-100,60},{100,-60}},lineColor={75,105,145},fillColor={235,243,250},fillPattern=FillPattern.Solid),Text(extent={{-94,18},{94,-18}},textString="ACTIVE SELECT OUT")}),Documentation(info="<html><p>任务控制向轨道环境发布已锁存活动对象的窄因果接口。</p></html>"));
end ActiveMissionSelectionOutput;
