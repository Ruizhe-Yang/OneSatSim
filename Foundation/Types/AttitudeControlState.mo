within OneSatSim.Foundation.Types;
type AttitudeControlState = enumeration(
    Initialization "Controller is initializing",
    Slewing "Reference changed and the spacecraft is slewing",
    Settling "Pointing/rate limits are met but dwell is incomplete",
    Tracking "Target or ground reference is stably tracked",
    SunPointing "The 45 degree charging attitude is stably tracked",
    SafeMode "Safe Sun-pointing attitude is stably tracked",
    Saturated "At least one reaction wheel is at its system-level limit")
  "低阶姿态控制器的可观察状态"
  annotation(Documentation(info="<html><p>表示姿态控制器从初始化、机动、稳定到跟踪的运行状态，并区分太阳指向、安全模式和飞轮限速状态。</p></html>"));
