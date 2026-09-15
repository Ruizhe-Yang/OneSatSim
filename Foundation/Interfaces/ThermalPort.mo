within NISSA_12UCubeSat.Foundation.Interfaces;
connector ThermalPort "设备壳体热端口"
  extends Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a;
  annotation(Icon(graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={191,0,0},fillColor={255,225,220},fillPattern=FillPattern.Solid),Line(points={{0,70},{0,-45}},color={191,0,0},thickness=2),Ellipse(extent={{-35,-35},{35,-95}},lineColor={191,0,0},fillColor={235,50,35},fillPattern=FillPattern.Solid)}));
  annotation(Documentation(info="<html><h4>接口语义</h4><p><b>用途：</b>在设备热节点和总体热网络之间传递温度与热流</p><p><b>字段与单位：</b>继承HeatPort_a：T单位K，Q_flow单位W</p><p><b>信号方向语义：</b>无因果；Q_flow正值表示热流入当前组件</p><p><b>典型连接：</b>具有显式热模型的Components、N-System与ThermalOverall</p><p><b>建模注意：</b>该连接器用于Modelica无因果连接网络；字段名称表达工程语义，不能仅凭曲线数组序号判断来源。</p></html>"));
end ThermalPort;
