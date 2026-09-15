within OneSatSim;
package Simulation "仿真入口包"
  annotation(Icon(graphics={Rectangle(extent={{-100,100},{100,-100}}, lineColor={25,95,145}, fillColor={228,242,250}, fillPattern=FillPattern.Solid), Polygon(points={{-28,45},{55,0},{-28,-45},{-28,45}}, fillColor={25,120,180}, fillPattern=FillPattern.Solid)}));
  annotation(Documentation(info="<html><h4>包职责</h4><p><b>定位：</b>提供唯一可运行总体入口。</p><p><b>内容：</b>CompleteMission读取由根目录DesignConfig.xlsx生成的任务场景、初始条件与整星硬件配置；未设置覆盖时继承Modelica默认基线。</p><p><b>推荐阅读：</b>从CompleteMission开始，按onboardTelemetry字段导航到OBC和设备源头。</p><p><b>适用范围：</b>用于12U立方星多领域系统级总体仿真、场景对比、能量/热/姿态/任务联动和星上工程遥测导航。</p></html>"));
end Simulation;
