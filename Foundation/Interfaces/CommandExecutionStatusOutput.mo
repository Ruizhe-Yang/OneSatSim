within NISSA_12UCubeSat.Foundation.Interfaces;
connector CommandExecutionStatusOutput = output NISSA_12UCubeSat.Foundation.Types.CommandExecutionStatus
  "指令执行状态因果输出" annotation(Documentation(info="<html><p>任务指令执行状态的因果输出端，用于状态机、时序器或适配器发布单一确定执行状态。</p></html>"));
