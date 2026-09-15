within NISSA_12UCubeSat.Foundation.Types;

package TelemetryCatalog "工程遥测包目录"

  constant Integer packetCount=30;

  constant String packetCode[packetCount]={"SAT-S0","SAT-S1","SAT-S2","SAT-S3","SAT-S4","SAT-S5","ZGK-S0","ZGK-S1","PDB-S0","TCB-S0","TTC-S0","TTC-S1","TTC-S2","CAM-S0","BBB-S0","GPS-S0","CMS-S0","SSY-S1","SSY-S2","SSY-S3","SSZ-S1","SSZ-S2","SSZ-S3","SAT-S6","SAT-S7","SAT-S8","SAT-S9","NVE-S0","SPT-S0","FAM-S0"};

  constant Integer nID[packetCount]={240,240,240,240,240,240,170,170,4,5,1,1,1,169,2,184,168,181,181,181,182,182,182,240,240,240,240,165,166,175};

  constant Integer packetType[packetCount]={0,1,2,3,4,5,0,1,0,0,0,1,2,0,0,0,0,1,2,3,1,2,3,6,7,8,9,0,0,0};

  constant Integer payloadLength[packetCount]={201,201,201,201,211,211,198,201,119,135,120,84,24,64,91,164,149,18,115,474,18,115,474,201,201,201,201,0,0,0};

  constant Integer groundLength[packetCount]={208,208,208,208,218,218,205,208,126,142,127,91,31,71,98,171,156,25,122,481,25,122,481,208,208,208,208,380,208,135};

  constant Boolean scheduled[packetCount]={true,true,true,true,true,true,true,true,true,true,true,false,false,true,true,true,true,true,true,true,true,true,true,false,false,false,false,false,false,false};

  constant Boolean obcOnlyOpaque[packetCount]={false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,true,true};

  annotation(Documentation(info="<html><h4>包职责</h4><p><b>定位：</b>汇总支持的包NID、包类型和长度常量，供协议导航和扩展验证</p><p><b>内容：</b>静态常量，无运行状态</p><p><b>推荐阅读：</b>主运行链聚焦SAT-S0/S1/S2/S3、PDB-S0和TCB-S0；其余条目作为支持性定义</p><p><b>适用范围：</b>用于12U立方星多领域系统级总体仿真、架构理解、能量/热/姿态/任务联动和星上工程遥测导航。</p></html>"));

end TelemetryCatalog;

