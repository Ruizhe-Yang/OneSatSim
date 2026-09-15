within OneSatSim.Foundation.Functions;

function decodeFloat32BE "大端IEEE-754 binary32解码函数"

  input Integer bytes[4];

  output Real value;

protected

  Integer word;

  Integer signBit;

  Integer exponentBits;

  Integer mantissa;

algorithm

  word := OneSatSim.Foundation.Functions.decodeUInt32BE(bytes);

  signBit := div(word,2147483648);

  exponentBits := mod(div(word,8388608),256);

  mantissa := mod(word,8388608);

  if exponentBits == 0 then

    value := (if signBit == 1 then -1.0 else 1.0)*(mantissa/8388608.0)*2.0^(-126);

  else

    value := (if signBit == 1 then -1.0 else 1.0)*(1.0 + mantissa/8388608.0)*2.0^(exponentBits - 127);

  end if;

  annotation(Documentation(info="<html><h4>函数用途</h4><p><b>作用：</b>把4个大端字节解释为binary32工程数值，作为协议支持工具</p><p><b>输入/输出：</b>输入bytes[4]: Integer；输出value: Real</p><p><b>算法：</b>先组合32位字，再按符号位、8位指数和23位尾数计算；指数为0时走非规范数分支</p><p><b>范围与边界：</b>未专门区分指数255对应的NaN和无穷；输入字节均以mod(byte,256)归一化</p><p><b>字节序：</b>bytes[1]为最高有效字节，bytes[4]为最低有效字节</p><p><b>运行路径：</b>属于协议/工具支持函数；CompleteMission当前主路径输出工程单位遥测，不要求每个函数都在该运行链中实例化。</p></html>"));
end decodeFloat32BE;

