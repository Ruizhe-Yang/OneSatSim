within OneSatSim.Foundation.Interfaces;
model AttitudeControlStateSignalBridge "姿态控制状态因果输出到可扩展信息总线的无状态恒等桥"
  OneSatSim.Foundation.Interfaces.AttitudeControlStateInput u
    annotation(Placement(transformation(extent={{-110,-10},{-90,10}})));
  OneSatSim.Foundation.Interfaces.AttitudeControlStateOutput y
    annotation(Placement(transformation(extent={{90,-10},{110,10}})));
equation
  y=u;
  annotation(
    Icon(graphics={Rectangle(extent={{-100,55},{100,-55}},lineColor={180,100,20},fillColor={252,244,230},fillPattern=FillPattern.Solid),Line(points={{-72,0},{72,0}},color={180,100,20},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-45,35},{45,-35}},textString="STATE")}),
    Documentation(info="<html><h4>功能定位</h4><p>把姿态控制状态的因果输出发布到可扩展信息总线字段。</p><h4>实现边界</h4><p>u为AttitudeControlStateInput、y为AttitudeControlStateOutput，仅实现y=u，不改变枚举值，不包含状态、延迟、事件或状态机逻辑。</p><h4>连接方向与使用</h4><p>模型不判断稳定、饱和或降级状态，也不保持历史值；所有状态判据仍在姿控核心中完成。</p></html>"));
end AttitudeControlStateSignalBridge;
