<div align="center">

<img src="./OneSatSim.png" alt="OneSatSim Logo" width="520">

# OneSatSim

### One-Stop Satellite Simulation · 一站式卫星总体仿真框架

**Modelica-based · Multi-domain · Mission-driven · Configurable · Extensible**  
**基于 Modelica · 多领域耦合 · 任务驱动 · 参数化配置 · 可二次开发**

[![Modelica](https://img.shields.io/badge/Modelica-MSL%204.0.0-5C6BC0?style=flat-square)](https://modelica.org/)
[![OpenModelica](https://img.shields.io/badge/OpenModelica-supported-1976D2?style=flat-square)](https://openmodelica.org/)
[![MWORKS](https://img.shields.io/badge/MWORKS.Sysplorer-supported-00897B?style=flat-square)](https://www.tongyuan.cc/)
[![Demo](https://img.shields.io/badge/Demo-12U%20CubeSat-455A64?style=flat-square)](#示范案例)

[中文](#中文) · [English](#english) · [技术说明 / Technical Report](./基于modelica的12U立方星总体建模与仿真实现说明.html)

</div>

---

<a id="中文"></a>

# 中文

## 1. 项目简介

**OneSatSim** 是一个基于 **Modelica** 的通用卫星系统级总体建模与仿真框架。项目名称来自 **One-Stop Satellite Simulation**：希望把卫星总体设计中原本分散在轨道、任务、电源、热控、姿态、载荷、数管、通信和资源预算中的分析工作，尽可能放到**同一个可执行模型、同一条任务时间轴和同一套参数配置体系**中完成。

当前公开版本以一颗 **12U 对地观测立方星**作为示范案例。它不是某一颗真实卫星的逐项复刻，也不是器件级高保真数字孪生，而是一个用于卫星总体设计、方案论证、任务—资源权衡、跨分系统耦合分析和二次开发的系统级仿真基线。

当前根包为：

```text
OneSatSim
```

项目版本为 `2.1.0`，基础模型仅依赖：

```text
Modelica Standard Library 4.0.0
```

OneSatSim 当前采用一个清晰的 **“1 + 4 + 8”** 总体结构：

- **1 个完整任务仿真入口**：`Simulation.CompleteMission`
- **4 个跨设备总体网络**：机械、供电、热、信息
- **8 个卫星分系统**：电源、姿轨控、载荷、数管、通信、导航、热控、结构

与只做静态质量预算、功率预算或单独轨道分析不同，OneSatSim 更关注一个问题：

> **当卫星真正沿着任务时间轴运行时，轨道环境、姿态动作、设备开关机、供电、热状态、存储、通信窗口与任务调度之间能否同时成立？**

---

## 2. OneSatSim 可以做什么？

OneSatSim 主要面向卫星方案设计和系统级工程分析，可以用于：

- **卫星总体方案快速建模**：建立结构、设备、分系统和整星之间的层级关系；
- **机—电—热—信多领域联合仿真**：观察不同物理域和信息域之间的相互影响；
- **轨道与真实日期环境分析**：在指定日历历元下生成轨道环境、太阳/月球几何、地影等输入；
- **任务全过程仿真**：在同一时间轴上执行成像、待机、姿态机动、下传、安全模式等任务状态；
- **任务—资源联合评估**：分析任务行为对电量、存储、温度、飞轮、数据吞吐等资源的影响；
- **电源系统分析**：观察太阳电池、母线、电池 SOC、电压、电流和负载变化；
- **热状态分析**：观察外热流、设备耗散、热容、导热、加热器等对温度演化的影响；
- **姿态控制资源分析**：观察反作用飞轮状态、磁力矩卸载、传感器和控制设备的资源消耗；
- **载荷与数管分析**：模拟成像数据产生、存储写入、读取和下传之间的动态平衡；
- **通信机会分析**：结合地面站窗口、任务调度和数据库存分析下传行为；
- **参数敏感性与 What-if 分析**：快速修改容量、效率、功率、安装参数、任务时长、目标和地面站等配置；
- **安全分析与故障研究的基础模型**：可在现有名义系统模型上继续扩展故障注入、保护逻辑、安全监视和故障场景；
- **算法、软件和控制策略的系统级验证载体**：可将更高保真的控制律、任务规划算法或外部程序逐步接入。

OneSatSim 的定位不是“把所有物理细节一次性建到最复杂”，而是提供一个**能够运行、能够解释、能够修改、能够逐层细化**的总体仿真骨架。

---

## 3. 核心建模思想

### 3.1 设备级白箱 + 系统级连接

OneSatSim 尽量将卫星设备作为可独立理解和替换的 Modelica 组件。典型设备同时具有：

- 机械安装与质量属性；
- 电源接口及功率消耗；
- 热接口及热耗散；
- 信息、遥测或任务接口。

因此，一次“相机开机”不再只是一个 Boolean 信号，而可以同时带来：

```text
任务指令
   ↓
载荷启动
   ├─→ 电功率变化
   ├─→ 热耗散变化
   ├─→ 数据产生
   ├─→ 存储占用
   └─→ 后续下传需求
```

### 3.2 四大总体网络

项目将跨设备公共关系组织为四类总体网络：

```text
MechanicsOverall
ElectricalOverall
ThermalOverall
InformationOverall
```

它们不是四颗独立的“卫星”，而是同一颗卫星上四类不同的系统级耦合关系。

### 3.3 八个分系统

当前基线包括：

```text
ElectricalPowerSystem
GNCSystem
PayloadSystem
DataHandlingSystem
CommunicationSystem
NavigationSystem
ThermalControlSystem
StructureSystem
```

各分系统再通过 `Systems.SpacecraftSystem` 集成为整星。

### 3.4 单一任务仿真入口

推荐使用唯一完整仿真入口：

```modelica
OneSatSim.Simulation.CompleteMission
```

当前示范配置默认采用：

```text
StartTime       = 0 s
StopTime        = 86400 s
OutputInterval  = 1 s
Tolerance       = 1e-5
Solver          = IDA
```

日历时间、任务时长、轨道初态和环境输入由配置工具生成；Modelica 仿真时间仍从 `0 s` 开始。

---

## 4. 参数化配置：先改 Excel，再运行模型

OneSatSim 提供了面向总体设计的参数配置链：

```text
DesignConfig.xlsx
        ↓
UpdateConfig.bat
        ↓
参数检查 / 单位检查 / 质量属性计算
        ↓
场景与硬件配置生成
        ↓
真实日期轨道与星历环境生成
        ↓
Simulation.CompleteMission
```

推荐用户优先修改根目录中的：

```text
DesignConfig.xlsx
```

然后运行：

```text
UpdateConfig.bat
```

该流程会更新场景、硬件设计参数、质量属性和环境数据等生成文件。

这种做法的目的，是尽量避免在多个 `.mo` 文件中重复手工修改参数，使一次仿真能够追溯到明确的配置输入。

---

## 5. 软件环境

### 5.1 OpenModelica —— 推荐的开源运行环境

[OpenModelica](https://openmodelica.org/) 是一个**开源的 Modelica 建模与仿真环境**，可以直接从官网下载安装。

- 官网：<https://openmodelica.org/>
- 官方下载：<https://openmodelica.org/download/>
- Windows 下载：<https://openmodelica.org/download/download-windows/>
- 官方用户手册：<https://openmodelica.org/doc/OpenModelicaUsersGuide/latest/>

OneSatSim 推荐优先使用 OpenModelica / OMEdit 进行模型检查、编译和仿真。当前项目的基础依赖是 **Modelica Standard Library 4.0.0**。

### 5.2 MWORKS.Sysplorer —— 可选的国产 Modelica 平台

[MWORKS.Sysplorer](https://www.tongyuan.cc/) 是同元软控开发的商业 Modelica 建模与仿真平台，属于**闭源软件**。

- 官方网站：<https://www.tongyuan.cc/>
- 产品下载：<https://www.tongyuan.cc/product/download>
- 许可配置说明：<https://www.tongyuan.cc/docs/sysplorer/2026a/Help/SetupHelp/Doc/SetupHelp/License.html>

对于中国高校在校生，可使用高校教育邮箱申请 **MWORKS 教育版许可**；按照同元当前公开许可说明，教育版仅限教育邮箱申请，许可具有有效期。教育版的具体免费政策、申请资格和有效期限请以同元官网当期规则为准。

OneSatSim 在顶层模型中保留了 MWORKS 相关仿真 annotation，因此可以在 Sysplorer 中继续进行模型打开、检查和仿真。

---

## 6. 快速开始

### 6.1 克隆项目

```bash
git clone https://github.com/Ruizhe-Yang/OneSatSim.git
cd OneSatSim
```

### 6.2 安装配置工具依赖

项目中的真实日期环境和参数生成工具使用 Python。建议按项目当前依赖文件安装：

```bash
python -m pip install -r tools/requirements-ephemeris.txt
```

### 6.3 修改配置

打开：

```text
DesignConfig.xlsx
```

修改需要的任务与硬件参数，保存并关闭 Excel。

随后在 Windows 下运行：

```text
UpdateConfig.bat
```

确认配置更新成功。

### 6.4 在 OpenModelica 中运行

1. 启动 **OMEdit**；
2. 打开根目录 `package.mo`；
3. 展开：

```text
OneSatSim
└─ Simulation
   └─ CompleteMission
```

4. 先执行 **Check Model**；
5. 编译模型；
6. 建议先进行短时仿真；
7. 确认模型运行正常后，再运行完整任务时间。

---

## 7. 项目结构

```text
OneSatSim/
├─ package.mo
├─ package.order
├─ OneSatSim.png
├─ DesignConfig.xlsx
├─ UpdateConfig.bat
│
├─ Foundation/
│  ├─ Interfaces/        # 机、电、热、信息与任务接口
│  ├─ Models/            # 公共行为模型与任务核心模型
│  ├─ Calculations/      # 可复用计算模型
│  ├─ Functions/         # 编解码、辅助函数等
│  └─ Types/             # 枚举、质量属性、遥测类型等
│
├─ Scenarios/
│  ├─ DefaultScenario.mo
│  ├─ GeneratedScenario.mo
│  ├─ GeneratedSpacecraftDesignConfig.mo
│  └─ DesignConfigRecords/
│
├─ Components/           # 设备级 Modelica 白箱组件
│
├─ Systems/
│  ├─ Four_systems/      # 机械、电气、热、信息四大总体
│  ├─ N_systems/         # 八个分系统
│  └─ SpacecraftSystem.mo
│
├─ Simulation/
│  └─ CompleteMission.mo # 唯一完整任务仿真入口
│
├─ Resources/
│  ├─ Ephemeris/         # DE440s、IERS、闰秒等资源
│  └─ Data/
│
├─ tools/                # 配置生成、环境生成、检查与验证脚本
└─ outputs/              # 配置审计和验证输出
```

---

## 8. 如何进行二次开发

OneSatSim 的一个主要目标，就是作为一个**可以继续长大的卫星总体仿真骨架**。推荐按照下面的层次进行扩展。

### 8.1 修改任务场景

如果只是更换任务，不建议立即修改底层模型。

优先在 `DesignConfig.xlsx` 中修改：

- 仿真日期与时长；
- 轨道初始状态；
- 地面站；
- 成像目标；
- 存储容量；
- 设备功率；
- 电池参数；
- 太阳电池参数；
- 任务相关阈值。

这样可以快速形成新的卫星任务案例。

### 8.2 替换硬件参数

可以把当前 12U 示例中的设备参数替换为自己的卫星参数，例如：

- 更换电池容量；
- 更换太阳电池效率与面积；
- 更换飞轮能力；
- 更换相机数据率；
- 更换数传速率；
- 更换设备质量与安装位置；
- 更换热容、导热或加热参数。

如果接口定义不变，很多情况下不需要重构整星连接关系。

### 8.3 新增设备

新增设备时，建议遵守当前的多域接口思想：

```text
MechanicalPort
PowerPort
ThermalPort
Information / Telemetry / Mission signals
```

然后将设备接入对应分系统，再由分系统接入四大总体网络。

### 8.4 将等效模型替换为高保真模型

OneSatSim 中很多模型刻意保持在“总体工程可计算”的颗粒度。

二次开发时可以逐步把：

```text
等效功耗
→ 电路级模型

集总热容
→ 更细热网络

低阶姿态模型
→ 更完整刚体/执行器/控制律

固定数据率
→ 链路预算与动态通信模型
```

逐层替换，而不必一开始就重写整个系统。

### 8.5 接入新的控制算法或星务逻辑

可以进一步：

- 修改 `MissionPlanner`；
- 修改 `MissionStateMachine`；
- 增加新的任务序列；
- 替换 GNC 控制核心；
- 对接外部 C/C++ 算法；
- 通过工具支持的 FMI/FMU 或外部函数机制接入其他程序；
- 建立软件在环、模型在环或进一步的联合仿真流程。

### 8.6 扩展安全分析

现有名义模型还可以作为安全分析的“被分析对象”，进一步增加：

- 传感器失效；
- 执行器退化；
- 电源异常；
- 热控异常；
- 通信中断；
- 任务取消；
- 安全模式触发；
- 故障检测与恢复；
- 故障注入与安全证据生成。

这也是 OneSatSim 后续非常重要的扩展方向之一。

---

## 9. 两个重要的思路来源

OneSatSim 并不是从零开始凭空设计。项目形成过程中，有两个工作对整体思路产生了重要影响。

### 9.1 《宇航学报》：机—电—热—信耦合的航天器系统级仿真方法

OneSatSim 的系统组织思想受到以下论文的重要启发：

> **彭坤，王岩，李智，翁昉倞，贾雨棽. 考虑机电热信耦合的航天器系统级分布式仿真方法研究[J]. 宇航学报, 2025, 46(9): 1896-1905.**  
> DOI: [10.3873/j.issn.1000-1328.2025.09.016](https://doi.org/10.3873/j.issn.1000-1328.2025.09.016)  
> 论文页面：<https://www.spacejournal.cn/yhxb/article/doi/10.3873/j.issn.1000-1328.2025.09.016>

该工作提出了面向航天器的 **“1 + 4 + N”** 系统级仿真结构，并强调：

- 以单机为重要建模颗粒度；
- 统一考虑机械、电气、热和信息耦合；
- 将总体模型、分系统模型和设备模型连接起来；
- 在方案阶段通过系统级仿真发现跨分系统问题。

OneSatSim 吸收了这种**分层组织、设备多域表达和跨系统耦合**的思想，但没有照搬论文中的分布式计算架构。当前 OneSatSim 将四大总体网络和八个分系统放在一个 Modelica 模型中，由统一求解器完成联合仿真。

### 9.2 “阿斯图友谊号”ASRTU-1 开源星务软件

OneSatSim 的任务逻辑、设备状态、星务信息组织和工程遥测设计还受到了 **ASRTU-1（阿斯图友谊号）开源星务软件**的启发。

该项目由**哈尔滨工业大学紫丁香学生微纳卫星团队**开发，并以 GPL-2.0 许可证公开：

- OpenLilacSat 开源平台：<https://gitee.com/openlilacsat>
- ASRTU-1 星务软件：<https://gitee.com/openlilacsat/ASRTU-1_OBC_Software>

公开星务程序包含任务调度、姿轨控接口、电源管理、故障处理、地面遥控等模块，为理解一颗真实学生卫星“在软件层面如何组织任务、设备和状态”提供了非常有价值的参考。

OneSatSim **不是 ASRTU-1 星务软件的 Modelica 翻译版，也不代表对实星软件的逐行复现**。本项目主要吸收其工程组织思路、状态接口思想和公开资料中反映的卫星系统构成，并将其转换为面向系统级仿真的 Modelica 表达。

---

## 10. 示范案例

当前仓库提供的是一个 **12U 立方星完整任务仿真案例**。

其主要分析对象包括：

```text
轨道与地影
太阳 / 月球 / 地球几何
目标与地面站机会
任务调度
成像
姿态控制
反作用飞轮
磁力矩卸载
太阳电池
电池 SOC
母线与负载
设备温度
主动热控
数据生成
数据存储
X 波段下传
工程遥测
```

当前 `CompleteMission` 默认提供 24 h 仿真设置，可作为新的任务和新的卫星设计的起点。

---

## 11. 适用边界

OneSatSim 是一个**系统级工程仿真框架**。

它适合：

- 总体设计；
- 方案比较；
- 任务—资源分析；
- 多领域耦合研究；
- 算法接入；
- 教学与科研；
- 二次开发；
- 安全分析的系统模型基础。

但它不能直接替代：

- 真实飞行软件；
- 器件鉴定模型；
- 热真空试验；
- 结构有限元分析；
- CFD；
- 电磁场仿真；
- 射频电路级仿真；
- 整星环境试验；
- 飞行认证与型号定型。

项目中的公开参考值、工程假设、配置参数和仿真结果应当保持明确区分。

---

## 12. 致谢

特别感谢 **大连理工大学智连星宇学社** 对本项目相关工作的支持。

感谢在卫星系统工程、模型梳理、建模讨论、测试交流与开源实践中提供帮助的老师、同学和开源社区贡献者。

同时感谢：

- Modelica Association；
- OpenModelica 社区；
- 同元软控 MWORKS 团队；
- 《宇航学报》相关研究团队；
- 哈尔滨工业大学紫丁香学生微纳卫星团队 / OpenLilacSat；
- JPL、IERS 及相关科学数据与开源软件维护者。

---

## 13. 技术说明

更完整的模型结构、建模原理、参数说明、仿真结果与工程评价见：

**[《基于 Modelica 的 12U 立方星总体建模与仿真实现说明》](./基于modelica的12U立方星总体建模与仿真实现说明.html)**

---

## 14. 参与开发

欢迎基于 OneSatSim 进行：

- 新卫星案例构建；
- 新设备模型开发；
- 高保真模型替换；
- 新任务规划算法开发；
- 故障与安全模型扩展；
- 不同 Modelica 平台适配；
- 仿真结果可视化；
- 教学案例建设。

如果发现模型问题、接口问题或有新的功能建议，欢迎通过 GitHub Issues / Pull Requests 参与项目建设。

项目地址：

<https://github.com/Ruizhe-Yang/OneSatSim>

---

<a id="english"></a>

# English

## 1. Overview

**OneSatSim** stands for **One-Stop Satellite Simulation**. It is a **Modelica-based system-level satellite modeling and simulation framework** designed to put spacecraft mission logic, orbital environment, physical behavior, subsystem interactions, and resource constraints onto one executable timeline.

The current public baseline uses a **12U Earth-observation CubeSat** as a demonstration case. It is not intended to be a one-to-one digital replica of a specific flight spacecraft. Instead, it provides an extensible engineering baseline for:

- early spacecraft design;
- system integration;
- mission-resource trade studies;
- multi-domain coupled simulation;
- algorithm evaluation;
- research and education;
- secondary development.

The current root package is:

```text
OneSatSim
```

Version:

```text
2.1.0
```

Core dependency:

```text
Modelica Standard Library 4.0.0
```

The framework follows a **1 + 4 + 8** organization:

- **1** complete mission simulation entry: `Simulation.CompleteMission`
- **4** cross-device overall networks: mechanics, electrical, thermal, and information
- **8** spacecraft subsystems: EPS, GNC, payload, data handling, communication, navigation, thermal control, and structure

The key question behind OneSatSim is:

> **Can the spacecraft mission, physical states, and resource constraints remain mutually consistent while the spacecraft actually executes its mission over time?**

---

## 2. What can OneSatSim do?

OneSatSim can be used for:

- spacecraft system architecture modeling;
- mechanical-electrical-thermal-information coupled simulation;
- real-epoch orbital environment generation;
- eclipse and celestial geometry analysis;
- imaging and ground-station opportunity analysis;
- mission scheduling and mission-state simulation;
- electrical power and battery SOC analysis;
- thermal-state and heater analysis;
- attitude-control resource analysis;
- reaction-wheel and momentum-unloading studies;
- payload-data generation and onboard-storage analysis;
- communication and downlink studies;
- engineering telemetry observation;
- design-parameter sensitivity studies;
- what-if scenario evaluation.

The model can also serve as a nominal system baseline for future fault injection, safety analysis, protection logic, and dynamic safety evidence studies.

---

## 3. Modeling philosophy

OneSatSim is based on several practical principles:

**Device-oriented white-box modeling.**  
A spacecraft unit can expose mechanical, electrical, thermal, and information interfaces instead of being represented only by a single power number or status flag.

**System-level coupling.**  
Power, heat, mission logic, storage, communication, attitude motion, and environment are solved on the same mission timeline.

**Progressive fidelity.**  
A simple executable model is preferred before increasing fidelity. Equivalent models can later be replaced by detailed models without rebuilding the entire spacecraft architecture.

**Traceable configuration.**  
Mission and spacecraft parameters are managed through a controlled Excel-to-Modelica generation chain.

---

## 4. Configuration workflow

The intended configuration chain is:

```text
DesignConfig.xlsx
        ↓
UpdateConfig.bat
        ↓
validation / unit checking / mass-property calculation
        ↓
generated scenario and spacecraft configuration
        ↓
real-epoch environment generation
        ↓
OneSatSim.Simulation.CompleteMission
```

Users are encouraged to modify `DesignConfig.xlsx` rather than manually maintaining multiple generated `.mo` files.

---

## 5. Software

### 5.1 OpenModelica

[OpenModelica](https://openmodelica.org/) is a **free and open-source Modelica modeling and simulation environment** and is the recommended reference environment for OneSatSim.

- Website: <https://openmodelica.org/>
- Download: <https://openmodelica.org/download/>
- Windows: <https://openmodelica.org/download/download-windows/>
- User Guide: <https://openmodelica.org/doc/OpenModelicaUsersGuide/latest/>

### 5.2 MWORKS.Sysplorer

[MWORKS.Sysplorer](https://www.tongyuan.cc/) is a **commercial closed-source Modelica modeling and simulation platform** developed by Tongyuan.

- Website: <https://www.tongyuan.cc/>
- Download: <https://www.tongyuan.cc/product/download>
- License guide: <https://www.tongyuan.cc/docs/sysplorer/2026a/Help/SetupHelp/Doc/SetupHelp/License.html>

Students at Chinese universities can apply for an **educational license** using an eligible academic email account. Please refer to Tongyuan's current licensing policy for the exact eligibility, cost, and validity period.

---

## 6. Quick start

Clone the repository:

```bash
git clone https://github.com/Ruizhe-Yang/OneSatSim.git
cd OneSatSim
```

Install the Python dependencies used by the configuration and ephemeris toolchain:

```bash
python -m pip install -r tools/requirements-ephemeris.txt
```

Edit:

```text
DesignConfig.xlsx
```

Then run on Windows:

```text
UpdateConfig.bat
```

Open `package.mo` in OMEdit or another compatible Modelica environment and run:

```text
OneSatSim.Simulation.CompleteMission
```

For a new configuration, a short simulation is recommended before running the full mission duration.

---

## 7. Secondary development

OneSatSim is designed to be extended.

### Change the mission

Modify mission duration, epoch, orbital initial state, targets, ground stations, and mission-related parameters in `DesignConfig.xlsx`.

### Change the spacecraft

Replace masses, installation positions, battery capacity, solar-array parameters, device power, thermal parameters, storage capacity, payload data rates, and communication parameters.

### Add a new device

Create a new component under `Components/`, expose the appropriate domain interfaces, connect it to a subsystem, and then integrate the subsystem with the overall networks.

### Increase model fidelity

Replace simplified models progressively:

```text
equivalent power load      → detailed electrical model
lumped thermal capacity    → detailed thermal network
low-order attitude model   → higher-fidelity dynamics and control
fixed data rate            → dynamic link-budget model
```

### Integrate new software or algorithms

Users can extend the mission planner, state machine, GNC algorithms, telemetry mapping, or connect external programs through Modelica-supported external functions and FMI/FMU workflows when supported by the selected toolchain.

### Extend safety analysis

The nominal spacecraft model can be extended with component faults, degraded modes, protection logic, safe-mode transitions, fault injection, recovery logic, and safety-analysis assets.

---

## 8. Two important sources of inspiration

### 8.1 Spacecraft system-level simulation with mechanical-electrical-thermal-information coupling

A major methodological inspiration is:

> **Peng Kun, Wang Yan, Li Zhi, Weng Fangjing, Jia Yuchen. Research on System-level Distributed Simulation Method for Spacecraft Considering the Coupling of Mechanical, Electrical, Thermal, and Information Systems. Journal of Astronautics, 2025, 46(9): 1896-1905.**  
> DOI: [10.3873/j.issn.1000-1328.2025.09.016](https://doi.org/10.3873/j.issn.1000-1328.2025.09.016)  
> Article: <https://www.spacejournal.cn/yhxb/article/doi/10.3873/j.issn.1000-1328.2025.09.016>

The paper proposes a **1 + 4 + N** spacecraft simulation architecture and emphasizes device-level multidisciplinary modeling and mechanical-electrical-thermal-information coupling.

OneSatSim adopts the ideas of hierarchical organization, device-level multi-domain modeling, and system-level coupling, but does **not** replicate the paper's distributed execution architecture. The current OneSatSim baseline integrates the four overall networks and eight subsystems into one Modelica simulation model.

### 8.2 ASRTU-1 open-source onboard computer software

Another important engineering reference is the open-source onboard computer software of **ASRTU-1 (ASRTU Friendship MicroSat)** developed by the **LilacSat Student Satellite Team at Harbin Institute of Technology**.

- OpenLilacSat: <https://gitee.com/openlilacsat>
- ASRTU-1 OBC Software: <https://gitee.com/openlilacsat/ASRTU-1_OBC_Software>

The public software includes mission scheduling, interfaces to attitude control, power management, fault handling, and ground-command functions. It provides a valuable real-world reference for understanding how mission logic, device states, and onboard engineering information can be organized in a student satellite.

OneSatSim is **not** a Modelica translation of the ASRTU-1 flight software and does not claim to reproduce the flight code line by line. The project mainly draws inspiration from its engineering organization, public system information, state-interface concepts, and open-source spirit.

---

## 9. Scope and limitations

OneSatSim is a **system-level engineering simulation framework**.

It is not a substitute for:

- flight software;
- component qualification models;
- thermal-vacuum testing;
- structural FEM;
- CFD;
- electromagnetic simulation;
- RF circuit-level simulation;
- spacecraft environmental testing;
- flight certification.

Reference data, engineering assumptions, configuration parameters, and simulation results should always be distinguished clearly.

---

## 10. Acknowledgements

Special thanks to the **Zhilian Xingyu Student Society of Dalian University of Technology (大连理工大学智连星宇学社)** for supporting the related work.

We also acknowledge the communities and teams behind:

- Modelica;
- OpenModelica;
- MWORKS / Tongyuan;
- the referenced *Journal of Astronautics* research;
- the HIT LilacSat / OpenLilacSat team;
- JPL, IERS, and the maintainers of the scientific data and open-source dependencies used by the project.

---

## 11. Technical report

For detailed model descriptions, implementation notes, simulation results, and engineering interpretation, see:

**[System-Level Modeling and Simulation of a 12U CubeSat with Modelica / 基于 Modelica 的 12U 立方星总体建模与仿真实现说明](./基于modelica的12U立方星总体建模与仿真实现说明.html)**

---

## 12. Contributing

Contributions are welcome in areas such as:

- new spacecraft cases;
- new component models;
- higher-fidelity subsystem models;
- mission-planning algorithms;
- fault and safety models;
- Modelica-tool compatibility;
- visualization and post-processing;
- educational examples.

Repository:

<https://github.com/Ruizhe-Yang/OneSatSim>

---

<div align="center">

**OneSatSim — Put the satellite mission, physics, software logic, and resources on one timeline.**

**OneSatSim —— 把卫星任务、物理状态、软件逻辑与资源约束放到同一条时间轴上。**

</div>
