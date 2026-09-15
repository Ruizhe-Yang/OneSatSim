within NISSA_12UCubeSat.Foundation.Models;
model SafetyMonitor "带回差的任务安全许可监视器"
  NISSA_12UCubeSat.Foundation.Interfaces.MissionFeedbackBus feedback annotation(Placement(transformation(extent={{-112,-10},{-92,10}})));
  NISSA_12UCubeSat.Foundation.Interfaces.SafetySignals safety annotation(Placement(transformation(extent={{92,-10},{112,10}})));
  parameter Real SOC_safe_enter=0.30;
  parameter Real SOC_safe_exit=0.40;
  parameter Real SOC_critical=0.20;
  parameter Real V_safe_enter(unit="V")=10.8;
  parameter Real V_safe_exit(unit="V")=11.5;
  parameter Real imagingSOC=0.40;
  parameter Real downlinkSOC=0.35;
  parameter Real batteryTemperatureLow(unit="K")=263.15;
  parameter Real batteryTemperatureHigh(unit="K")=318.15;
  parameter Real payloadTemperatureLow(unit="K")=273.15;
  parameter Real payloadTemperatureHigh(unit="K")=313.15;
  parameter Real transmitterTemperatureHigh(unit="K")=338.15;
protected
  Boolean criticalUnsafe;
  Boolean recoveryConditions;
  Boolean payloadTemperatureOperational;
  discrete Boolean unsafeLatched(start=false,fixed=true);
equation
  criticalUnsafe=feedback.batterySOC < SOC_safe_enter or feedback.busVoltage < V_safe_enter or feedback.batteryTemperature < batteryTemperatureLow or feedback.batteryTemperature > batteryTemperatureHigh or feedback.transmitterTemperature > transmitterTemperatureHigh;
  recoveryConditions=feedback.batterySOC > SOC_safe_exit and feedback.busVoltage > V_safe_exit and feedback.batteryTemperature > batteryTemperatureLow+2 and feedback.batteryTemperature < batteryTemperatureHigh-3 and feedback.payloadTemperature < payloadTemperatureHigh-3 and feedback.transmitterTemperature < transmitterTemperatureHigh-3;
  payloadTemperatureOperational=feedback.payloadTemperature >= payloadTemperatureLow and feedback.payloadTemperature <= payloadTemperatureHigh;
  safety.powerHealthy=feedback.batterySOC > downlinkSOC and feedback.busVoltage > 11.2;
  safety.thermalHealthy=feedback.batteryTemperature > batteryTemperatureLow and feedback.batteryTemperature < batteryTemperatureHigh and feedback.payloadTemperature < payloadTemperatureHigh and feedback.transmitterTemperature < transmitterTemperatureHigh;
  safety.attitudeHealthy=feedback.aocsAvailable;
  safety.storageHealthy=not feedback.storageFull;
  safety.spacecraftHealthy=safety.powerHealthy and safety.thermalHealthy and safety.attitudeHealthy;
  safety.imagingAllowed=feedback.batterySOC > imagingSOC and feedback.busVoltage > 11.4 and safety.thermalHealthy and payloadTemperatureOperational and safety.attitudeHealthy and not feedback.storageHigh and not unsafeLatched;
  safety.downlinkAllowed=feedback.batterySOC > downlinkSOC and feedback.busVoltage > 11.2 and safety.thermalHealthy and safety.attitudeHealthy and feedback.dataAvailable and not unsafeLatched;
  safety.safeModeRequired=unsafeLatched;
  safety.recoveryAllowed=not unsafeLatched and recoveryConditions;
  safety.safetyReason=if feedback.batterySOC <= SOC_critical then NISSA_12UCubeSat.Foundation.Types.RejectReason.LowSOC else
    if feedback.batterySOC <= imagingSOC then NISSA_12UCubeSat.Foundation.Types.RejectReason.LowSOC else
    if feedback.busVoltage <= 11.2 then NISSA_12UCubeSat.Foundation.Types.RejectReason.LowBusVoltage else
    if not safety.thermalHealthy or not payloadTemperatureOperational then NISSA_12UCubeSat.Foundation.Types.RejectReason.ThermalLimit else
    if feedback.storageHigh then NISSA_12UCubeSat.Foundation.Types.RejectReason.StorageFull else
    if not feedback.dataAvailable then NISSA_12UCubeSat.Foundation.Types.RejectReason.NoData else
    if not feedback.aocsAvailable then NISSA_12UCubeSat.Foundation.Types.RejectReason.AttitudeUnavailable else NISSA_12UCubeSat.Foundation.Types.RejectReason.None;
algorithm
  when initial() then
    unsafeLatched:=criticalUnsafe;
  elsewhen criticalUnsafe then
    unsafeLatched:=true;
  elsewhen recoveryConditions then
    unsafeLatched:=false;
  end when;
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={180,80,20},fillColor={252,239,222},fillPattern=FillPattern.Solid),Polygon(points={{0,52},{55,30},{45,-40},{0,-58},{-45,-40},{-55,30},{0,52}},fillColor={245,190,95},fillPattern=FillPattern.Solid),Text(extent={{-94,-64},{94,-42}},textString="SAFETY")}),Documentation(info="<html><h4>功能定位</h4><p>把电池SOC、母线电压、关键温度、姿控与设备反馈转换为安全模式请求及成像/下传许可。</p><h4>输入与接口关系</h4><p>feedback来自MissionFeedbackAdapter；参数定义安全进入/退出SOC与电压阈值、关键温度范围以及成像/下传最低SOC。</p><h4>内部职责与实现</h4><p>对SOC和母线使用进入/退出回差形成安全锁存，结合临界SOC、温度和设备可用性生成safeModeRequired、recoveryAllowed、imagingAllowed和downlinkAllowed等信号。</p><h4>输出</h4><p>SafetySignals交给CommandArbiter、三个Sequencer和CommandAdapter。</p><h4>连续/离散状态</h4><p>含安全回差离散状态；温度与许可组合为代数条件。回差避免阈值附近反复切换。</p><h4>使用与观察</h4><p>查看安全请求、恢复许可及各禁止原因，并回溯SOC、电压和关键温度。标准24 h回归要求无安全进入。</p><h4>建模边界</h4><p>不执行安全动作、不修改设备参数，也不替代详细FDIR；仅提供任务级保护判据。</p></html>"));
end SafetyMonitor;
