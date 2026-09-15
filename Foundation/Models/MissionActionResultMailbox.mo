within OneSatSim.Foundation.Models;
model MissionActionResultMailbox "任务动作结果事件邮箱"
  Modelica.Blocks.Interfaces.IntegerInput imagingStartedIn annotation(Placement(transformation(extent={{-112,78},{-92,98}})));
  Modelica.Blocks.Interfaces.IntegerInput imagingCompletedIn annotation(Placement(transformation(extent={{-112,58},{-92,78}})));
  Modelica.Blocks.Interfaces.IntegerInput imagingFailedIn annotation(Placement(transformation(extent={{-112,38},{-92,58}})));
  Modelica.Blocks.Interfaces.IntegerInput imagingAbortedIn annotation(Placement(transformation(extent={{-112,18},{-92,38}})));
  Modelica.Blocks.Interfaces.IntegerInput imagingTimeoutIn annotation(Placement(transformation(extent={{-112,-2},{-92,18}})));
  Modelica.Blocks.Interfaces.IntegerInput downlinkStartedIn annotation(Placement(transformation(extent={{-112,-22},{-92,-2}})));
  Modelica.Blocks.Interfaces.IntegerInput downlinkCompletedIn annotation(Placement(transformation(extent={{-112,-42},{-92,-22}})));
  Modelica.Blocks.Interfaces.IntegerInput downlinkFailedIn annotation(Placement(transformation(extent={{-112,-62},{-92,-42}})));
  Modelica.Blocks.Interfaces.IntegerInput downlinkAbortedIn annotation(Placement(transformation(extent={{-112,-82},{-92,-62}})));
  Modelica.Blocks.Interfaces.IntegerInput downlinkTimeoutIn annotation(Placement(transformation(extent={{-112,-102},{-92,-82}})));
  Modelica.Blocks.Interfaces.IntegerInput safeEntryCompleteIn annotation(Placement(transformation(extent={{-12,-112},{8,-92}},rotation=90)));
  Modelica.Blocks.Interfaces.IntegerInput recoveryCompleteIn annotation(Placement(transformation(extent={{28,-112},{48,-92}},rotation=90)));
  Modelica.Blocks.Interfaces.IntegerOutput imagingStartedOut annotation(Placement(transformation(extent={{92,78},{112,98}})));
  Modelica.Blocks.Interfaces.IntegerOutput imagingCompletedOut annotation(Placement(transformation(extent={{92,58},{112,78}})));
  Modelica.Blocks.Interfaces.IntegerOutput imagingFailedOut annotation(Placement(transformation(extent={{92,38},{112,58}})));
  Modelica.Blocks.Interfaces.IntegerOutput imagingAbortedOut annotation(Placement(transformation(extent={{92,18},{112,38}})));
  Modelica.Blocks.Interfaces.IntegerOutput imagingTimeoutOut annotation(Placement(transformation(extent={{92,-2},{112,18}})));
  Modelica.Blocks.Interfaces.IntegerOutput downlinkStartedOut annotation(Placement(transformation(extent={{92,-22},{112,-2}})));
  Modelica.Blocks.Interfaces.IntegerOutput downlinkCompletedOut annotation(Placement(transformation(extent={{92,-42},{112,-22}})));
  Modelica.Blocks.Interfaces.IntegerOutput downlinkFailedOut annotation(Placement(transformation(extent={{92,-62},{112,-42}})));
  Modelica.Blocks.Interfaces.IntegerOutput downlinkAbortedOut annotation(Placement(transformation(extent={{92,-82},{112,-62}})));
  Modelica.Blocks.Interfaces.IntegerOutput downlinkTimeoutOut annotation(Placement(transformation(extent={{92,-102},{112,-82}})));
  Modelica.Blocks.Interfaces.IntegerOutput safeEntryCompleteOut annotation(Placement(transformation(extent={{-12,92},{8,112}},rotation=90)));
  Modelica.Blocks.Interfaces.IntegerOutput recoveryCompleteOut annotation(Placement(transformation(extent={{28,92},{48,112}},rotation=90)));
  parameter Real dispatchBoundary(unit="s")=1e-4
    "单次事件邮箱交付边界；不是周期采样或物理通信延迟";
protected
  discrete Integer pendingKind(start=0,fixed=true);
  discrete Integer pendingId(start=0,fixed=true);
  discrete Real dispatchDeadline(start=1e100,fixed=true);
  discrete Integer imagingStartedId(start=0,fixed=true);
  discrete Integer imagingCompletedId(start=0,fixed=true);
  discrete Integer imagingFailedId(start=0,fixed=true);
  discrete Integer imagingAbortedId(start=0,fixed=true);
  discrete Integer imagingTimeoutId(start=0,fixed=true);
  discrete Integer downlinkStartedId(start=0,fixed=true);
  discrete Integer downlinkCompletedId(start=0,fixed=true);
  discrete Integer downlinkFailedId(start=0,fixed=true);
  discrete Integer downlinkAbortedId(start=0,fixed=true);
  discrete Integer downlinkTimeoutId(start=0,fixed=true);
  discrete Integer safeEntryCompleteId(start=0,fixed=true);
  discrete Integer recoveryCompleteId(start=0,fixed=true);
equation
  imagingStartedOut=imagingStartedId;
  imagingCompletedOut=imagingCompletedId;
  imagingFailedOut=imagingFailedId;
  imagingAbortedOut=imagingAbortedId;
  imagingTimeoutOut=imagingTimeoutId;
  downlinkStartedOut=downlinkStartedId;
  downlinkCompletedOut=downlinkCompletedId;
  downlinkFailedOut=downlinkFailedId;
  downlinkAbortedOut=downlinkAbortedId;
  downlinkTimeoutOut=downlinkTimeoutId;
  safeEntryCompleteOut=safeEntryCompleteId;
  recoveryCompleteOut=recoveryCompleteId;
algorithm
  // Capture stage: only the mailbox snapshot and its one-shot deadline are
  // written here.  No delivered result is modified in this event equation.
  when {initial(),change(imagingStartedIn),change(imagingCompletedIn),
      change(imagingFailedIn),change(imagingAbortedIn),change(imagingTimeoutIn),
      change(downlinkStartedIn),change(downlinkCompletedIn),change(downlinkFailedIn),
      change(downlinkAbortedIn),change(downlinkTimeoutIn),change(safeEntryCompleteIn),
      change(recoveryCompleteIn)} then
    if initial() then
      pendingKind:=0;
      pendingId:=0;
      dispatchDeadline:=1e100;
    elseif change(imagingStartedIn) then
      pendingKind:=1; pendingId:=imagingStartedIn; dispatchDeadline:=time+dispatchBoundary;
    elseif change(imagingCompletedIn) then
      pendingKind:=2; pendingId:=imagingCompletedIn; dispatchDeadline:=time+dispatchBoundary;
    elseif change(imagingFailedIn) then
      pendingKind:=3; pendingId:=imagingFailedIn; dispatchDeadline:=time+dispatchBoundary;
    elseif change(imagingAbortedIn) then
      pendingKind:=4; pendingId:=imagingAbortedIn; dispatchDeadline:=time+dispatchBoundary;
    elseif change(imagingTimeoutIn) then
      pendingKind:=5; pendingId:=imagingTimeoutIn; dispatchDeadline:=time+dispatchBoundary;
    elseif change(downlinkStartedIn) then
      pendingKind:=6; pendingId:=downlinkStartedIn; dispatchDeadline:=time+dispatchBoundary;
    elseif change(downlinkCompletedIn) then
      pendingKind:=7; pendingId:=downlinkCompletedIn; dispatchDeadline:=time+dispatchBoundary;
    elseif change(downlinkFailedIn) then
      pendingKind:=8; pendingId:=downlinkFailedIn; dispatchDeadline:=time+dispatchBoundary;
    elseif change(downlinkAbortedIn) then
      pendingKind:=9; pendingId:=downlinkAbortedIn; dispatchDeadline:=time+dispatchBoundary;
    elseif change(downlinkTimeoutIn) then
      pendingKind:=10; pendingId:=downlinkTimeoutIn; dispatchDeadline:=time+dispatchBoundary;
    elseif change(safeEntryCompleteIn) then
      pendingKind:=11; pendingId:=safeEntryCompleteIn; dispatchDeadline:=time+dispatchBoundary;
    elseif change(recoveryCompleteIn) then
      pendingKind:=12; pendingId:=recoveryCompleteIn; dispatchDeadline:=time+dispatchBoundary;
    end if;
  end when;
algorithm
  // Delivery stage: the deadline is strictly later than the capture event and
  // only pre(...) snapshots are read.  This is the discrete causality cut.
  when {initial(),time >= pre(dispatchDeadline)} then
    if initial() then
      imagingStartedId:=0;
      imagingCompletedId:=0;
      imagingFailedId:=0;
      imagingAbortedId:=0;
      imagingTimeoutId:=0;
      downlinkStartedId:=0;
      downlinkCompletedId:=0;
      downlinkFailedId:=0;
      downlinkAbortedId:=0;
      downlinkTimeoutId:=0;
      safeEntryCompleteId:=0;
      recoveryCompleteId:=0;
    else
      if pre(pendingKind) == 1 then imagingStartedId:=pre(pendingId);
      elseif pre(pendingKind) == 2 then imagingCompletedId:=pre(pendingId);
      elseif pre(pendingKind) == 3 then imagingFailedId:=pre(pendingId);
      elseif pre(pendingKind) == 4 then imagingAbortedId:=pre(pendingId);
      elseif pre(pendingKind) == 5 then imagingTimeoutId:=pre(pendingId);
      elseif pre(pendingKind) == 6 then downlinkStartedId:=pre(pendingId);
      elseif pre(pendingKind) == 7 then downlinkCompletedId:=pre(pendingId);
      elseif pre(pendingKind) == 8 then downlinkFailedId:=pre(pendingId);
      elseif pre(pendingKind) == 9 then downlinkAbortedId:=pre(pendingId);
      elseif pre(pendingKind) == 10 then downlinkTimeoutId:=pre(pendingId);
      elseif pre(pendingKind) == 11 then safeEntryCompleteId:=pre(pendingId);
      elseif pre(pendingKind) == 12 then recoveryCompleteId:=pre(pendingId);
      end if;
    end if;
  end when;
  annotation(
    Icon(graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={120,85,20},fillColor={255,246,220},fillPattern=FillPattern.Solid),Rectangle(extent={{-62,44},{62,-44}},lineColor={120,85,20},fillColor={255,255,255},fillPattern=FillPattern.Solid),Line(points={{-82,0},{82,0}},color={120,85,20},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-92,-90},{92,-58}},textString="EVENT MAILBOX")}),
    Documentation(info="<html><h4>功能定位</h4><p>汇集成像、下传及安全时序器的动作结果事件，并以单向快照回送MissionStateMachine。</p><h4>输入与接口关系</h4><p>输入包括成像和下传的started/completed/failed/aborted/timeout事件ID，以及安全进入和恢复完成事件。</p><h4>内部职责与实现</h4><p>各输入事件被独立锁存并在有限边界后发布，保持事件ID与动作类别，不把不同结果合并成一个模糊状态。</p><h4>输出</h4><p>输出与输入一一对应，供状态机确认动作开始、结束、失败、中止和超时。</p><h4>连续/离散状态</h4><p>含离散事件快照与调度边界，无连续状态。重复ID不会被解释为新动作。</p><h4>使用与观察</h4><p>分析任务计数时以结果事件ID为准；内部pending快照仅用于因果链诊断。</p><h4>建模边界</h4><p>不决定任务成功条件、不生成结果，也不修改状态机优先级。</p></html>"));
end MissionActionResultMailbox;
