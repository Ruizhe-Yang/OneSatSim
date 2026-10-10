# MOSAIC-12UCubeSat v1.1.5

## 本次辅助更新

本版从用户提供的v1.1.4工程生成，补齐按类组织的Documentation与声明字符串说明。Modelica标识符、目录导入方式、实际方程/算法、初态、参数、真实connect、Icon/Diagram及结果选择保持原样。MQ9的中文名称仅进入类说明，不进入代码标识符。

共检查235个.mo文件、235个类定义，其中108个model/block；3617个直接声明字段具有说明。继承MSL字段不复制重定义，其说明继续取标准库。

### 使用Documentation

从本目录package.mo加载工程，进入Simulation.CompleteMission，在建模器的信息/Documentation视图阅读用途、当前组成、接口、参数表达式、显式状态、实现摘录和边界。目录下的Scripts/DocumentationSupport/variable_descriptions.csv可用于查阅字段说明。表格是文档索引，不是新增运行参数源。

### 仿真后结果注释

请重新翻译/编译后按原流程运行，查看结果浏览器的Description/描述列或悬浮信息。新写入的是标准声明string-comment；具体显示和保存由实际引擎、变量过滤、别名消除及界面设置决定。旧MAT文件不会被注释更新自动改写。模型被隐藏或未被原输出合同保存的变量不会因此自动出现。本补丁没有修改HideResult、过滤器、采样或输出量。结果元数据体积可能增加，未实测新的MAT体积。

### 文档持续保留

Scripts/DocumentationSupport保存源级语义说明目录与仅处理注释的生成后处理器。原配置生成入口仅在写出.mo时调用它；配置数值、校验、提交顺序和仿真命令不变。新增类无目录记录时不自动编造业务描述；后续维护应补目录并重新检查。

### 核验边界

所有.mo均做去除Documentation、声明说明及根发布version后的token级一致性检查；图形注解、experiment、Evaluate、uses版本和普通字符串常量仍纳入保护。此静态结果不是完整Modelica语法检查、编译或重新仿真。当前环境未运行OpenModelica/MWorks，也未做GUI显示验证。原数据/工作簿/图片保留原字节。

输入工程的任务验收仍为 PARTIAL：当前启用14目标/4站；8目标/3站及5次成像/5次下传目标仍应按原报告单独核验。用户认可架构符合性，不自动改变这些历史验收状态。

证据：`Scripts/DocumentationSupport/auxiliary_change_ledger.json`、`release_metadata.json`。生成清单仅因辅助文本变化更新对应文件字节指纹，原始清单保留为baseline_generation_manifest.json，不把重新计算哈希说成重新生成数值或运行验证。

---

## 原版本使用资料（历史内容，以上述补丁说明为准）

# MOSAIC-12UCubeSat v1.1.4｜OneSatSim

本目录就是 Modelica 根包 `OneSatSim`，直接打开 `package.mo`；仿真入口为 `OneSatSim.Simulation.CompleteMission`。仅依赖 Modelica Standard Library 4.0.0。任务历元为 2026-10-01 00:00:00 UTC，仿真窗口 0—86400 s。

## 验证状态

**PARTIAL：当前默认场景仍为原任务的 14 个启用目标、4 个启用地面站。** 包名迁移阶段的 24 小时输出与原 v1.1.3 逐点相同；本包进一步完成显式连接、传感器支路清理和图形整理，能够在 OpenModelica 1.25.5 加载、检查和运行 24 小时，但与原任务的严格数值等价门槛未通过。因此，8 目标/3 站的新任务未进行正式 R2 运行，本包不声称满足 5 次有效成像/5 次有效下传的新版任务验收。详见随包交付的中文总结与 Results ZIP。MWorks/Sysplorer 未自动实测。

## 模型与离线配置

设计参数和 34563×16 环境表已固化在 `Scenarios/*.mo`。求解阶段不读取 Excel、JSON、TXT、Python、SPK、IERS 或网络。修改设计输入时编辑 `DesignConfig.xlsx`，再运行 `UpdateConfig.bat`；转换在离线阶段使用 `Scripts/Inputs/Ephemeris/` 中的原始数据，事务式更新生成的 `.mo` 和配置清单。不要把未经验收的 R2 候选配置当作当前默认场景。

## 导入与检查

在建模工具中打开当前目录的 `package.mo`，选择 `OneSatSim.Simulation.CompleteMission`。本机可使用：

```powershell
.\UpdateConfig.bat
python .\Scripts\check_project.py --output .\project_check.json
python .\Scripts\load_package.py
.\RunSimulation.bat --run-kind DIAGNOSTIC --stop 120 --output-interval 1 --reason local-check
```

`Scripts/load_package.py` 和 `Scripts/run_openmodelica.py` 默认均直接加载根 `package.mo`。正式设置保留 1 s 输出间隔、`1e-7` 容差、IDA／SPGMR／`coloredNumerical` 与原线性撕裂设置。正式结果上限为 50,000,000 bytes；构建物、日志和 MAT 存放在工程外的 `work/` 与 `results/` 目录。
