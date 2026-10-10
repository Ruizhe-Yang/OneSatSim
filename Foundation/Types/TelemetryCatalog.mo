within OneSatSim.Foundation.Types;
package TelemetryCatalog "工程遥测包目录"

  constant Integer packetCount=30 "配置项 packetCount" ;

  constant String packetCode[packetCount]={"SAT-S0","SAT-S1","SAT-S2","SAT-S3","SAT-S4","SAT-S5","ZGK-S0","ZGK-S1","PDB-S0","TCB-S0","TTC-S0","TTC-S1","TTC-S2","CAM-S0","BBB-S0","GPS-S0","CMS-S0","SSY-S1","SSY-S2","SSY-S3","SSZ-S1","SSZ-S2","SSZ-S3","SAT-S6","SAT-S7","SAT-S8","SAT-S9","NVE-S0","SPT-S0","FAM-S0"} "配置项 packetCode" ;

  constant Integer nID[packetCount]={240,240,240,240,240,240,170,170,4,5,1,1,1,169,2,184,168,181,181,181,182,182,182,240,240,240,240,165,166,175} "配置项 nID" ;

  constant Integer packetType[packetCount]={0,1,2,3,4,5,0,1,0,0,0,1,2,0,0,0,0,1,2,3,1,2,3,6,7,8,9,0,0,0} "配置项 packetType" ;

  constant Integer payloadLength[packetCount]={201,201,201,201,211,211,198,201,119,135,120,84,24,64,91,164,149,18,115,474,18,115,474,201,201,201,201,0,0,0} "配置项 payloadLength" ;

  constant Integer groundLength[packetCount]={208,208,208,208,218,218,205,208,126,142,127,91,31,71,98,171,156,25,122,481,25,122,481,208,208,208,208,380,208,135} "地面Length" ;

  constant Boolean scheduled[packetCount]={true,true,true,true,true,true,true,true,true,true,true,false,false,true,true,true,true,true,true,true,true,true,true,false,false,false,false,false,false,false} "配置项 scheduled" ;

  constant Boolean obcOnlyOpaque[packetCount]={false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,true,true} "配置项 obcOnlyOpaque" ;

  annotation(Documentation(info="<html><h2>工程遥测包目录</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Types.TelemetryCatalog</code>　<b>类型：</b>package</p><h3>用途与定位</h3><p>工程遥测包目录</p><h3>阅读与调用</h3><p>本包用于组织类。按下表进入相应模型；包本身不单独启动仿真。</p><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>packetCount</code></td><td>Integer</td><td>配置项 packetCount</td><td><code>=30</code></td></tr><tr><td><code>packetCode[packetCount]</code></td><td>String</td><td>配置项 packetCode</td><td><code>数组/矩阵或复杂记录；查看本类参数对话框与源码中的当前声明</code></td></tr><tr><td><code>nID[packetCount]</code></td><td>Integer</td><td>配置项 nID</td><td><code>={240,240,240,240,240,240,170,170,4,5,1,1,1,169,2,184,168,181,181,181,182,182,182,240,240,240,240,165,166,175}</code></td></tr><tr><td><code>packetType[packetCount]</code></td><td>Integer</td><td>配置项 packetType</td><td><code>={0,1,2,3,4,5,0,1,0,0,0,1,2,0,0,0,0,1,2,3,1,2,3,6,7,8,9,0,0,0}</code></td></tr><tr><td><code>payloadLength[packetCount]</code></td><td>Integer</td><td>配置项 payloadLength</td><td><code>={201,201,201,201,211,211,198,201,119,135,120,84,24,64,91,164,149,18,115,474,18,115,474,201,201,201,201,0,0,0}</code></td></tr><tr><td><code>groundLength[packetCount]</code></td><td>Integer</td><td>地面Length</td><td><code>={208,208,208,208,218,218,205,208,126,142,127,91,31,71,98,171,156,25,122,481,25,122,481,208,208,208,208,380,208,135}</code></td></tr><tr><td><code>scheduled[packetCount]</code></td><td>Boolean</td><td>配置项 scheduled</td><td><code>={true,true,true,true,true,true,true,true,true,true,true,false,false,true,true,true,true,true,true,true,true,true,true,false,false,false,false,false,false,false}</code></td></tr><tr><td><code>obcOnlyOpaque[packetCount]</code></td><td>Boolean</td><td>配置项 obcOnlyOpaque</td><td><code>={false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,true,true}</code></td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={83,131,109}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Type definition", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-43.8,24},{-25.8,24},{-25.8,-0.6},{-43.8,-0.6}}, color={83,131,109}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{-34.8,-0.6},{-34.8,24}}, color={83,131,109}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{-12.6,-7.8},{33.6,34.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Rectangle(extent={{-8.4,-2.4},{29.4,29.4}}, lineColor={0,0,0}, fillColor={246,249,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-23.4,12},{-12.6,12}}, color={83,131,109}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-6,3},{1.2,3},{4.8,17.4},{9,4.8},{14.4,21.6},{20.4,10.8},{25.8,15}}, color={83,131,109}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-4.2,24.6},{13.2,24.6}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{19.2,22.2},{25.8,26.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.4, radius=0),
      Line(points={{-1.2,-12.6},{22.2,-12.6}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Telemetry Catalogue", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }),
    Diagram(coordinateSystem(extent={{-150,-145},{150,155}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={83,131,109}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Type definition", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Polygon(points={{-55,52},{40,52},{58,34},{58,-49},{-55,-49},{-55,52}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.65),
      Line(points={{40,52},{40,34},{58,34}}, color={0,0,0}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-43.8,24},{-25.8,24},{-25.8,-0.6},{-43.8,-0.6}}, color={83,131,109}, thickness=0.85, pattern=LinePattern.Solid),
      Line(points={{-34.8,-0.6},{-34.8,24}}, color={83,131,109}, thickness=0.65, pattern=LinePattern.Solid),
      Rectangle(extent={{-12.6,-7.8},{33.6,34.8}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.75, radius=2),
      Rectangle(extent={{-8.4,-2.4},{29.4,29.4}}, lineColor={0,0,0}, fillColor={246,249,247}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{-23.4,12},{-12.6,12}}, color={83,131,109}, thickness=0.75, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-6,3},{1.2,3},{4.8,17.4},{9,4.8},{14.4,21.6},{20.4,10.8},{25.8,15}}, color={83,131,109}, thickness=0.7, pattern=LinePattern.Solid),
      Line(points={{-4.2,24.6},{13.2,24.6}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{19.2,22.2},{25.8,26.4}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.4, radius=0),
      Line(points={{-1.2,-12.6},{22.2,-12.6}}, color={0,0,0}, thickness=0.65, pattern=LinePattern.Solid),
      Line(points={{-42,-28},{44,-28}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-42,-38},{44,-38}}, color={113,122,132}, thickness=0.45, pattern=LinePattern.Solid),
      Line(points={{-16,-23},{-16,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{15,-23},{15,-43}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-91},{80,-65}}, textString="Telemetry Catalogue", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold})
    }));

end TelemetryCatalog;