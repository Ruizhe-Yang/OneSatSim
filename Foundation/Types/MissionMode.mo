within NISSA_12UCubeSat.Foundation.Types;
type MissionMode = enumeration(Boot, Idle, TargetPreSlew, ImagingPreparation, Imaging, DownlinkPreparation, Downlink, SafeEntry, SafeHold, Recovery) "整星总体任务模式"
  annotation(Documentation(info="<html><p>定义整星从启动和空闲，到目标预指向、成像准备、成像、下传准备、下传、安全保持和恢复的总体任务模式。</p></html>"));
