within NISSA_12UCubeSat.Foundation.Functions;

function decodeUInt24BE "大端24位无符号整数解码函数"input Integer bytes[3];

  output Integer value;

algorithm

  value := mod(bytes[1],256)*65536+mod(bytes[2],256)*256+mod(bytes[3],256);

  annotation(Documentation(info="<html><h4>函数用途</h4><p><b>作用：</b>把字节解码为24位无符号Integer</p><p><b>输入/输出：</b>输入bytes[3]；输出value: Integer</p><p><b>算法：</b>按大端权重组合，并用mod(byte,256)归一化每个字节</p><p><b>范围与边界：</b>输出范围[0,16777215]；输入数组长度固定</p><p><b>字节序：</b>大端序：数组首元素为最高有效字节</p><p><b>运行路径：</b>属于协议/工具支持函数；CompleteMission当前主路径输出工程单位遥测，不要求每个函数都在该运行链中实例化。</p></html>"));
end decodeUInt24BE;

