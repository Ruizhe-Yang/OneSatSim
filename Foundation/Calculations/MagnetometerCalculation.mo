within OneSatSim.Foundation.Calculations;
model MagnetometerCalculation "三轴轨道磁场低阶计算"
  parameter Real fieldXAmplitude(unit="T")=25e-6;
  parameter Real fieldYAmplitude(unit="T")=18e-6;
  parameter Real fieldZAmplitude(unit="T")=34e-6;
  parameter Modelica.Units.SI.Radius earthRadius=6378137;
  parameter Modelica.Units.SI.Time magneticFieldPeriod=5624.1;
  Modelica.Blocks.Interfaces.RealInput instantaneousAltitude(unit="m") annotation(Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput magneticField[3](each unit="T") annotation(Placement(transformation(extent={{80,-10},{100,10}})));
equation
  magneticField[1]=fieldXAmplitude*(earthRadius/(earthRadius+instantaneousAltitude))^3*cos(2*Modelica.Constants.pi*time/magneticFieldPeriod);
  magneticField[2]=fieldYAmplitude*(earthRadius/(earthRadius+instantaneousAltitude))^3*sin(2*Modelica.Constants.pi*time/magneticFieldPeriod);
  magneticField[3]=fieldZAmplitude*(earthRadius/(earthRadius+instantaneousAltitude))^3;
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={90,60,120},fillColor={241,234,247},fillPattern=FillPattern.Solid),Ellipse(extent={{-38,38},{38,-38}},lineColor={90,60,120}),Line(points={{-70,0},{65,0}},color={90,60,120},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-90,-62},{90,-38}},textString="B XYZ")}),Documentation(info="<html><h4>功能定位</h4><p>生成随高度和轨道相位变化的三轴地磁场低阶工程量。</p><h4>输入与物理含义</h4><p>instantaneousAltitude为瞬时轨道高度；三个幅值、地球半径与磁场周期为任务级参数。</p><h4>输出与物理含义</h4><p>magneticField[1:3]以T给出三轴场分量，供磁强计遥测及磁力矩器控制使用。</p><h4>主要计算关系</h4><p>各轴幅值按地心距三次方反比缩放，X/Y分量按轨道周期正余弦变化，Z分量保留同相低阶幅值。</p><h4>状态、事件与假设</h4><p>方程显含time但无内部状态、采样或事件；不是IGRF/WMM，也不含姿态旋转、高阶球谐、局部磁扰和传感噪声。</p><h4>调用与结果使用</h4><p>由MagnetometerUnit调用。主要查看三轴磁场及幅值包络；磁卸载分析还需联合供电、轮速与本体速率。</p></html>"));
end MagnetometerCalculation;
