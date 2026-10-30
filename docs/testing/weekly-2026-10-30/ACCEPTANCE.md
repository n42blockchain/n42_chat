# 2026-10-30 Chat 追赶能力验收

## 生产能力矩阵

“有源码”仅证明路径存在；“宿主源码接入”不等于新构建或发布。本轮宿主集成的准确提交及依赖解析记录见宿主 `docs/testing/chat-catch-up-2026-10-30.md`。

| 场景 | 模块代码 | 示例宿主 | iOS/Android 宿主源码 | 受控设备测试 | 本轮生产发布 |
| --- | --- | --- | --- | --- | --- |
| 多设备登录/同步 | 存在 | 本轮未运行 | 已有初始化接入 | 未执行 3 设备实验 | 未发布 |
| E2EE 群聊/设备撤销 | 存在；发送守卫保留 | 本轮未运行 | enableEncryption=true | 未检查撤销后密钥投递 | 未发布 |
| 密钥备份恢复 | 存在 | 本轮未运行 | 安全设置/恢复入口存在 | 未执行 30/30 恢复 | 未发布 |
| 推送 | 存在 | 本轮未运行 | 配置 m.si46.world 网关 | 未检查前后台/终止状态及服务端日志 | 未发布 |
| 聊天内转账 | 已有桥与确认测试 | 本轮未运行 | 钱包桥已接入 | 未签名/广播/验收资金流 | 未发布 |
| 永久置顶 | 既有 Matrix state，无期限字段 | 未运行 | 通过 Chat 依赖提供 | 未做双端同步 | 未发布 |
| 追赶面板/提及筛选 | 本轮新增；有单元/组件测试 | 未运行 | 更新 pin 后提供 | 未做真实用户实验 | 未发布 |
| 本地日历建议 | 本轮新增；本地规则+确认 | 无原生桥运行证据 | 已有 EventKit/Android ACTION_INSERT 编辑器 | 未做双平台真实保存/取消 | 未发布 |
| 受控历史补发 | 未实现 | 不适用 | 不适用 | 未执行 | 未发布 |

## 信任边界

宿主 `lib/core/app/chat_initialization.dart` 实际默认 homeserver 为 `https://m.si46.world`，推送地址为同域 `/_matrix/push/v1/notify`，不是 README 中的公共示例。配置只证明客户端目标地址，不证明服务器部署版本、日志策略或安全性。没有读取或复制登录令牌、备份密钥、推送 token。

加密正文应在设备解密；服务器仍可见传输元数据。密钥备份须独立核对服务端保存的密文、恢复凭证管理和用户验证过程。推送 payload/网关日志不能由前台 E2EE 单测推断安全。钱包消息及日历建议没有签名权限；真实签名界面仍须显示网络、资产、金额、地址和费用。

## 可复现命令

使用 Flutter 3.47.5 / Dart 3.13 工具链。日志是本机自动化证据，不能代替上表设备与生产列。

```sh
flutter test --no-pub test/unit/services/chat_catch_up_test.dart test/unit/services/local_calendar_suggestion_test.dart test/unit/datasources/matrix_group_datasource_test.dart test/widget/
flutter analyze --no-pub --no-fatal-infos
python3 tool/architecture/check_matrix_boundary.py
python3 -m unittest discover -s tool/architecture -p 'test_*.py'
python3 -m unittest discover -s tool/production_acceptance -p 'test_*.py'
python3 tool/production_acceptance/check.py docs/testing/weekly-2026-10-30/production-evidence.json
```

最后一条当前必须非零退出：模板没有真实实验测量值。这是阻止错误宣称验收通过的结果，不是生产测试失败。

## 自动化结果

结果与完整回归边界在本轮收尾时追加。新 UI 仅有英文、简体/繁体中文翻译；其他语言回退英文。完整历史索引、选择性重新加密/审计和 Apple Suggested Actions 并未被这些测试覆盖。

- 完整 Chat 回归：7,732 passed / 4 skipped / 2 failed（`full.log.gz`）。两项均为既有 `chat_core_golden_test.dart` 浅色/深色截图；在未修改的 `a4951b13` 独立工作树复测也失败（`baseline-golden.log.gz`）。未覆盖旧基线或降低比较阈值。
- 针对性回归：置顶载荷 + 追赶规则 + 本地日历 + 确认组件共 23 项通过；另有小屏幕追赶面板测试 1 项通过（`targeted.log.gz`、`sheet.log.gz`）。完整回归启动后增加的这两项置顶/面板测试不计入 7,732。
- `flutter analyze --no-pub --no-fatal-infos`：无 error/warning，首次有 310 条 info。修正新增代码中的 4 条风格提示后，新增服务/组件定向分析为 No issues found（`changed-analyze.log.gz`）。既有 info 不在本轮清理范围。
- SDK 导入门禁通过：13 个既有 presentation 导入，无新增；domain 无直接 Matrix 包导入。Python 门禁测试 4 项通过。生产证据检查按预期拒绝未填写模板。
