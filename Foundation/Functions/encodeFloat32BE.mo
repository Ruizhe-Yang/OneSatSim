within NISSA_12UCubeSat.Foundation.Functions;

function encodeFloat32BE "大端IEEE-754 binary32编码函数"

  input Real value;

  output Integer bytes[4];

protected

  Real a;

  Integer signBit;

  Integer exponent;

  Integer mantissa;

  Integer word;

algorithm

  if value == 0 then

    word := 0;

  else

    signBit := if value < 0 then 1 else 0;

    a := abs(value);

    exponent := integer(floor(log(a)/log(2)));

    mantissa := integer(floor((a/2.0^exponent - 1.0)*8388608.0 + 0.5));

    if mantissa >= 8388608 then

      mantissa := 0;

      exponent := exponent + 1;

    end if;

    word := signBit*2147483648 + (exponent + 127)*8388608 + mantissa;

  end if;

  bytes := NISSA_12UCubeSat.Foundation.Functions.encodeUInt32BE(word);

  annotation(Documentation(info="<html><h4>函数用途</h4><p><b>作用：</b>把有限普通Real值转换为4个大端binary32字节，作为协议支持工具</p><p><b>输入/输出：</b>输入value: Real；输出bytes[4]: Integer</p><p><b>算法：</b>由符号、以2为底的指数和23位尾数构造32位字，再调用encodeUInt32BE拆分</p><p><b>范围与边界：</b>显式支持零和有限规范化数；不专门处理NaN、无穷、溢出及极小非规范数</p><p><b>字节序：</b>bytes[1]为最高有效字节，bytes[4]为最低有效字节</p><p><b>运行路径：</b>属于协议/工具支持函数；CompleteMission当前主路径输出工程单位遥测，不要求每个函数都在该运行链中实例化。</p></html>"));
end encodeFloat32BE;

