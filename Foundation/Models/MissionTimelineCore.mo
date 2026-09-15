within OneSatSim.Foundation.Models;
model MissionTimelineCore "Deprecated compatibility timeline: mission opportunities only"
  OneSatSim.Foundation.Interfaces.EnvironmentPort environment;
  OneSatSim.Foundation.Interfaces.MissionControlBus control;
equation
  control.imagingOpportunity=environment.targetVisible;
  control.downlinkOpportunity=environment.groundContact;
  control.eclipse=environment.eclipse;
  control.sunlightAvailable=not environment.eclipse;
  control.groundContact=environment.groundContact;
  control.targetVisible=environment.targetVisible;
  control.groundStationIndex=environment.groundStationIndex;
  control.targetIndex=environment.targetIndex;
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={80,60,130},fillColor={239,233,248},fillPattern=FillPattern.Solid),Polygon(points={{-70,30},{-30,30},{-30,50},{20,0},{-30,-50},{-30,-30},{-70,-30},{-70,30}},fillColor={110,80,170},fillPattern=FillPattern.Solid),Text(extent={{-20,-60},{94,-35}},textString="TASK MODE")}),Documentation(info="<html><h4>用途与保留理由</h4><p><b>系统角色：</b>把轨道环境、电源状态和任务机会转换为星上模式及设备指令</p><p><b>黑箱理由：</b>任务优先级包含跨域条件判断，使用方程黑箱便于集中审查</p><h4>方程或算法实现</h4><p><b>实现：</b>在equation区以条件表达式实现安全、成像、数传、对日优先级，无外接MissionDesign</p><p><b>连续/离散特性：</b>优先级依次为安全处置、目标可见时成像、地面站可见且无成像时数传、空闲时对日；三地面站机会来自环境模型</p><p><b>接口：</b>information（InformationPort）</p><h4>参数、状态与交互</h4><p><b>关键参数：</b>低压安全阈值、目标可见、三站可见和任务优先级</p><p><b>关键状态：</b>由连续条件组合得到的模式布尔量和站点索引</p><p><b>遥测关系：</b>指令不直接作为总体输出，但决定相机、发射机、热功耗和设备状态，间接反映在遥测中</p><p><b>使用说明：</b>该模型不含connect语句，用户应在调用它的Components白箱中检查图形连接；修改方程或sample/when时需重新执行checkModel和离散事件一致性检查。</p></html>"));
end MissionTimelineCore;
