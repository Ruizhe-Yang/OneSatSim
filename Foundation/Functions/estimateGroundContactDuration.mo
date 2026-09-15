within OneSatSim.Foundation.Functions;
function estimateGroundContactDuration
  "按当前相对运动估算预测时域内超过最低仰角的累计时长"
  input Real stationRelative[3] "地面站到航天器的相对位置";
  input Real stationRelativeVelocity[3] "相对速度";
  input Real stationPosition[3] "地面站地心位置";
  input Real stationVelocity[3] "地面站惯性速度";
  input Real minimumElevationSin "最低仰角正弦";
  input Real predictionHorizon(unit="s")=180;
  output Real visibleDuration(unit="s");
protected
  constant Integer intervalCount=36 "5 s级局部预测，保持任务级低计算量";
  Real dt;
  Real tau0;
  Real tau1;
  Real relative0[3];
  Real relative1[3];
  Real position0[3];
  Real position1[3];
  Real spacecraftPosition[3];
  Real spacecraftAcceleration[3];
  Real stationAcceleration[3];
  Real relativeAcceleration[3];
  Real margin0;
  Real margin1;
algorithm
  dt:=predictionHorizon/intervalCount;
  visibleDuration:=0;
  spacecraftPosition:=stationPosition+stationRelative;
  spacecraftAcceleration:=-3.986004418e14*spacecraftPosition/
    max(1e-12,(spacecraftPosition*spacecraftPosition)^(1.5));
  stationAcceleration:={-(2*Modelica.Constants.pi/86164)^2*stationPosition[1],
    -(2*Modelica.Constants.pi/86164)^2*stationPosition[2],0};
  relativeAcceleration:=spacecraftAcceleration-stationAcceleration;
  for k in 0:intervalCount-1 loop
    tau0:=k*dt;
    tau1:=(k+1)*dt;
    relative0:=stationRelative+tau0*stationRelativeVelocity+0.5*tau0^2*relativeAcceleration;
    relative1:=stationRelative+tau1*stationRelativeVelocity+0.5*tau1^2*relativeAcceleration;
    position0:=stationPosition+tau0*stationVelocity+0.5*tau0^2*stationAcceleration;
    position1:=stationPosition+tau1*stationVelocity+0.5*tau1^2*stationAcceleration;
    margin0:=(relative0*position0)/sqrt(max(1e-12,(relative0*relative0)*(position0*position0)))-minimumElevationSin;
    margin1:=(relative1*position1)/sqrt(max(1e-12,(relative1*relative1)*(position1*position1)))-minimumElevationSin;
    if margin0 >= 0 and margin1 >= 0 then
      visibleDuration:=visibleDuration+dt;
    elseif margin0 < 0 and margin1 >= 0 then
      visibleDuration:=visibleDuration+dt*margin1/max(1e-12,margin1-margin0);
    elseif margin0 >= 0 and margin1 < 0 then
      visibleDuration:=visibleDuration+dt*margin0/max(1e-12,margin0-margin1);
    end if;
  end for;
  annotation(Documentation(info="<html><h4>功能定位</h4><p>在不增加轨道状态或根求解器的前提下，按当前地面站—航天器相对运动预测未来180 s内满足正式最低仰角的时长。</p><h4>方法与边界</h4><p>用当前地心位置计算引力与地球自转向心加速度，采用二阶局部运动和36个区间，并在线性阈值穿越处插值。只为任务接受可执行性提供任务级估算，不替代高精度过站预报。</p></html>"));
end estimateGroundContactDuration;
