within OneSatSim.Foundation.Functions;

function decodeUInt32BE "大端32位无符号整数解码函数"input Integer bytes[4];

  output Integer value;

algorithm

  value := 16777216*mod(bytes[1],256) + 65536*mod(bytes[2],256) + 256*mod(bytes[3],256) + mod(bytes[4],256);

  annotation(Documentation(info="<html><h4>函数用途</h4><p><b>作用：</b>把字节解码为32位无符号Integer</p><p><b>输入/输出：</b>输入bytes[4]；输出value: Integer</p><p><b>算法：</b>按大端权重组合，并用mod(byte,256)归一化每个字节</p><p><b>范围与边界：</b>输出范围[0,4294967295]；输入数组长度固定</p><p><b>字节序：</b>大端序：数组首元素为最高有效字节</p><p><b>运行路径：</b>属于协议/工具支持函数；CompleteMission当前主路径输出工程单位遥测，不要求每个函数都在该运行链中实例化。</p></html>"));
end decodeUInt32BE;

