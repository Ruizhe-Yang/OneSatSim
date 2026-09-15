within NISSA_12UCubeSat.Foundation.Models;
model MissionActionRequestMailbox "任务动作请求事件邮箱"
  Modelica.Blocks.Interfaces.IntegerInput imagingRequestIn annotation(Placement(transformation(extent={{-112,58},{-92,78}})));
  Modelica.Blocks.Interfaces.IntegerInput downlinkRequestIn annotation(Placement(transformation(extent={{-112,18},{-92,38}})));
  Modelica.Blocks.Interfaces.IntegerInput safeRequestIn annotation(Placement(transformation(extent={{-112,-22},{-92,-2}})));
  NISSA_12UCubeSat.Foundation.Interfaces.CommandTypeInput safeCommandIn annotation(Placement(transformation(extent={{-112,-62},{-92,-42}})));
  NISSA_12UCubeSat.Foundation.Interfaces.ActiveMissionSelectionInput selectionIn annotation(Placement(transformation(extent={{-112,-98},{-92,-78}})));
  Modelica.Blocks.Interfaces.IntegerOutput imagingRequestOut annotation(Placement(transformation(extent={{92,58},{112,78}})));
  Modelica.Blocks.Interfaces.IntegerOutput downlinkRequestOut annotation(Placement(transformation(extent={{92,18},{112,38}})));
  Modelica.Blocks.Interfaces.IntegerOutput safeRequestOut annotation(Placement(transformation(extent={{92,-22},{112,-2}})));
  NISSA_12UCubeSat.Foundation.Interfaces.CommandTypeOutput safeCommandOut annotation(Placement(transformation(extent={{92,-62},{112,-42}})));
  NISSA_12UCubeSat.Foundation.Interfaces.ActiveMissionSelectionOutput selectionOut annotation(Placement(transformation(extent={{92,-98},{112,-78}})));
  parameter Real dispatchBoundary(unit="s")=1e-4
    "单次请求交付边界；不是周期采样或物理通信延迟";
protected
  discrete Integer pendingKind(start=0,fixed=true);
  discrete Integer pendingId(start=0,fixed=true);
  discrete Integer pendingTarget(start=0,fixed=true);
  discrete Integer pendingStation(start=0,fixed=true);
  discrete NISSA_12UCubeSat.Foundation.Types.CommandType pendingSafeCommand(
    start=NISSA_12UCubeSat.Foundation.Types.CommandType.None,fixed=true);
  discrete Real dispatchDeadline(start=1e100,fixed=true);
  discrete Integer imagingRequestId(start=0,fixed=true);
  discrete Integer downlinkRequestId(start=0,fixed=true);
  discrete Integer safeRequestId(start=0,fixed=true);
  discrete Integer targetIndex(start=0,fixed=true);
  discrete Integer stationIndex(start=0,fixed=true);
  discrete NISSA_12UCubeSat.Foundation.Types.CommandType safeCommand(
    start=NISSA_12UCubeSat.Foundation.Types.CommandType.None,fixed=true);
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
      pendingSafeCommand:=NISSA_12UCubeSat.Foundation.Types.CommandType.None;
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
      safeCommand:=NISSA_12UCubeSat.Foundation.Types.CommandType.None;
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
  annotation(
    Icon(graphics={Rectangle(extent={{-100,100},{100,-100}},lineColor={125,70,155},fillColor={244,235,250},fillPattern=FillPattern.Solid),Rectangle(extent={{-62,44},{62,-44}},lineColor={125,70,155},fillColor={255,255,255},fillPattern=FillPattern.Solid),Line(points={{-82,0},{82,0}},color={125,70,155},arrow={Arrow.None,Arrow.Filled}),Text(extent={{-92,-90},{92,-58}},textString="REQUEST MAILBOX")}),
    Documentation(info="<html><h4>功能定位</h4><p>把MissionStateMachine形成的成像、下传、安全动作请求和活动对象选择作为单向快照交付给三个Sequencer。</p><h4>输入与接口关系</h4><p>输入包含三类请求ID、安全命令和ActiveMissionSelection；均来自状态机当前事件快照。</p><h4>内部职责与实现</h4><p>输入变化先锁存，在dispatchBoundary后把同一快照发布到输出，避免状态—选择—几何—状态的零时间离散闭环。</p><h4>输出</h4><p>输出为三个动作请求、安全命令和活动任务选择，分别连接对应Sequencer及环境活动对象选择。</p><h4>连续/离散状态</h4><p>含pending与已交付两组离散快照及一次性截止时间；dispatchBoundary不是周期采样或物理通信时延。</p><h4>使用与观察</h4><p>调试事件链时比较输入/输出请求ID与交付时刻，正常任务指标不需保存内部pending变量。</p><h4>建模边界</h4><p>不仲裁、不修改请求内容、不重试；只负责确定性的单向事件交付。</p></html>"));
end MissionActionRequestMailbox;
