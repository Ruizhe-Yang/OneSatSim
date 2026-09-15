within OneSatSim.Foundation.Calculations;
model FotonAmurCalculation "科学载荷任务门控计算"
  parameter Boolean missionEnabled=false;
  Modelica.Blocks.Interfaces.BooleanInput missionOn annotation(Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput active annotation(Placement(transformation(extent={{80,25},{100,45}})));
  Modelica.Blocks.Interfaces.IntegerOutput status annotation(Placement(transformation(extent={{80,-45},{100,-25}})));
equation
  active=missionEnabled and missionOn;
  status=if active then 1 else 0;
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={100,80,45},fillColor={247,240,225},fillPattern=FillPattern.Solid),Line(points={{-70,0},{65,0}},color={100,80,45},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-90,45},{90,-45}},textString="FOTON-AMUR\nGATE")}),Documentation(info="<html><h4>功能定位</h4><p>把场景级专项载荷许可与星上任务开关组合为科学载荷实际使能。</p><h4>输入与物理含义</h4><p>missionEnabled为配置许可，missionOn为任务侧实时指令。</p><h4>输出与物理含义</h4><p>active表示两条件同时满足，status按0/1发布。</p><h4>主要计算关系</h4><p>使用逻辑与运算形成active，再映射整数状态。</p><h4>状态、事件与假设</h4><p>纯代数、无状态；不负责科学载荷内部测量、数据量或动作时序。默认许可为false。</p><h4>调用与结果使用</h4><p>由FotonAmurPayloadUnit调用。只有启用专项任务时才需要观察active/status；一般24 h标准任务中可保持关闭。</p></html>"));
end FotonAmurCalculation;
