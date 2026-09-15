within OneSatSim.Foundation.Functions;

function encodeUInt24BE "大端24位无符号整数编码函数"input Integer value;

  output Integer bytes[3];

protected Integer v;

algorithm

  v := min(16777215,max(0,value));

  bytes := {mod(div(v,65536),256),mod(div(v,256),256),mod(v,256)};

  annotation(Documentation(info="<html><h4>函数用途</h4><p><b>作用：</b>把Integer编码为24位无符号协议字节</p><p><b>输入/输出：</b>输入value: Integer；输出bytes[3]: Integer</p><p><b>算法：</b>先执行边界处理，再用整除和取模拆分各8位字节</p><p><b>范围与边界：</b>输入按无符号范围[0,16777215]饱和</p><p><b>字节序：</b>大端序：数组首元素为最高有效字节</p><p><b>运行路径：</b>属于协议/工具支持函数；CompleteMission当前主路径输出工程单位遥测，不要求每个函数都在该运行链中实例化。</p></html>"));
end encodeUInt24BE;

