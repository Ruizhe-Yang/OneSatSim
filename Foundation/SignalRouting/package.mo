within OneSatSim.Foundation;
package SignalRouting "显式无状态信号路由"
  extends Modelica.Icons.Package annotation(IconMap(primitivesVisible=false),DiagramMap(primitivesVisible=false));
  annotation(Documentation(info="<html><h2>显式无状态信号路由</h2><p><b>类路径：</b><code>OneSatSim.Foundation.SignalRouting</code>　<b>类型：</b>package</p><h3>用途与定位</h3><p>显式无状态信号路由</p><h3>阅读与调用</h3><p>本包用于组织类。按下表进入相应模型；包本身不单独启动仿真。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>类</th><th>用途</th></tr><tr><td><a href=\"modelica://OneSatSim.Foundation.SignalRouting.RealSignalForward\">OneSatSim.Foundation.SignalRouting.RealSignalForward</a></td><td>Real信号显式转发</td></tr></table><h3>继承与复用</h3><p>本类的继承/别名声明如下。继承得到的端口、参数、状态和算法仍由被引用类定义，不重复增加一套行为。</p><pre>Modelica.Icons.Package annotation(IconMap(primitivesVisible=false),DiagramMap(primitivesVisible=false))</pre></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={83,131,109}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Package", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-68,-45},{-68,39},{-25,39},{-15,49},{66,49},{66,-45},{-68,-45}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-65,34},{68,34},{60,-45},{-68,-45},{-65,34}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Rectangle(extent={{-12.6,-15.8},{13.2,13.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Line(points={{-41.4,-2},{-12.6,-2}}, color={77,126,172}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{13.2,-2},{41.4,-2}}, color={77,126,172}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-8.4,-5.6},{-4.2,4},{0,-7.4},{4.8,3.4},{9,-5}}, color={77,126,172}, thickness=0.65, pattern=LinePattern.Solid, smooth=Smooth.Bezier),
      Line(points={{-6,-23},{6,-23}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Signal Routing", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={83,131,109}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Package", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-68,-45},{-68,39},{-25,39},{-15,49},{66,49},{66,-45},{-68,-45}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7),
      Polygon(points={{-65,34},{68,34},{60,-45},{-68,-45},{-65,34}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Rectangle(extent={{-12.6,-15.8},{13.2,13.6}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=0),
      Line(points={{-41.4,-2},{-12.6,-2}}, color={77,126,172}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{13.2,-2},{41.4,-2}}, color={77,126,172}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-8.4,-5.6},{-4.2,4},{0,-7.4},{4.8,3.4},{9,-5}}, color={77,126,172}, thickness=0.65, pattern=LinePattern.Solid, smooth=Smooth.Bezier),
      Line(points={{-6,-23},{6,-23}}, color={113,122,132}, thickness=0.5, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Signal Routing", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));
end SignalRouting;