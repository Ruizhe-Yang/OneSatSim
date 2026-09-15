within NISSA_12UCubeSat.Foundation.Types;
type CommandExecutionStatus = enumeration(Idle, Requested, Accepted, Rejected, Executing, Completed, Failed, Aborted) "任务指令生命周期状态"
  annotation(Documentation(info="<html><p>统一描述任务指令从空闲、提出、接受和执行，到完成、失败或中止的生命周期状态。</p></html>"));
