within NISSA_12UCubeSat.Foundation.Functions;

function decodeInt24BE "大端24位有符号整数解码函数"input Integer bytes[3];

  output Integer value;

protected Integer raw;

algorithm

  raw := NISSA_12UCubeSat.Foundation.Functions.decodeUInt24BE(bytes);

  value := if raw >= 8388608 then raw-16777216 else raw;

  annotation(Documentation(info="<html><h4>函数用途</h4><p><b>作用：</b>把字节解码为24位有符号Integer</p><p><b>输入/输出：</b>输入bytes[3]；输出value: Integer</p><p><b>算法：</b>按大端权重组合无符号值，再以最高位执行二补码符号扩展</p><p><b>范围与边界：</b>输出范围[-8388608,8388607]；输入数组长度固定</p><p><b>字节序：</b>大端序：数组首元素为最高有效字节</p><p><b>运行路径：</b>属于协议/工具支持函数；CompleteMission当前主路径输出工程单位遥测，不要求每个函数都在该运行链中实例化。</p></html>"));
end decodeInt24BE;

