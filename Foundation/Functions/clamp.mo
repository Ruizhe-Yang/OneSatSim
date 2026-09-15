within OneSatSim.Foundation.Functions;
function clamp "标量上下限约束函数"
  input Real u;
  input Real uMin;
  input Real uMax;
  output Real y;
algorithm
  y := min(uMax, max(uMin, u));
  annotation(Documentation(info="<html><h4>函数用途</h4><p><b>作用：</b>把实数u限制在闭区间[uMin,uMax]内，供控制和协议量化边界处理复用</p><p><b>输入/输出：</b>输入u、uMin、uMax；输出y</p><p><b>算法：</b>计算min(uMax, max(uMin, u))</p><p><b>范围与边界：</b>当u低于下限返回uMin，高于上限返回uMax；调用者应保证uMin不大于uMax</p><p><b>字节序：</b>不涉及字节序</p><p><b>运行路径：</b>属于协议/工具支持函数；CompleteMission当前主路径输出工程单位遥测，不要求每个函数都在该运行链中实例化。</p></html>"));
end clamp;