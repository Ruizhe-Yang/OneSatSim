within OneSatSim.Foundation.Interfaces;
connector PowerPort "三电压轨电源接口"
  Modelica.Electrical.Analog.Interfaces.Pin p12;
  Modelica.Electrical.Analog.Interfaces.Pin n12;
  Modelica.Electrical.Analog.Interfaces.Pin p5;
  Modelica.Electrical.Analog.Interfaces.Pin n5;
  Modelica.Electrical.Analog.Interfaces.Pin p33;
  Modelica.Electrical.Analog.Interfaces.Pin n33;
  annotation(Icon(graphics = {Rectangle(extent = {{-100, 70}, {100, -70}}, lineColor = {0, 0, 200}, fillColor = {224, 232, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-92, 42}, {92, 12}}, textString = "12 / 5 / 3.3 V", textColor = {0, 0, 170}), Line(points = {{-70, -28}, {70, -28}}, color = {0, 0, 200}, thickness = 1), Text(extent = {{-90, -58}, {90, -32}}, textString = "POWER BUS", textColor = {0, 0, 170})}));
  annotation(Documentation(info = "<html><h4>接口语义</h4><p><b>用途：</b>把12 V、5 V和3.3 V三组正负电气Pin打包为一个系统端口</p><p><b>字段与单位：</b>p12/n12、p5/n5、p33/n33，电压V、电流A采用MSL Pin流变量约定</p><p><b>信号方向语义：</b>无因果电端口，电流正方向按Pin流入组件</p><p><b>典型连接：</b>ElectricalOverall、电源分系统与各用电Components</p><p><b>建模注意：</b>该连接器用于Modelica无因果连接网络；字段名称表达工程语义，不能仅凭曲线数组序号判断来源。</p></html>"));
end PowerPort;