within NISSA_12UCubeSat.Foundation.Functions;
function decodeInt32BEAt "字节数组指定位置的大端32位有符号整数解码函数"
  input Integer bytes[:];
  input Integer startIndex;
  output Integer value;
protected
  Integer unsignedValue;
algorithm
  unsignedValue := 16777216*mod(bytes[startIndex],256)
                 + 65536*mod(bytes[startIndex + 1],256)
                 + 256*mod(bytes[startIndex + 2],256)
                 + mod(bytes[startIndex + 3],256);
  value := if unsignedValue >= 2147483648 then unsignedValue - 4294967296 else unsignedValue;
  annotation(Documentation(info="<html><h4>函数用途</h4><p><b>作用：</b>把字节解码为32位有符号Integer</p><p><b>输入/输出：</b>输入bytes[:]与startIndex；输出value: Integer</p><p><b>算法：</b>按大端权重组合无符号值，再以最高位执行二补码符号扩展</p><p><b>范围与边界：</b>输出范围[-2147483648,2147483647]；从startIndex起读取，调用者必须保证数组剩余长度足够</p><p><b>字节序：</b>大端序：数组首元素为最高有效字节</p><p><b>运行路径：</b>属于协议/工具支持函数；CompleteMission当前主路径输出工程单位遥测，不要求每个函数都在该运行链中实例化。</p></html>"));
end decodeInt32BEAt;
