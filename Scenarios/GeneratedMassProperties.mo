within OneSatSim.Scenarios;
record GeneratedMassProperties "由机械组件离线汇总的整星质量特性"
  extends OneSatSim.Foundation.Types.MassProperties(
    modeledRigidBodyMass=19.96739752,
    wheelHousingAllowance=0,
    centerOfMass={0.00197271577132,0.00497010188236,0.0857572461852},
    inertiaTensor={{0.559453481253,0.000195772313146,0.00337797792723},{0.000195772313146,0.55289525889,0.00851054911142},{0.00337797792723,0.00851054911142,0.157852635333}},
    primaryStructureMass=3.03739752);
  annotation(Documentation(info="<html><p>由tools/generate_mass_properties.py从本次解析后的组件参数、活动Body/BodyBox和静态机械安装路径生成。运行时只读取常数，不执行矩阵汇总。</p></html>"));
end GeneratedMassProperties;
