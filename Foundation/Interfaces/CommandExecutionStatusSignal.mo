within NISSA_12UCubeSat.Foundation.Interfaces;
connector CommandExecutionStatusSignal=NISSA_12UCubeSat.Foundation.Types.CommandExecutionStatus
  "无因果任务执行状态标量" annotation(Documentation(info="<html><p>任务指令执行状态的无因果共享信号，用于任务内部总线和状态接口，不包含协议编码或事件记忆。</p></html>"));
