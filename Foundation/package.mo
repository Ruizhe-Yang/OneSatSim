within OneSatSim;
package Foundation "基础建模包"
  extends Modelica.Icons.Package annotation(IconMap(primitivesVisible=false),DiagramMap(primitivesVisible=false));
  annotation(Documentation(info="<html><h2>基础建模包</h2><p><b>类路径：</b><code>OneSatSim.Foundation</code>　<b>类型：</b>package</p><h3>用途与定位</h3><p>基础建模包</p><h3>阅读与调用</h3><p>本包用于组织类。按下表进入相应模型；包本身不单独启动仿真。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>类</th><th>用途</th></tr><tr><td><a href=\"modelica://OneSatSim.Foundation.Calculations\">OneSatSim.Foundation.Calculations</a></td><td>无状态工程派生量计算</td></tr><tr><td><a href=\"modelica://OneSatSim.Foundation.Functions\">OneSatSim.Foundation.Functions</a></td><td>纯计算函数</td></tr><tr><td><a href=\"modelica://OneSatSim.Foundation.Interfaces\">OneSatSim.Foundation.Interfaces</a></td><td>接口类型</td></tr><tr><td><a href=\"modelica://OneSatSim.Foundation.Models\">OneSatSim.Foundation.Models</a></td><td>必要方程核心包</td></tr><tr><td><a href=\"modelica://OneSatSim.Foundation.SignalRouting\">OneSatSim.Foundation.SignalRouting</a></td><td>显式无状态信号路由</td></tr><tr><td><a href=\"modelica://OneSatSim.Foundation.Types\">OneSatSim.Foundation.Types</a></td><td>类型与遥测目录包</td></tr></table><h3>继承与复用</h3><p>本类的继承/别名声明如下。继承得到的端口、参数、状态和算法仍由被引用类定义，不重复增加一套行为。</p><pre>Modelica.Icons.Package annotation(IconMap(primitivesVisible=false),DiagramMap(primitivesVisible=false))</pre></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={83,131,109}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Package", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-68,-45},{-68,39},{-25,39},{-15,49},{66,49},{66,-45},{-68,-45}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-65,34},{68,34},{60,-45},{-68,-45},{-65,34}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Rectangle(extent={{-36,11.2},{-23.4,22}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{-23.4,16.6},{-10.2,16.6},{-10.2,7.3},{1.8,7.3}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{-36,-7.4},{-23.4,3.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{-23.4,-2},{-10.2,-2},{-10.2,-2},{1.8,-2}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{-36,-26},{-23.4,-15.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{-23.4,-20.6},{-10.2,-20.6},{-10.2,-11.3},{1.8,-11.3}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{1.8,-17},{16.8,13}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{16.8,7},{27,7},{27,16},{40.8,16}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{16.8,-2},{27,-2},{27,-2},{40.8,-2}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{16.8,-11},{27,-11},{27,-20},{40.8,-20}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{6,-11.6},{12.6,7.6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Foundation", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={83,131,109}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Package", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-68,-45},{-68,39},{-25,39},{-15,49},{66,49},{66,-45},{-68,-45}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-65,34},{68,34},{60,-45},{-68,-45},{-65,34}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Rectangle(extent={{-36,11.2},{-23.4,22}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{-23.4,16.6},{-10.2,16.6},{-10.2,7.3},{1.8,7.3}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{-36,-7.4},{-23.4,3.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{-23.4,-2},{-10.2,-2},{-10.2,-2},{1.8,-2}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{-36,-26},{-23.4,-15.2}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{-23.4,-20.6},{-10.2,-20.6},{-10.2,-11.3},{1.8,-11.3}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{1.8,-17},{16.8,13}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.65, radius=0),
      Line(points={{16.8,7},{27,7},{27,16},{40.8,16}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{16.8,-2},{27,-2},{27,-2},{40.8,-2}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{16.8,-11},{27,-11},{27,-20},{40.8,-20}}, color={128,97,151}, thickness=0.65, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{6,-11.6},{12.6,7.6}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Foundation", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));
end Foundation;