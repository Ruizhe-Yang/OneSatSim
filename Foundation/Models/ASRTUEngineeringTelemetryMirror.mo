within OneSatSim.Foundation.Models;
model ASRTUEngineeringTelemetryMirror "Continuous engineering telemetry mirror"
  OneSatSim.Foundation.Interfaces.ASRTUStatePort state annotation(Placement(transformation(extent={{-112,-10},{-92,10}})));
  OneSatSim.Foundation.Interfaces.OnboardTelemetryPort telemetry annotation(Placement(transformation(extent={{92,-10},{112,10}})));
protected
  parameter Integer thermistorMap[20]={1,3,6,7,10,11,14,20,21,22,23,24,25,26,27,28,29,30,31,32};
equation
  // Packet protocol timing is deliberately outside this system-level model.
  telemetry.currentPacketNID=0;
  telemetry.currentPacketType=0;
  telemetry.packetLength=0;
  telemetry.sequenceCount=0;
  telemetry.packetCounter=0;
  telemetry.packetStrobe=false;

  telemetry.SAT_S0_busVoltage_V=state.busVoltage;
  telemetry.SAT_S0_busCurrent_A=state.busCurrent;
  telemetry.SAT_S0_subArray_V=state.subArrayVoltage;
  telemetry.SAT_S0_MPPT_V=state.mpptVoltage;
  telemetry.SAT_S0_MPPT_A=state.mpptCurrent;
  telemetry.SAT_S0_charger_V=state.chargerVoltage;
  telemetry.SAT_S0_charger_A=state.chargerCurrent;
  telemetry.SAT_S0_batteryCurrent_A=state.pdCurrent[22];
  telemetry.SAT_S0_batteryVoltage_V=state.batteryVoltage;
  telemetry.SAT_S0_batterySOC=state.batterySOC;

  telemetry.SAT_S1_thermistor_degC=state.thermistorTemperature[thermistorMap]-fill(273.15,20);

  telemetry.SAT_S2_wheel_rpm=state.wheelSpeed*60/(2*Modelica.Constants.pi);
  telemetry.SAT_S2_wheel_A=state.wheelCurrent;
  telemetry.SAT_S2_wheelStatus=state.wheelStatus;
  telemetry.SAT_S2_starY_q=state.starQuaternion[1,:];
  telemetry.SAT_S2_starZ_q=state.starQuaternion[2,:];
  telemetry.SAT_S2_starY_w_deg_s=state.starAngularVelocity[1,:]*180/Modelica.Constants.pi;
  telemetry.SAT_S2_starZ_w_deg_s=state.starAngularVelocity[2,:]*180/Modelica.Constants.pi;
  telemetry.SAT_S2_YH50_deg_s=state.yh50Rate*180/Modelica.Constants.pi;
  telemetry.SAT_S2_GNSS_position_m=state.gnssPosition;
  telemetry.SAT_S2_GNSS_velocity_m_s=state.gnssVelocity;
  telemetry.SAT_S2_magneticField_Gauss=state.magneticField*1e4;
  telemetry.SAT_S2_MEMS_gyro_deg_s=state.mems[1:3]*180/Modelica.Constants.pi;
  telemetry.SAT_S2_MEMS_accel_m_s2=state.mems[4:6];
  telemetry.SAT_S2_sunAngle_deg=state.sunAngle*180/Modelica.Constants.pi;

  telemetry.SAT_S3_bus12_V=state.busVoltage[1];
  telemetry.SAT_S3_commandErrorCount=state.commandErrorCount;
  telemetry.SAT_S3_watchdogCount=state.watchdogCount;
  telemetry.SAT_S3_bootSeconds=state.bootSeconds;
  telemetry.SAT_S3_milliseconds=state.milliseconds;
  telemetry.SAT_S3_cpuTemperature_degC=state.cpuTemperature-273.15;
  telemetry.SAT_S3_boardTemperature_degC=state.boardTemperature-273.15;
  telemetry.SAT_S3_missionMode=Integer(state.missionMode);
  telemetry.SAT_S3_controlMode=Integer(state.controlMode);
  telemetry.SAT_S3_commandType=Integer(state.currentCommand);
  telemetry.SAT_S3_commandExecutionStatus=Integer(state.executionStatus);
  telemetry.SAT_S3_rejectReason=Integer(state.rejectReason);
  telemetry.SAT_S3_commandId=state.commandId;
  telemetry.SAT_S3_transitionCounter=state.transitionCounter;
  telemetry.SAT_S3_executionTime_s=state.executionTime;
  telemetry.SAT_S3_commandAccepted=state.commandAccepted;
  telemetry.SAT_S3_commandRejected=state.commandRejected;
  telemetry.SAT_S3_commandExecuting=state.commandExecuting;
  telemetry.SAT_S3_commandCompleted=state.commandCompleted;
  telemetry.SAT_S3_commandFailed=state.commandFailed;
  telemetry.SAT_S3_commandAborted=state.commandAborted;
  telemetry.SAT_S3_commandTimeout=state.commandTimeout;
  telemetry.SAT_S3_imagingOpportunity=state.imagingOpportunity;
  telemetry.SAT_S3_downlinkOpportunity=state.downlinkOpportunity;
  telemetry.SAT_S3_imagingAllowed=state.imagingAllowed;
  telemetry.SAT_S3_downlinkAllowed=state.downlinkAllowed;
  telemetry.SAT_S3_safeModeRequired=state.safeModeRequired;
  telemetry.SAT_S3_usedStorage_MB=state.usedStorage/1e6;
  telemetry.SAT_S3_remainingStorage_MB=state.remainingStorage/1e6;
  telemetry.SAT_S3_attitudeError_deg=state.attitudeError*180/Modelica.Constants.pi;
  telemetry.SAT_S3_attitudeSettled=state.attitudeSettled;

  telemetry.PDB_S0_channelState=state.pdState;
  telemetry.PDB_S0_channelCurrent_A=state.pdCurrent;
  telemetry.PDB_S0_MPPT_V=state.mpptVoltage;
  telemetry.PDB_S0_MPPT_A=state.mpptCurrent;
  telemetry.PDB_S0_charger_V=state.chargerVoltage;
  telemetry.PDB_S0_charger_A=state.chargerCurrent;

  telemetry.TCB_S0_channelState=state.tcState;
  telemetry.TCB_S0_channelCurrent_A=state.tcCurrent;
  telemetry.TCB_S0_heaterUpper_degC=state.heaterUpper-fill(273.15,14);
  telemetry.TCB_S0_heaterLower_degC=state.heaterLower-fill(273.15,14);
  telemetry.TCB_S0_thermistor_degC=state.thermistorTemperature-fill(273.15,32);

  telemetry.GNSS_fix=state.gnssFix;
  telemetry.Camera_status=state.cameraStatus;
  telemetry.Baseband_status=state.basebandStatus;
  telemetry.TTC_status=state.ttcStatus;
  telemetry.StarTrackerY_status=state.starStatus[1];
  telemetry.StarTrackerZ_status=state.starStatus[2];
  annotation(Icon(graphics={Rectangle(extent={{-100,72},{100,-72}},lineColor={0,100,160},fillColor={222,241,250},fillPattern=FillPattern.Solid),Rectangle(extent={{-68,38},{-18,-38}},lineColor={0,100,160},fillColor={250,250,250},fillPattern=FillPattern.Solid),Line(points={{-10,0},{62,0}},color={0,100,160},thickness=2),Polygon(points={{62,18},{90,0},{62,-18},{62,18}},fillColor={0,100,160},fillPattern=FillPattern.Solid),Text(extent={{-92,-66},{92,-44}},textString="ENG TM / MIRROR")}),Documentation(info="<html><h4>System role</h4><p>Engineering telemetry is mapped continuously from the onboard state database. Packet-level scheduling and protocol timing are intentionally omitted from the system-level model to preserve fast long-duration simulation.</p><h4>Implementation</h4><p>The equation section performs deterministic engineering-unit mappings only. There are no event clauses, sample operators, clocks, quantizers, packet counters or held packet states. Protocol metadata outputs are fixed to neutral values.</p><h4>Interfaces</h4><p><b>state:</b> continuous OBC state database mirror. <b>telemetry:</b> complete engineering telemetry field set forwarded through InformationPort.onboardTelemetry.</p></html>"));
end ASRTUEngineeringTelemetryMirror;
