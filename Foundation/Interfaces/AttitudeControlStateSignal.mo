within OneSatSim.Foundation.Interfaces;
connector AttitudeControlStateSignal=OneSatSim.Foundation.Types.AttitudeControlState
  "无因果姿态控制状态标量" annotation(Documentation(info="<html><p>姿态控制状态枚举的无因果共享信号。适合InformationPort内部字段连接，具体生产者与读取者由上层白箱连线确定。</p></html>"));
