within OneSatSim.Foundation;
package Interfaces "接口定义包"
  extends Modelica.Icons.InterfacesPackage;
  annotation(Documentation(info="<html><h4>包职责</h4><p><b>定位：</b>定义机电热信、任务、环境、源端电源与连续星上工程遥测连接器。</p><p><b>推荐阅读：</b>优先阅读InformationPort、DeviceStatusBus、SourcePowerPort、PowerPort和OnboardTelemetryPort。</p><p><b>语义约束：</b>设备测量与机器反馈共用InformationPort；OnboardTelemetryPort只出现在总体观察输出，不形成平行的数据状态网络。</p></html>"));
end Interfaces;
