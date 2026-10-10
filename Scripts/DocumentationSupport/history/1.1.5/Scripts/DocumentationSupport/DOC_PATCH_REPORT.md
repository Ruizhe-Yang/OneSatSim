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
