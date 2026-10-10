within OneSatSim.Foundation.Calculations;
model PayloadCaptureCalculation "载荷拍摄状态与写入率计算"
  parameter Real imagingDataRate(unit="1/s")=2e6 "成像数据速率 [1/s]" ;
  Modelica.Blocks.Interfaces.BooleanInput captureCommand  "capture指令" annotation(Placement(visible=true, transformation(origin={-89,0}, extent={{-17.28,-17.28},{17.28,17.28}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-17.28,-17.28},{17.28,17.28}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput status  "计算/接口量 status" annotation(Placement(visible=true, transformation(origin={89,80}, extent={{-18,-18},{18,18}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-18,-18},{18,18}}, rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput payloadWriteRate  "payloadWrite速率" annotation(Placement(visible=true, transformation(origin={89,-80}, extent={{-18,-18},{18,18}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-18,-18},{18,18}}, rotation=0)));
equation
  status=if captureCommand then 1 else 0;
  payloadWriteRate=if captureCommand then imagingDataRate else 0;
  annotation(Documentation(info="<html><h2>载荷拍摄状态与写入率计算</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Calculations.PayloadCaptureCalculation</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>载荷拍摄状态与写入率计算</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.SelfieCameraUnit\">OneSatSim.Components.SelfieCameraUnit</a> 的 <code>captureCalculation</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>captureCommand</code></td><td>Modelica.Blocks.Interfaces.BooleanInput</td><td>public</td><td>按声明/类型合同</td><td>capture指令</td></tr><tr><td><code>status</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 status</td></tr><tr><td><code>payloadWriteRate</code></td><td>Modelica.Blocks.Interfaces.RealOutput</td><td>public</td><td>按声明/类型合同</td><td>payloadWrite速率</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>imagingDataRate</code></td><td>Real</td><td>成像数据速率 [1/s]</td><td><code>=2e6</code></td></tr></table><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] status=if captureCommand then 1 else 0;\n[equation] payloadWriteRate=if captureCommand then imagingDataRate else 0;</pre></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={236,64,122},lineColor={236,64,122},lineThickness=0,radius=0),
      Rectangle(extent={{-55,-36},{55,34}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,radius=0),
      Ellipse(extent={{-23,-24},{23,22}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Rectangle(extent={{-28,34},{16,48}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0)
    }),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}},preserveAspectRatio=true),graphics={
      Rectangle(extent={{-100,-100},{100,100}},fillPattern=FillPattern.Solid,fillColor={236,64,122},lineColor={236,64,122},lineThickness=0,radius=0),
      Rectangle(extent={{-55,-36},{55,34}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,radius=0),
      Ellipse(extent={{-23,-24},{23,22}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.None,lineThickness=1.4,startAngle=0,endAngle=360),
      Rectangle(extent={{-28,34},{16,48}},lineColor={255,255,255},fillColor={255,255,255},fillPattern=FillPattern.Solid,lineThickness=1.4,radius=0)
    }));
end PayloadCaptureCalculation;