within NISSA_12UCubeSat.Foundation.Calculations;
model GNSSFixCalculation "GNSS定位状态计算"
  Modelica.Blocks.Interfaces.BooleanInput eclipse annotation(Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.IntegerOutput fixStatus annotation(Placement(transformation(extent={{80,-10},{100,10}})));
equation
  fixStatus=if eclipse then 2 else 3;
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={40,110,80},fillColor={232,246,239},fillPattern=FillPattern.Solid),Line(points={{-70,0},{65,0}},color={40,110,80},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-90,45},{90,-45}},textString="GNSS FIX")}),Documentation(info="<html><h4>功能定位</h4><p>提供总体仿真所需的低阶GNSS定位状态码。</p><h4>输入与物理含义</h4><p>eclipse为环境日影标志，在当前等效中用于区分两种可用工作状态。</p><h4>输出与物理含义</h4><p>fixStatus在日影时为2、日照时为3，两者均表示模型约定的有效定位状态类别。</p><h4>主要计算关系</h4><p>用单一条件表达式根据eclipse选择状态码。</p><h4>状态、事件与假设</h4><p>纯代数、无捕获状态；不模拟可见星数、DOP、伪距、钟差、导航滤波或失锁。不能据此评估GNSS精度。</p><h4>调用与结果使用</h4><p>由GPSReceiverUnit（历史类名，当前按GNSS语义使用）调用。用户应同时查看位置、速度参考系与历元；fixStatus只用于任务级状态映射。</p></html>"));
end GNSSFixCalculation;
