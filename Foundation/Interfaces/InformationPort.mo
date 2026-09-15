within NISSA_12UCubeSat.Foundation.Interfaces;
expandable connector InformationPort "统一星上信息接口"
  CommandBus command;
  CommandStatusBus commandStatus;
  DeviceStatusBus device;
  PayloadDataPort payload;
  annotation(Icon(graphics={Rectangle(extent={{-100,60},{100,-60}},lineColor={0,90,180},fillColor={220,245,255},fillPattern=FillPattern.Solid),Text(extent={{-92,28},{92,-2}},textString="12U CubeSat DATA",textColor={0,90,180}),Text(extent={{-92,-10},{92,-40}},textString="ONE BUS",textColor={0,90,180})}),Documentation(info="<html><h4>接口语义</h4><p><b>用途：</b>把指令、执行状态、设备/传感器状态和业务数据组合为唯一星上信息端口。</p><p><b>字段：</b>command、commandStatus、device、payload。工程遥测不是第二类星上数据，也不回灌本端口；它由整星边界的只读观察器从这些源数据生成。</p><p><b>信号方向语义：</b>外层采用可扩展信息总线；device与payload按唯一生产者发布，command与commandStatus保持固定字段结构以兼容任务控制链。</p></html>"));
end InformationPort;
