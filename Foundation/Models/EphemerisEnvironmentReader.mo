within NISSA_12UCubeSat.Foundation.Models;
model EphemerisEnvironmentReader "真实历元轨道与地球定向环境表读取器"
  import SI=Modelica.Units.SI;
  parameter String dataURI "modelica://资源URI";
  parameter String tableName="environment" "外部表名称";
  parameter SI.Time simulationDuration "允许的在线仿真时长";
  parameter Integer tableRows(min=2) "审计用表行数";
  Modelica.Blocks.Sources.CombiTimeTable environmentTable(
    tableOnFile=true,
    tableName=tableName,
    fileName=Modelica.Utilities.Files.loadResource(dataURI),
    columns={2,3,4,5,6,7,8,9,10,11,12,13,14,15,16},
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative,
    extrapolation=Modelica.Blocks.Types.Extrapolation.NoExtrapolation,
    timeEvents=Modelica.Blocks.Types.TimeEvents.NoTimeEvents,
    verboseRead=false) annotation(Placement(transformation(extent={{-72,-12},{-52,8}})));
  output SI.Position position[3] "卫星相对地心GCRS位置";
  output SI.Velocity velocity[3] "由位置插值曲线求导得到的GCRS速度";
  output Real sunDirection[3] "卫星指向太阳的GCRS单位方向";
  output Real earthToInertial[3,3] "ITRS球形地面坐标到GCRS的旋转矩阵";
  output Real earthToInertialRate[3,3](each unit="1/s") "与插值旋转矩阵一致的时间导数";
protected
  Real sunNorm;
initial equation
  assert(simulationDuration > 0,"Generated environment duration must be positive");
  assert(tableRows >= 3,"Generated environment table must contain at least three rows");
equation
  position=environmentTable.y[1:3];
  velocity={der(environmentTable.y[1]),der(environmentTable.y[2]),der(environmentTable.y[3])};
  sunNorm=sqrt(max(1e-24,environmentTable.y[4]^2+environmentTable.y[5]^2+environmentTable.y[6]^2));
  sunDirection=environmentTable.y[4:6]/sunNorm;
  earthToInertial={{environmentTable.y[7],environmentTable.y[8],environmentTable.y[9]},
    {environmentTable.y[10],environmentTable.y[11],environmentTable.y[12]},
    {environmentTable.y[13],environmentTable.y[14],environmentTable.y[15]}};
  for i in 1:3 loop
    for j in 1:3 loop
      earthToInertialRate[i,j]=der(earthToInertial[i,j]);
    end for;
  end for;
  annotation(Icon(graphics={Rectangle(extent={{-100,70},{100,-70}},lineColor={35,75,120},fillColor={230,240,248},fillPattern=FillPattern.Solid),Line(points={{-72,-34},{-38,20},{0,-2},{38,42},{74,20}},color={30,105,175},thickness=1),Text(extent={{-92,-64},{92,-40}},textString="GCRS / JPL / IERS")}),Documentation(info="<html><h4>功能定位</h4><p>一次读取离线生成的轨道、太阳方向和地球定向连续表，避免各分系统重复加载资源。</p><h4>插值关系</h4><p>MSL CombiTimeTable采用连续一阶导数插值且关闭节点时间事件；velocity直接取position插值的导数，earthToInertialRate直接取同一旋转矩阵插值的导数，保持位置/速度与定向/角速度的一致关系。</p><h4>坐标与单位</h4><p>position为卫星相对地心的GCRS位置（m），velocity为GCRS速度（m/s），sunDirection为卫星指向太阳的GCRS单位方向，earthToInertial把球形ITRS地面矢量转至GCRS。</p><h4>边界</h4><p>表外查询采用NoExtrapolation并报错；运行时不联网、不调用Python。星历来源、时间尺度、资源哈希和误差见同目录environment_metadata.json。</p></html>"));
end EphemerisEnvironmentReader;
