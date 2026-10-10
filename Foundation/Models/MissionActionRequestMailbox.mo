within OneSatSim.Foundation.Models;
model MissionActionRequestMailbox "任务动作请求事件邮箱"
  Modelica.Blocks.Interfaces.IntegerInput imagingRequestIn  "成像请求In" annotation(Placement(visible=true, transformation(origin={-225,103}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput downlinkRequestIn  "下传请求In" annotation(Placement(visible=true, transformation(origin={-225,45}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,40}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput safeRequestIn  "安全模式请求In" annotation(Placement(visible=true, transformation(origin={-225,-13}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-6,-6},{6,6}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.CommandTypeInput safeCommandIn  "安全模式指令In" annotation(Placement(visible=true, transformation(origin={-225,-45}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-40}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.ActiveMissionSelectionInput selectionIn  "计算/接口量 selectionIn" annotation(Placement(visible=true, transformation(origin={-225,-103}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-12,-12},{12,12}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput imagingRequestOut  "成像请求Out" annotation(Placement(visible=true, transformation(origin={225,103}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput downlinkRequestOut  "下传请求Out" annotation(Placement(visible=true, transformation(origin={225,45}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,40}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput safeRequestOut  "安全模式请求Out" annotation(Placement(visible=true, transformation(origin={225,-13}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,0}, extent={{-6,-6},{6,6}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.CommandTypeOutput safeCommandOut  "安全模式指令Out" annotation(Placement(visible=true, transformation(origin={225,-45}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-40}, extent={{-12,-12},{12,12}}, rotation=0)));
  OneSatSim.Foundation.Interfaces.ActiveMissionSelectionOutput selectionOut  "计算/接口量 selectionOut" annotation(Placement(visible=true, transformation(origin={225,-103}, extent={{-12,-12},{12,12}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-12,-12},{12,12}}, rotation=0)));
  parameter Real dispatchBoundary(unit="s")=1e-4
    "单次请求交付边界；不是周期采样或物理通信延迟";
protected
  discrete Integer pendingKind(start=0,fixed=true) "计算/接口量 pendingKind" ;
  discrete Integer pendingId(start=0,fixed=true) "计算/接口量 pendingId" ;
  discrete Integer pendingTarget(start=0,fixed=true) "pending目标" ;
  discrete Integer pendingStation(start=0,fixed=true) "pending站点" ;
  discrete OneSatSim.Foundation.Types.CommandType pendingSafeCommand(
    start=OneSatSim.Foundation.Types.CommandType.None,fixed=true) "pending安全模式指令" ;
  discrete Real dispatchDeadline(start=1e100,fixed=true) "计算/接口量 dispatchDeadline" ;
  discrete Integer imagingRequestId(start=0,fixed=true) "成像请求Id" ;
  discrete Integer downlinkRequestId(start=0,fixed=true) "下传请求Id" ;
  discrete Integer safeRequestId(start=0,fixed=true) "安全模式请求Id" ;
  discrete Integer targetIndex(start=0,fixed=true) "目标Index" ;
  discrete Integer stationIndex(start=0,fixed=true) "站点Index" ;
  discrete OneSatSim.Foundation.Types.CommandType safeCommand(
    start=OneSatSim.Foundation.Types.CommandType.None,fixed=true) "安全模式指令" ;
equation
  imagingRequestOut=imagingRequestId;
  downlinkRequestOut=downlinkRequestId;
  safeRequestOut=safeRequestId;
  safeCommandOut=safeCommand;
  selectionOut.targetIndex=targetIndex;
  selectionOut.groundStationIndex=stationIndex;
algorithm
  // Capture stage: snapshot one accepted action request.
  when {initial(),change(imagingRequestIn),change(downlinkRequestIn),
      change(safeRequestIn)} then
    if initial() then
      pendingKind:=0;
      pendingId:=0;
      pendingTarget:=0;
      pendingStation:=0;
      pendingSafeCommand:=OneSatSim.Foundation.Types.CommandType.None;
      dispatchDeadline:=1e100;
    elseif change(imagingRequestIn) then
      pendingKind:=1;
      pendingId:=imagingRequestIn;
      pendingTarget:=selectionIn.targetIndex;
      pendingStation:=0;
      dispatchDeadline:=time+dispatchBoundary;
    elseif change(downlinkRequestIn) then
      pendingKind:=2;
      pendingId:=downlinkRequestIn;
      pendingTarget:=0;
      pendingStation:=selectionIn.groundStationIndex;
      dispatchDeadline:=time+dispatchBoundary;
    elseif change(safeRequestIn) then
      pendingKind:=3;
      pendingId:=safeRequestIn;
      pendingSafeCommand:=safeCommandIn;
      dispatchDeadline:=time+dispatchBoundary;
    end if;
  end when;
algorithm
  // Delivery stage: publish only a pre(...) snapshot at the one-shot deadline.
  when {initial(),time >= pre(dispatchDeadline)} then
    if initial() then
      imagingRequestId:=0;
      downlinkRequestId:=0;
      safeRequestId:=0;
      targetIndex:=0;
      stationIndex:=0;
      safeCommand:=OneSatSim.Foundation.Types.CommandType.None;
    else
      if pre(pendingKind) == 1 then
        targetIndex:=pre(pendingTarget);
        stationIndex:=0;
        imagingRequestId:=pre(pendingId);
      elseif pre(pendingKind) == 2 then
        targetIndex:=0;
        stationIndex:=pre(pendingStation);
        downlinkRequestId:=pre(pendingId);
      elseif pre(pendingKind) == 3 then
        safeCommand:=pre(pendingSafeCommand);
        safeRequestId:=pre(pendingId);
      end if;
    end if;
  end when;
  annotation(Documentation(info="<html><h2>任务动作请求事件邮箱</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Models.MissionActionRequestMailbox</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>任务动作请求事件邮箱</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.MissionControlUnit\">OneSatSim.Components.MissionControlUnit</a> 的 <code>requestMailbox</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>imagingRequestIn</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>成像请求In</td></tr><tr><td><code>downlinkRequestIn</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>下传请求In</td></tr><tr><td><code>safeRequestIn</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>安全模式请求In</td></tr><tr><td><code>safeCommandIn</code></td><td>OneSatSim.Foundation.Interfaces.CommandTypeInput</td><td>public</td><td>按声明/类型合同</td><td>安全模式指令In</td></tr><tr><td><code>selectionIn</code></td><td>OneSatSim.Foundation.Interfaces.ActiveMissionSelectionInput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 selectionIn</td></tr><tr><td><code>imagingRequestOut</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>成像请求Out</td></tr><tr><td><code>downlinkRequestOut</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>下传请求Out</td></tr><tr><td><code>safeRequestOut</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>安全模式请求Out</td></tr><tr><td><code>safeCommandOut</code></td><td>OneSatSim.Foundation.Interfaces.CommandTypeOutput</td><td>public</td><td>按声明/类型合同</td><td>安全模式指令Out</td></tr><tr><td><code>selectionOut</code></td><td>OneSatSim.Foundation.Interfaces.ActiveMissionSelectionOutput</td><td>public</td><td>按声明/类型合同</td><td>计算/接口量 selectionOut</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>dispatchBoundary</code></td><td>Real</td><td>单次请求交付边界；不是周期采样或物理通信延迟</td><td><code>=1e-4</code></td></tr></table><h3>状态与初始化</h3><p>本类源码中显式出现的导数对象或离散声明：<code>pendingKind, pendingId, pendingTarget, pendingStation, pendingSafeCommand, dispatchDeadline, imagingRequestId, downlinkRequestId, safeRequestId, targetIndex, stationIndex, safeCommand</code>。初始化取当前声明的 start/fixed、initial 方程/算法及继承设置。此处是源码级说明，不等同于编译后连续状态统计。</p><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] imagingRequestOut=imagingRequestId;\n[equation] downlinkRequestOut=downlinkRequestId;\n[equation] safeRequestOut=safeRequestId;\n[equation] safeCommandOut=safeCommand;\n[equation] selectionOut.targetIndex=targetIndex;\n[equation] selectionOut.groundStationIndex=stationIndex;\n[algorithm] when {initial(),change(imagingRequestIn),change(downlinkRequestIn), change(safeRequestIn)} then if initial() then pendingKind:=0;\n[algorithm] pendingId:=0;\n[algorithm] pendingTarget:=0;\n[algorithm] pendingStation:=0;</pre><p>本类另有35段语句；阅读完整源码可查看其余边界与逻辑。</p><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>pendingKind</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 pendingKind</td></tr><tr><td><code>pendingId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 pendingId</td></tr><tr><td><code>pendingTarget</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>pending目标</td></tr><tr><td><code>pendingStation</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>pending站点</td></tr><tr><td><code>pendingSafeCommand</code></td><td>OneSatSim.Foundation.Types.CommandType</td><td>discrete</td><td>按声明/类型合同</td><td>pending安全模式指令</td></tr><tr><td><code>dispatchDeadline</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 dispatchDeadline</td></tr><tr><td><code>imagingRequestId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>成像请求Id</td></tr><tr><td><code>downlinkRequestId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>下传请求Id</td></tr><tr><td><code>safeRequestId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>安全模式请求Id</td></tr><tr><td><code>targetIndex</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>目标Index</td></tr><tr><td><code>stationIndex</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>站点Index</td></tr><tr><td><code>safeCommand</code></td><td>OneSatSim.Foundation.Types.CommandType</td><td>discrete</td><td>按声明/类型合同</td><td>安全模式指令</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-31,-26},{32,33}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Rectangle(extent={{-23,17},{24,22}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Rectangle(extent={{-21,-17},{22,9}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{-21,9},{0,-5},{22,9}}, color={0,0,0}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-21,-17},{-4,-2}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{22,-17},{4,-2}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-71,7},{-38,7}}, color={128,97,151}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{38,-8},{69,-8}}, color={128,97,151}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-14,44},{-14,52},{4,52},{4,44},{22,44}}, color={113,122,132}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Action Request Mailbox", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-269,-147},{269,191}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-66.75,-72.75},{66.75,71.25}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-57,48},{57,48}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-63,51.75},{-48,66.75}}, lineColor={0,0,0}, fillColor={128,97,151}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-45.75,53.25},{57,64.5}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-23.25,-19.5},{24,24.75}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Rectangle(extent={{-17.25,12.75},{18,16.5}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Rectangle(extent={{-15.75,-12.75},{16.5,6.75}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{-15.75,6.75},{0,-3.75},{16.5,6.75}}, color={0,0,0}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-15.75,-12.75},{-3,-1.5}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{16.5,-12.75},{3,-1.5}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-53.25,5.25},{-28.5,5.25}}, color={128,97,151}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{28.5,-6},{51.75,-6}}, color={128,97,151}, thickness=0.85, pattern=LinePattern.Solid, arrow={Arrow.None,Arrow.Open}),
      Line(points={{-10.5,33},{-10.5,39},{3,39},{3,33},{16.5,33}}, color={113,122,132}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-57,-43.5},{57,-43.5}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-60,-59.25},{60,-48}}, textString="Action Request Mailbox", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-257,146},{257,175}}, textString="Mission Action Request Mailbox", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-257,138},{257,138}}, color={215,220,226}, thickness=0.25)
    }));
end MissionActionRequestMailbox;