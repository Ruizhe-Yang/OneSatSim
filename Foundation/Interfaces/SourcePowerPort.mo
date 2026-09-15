within NISSA_12UCubeSat.Foundation.Interfaces;
connector SourcePowerPort "太阳阵/电池/PCDU之间的原始双线电源端口"
  Modelica.Electrical.Analog.Interfaces.Pin p "原始电源正端";
  Modelica.Electrical.Analog.Interfaces.Pin n "原始电源负端";
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={180,90,20},fillColor={255,242,220},fillPattern=FillPattern.Solid),Text(extent={{-92,26},{92,-4}},textString="RAW p / n",textColor={150,70,10}),Text(extent={{-90,-55},{90,-28}},textString="SOURCE",textColor={150,70,10})}),Documentation(info="<html><p>仅用于太阳阵、电池与PCDU输入之间的未稳压双线汇流，当前工作范围约14至17 V。该端口不携带5 V或3.3 V轨，也不应直接连接外部负载母线。</p></html>"));
end SourcePowerPort;
