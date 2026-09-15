within OneSatSim.Foundation.Interfaces;
connector SafetySignals "Mission safety permissions and safe-mode demand"
  BooleanSignal spacecraftHealthy;
  BooleanSignal imagingAllowed;
  BooleanSignal downlinkAllowed;
  BooleanSignal powerHealthy;
  BooleanSignal thermalHealthy;
  BooleanSignal attitudeHealthy;
  BooleanSignal storageHealthy;
  BooleanSignal safeModeRequired;
  BooleanSignal recoveryAllowed;
  RejectReasonSignal safetyReason;
  annotation(Icon(graphics={Rectangle(extent={{-100,60},{100,-60}},lineColor={170,75,40},fillColor={252,239,230},fillPattern=FillPattern.Solid),Text(extent={{-94,18},{94,-18}},textString="SAFETY")}),Documentation(info="<html><p>安全监视器的唯一输出接口，集中表达任务许可、安全模式需求与恢复条件。</p></html>"));
end SafetySignals;
