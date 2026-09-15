within OneSatSim.Foundation.Interfaces;
model ControlModeSignalBridge "控制模式因果输出到可扩展信息总线的无状态恒等桥"
  OneSatSim.Foundation.Interfaces.ControlModeInput u
    annotation(Placement(transformation(extent={{-110,-10},{-90,10}})));
  OneSatSim.Foundation.Interfaces.ControlModeOutput y
    annotation(Placement(transformation(extent={{90,-10},{110,10}})));
equation
  y=u;
  annotation(
    Icon(graphics={Rectangle(extent={{-100,55},{100,-55}},lineColor={180,100,20},fillColor={252,244,230},fillPattern=FillPattern.Solid),Line(points={{-72,0},{72,0}},color={180,100,20},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-38,35},{38,-35}},textString="MODE")}),
    Documentation(info="<html><h4>功能定位</h4><p>把姿态控制模式的因果输出发布到可扩展信息总线字段。</p><h4>实现边界</h4><p>u为ControlModeInput、y为ControlModeOutput，仅实现y=u，不改变枚举值，不包含状态、延迟、事件或模式转换逻辑。</p><h4>连接方向与使用</h4><p>该模型只处理因果接口边界，不执行模式选择、优先级、状态保持或枚举转换；模式逻辑仍由EquivalentAOCSCore与任务控制链负责。</p></html>"));
end ControlModeSignalBridge;
