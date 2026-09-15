within OneSatSim.Foundation.Types;
type ControlMode = enumeration(Initialization, Detumbling, SunPointing, TargetPointing, GroundPointing, SafeMode) "姿态控制请求或实际模式"
  annotation(Documentation(info="<html><p>定义姿态控制系统的初始化、消旋、太阳指向、目标指向、地面站指向和安全模式。</p></html>"));
