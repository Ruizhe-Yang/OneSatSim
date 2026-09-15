# OneSatSim 设计配置更新报告

- 场景名称：`OneSatSim_DefaultDesign`
- 参数表：`DesignConfig.xlsx`
- 组件参数：454
- Excel 显式覆盖：0
- 参数映射：454/454 PASS
- 配置生成文件变化：0
- 机械质量属性：审计并生成
- UTC区间：`2026-09-06T00:00:00.000Z` → `2026-09-07T00:00:00.000Z`
- 状态输入：`Cartesian / GCRS`，状态历元 `2026-09-06T00:00:00.000Z`
- 环境传播：`J2SunMoon`，环境采样 2.5 s
- EOP状态：`PREDICTED`
- 环境插值最大误差：位置 0.00926042 m；速度 0.0199649 m/s；地球定向 0.00752872 arcsec

## 生成文件


## 警告

- 无

## 下一步

在 OpenModelica/OMEdit 中运行 `OneSatSim.Simulation.CompleteMission`。配置更新工具不会自动启动 MWorks，也不会自动运行24 h仿真。
