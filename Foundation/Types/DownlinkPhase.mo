within OneSatSim.Foundation.Types;
type DownlinkPhase = enumeration(Idle, PowerOn, Initialize, WaitGroundPointing, EstablishLink, Transmit, Shutdown, Complete, Failed) "高速数据下传动作阶段"
  annotation(Documentation(info="<html><p>描述高速数据下传从设备上电、初始化、等待地面站指向、建链和发送，到关机、完成或失败的阶段。</p></html>"));
