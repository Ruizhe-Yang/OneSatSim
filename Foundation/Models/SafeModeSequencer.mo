within NISSA_12UCubeSat.Foundation.Models;
model SafeModeSequencer "请求驱动的安全进入、保持与恢复时序器"
  Modelica.Blocks.Interfaces.IntegerInput actionRequestId annotation(Placement(transformation(extent={{-112,25},{-92,45}})));
  NISSA_12UCubeSat.Foundation.Interfaces.CommandTypeInput actionCommand;
  Modelica.Blocks.Interfaces.IntegerOutput safeEntryCompleteEventId;
  Modelica.Blocks.Interfaces.IntegerOutput recoveryCompleteEventId;
  NISSA_12UCubeSat.Foundation.Interfaces.SafetySignals safety annotation(Placement(transformation(extent={{-112,-45},{-92,-25}})));
  NISSA_12UCubeSat.Foundation.Interfaces.SafeModeActionSignals action annotation(Placement(transformation(extent={{92,-10},{112,10}})));
  parameter Real safeEntryTime(unit="s")=5;
  parameter Real recoveryHoldTime(unit="s")=600;
  parameter Real stagedRecoveryTime(unit="s")=30;
protected
  discrete Real safeEntryDeadline(start=1e100,fixed=true);
  discrete Real recoveryDeadline(start=1e100,fixed=true);
  discrete Real stagedRecoveryDeadline(start=1e100,fixed=true);
  discrete Boolean safeEntryCompleteLatch(start=false,fixed=true);
  discrete Boolean recoveryReadyLatch(start=false,fixed=true);
  discrete Boolean recoveryCompleteLatch(start=false,fixed=true);
  discrete Integer activeRequest(start=0,fixed=true);
  discrete Integer safeEntryEventId(start=0,fixed=true);
  discrete Integer recoveryEventId(start=0,fixed=true);
  Modelica.Blocks.Interfaces.IntegerOutput safeEntryCompleteEventIdPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  Modelica.Blocks.Interfaces.IntegerOutput recoveryCompleteEventIdPublisher annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
  NISSA_12UCubeSat.Foundation.Interfaces.IntegerSignalBridge actionIntegerBridge[2] annotation(Placement(visible=false, transformation(extent={{-4,-4},{4,4}})));
equation
  action.safeEntryComplete=safeEntryCompleteLatch;
  action.recoveryReady=recoveryReadyLatch;
  action.recoveryComplete=recoveryCompleteLatch;
  safeEntryCompleteEventIdPublisher=safeEntryEventId;
  recoveryCompleteEventIdPublisher=recoveryEventId;
  safeEntryCompleteEventId=safeEntryEventId;
  recoveryCompleteEventId=recoveryEventId;
algorithm
  when {change(actionRequestId),change(safety.recoveryAllowed),
      time >= safeEntryDeadline,time >= recoveryDeadline,time >= stagedRecoveryDeadline} then
    if change(actionRequestId) and
        actionCommand == NISSA_12UCubeSat.Foundation.Types.CommandType.EnterSafeMode then
      activeRequest:=actionRequestId;
      safeEntryDeadline:=time+safeEntryTime;
      recoveryDeadline:=1e100;
      stagedRecoveryDeadline:=1e100;
      safeEntryCompleteLatch:=false;
      recoveryReadyLatch:=false;
      recoveryCompleteLatch:=false;
    elseif change(actionRequestId) and
        actionCommand == NISSA_12UCubeSat.Foundation.Types.CommandType.ExitSafeMode then
      activeRequest:=actionRequestId;
      safeEntryDeadline:=1e100;
      recoveryDeadline:=1e100;
      stagedRecoveryDeadline:=time+stagedRecoveryTime;
      recoveryReadyLatch:=false;
      recoveryCompleteLatch:=false;
    elseif time >= pre(safeEntryDeadline) then
      safeEntryDeadline:=1e100;
      safeEntryCompleteLatch:=true;
      safeEntryEventId:=activeRequest;
      recoveryDeadline:=if safety.recoveryAllowed then time+recoveryHoldTime else 1e100;
    elseif change(safety.recoveryAllowed) and safeEntryCompleteLatch then
      recoveryDeadline:=if safety.recoveryAllowed then time+recoveryHoldTime else 1e100;
      recoveryReadyLatch:=false;
    elseif time >= pre(recoveryDeadline) then
      recoveryDeadline:=1e100;
      recoveryReadyLatch:=true;
    elseif time >= pre(stagedRecoveryDeadline) then
      stagedRecoveryDeadline:=1e100;
      recoveryCompleteLatch:=true;
      recoveryEventId:=activeRequest;
    end if;
  end when;
equation
  connect(safeEntryCompleteEventIdPublisher,actionIntegerBridge[1].u);
  connect(actionIntegerBridge[1].y,action.safeEntryCompleteEventId);
  connect(recoveryCompleteEventIdPublisher,actionIntegerBridge[2].u);
  connect(actionIntegerBridge[2].y,action.recoveryCompleteEventId);
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={180,80,20},fillColor={252,239,222},fillPattern=FillPattern.Solid),Rectangle(extent={{-55,40},{55,-38}},fillColor={245,190,95},fillPattern=FillPattern.Solid),Line(points={{-30,0},{30,0}},color={150,65,20},thickness=3),Text(extent={{-94,-64},{94,-42}},textString="SAFE / RECOVERY")}),Documentation(info="<html><h4>功能定位</h4><p>把安全进入或恢复请求展开为可验证的分阶段设备动作。</p><h4>输入与接口关系</h4><p>actionRequestId与actionCommand来自MissionStateMachine，safety提供当前安全条件。</p><h4>内部职责与实现</h4><p>安全进入按safeEntryTime完成关载荷/通信和进入安全姿态；恢复需满足恢复条件并经过recoveryHoldTime与stagedRecoveryTime，结果以事件ID交付。</p><h4>输出</h4><p>SafeModeActionSignals提供安全模式、恢复动作和设备门控；另输出安全进入完成与恢复完成事件。</p><h4>连续/离散状态</h4><p>含阶段、计时、请求ID和完成事件离散状态，无连续物理状态。</p><h4>使用与观察</h4><p>标准任务应保持SafeMode进入次数为0；故障分析时查看安全条件、阶段和两个完成事件。</p><h4>建模边界</h4><p>不判断SOC/电压/温度安全门限，判据由SafetyMonitor提供；不模拟具体软件任务。</p></html>"));
end SafeModeSequencer;
