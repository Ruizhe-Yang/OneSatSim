within OneSatSim.Foundation.Interfaces;
connector MechanicalPort "三维刚性安装接口"
  extends Modelica.Mechanics.MultiBody.Interfaces.Frame_a;
  annotation(Icon(graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={95,95,95},fillColor={215,215,215},fillPattern=FillPattern.Solid),Ellipse(extent={{-45,45},{45,-45}},lineColor={80,80,80}),Line(points={{-70,0},{70,0}},color={80,80,80}),Line(points={{0,-70},{0,70}},color={80,80,80})}));
  annotation(Documentation(info="<html><h4>接口语义</h4><p><b>用途：</b>统一组件安装位置、姿态、力与力矩的多体机械连接</p><p><b>字段与单位：</b>继承Frame_a：位置m、姿态、力N、力矩N·m</p><p><b>信号方向语义：</b>无因果；流变量遵循MultiBody框架平衡</p><p><b>典型连接：</b>组件刚体、N-System、StructureSystem与MechanicsOverall</p><p><b>建模注意：</b>该连接器用于Modelica无因果连接网络；字段名称表达工程语义，不能仅凭曲线数组序号判断来源。</p></html>"));
end MechanicalPort;
