within OneSatSim.Foundation.Types;
type CommandType = enumeration(None, Imaging, Downlink, EnterSafeMode, ExitSafeMode) "总体任务指令类型"
  annotation(Documentation(info="<html><p>定义任务调度器可发布的成像、下传、安全模式进入和退出等总体任务指令类型。</p></html>"));
