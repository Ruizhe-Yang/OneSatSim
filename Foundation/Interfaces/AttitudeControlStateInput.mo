within OneSatSim.Foundation.Interfaces;
connector AttitudeControlStateInput = input OneSatSim.Foundation.Types.AttitudeControlState
  "姿态控制状态因果输入" annotation(Documentation(info="<html><p>姿态控制状态枚举的因果输入端。仅用于窄适配器接收计算端发布值，不改变枚举语义，也不用于共享总线字段的直接替代。</p></html>"));
