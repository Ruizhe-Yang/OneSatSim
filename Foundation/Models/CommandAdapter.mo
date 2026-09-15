within NISSA_12UCubeSat.Foundation.Models;
model CommandAdapter "任务接口到设备指令与状态的纯映射"
  NISSA_12UCubeSat.Foundation.Interfaces.OpportunitySignals opportunity annotation(Placement(transformation(extent={{-112,62},{-92,82}})));
  NISSA_12UCubeSat.Foundation.Interfaces.SafetySignals safety annotation(Placement(transformation(extent={{-112,30},{-92,50}})));
  NISSA_12UCubeSat.Foundation.Interfaces.ArbiterDecisionSignals decision annotation(Placement(transformation(extent={{-112,-2},{-92,18}})));
  NISSA_12UCubeSat.Foundation.Interfaces.MissionStateSignals state annotation(Placement(transformation(extent={{-112,-34},{-92,-14}})));
  NISSA_12UCubeSat.Foundation.Interfaces.ImagingActionSignals imagingAction annotation(Placement(transformation(extent={{-112,-66},{-92,-46}})));
  NISSA_12UCubeSat.Foundation.Interfaces.DownlinkActionSignals downlinkAction annotation(Placement(transformation(extent={{-112,-92},{-92,-72}})));
  NISSA_12UCubeSat.Foundation.Interfaces.CommandBus command annotation(Placement(transformation(extent={{92,35},{112,55}})));
  NISSA_12UCubeSat.Foundation.Interfaces.CommandStatusBus status annotation(Placement(transformation(extent={{92,-55},{112,-35}})));
protected
  Boolean safeModeInternal;
  Boolean preSequencerImagingFailure
    "预指向阶段已失败、尚未向成像时序器发出动作请求";
equation
  safeModeInternal=state.missionMode == NISSA_12UCubeSat.Foundation.Types.MissionMode.SafeEntry or
    state.missionMode == NISSA_12UCubeSat.Foundation.Types.MissionMode.SafeHold or
    (state.missionMode == NISSA_12UCubeSat.Foundation.Types.MissionMode.Recovery and state.stateElapsed < 10);
  preSequencerImagingFailure=state.currentCommand == NISSA_12UCubeSat.Foundation.Types.CommandType.Imaging and
    state.commandFailed and imagingAction.failureReason == NISSA_12UCubeSat.Foundation.Types.RejectReason.None;
  command.safeMode=safeModeInternal;
  command.missionOn=not safeModeInternal;
  command.payloadPowerCommand=imagingAction.payloadPowerCommand and not safeModeInternal;
  command.captureCommand=imagingAction.captureCommand and not safeModeInternal;
  command.earthObservationCaptureCommand=command.captureCommand;
  command.selfieCaptureCommand=false;
  command.communicationPowerCommand=downlinkAction.communicationPowerCommand and not safeModeInternal;
  command.transmitCommand=downlinkAction.transmitCommand and not safeModeInternal;
  command.imaging=command.captureCommand;
  command.downlink=command.transmitCommand;
  command.sunPointing=state.controlMode == NISSA_12UCubeSat.Foundation.Types.ControlMode.SunPointing or
    state.controlMode == NISSA_12UCubeSat.Foundation.Types.ControlMode.SafeMode;
  command.desiredControlMode=state.controlMode;
  command.groundStationIndex=state.activeGroundStationIndex;
  command.targetIndex=state.activeTargetIndex;
  command.missionPriority=if safeModeInternal then 5 else
    if state.missionMode == NISSA_12UCubeSat.Foundation.Types.MissionMode.Recovery then 4 else
    if downlinkAction.busy then 3 else if imagingAction.busy then 2 else 1;
  status.currentCommand=state.currentCommand;
  status.executionStatus=if decision.rejected then NISSA_12UCubeSat.Foundation.Types.CommandExecutionStatus.Rejected else state.executionStatus;
  status.rejectReason=if state.commandAborted then NISSA_12UCubeSat.Foundation.Types.RejectReason.SafetyPreempted else
    if imagingAction.failed then imagingAction.failureReason else
    if state.commandTimeout then NISSA_12UCubeSat.Foundation.Types.RejectReason.Timeout else decision.rejectReason;
  status.missionMode=state.missionMode;
  status.controlMode=state.controlMode;
  status.commandId=if state.activeRequestId <> 0 then state.activeRequestId else decision.acceptedCommandId;
  status.transitionCounter=state.transitionCounter;
  status.accepted=decision.accepted;
  status.rejected=decision.rejected;
  status.executing=state.commandExecuting;
  status.completed=state.commandCompleted;
  status.failed=state.commandFailed;
  status.aborted=state.commandAborted;
  status.timeout=state.commandTimeout;
  status.safePreemption=state.commandAborted and safeModeInternal;
  status.executionTime=state.executionTime;
  status.imagingOpportunity=opportunity.imagingOpportunity;
  status.downlinkOpportunity=opportunity.downlinkOpportunity;
  status.imagingAllowed=safety.imagingAllowed;
  status.downlinkAllowed=safety.downlinkAllowed;
  status.safeModeRequired=safety.safeModeRequired;
  status.imagingCaptureStarted=if preSequencerImagingFailure then false else imagingAction.captureStarted;
  status.imagingImageComplete=if preSequencerImagingFailure then false else imagingAction.imageComplete;
  status.imagingValidImageBytes=if preSequencerImagingFailure then 0 else imagingAction.validImageBytes;
  status.imagingFailureReason=if preSequencerImagingFailure then
    (if state.commandTimeout then NISSA_12UCubeSat.Foundation.Types.RejectReason.Timeout else
      NISSA_12UCubeSat.Foundation.Types.RejectReason.TargetVisibilityLost) else imagingAction.failureReason;
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={120,70,150},fillColor={243,235,249},fillPattern=FillPattern.Solid),Line(points={{-70,0},{70,0}},color={120,70,150},thickness=3,arrow={Arrow.None,Arrow.Filled}),Text(extent={{-94,-64},{94,-42}},textString="CMD ADAPTER")}),Documentation(info="<html><h4>功能定位</h4><p>把机会、安全、仲裁决策、任务状态和三个动作时序结果统一映射为设备CommandBus及CommandStatusBus。</p><h4>输入与接口关系</h4><p>输入为OpportunitySignals、SafetySignals、ArbiterDecisionSignals、MissionStateSignals、Imaging/Downlink/SafeModeActionSignals；这些接口由MissionControlUnit唯一连接。</p><h4>内部职责与实现</h4><p>按固定字段映射生成任务模式、姿态模式、相机/通信/安全指令、活动对象索引以及请求状态，不重新做规划或时序判断。因果发布量经小型Bridge进入共享总线。</p><h4>输出</h4><p>command驱动各设备，status供星务状态数据库与遥测链解释请求、执行和拒绝原因。</p><h4>连续/离散状态</h4><p>纯代数、无状态、无采样；所有任务记忆位于上游状态机和Sequencer。</p><h4>使用与观察</h4><p>调试命令错误时沿decision/state/action输入逐段检查；本模型适合核对最终字段映射，不是任务决策入口。</p><h4>建模边界</h4><p>不模拟软件消息、队列和总线协议；不得在此增加新的任务优先级。</p></html>"));
end CommandAdapter;
