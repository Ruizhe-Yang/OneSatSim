within OneSatSim.Foundation.Models;
model MissionGeometryEventMailbox "活动目标几何事件邮箱"
  Modelica.Blocks.Interfaces.BooleanInput targetPreparationReadyIn
    annotation(Placement(transformation(extent={{-112,30},{-92,50}})));
  Modelica.Blocks.Interfaces.BooleanInput targetEarlyOpportunityIn
    annotation(Placement(transformation(extent={{-112,-50},{-92,-30}})));
  Modelica.Blocks.Interfaces.IntegerInput targetPreparationIndexIn
    annotation(Placement(transformation(extent={{-112,-10},{-92,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput targetPreparationReadyOut
    annotation(Placement(transformation(extent={{92,30},{112,50}})));
  Modelica.Blocks.Interfaces.BooleanOutput targetEarlyOpportunityOut
    annotation(Placement(transformation(extent={{92,-50},{112,-30}})));
  Modelica.Blocks.Interfaces.IntegerOutput geometryEventIdOut
    annotation(Placement(transformation(extent={{92,-10},{112,10}})));
  Modelica.Blocks.Interfaces.IntegerOutput targetPreparationIndexOut
    annotation(Placement(transformation(extent={{92,-82},{112,-62}})));
  parameter Real dispatchBoundary(unit="s")=2e-4
    "单次几何状态交付边界；与请求决策边界错开，不是周期采样或物理传输延迟";
protected
  discrete Boolean pendingPreparationReady(start=false,fixed=true);
  discrete Boolean pendingEarlyOpportunity(start=false,fixed=true);
  discrete Integer pendingPreparationIndex(start=0,fixed=true);
  discrete Integer pendingEventId(start=0,fixed=true);
  discrete Real dispatchDeadline(start=1e100,fixed=true);
  discrete Boolean preparationReady(start=false,fixed=true);
  discrete Boolean earlyOpportunity(start=false,fixed=true);
  discrete Integer preparationIndex(start=0,fixed=true);
  discrete Integer geometryEventId(start=0,fixed=true);
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
  annotation(
    Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={45,100,145},fillColor={231,241,250},fillPattern=FillPattern.Solid),Rectangle(extent={{-62,34},{62,-34}},lineColor={45,100,145},fillColor={255,255,255},fillPattern=FillPattern.Solid),Line(points={{-82,0},{82,0}},color={45,100,145},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-94,-64},{94,-42}},textString="GEOMETRY EVENT")}),
    Documentation(info="<html><h4>功能定位</h4><p>把活动目标的正式准备、提前预指向机会和目标索引转换为单向事件快照。</p><h4>输入与接口关系</h4><p>输入由MissionOpportunityGenerator的OpportunitySignals经Boolean/Integer SignalReader提供。</p><h4>内部职责与实现</h4><p>捕获几何状态变化，生成递增geometryEventId，并在dispatchBoundary后一次性交付同一组准备状态与索引。</p><h4>输出</h4><p>输出准备标志、提前机会、目标索引和几何事件ID，供MissionStateMachine使用。</p><h4>连续/离散状态</h4><p>含pending与已交付几何快照；不包含连续动态。有限边界用于切断同一事件迭代，不代表通信时延。</p><h4>使用与观察</h4><p>查看geometryEventId与目标索引可定位预指向触发；常规生产结果通常只需任务阶段和最终请求结果。</p><h4>建模边界</h4><p>不预测轨道、不选择目标、不改变机会真假；几何计算仍在OrbitalEnvironmentCore。</p></html>"));
end MissionGeometryEventMailbox;
