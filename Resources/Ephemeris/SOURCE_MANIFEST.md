# 固定星历与地球定向资源

这些文件仅由 `UpdateConfig.bat` 的离线预处理阶段读取。Modelica 仿真阶段读取生成后的 `Resources/Data/GeneratedEphemeris/environment.txt`，不会联网。

| 文件 | 官方来源 | SHA-256 | 用途 |
|---|---|---|---|
| `de440s.bsp` | <https://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/planets/de440s.bsp> | `c1c7feeab882263fc493a9d5a5b2ddd71b54826cdf65d8d17a76126b260a49f2` | JPL DE440s 地球、太阳与月球几何状态 |
| `finals2000A.all` | <https://datacenter.iers.org/data/9/finals2000A.all> | `80119694522717471744a78b28bc872e998523f8b1e2007424f9cd08af7ac4c6` | IERS Bulletin A UT1−UTC、极移及标志 |
| `Leap_Second.dat` | <https://hpiers.obspm.fr/iers/bul/bulc/Leap_Second.dat> | `6cb6f5d4b819f2e568e25db4b0b26d89dedf031fdffb18bc94d40f4e94e268d7` | UTC、TAI、TT、TDB 时间尺度转换所需闰秒表 |

`finals2000A.all` 同时包含观测与预测区段。若所选日期使用预测记录，生成元数据和 Excel 的 `OrbitResolved` 会标记 `PREDICTED`；`AllowPredictedEOP=FALSE` 时生成器会拒绝该区间。

资源不会按系统日期自动刷新。替换任何资源后必须同步更新本清单并重新运行全套配置与精度测试。
