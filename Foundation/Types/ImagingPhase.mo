within NISSA_12UCubeSat.Foundation.Types;
type ImagingPhase = enumeration(Idle, PowerOn, Initialize, WaitAttitude, Capture, StoreData, PowerOff, Complete, Failed) "对地观测成像动作阶段"
  annotation(Documentation(info="<html><p>描述对地观测相机从上电、初始化和等待姿态，到曝光、数据存储、关机、完成或失败的阶段。</p></html>"));
