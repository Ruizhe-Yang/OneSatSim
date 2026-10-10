within OneSatSim.Foundation.Models;
model MissionGeometryEventMailbox "活动目标几何事件邮箱"
  Modelica.Blocks.Interfaces.BooleanInput targetPreparationReadyIn 
     "目标Preparation就绪In" annotation(Placement(visible=true, transformation(origin={-225,32}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanInput targetEarlyOpportunityIn 
     "目标EarlyOpportunityIn" annotation(Placement(visible=true, transformation(origin={-225,0}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,0}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerInput targetPreparationIndexIn 
     "目标PreparationIndexIn" annotation(Placement(visible=true, transformation(origin={-225,-32}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={-89,-80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput targetPreparationReadyOut 
     "目标Preparation就绪Out" annotation(Placement(visible=true, transformation(origin={225,61}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,80}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.BooleanOutput targetEarlyOpportunityOut 
     "目标EarlyOpportunityOut" annotation(Placement(visible=true, transformation(origin={225,29}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,26.666667}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput geometryEventIdOut 
     "几何EventIdOut" annotation(Placement(visible=true, transformation(origin={225,-61}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-26.666667}, extent={{-6,-6},{6,6}}, rotation=0)));
  Modelica.Blocks.Interfaces.IntegerOutput targetPreparationIndexOut 
     "目标PreparationIndexOut" annotation(Placement(visible=true, transformation(origin={225,-3}, extent={{-6,-6},{6,6}}, rotation=0), iconVisible=true, iconTransformation(origin={89,-80}, extent={{-6,-6},{6,6}}, rotation=0)));
  parameter Real dispatchBoundary(unit="s")=2e-4
    "单次几何状态交付边界；与请求决策边界错开，不是周期采样或物理传输延迟";
protected
  discrete Boolean pendingPreparationReady(start=false,fixed=true) "pendingPreparation就绪" ;
  discrete Boolean pendingEarlyOpportunity(start=false,fixed=true) "计算/接口量 pendingEarlyOpportunity" ;
  discrete Integer pendingPreparationIndex(start=0,fixed=true) "计算/接口量 pendingPreparationIndex" ;
  discrete Integer pendingEventId(start=0,fixed=true) "计算/接口量 pendingEventId" ;
  discrete Real dispatchDeadline(start=1e100,fixed=true) "计算/接口量 dispatchDeadline" ;
  discrete Boolean preparationReady(start=false,fixed=true) "preparation就绪" ;
  discrete Boolean earlyOpportunity(start=false,fixed=true) "计算/接口量 earlyOpportunity" ;
  discrete Integer preparationIndex(start=0,fixed=true) "计算/接口量 preparationIndex" ;
  discrete Integer geometryEventId(start=0,fixed=true) "几何EventId" ;
equation
  targetPreparationReadyOut=preparationReady;
  targetEarlyOpportunityOut=earlyOpportunity;
  geometryEventIdOut=geometryEventId;
  targetPreparationIndexOut=preparationIndex;
algorithm
  // Capture only changes of the active object's formal/early geometry state.
  when {initial(),change(targetPreparationReadyIn),change(targetEarlyOpportunityIn),
      change(targetPreparationIndexIn)} then
    if initial() then
      pendingPreparationReady:=targetPreparationReadyIn;
      pendingEarlyOpportunity:=targetEarlyOpportunityIn;
      pendingPreparationIndex:=targetPreparationIndexIn;
      pendingEventId:=0;
      dispatchDeadline:=1e100;
    else
      pendingPreparationReady:=targetPreparationReadyIn;
      pendingEarlyOpportunity:=targetEarlyOpportunityIn;
      pendingPreparationIndex:=targetPreparationIndexIn;
      pendingEventId:=pre(pendingEventId)+1;
      dispatchDeadline:=time+dispatchBoundary;
    end if;
  end when;
algorithm
  // Delivery uses only the captured pre(...) snapshot, cutting the zero-time
  // State -> active selection -> orbit geometry -> State discrete loop.
  when {initial(),time >= pre(dispatchDeadline)} then
    if initial() then
      preparationReady:=targetPreparationReadyIn;
      earlyOpportunity:=targetEarlyOpportunityIn;
      preparationIndex:=targetPreparationIndexIn;
      geometryEventId:=0;
    else
      preparationReady:=pre(pendingPreparationReady);
      earlyOpportunity:=pre(pendingEarlyOpportunity);
      preparationIndex:=pre(pendingPreparationIndex);
      geometryEventId:=pre(pendingEventId);
    end if;
  end when;
  annotation(Documentation(info="<html><h2>活动目标几何事件邮箱</h2><p><b>类路径：</b><code>OneSatSim.Foundation.Models.MissionGeometryEventMailbox</code>　<b>类型：</b>model</p><h3>用途与定位</h3><p>活动目标几何事件邮箱</p><h3>在工程中使用</h3><p>当前直接使用位置：<a href=\"modelica://OneSatSim.Components.MissionControlUnit\">OneSatSim.Components.MissionControlUnit</a> 的 <code>geometryMailbox</code>。</p><h3>接口、输入与输出</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>targetPreparationReadyIn</code></td><td>Modelica.Blocks.Interfaces.BooleanInput</td><td>public</td><td>按声明/类型合同</td><td>目标Preparation就绪In</td></tr><tr><td><code>targetEarlyOpportunityIn</code></td><td>Modelica.Blocks.Interfaces.BooleanInput</td><td>public</td><td>按声明/类型合同</td><td>目标EarlyOpportunityIn</td></tr><tr><td><code>targetPreparationIndexIn</code></td><td>Modelica.Blocks.Interfaces.IntegerInput</td><td>public</td><td>按声明/类型合同</td><td>目标PreparationIndexIn</td></tr><tr><td><code>targetPreparationReadyOut</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>目标Preparation就绪Out</td></tr><tr><td><code>targetEarlyOpportunityOut</code></td><td>Modelica.Blocks.Interfaces.BooleanOutput</td><td>public</td><td>按声明/类型合同</td><td>目标EarlyOpportunityOut</td></tr><tr><td><code>geometryEventIdOut</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>几何EventIdOut</td></tr><tr><td><code>targetPreparationIndexOut</code></td><td>Modelica.Blocks.Interfaces.IntegerOutput</td><td>public</td><td>按声明/类型合同</td><td>目标PreparationIndexOut</td></tr></table><h3>配置与参数</h3><p>下面列出当前源码表达式，仅用于阅读；当前参数对话框、生效配置记录与原有配置工具仍是使用依据。本页不新增默认值或换算。</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>参数</th><th>类型</th><th>用途</th><th>源码表达式</th></tr><tr><td><code>dispatchBoundary</code></td><td>Real</td><td>单次几何状态交付边界；与请求决策边界错开，不是周期采样或物理传输延迟</td><td><code>=2e-4</code></td></tr></table><h3>状态与初始化</h3><p>本类源码中显式出现的导数对象或离散声明：<code>pendingPreparationReady, pendingEarlyOpportunity, pendingPreparationIndex, pendingEventId, dispatchDeadline, preparationReady, earlyOpportunity, preparationIndex, geometryEventId</code>。初始化取当前声明的 start/fixed、initial 方程/算法及继承设置。此处是源码级说明，不等同于编译后连续状态统计。</p><h3>实现摘要</h3><p>以下表达式直接摘自本类，保留原始符号和单位体系；完整的条件分支、循环与初始化以源码为准。</p><pre>[equation] targetPreparationReadyOut=preparationReady;\n[equation] targetEarlyOpportunityOut=earlyOpportunity;\n[equation] geometryEventIdOut=geometryEventId;\n[equation] targetPreparationIndexOut=preparationIndex;\n[algorithm] when {initial(),change(targetPreparationReadyIn),change(targetEarlyOpportunityIn), change(targetPreparationIndexIn)} then if initial() then pendingPreparationReady:=targetPreparationReadyIn;\n[algorithm] pendingEarlyOpportunity:=targetEarlyOpportunityIn;\n[algorithm] pendingPreparationIndex:=targetPreparationIndexIn;\n[algorithm] pendingEventId:=0;\n[algorithm] dispatchDeadline:=1e100;\n[algorithm] else pendingPreparationReady:=targetPreparationReadyIn;</pre><p>本类另有16段语句；阅读完整源码可查看其余边界与逻辑。</p><h3>结果与内部计算量</h3><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\"><tr><th>名称/维数</th><th>类型</th><th>声明角色</th><th>单位</th><th>含义</th></tr><tr><td><code>pendingPreparationReady</code></td><td>Boolean</td><td>discrete</td><td>按声明/类型合同</td><td>pendingPreparation就绪</td></tr><tr><td><code>pendingEarlyOpportunity</code></td><td>Boolean</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 pendingEarlyOpportunity</td></tr><tr><td><code>pendingPreparationIndex</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 pendingPreparationIndex</td></tr><tr><td><code>pendingEventId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 pendingEventId</td></tr><tr><td><code>dispatchDeadline</code></td><td>Real</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 dispatchDeadline</td></tr><tr><td><code>preparationReady</code></td><td>Boolean</td><td>discrete</td><td>按声明/类型合同</td><td>preparation就绪</td></tr><tr><td><code>earlyOpportunity</code></td><td>Boolean</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 earlyOpportunity</td></tr><tr><td><code>preparationIndex</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>计算/接口量 preparationIndex</td></tr><tr><td><code>geometryEventId</code></td><td>Integer</td><td>discrete</td><td>按声明/类型合同</td><td>几何EventId</td></tr></table></html>"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-89,-97},{89,95}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-76,64},{76,64}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-84,69},{-64,89}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-61,71},{76,86}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-31,-26},{32,33}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Rectangle(extent={{-23,17},{24,22}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Rectangle(extent={{-21,-17},{22,9}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{-21,9},{0,-5},{22,9}}, color={0,0,0}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-21,-17},{-4,-2}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{22,-17},{4,-2}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-12.6,-45.16},{6.84,-25.72}}, lineColor={0,0,0}, fillColor={239,246,250}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-6.768,-45.16},{1.008,-25.72}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Ellipse(extent={{-12.6,-38.842},{6.84,-32.038}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Line(points={{-12.6,-35.44},{6.84,-35.44}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-2.88,-45.16},{-2.88,-25.72}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-24.12,-46.96},{22.68,-18.16}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.7, startAngle=0, endAngle=360),
      Rectangle(extent={{14.76,-26.44},{18.36,-22.84}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Rectangle(extent={{11.88,-26.08},{14.4,-23.2}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{18.72,-26.08},{21.24,-23.2}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{16.56,-26.44},{1.08,-30.04}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Line(points={{16.56,-26.44},{5.4,-39.04}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Ellipse(extent={{0,-31.12},{2.16,-28.96}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Ellipse(extent={{4.32,-40.12},{6.48,-37.96}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Line(points={{-14,44},{-14,52},{4,52},{4,44},{22,44}}, color={113,122,132}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-76,-58},{76,-58}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-80,-79},{80,-64}}, textString="Geometry Event Mailbox", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-80,-93},{80,-82}}, textString="%name", fontSize=0, lineColor={80,80,80}, horizontalAlignment=TextAlignment.Center)
    }),
    Diagram(coordinateSystem(extent={{-269,-108.5},{269,152.5}}, preserveAspectRatio=true, grid={2,2}), graphics={
      Rectangle(extent={{-66.75,-72.75},{66.75,71.25}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=3),
      Line(points={{-57,48},{57,48}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Rectangle(extent={{-63,51.75},{-48,66.75}}, lineColor={0,0,0}, fillColor={73,112,158}, fillPattern=FillPattern.Solid, lineThickness=0.85, radius=0),
      Text(extent={{-45.75,53.25},{57,64.5}}, textString="Behavior core", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center),
      Rectangle(extent={{-23.25,-19.5},{24,24.75}}, lineColor={0,0,0}, fillColor={242,245,247}, fillPattern=FillPattern.Solid, lineThickness=0.7, radius=2),
      Rectangle(extent={{-17.25,12.75},{18,16.5}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Rectangle(extent={{-15.75,-12.75},{16.5,6.75}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.55, radius=0),
      Line(points={{-15.75,6.75},{0,-3.75},{16.5,6.75}}, color={0,0,0}, thickness=0.55, pattern=LinePattern.Solid),
      Line(points={{-15.75,-12.75},{-3,-1.5}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{16.5,-12.75},{3,-1.5}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-9.45,-33.87},{5.13,-19.29}}, lineColor={0,0,0}, fillColor={239,246,250}, fillPattern=FillPattern.Solid, lineThickness=0.65, startAngle=0, endAngle=360),
      Ellipse(extent={{-5.076,-33.87},{0.756,-19.29}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Ellipse(extent={{-9.45,-29.1315},{5.13,-24.0285}}, lineColor={113,122,132}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.4, startAngle=0, endAngle=360),
      Line(points={{-9.45,-26.58},{5.13,-26.58}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Line(points={{-2.16,-33.87},{-2.16,-19.29}}, color={113,122,132}, thickness=0.4, pattern=LinePattern.Solid),
      Ellipse(extent={{-18.09,-35.22},{17.01,-13.62}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.None, lineThickness=0.7, startAngle=0, endAngle=360),
      Rectangle(extent={{11.07,-19.83},{13.77,-17.13}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.6, radius=0),
      Rectangle(extent={{8.91,-19.56},{10.8,-17.4}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Rectangle(extent={{14.04,-19.56},{15.93,-17.4}}, lineColor={0,0,0}, fillColor={221,235,246}, fillPattern=FillPattern.Solid, lineThickness=0.45, radius=0),
      Line(points={{12.42,-19.83},{0.81,-22.53}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Line(points={{12.42,-19.83},{4.05,-29.28}}, color={73,112,158}, thickness=0.6, pattern=LinePattern.Dash),
      Ellipse(extent={{0,-23.34},{1.62,-21.72}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Ellipse(extent={{3.24,-30.09},{4.86,-28.47}}, lineColor={73,112,158}, fillColor={255,255,255}, fillPattern=FillPattern.Solid, lineThickness=0.7, startAngle=0, endAngle=360),
      Line(points={{-10.5,33},{-10.5,39},{3,39},{3,33},{16.5,33}}, color={113,122,132}, thickness=0.6, pattern=LinePattern.Solid),
      Line(points={{-57,-43.5},{57,-43.5}}, color={219,223,227}, thickness=0.4, pattern=LinePattern.Solid),
      Text(extent={{-60,-59.25},{60,-48}}, textString="Geometry Event Mailbox", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Center, textStyle={TextStyle.Bold}),
      Text(extent={{-257,107.5},{257,136.5}}, textString="Mission Geometry Event Mailbox", fontSize=0, lineColor={0,0,0}, horizontalAlignment=TextAlignment.Left, textStyle={TextStyle.Bold}),
      Line(points={{-257,99.5},{257,99.5}}, color={215,220,226}, thickness=0.25)
    }));
end MissionGeometryEventMailbox;