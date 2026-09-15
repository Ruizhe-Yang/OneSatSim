within NISSA_12UCubeSat.Foundation.Interfaces;
connector AttitudeControlStateOutput = output NISSA_12UCubeSat.Foundation.Types.AttitudeControlState
  "姿态控制状态因果输出" annotation(Documentation(info="<html><p>姿态控制状态枚举的因果输出端。由计算核心发布确定状态，通常连接AttitudeControlStateSignalBridge后进入共享信息总线。</p></html>"));
