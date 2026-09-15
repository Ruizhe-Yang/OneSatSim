within OneSatSim.Foundation.Types;
record MassProperties "整星质量特性唯一配置记录"
  parameter Modelica.Units.SI.Mass modeledRigidBodyMass
    "Components中显式Body/BodyBox静态质量审计总和，包含四台飞轮壳体与安装件";
  parameter Modelica.Units.SI.Mass wheelHousingAllowance
    "兼容字段；飞轮壳体已作为四个有位置的Body纳入机械事实源";
  final parameter Modelica.Units.SI.Mass totalMass=modeledRigidBodyMass+wheelHousingAllowance;
  parameter Modelica.Units.SI.Position centerOfMass[3]
    "整星质心相对结构基准";
  parameter Modelica.Units.SI.Inertia inertiaTensor[3,3]
    "由机械事实源在spacecraft reference frame汇总的完整惯量张量";
  final parameter Modelica.Units.SI.Inertia inertiaDiagonal[3]={inertiaTensor[1,1],inertiaTensor[2,2],inertiaTensor[3,3]}
    "低阶AOCS使用的惯量对角项；完整张量保留在inertiaTensor";
  parameter Modelica.Units.SI.Mass primaryStructureMass
    "主框架与下舱板显式结构质量";
  annotation(Documentation(info="<html><h4>事实源</h4><p>静态质量、质心和完整惯量张量由tools/generate_mass_properties.py从八个N-System实际启用的Body、BodyBox、FixedTranslation和机械连接路径离线汇总。Diagram Placement不参与物理位置计算。</p><h4>飞轮质量</h4><p>原0.720 kg无位置余量已按每台0.180 kg分配至四个反作用飞轮壳体/安装件，并作为有r_CM和局部惯量的Body进入机械路径。</p><h4>运行边界</h4><p>Modelica运行时只读取常数；AOCS当前使用张量对角项，非对角项保留用于审计和后续模型升级。</p></html>"));
end MassProperties;
