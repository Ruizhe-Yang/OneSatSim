within OneSatSim.Foundation.Calculations;
model HeaterChannelCalculation "单路加热器指令与平均电导计算"
  parameter Integer activeState=170 "加热有效状态字";
  parameter Modelica.Units.SI.Resistance heaterResistance=144 "等效加热电阻";
  Modelica.Blocks.Interfaces.IntegerInput controlState annotation(Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput command annotation(Placement(transformation(extent={{80,25},{100,45}})));
  Modelica.Blocks.Interfaces.RealOutput conductance(unit="S") annotation(Placement(transformation(extent={{80,-45},{100,-25}})));
equation
  command=controlState == activeState;
  conductance=if command then 1/heaterResistance else 0;
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={190,70,30},fillColor={252,235,225},fillPattern=FillPattern.Solid),Line(points={{-70,0},{65,0}},color={190,70,30},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-88,52},{88,18}},textString="HEATER"),Text(extent={{-88,-18},{88,-52}},textString="STATE -> G")}),Documentation(info="<html><h4>功能定位</h4><p>把单路TCB整数状态字转换为加热开关命令和连续平均电导。</p><h4>输入与物理含义</h4><p>controlState为热控通道码；activeState默认170；heaterResistance为支路等效电阻。</p><h4>输出与物理含义</h4><p>command表示是否导通，conductance供VariableConductor使用。</p><h4>主要计算关系</h4><p>当controlState等于activeState时command为true且电导为1/R，否则电导为0。</p><h4>状态、事件与假设</h4><p>纯代数、无状态；不包含继电器延迟、PWM、线束和热状态，焦耳热由父组件标准电阻/导体计算。</p><h4>调用与结果使用</h4><p>由HeaterRadiatorUnit、BatteryUnit和EarthObservationCameraUnit调用。调试时核对通道状态、command、电流和对应热节点温升，不需保存内部比较表达式。</p></html>"));
end HeaterChannelCalculation;
