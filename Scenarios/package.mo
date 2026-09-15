within OneSatSim;
package Scenarios "静态仿真场景参数层"
  extends Modelica.Icons.Package;
  constant DefaultSpacecraftDesignConfig defaultSpacecraftDesignConfig=
    DefaultSpacecraftDesignConfig()
    "供GeneratedSpacecraftDesignConfig引用的唯一硬件数值基线"
    annotation(HideResult=true);
  annotation(Documentation(info="<html><h4>用途</h4><p>以标准Modelica record、parameter和component modification承载硬件设计、轨道、地面站、拍摄目标及初始条件。Excel不被Modelica直接读取；离线工具只生成Generated配置。</p><h4>默认值</h4><p>defaultSpacecraftDesignConfig实例化DefaultSpacecraftDesignConfig，供生成记录引用未覆盖字段，避免Python或Generated记录复制数值默认值。</p><h4>边界</h4><p>本包只包含静态配置，不包含运行时信号总线、外部对象、文件解析或联网依赖。</p></html>"));
end Scenarios;
