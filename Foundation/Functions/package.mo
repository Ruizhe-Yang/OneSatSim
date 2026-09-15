within OneSatSim.Foundation;
package Functions "总体仿真通用函数包"
  extends Modelica.Icons.FunctionsPackage;
  annotation(Documentation(info="<html><h4>包职责</h4><p><b>定位：</b>只保留当前总体物理模型实际调用的无状态数学函数。</p><p><b>内容：</b>clamp用于连续工程量限幅。</p><p><b>清理说明：</b>未被主工程调用的字节协议编解码函数已移除；协议帧构造不属于本轮连续物理仿真的运行边界。</p></html>"));
end Functions;
