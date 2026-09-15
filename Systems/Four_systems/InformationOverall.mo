within OneSatSim.Systems.Four_systems;
model InformationOverall "信息总体"
  Foundation.Interfaces.InformationPort subsystem[8] annotation(Placement(transformation(extent={{-112,-10},{-92,10}})));
equation
  connect(subsystem[1],subsystem[2]) annotation(Line(points={{-102,0},{-75,0}},color={0,90,180},thickness=0.5));
  connect(subsystem[1],subsystem[3]) annotation(Line(points={{-102,0},{-65,0}},color={0,90,180},thickness=0.5));
  connect(subsystem[1],subsystem[4]) annotation(Line(points={{-102,0},{-55,0}},color={0,90,180},thickness=0.5));
  connect(subsystem[1],subsystem[5]) annotation(Line(points={{-102,0},{-45,0}},color={0,90,180},thickness=0.5));
  connect(subsystem[1],subsystem[6]) annotation(Line(points={{-102,0},{-35,0}},color={0,90,180},thickness=0.5));
  connect(subsystem[1],subsystem[7]) annotation(Line(points={{-102,0},{-25,0}},color={0,90,180},thickness=0.5));
  connect(subsystem[1],subsystem[8]) annotation(Line(points={{-102,0},{-15,0}},color={0,90,180},thickness=0.5));
  annotation(Icon(graphics={Rectangle(extent={{-100,85},{100,-85}},lineColor={20,90,155},fillColor={225,240,250},fillPattern=FillPattern.Solid),Line(points={{-75,0},{75,0}},color={20,90,155},thickness=4),Ellipse(extent={{-8,8},{8,-8}},fillColor={20,90,155},fillPattern=FillPattern.Solid),Text(extent={{-92,-82},{92,-58}},textString="ONE INFORMATION BUS")}),Diagram(coordinateSystem(extent={{-110,-110},{110,110}}),graphics={Text(extent={{-94,80},{94,66}},textString="8个N分系统共享设备数据/指令/星上工程遥测")}),Documentation(info="<html><h4>总体职责</h4><p><b>系统角色：</b>1+4+8中的信息总体，将八个分系统的唯一InformationPort汇接为一条星上信息总线</p><p><b>建模层级：</b>四个领域Overall之一，直接服务严格1+4+8总体集成</p><h4>实现与交互</h4><p><b>白箱实现：</b>八个InformationPort直接connect到同一无因果复合总线，不再放置重复路由组件</p><p><b>内部对象：</b>由声明参数和方程构成</p><p><b>端口：</b>无对外连接器；通过参数、方程或算法提供内部计算能力</p><p><b>运行行为：</b>CommandBus、DeviceStatusBus、PayloadDataPort和OnboardTelemetryPort在一条总线上共享；各设备只有一个信息接口</p><h4>参数、状态与使用</h4><p><b>关键参数：</b>八个分系统端口和四个信息语义域</p><p><b>关键状态：</b>总线中当前命令、设备状态、业务数据和保持的工程遥测</p><p><b>遥测关系：</b>统一设备状态进入OBC，OBC形成的工程遥测再沿同一总线到通信分系统和总体输出</p><p><b>使用说明：</b>从SpacecraftSystem总图进入本模型，可检查八个N-System如何共享该领域网络；不要把总体网络理解为高保真有限元、电路板级或软件路由器模型。</p></html>"));
end InformationOverall;
