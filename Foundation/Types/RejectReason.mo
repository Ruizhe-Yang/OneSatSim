within OneSatSim.Foundation.Types;
type RejectReason = enumeration(None, LowSOC, LowBusVoltage, ThermalLimit, StorageFull, NoData, AttitudeUnavailable, Busy, InvalidState, Timeout, SafetyPreempted, TargetVisibilityLost, OffNadirLimit, CameraFOVLimit, TargetNotIlluminated, InsufficientOpportunityTime, StaleOpportunity) "任务请求拒绝或中止原因"
  annotation(Documentation(info="<html><p>给出任务请求因能源、热、存储、姿态、可见性、视场或安全抢占而被拒绝或中止的结构化原因。</p></html>"));
