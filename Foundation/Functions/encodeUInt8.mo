within OneSatSim.Foundation.Functions;

function encodeUInt8 "8位无符号整数编码函数"input Integer value;

  output Integer byte;

algorithm

  byte := mod(max(0, min(255, value)), 256);

  annotation(Documentation(info="<html><h4>函数用途</h4><p><b>作用：</b>把Integer编码为8位无符号协议字节</p><p><b>输入/输出：</b>输入value: Integer；输出byte: Integer</p><p><b>算法：</b>先执行边界处理，再用整除和取模拆分各8位字节</p><p><b>范围与边界：</b>输入按无符号范围[0,255]饱和</p><p><b>字节序：</b>单字节不涉及顺序</p><p><b>运行路径：</b>属于协议/工具支持函数；CompleteMission当前主路径输出工程单位遥测，不要求每个函数都在该运行链中实例化。</p></html>"));
end encodeUInt8;

