# 追赶能力后续补齐

本轮用户明确要求“先跳过真机验收”。没有设备签名、生产 Matrix 操作、真实转账或用户实验；原 `production-evidence.json` 的测量字段继续为 null。

## 代码完成项

1. 全范围未读提及/直接回复：`MatrixUnreadAttention` 从服务器最新事件按分页顺序扫描到 `fullyRead`，按事件 ID 解析本人原消息，过滤编辑回退、阅后即焚及撤回；空分页继续推进。读标记缺失、无法解密、重复游标或账号/读标记/最新事件变化不会返回假“完整”。退出页面后停止继续扫描。会话提及入口使用该结果，静音群不因通知设置丢失匹配。
2. 受控历史补发：`IChatCatchUpRepository` 与 Matrix 数据适配器提供策略、预览、确认、恢复和对账。默认关闭，只接受管理员及普通文本。界面确认接收人、消息数量、时间范围和每条正文。重新获取 canonical 事件并检查指纹，严格拒绝正文/权限/策略/成员变化。仅向两人加密私聊发送重新加密后的选中正文，群内只发布无正文的审计。强制轮换目标会话的发送密钥，不导出源历史密钥。未知发送结果绝不当失败自动重试。
3. Apple 系统行动：宿主接入 iOS 27+ SuggestedActionsView，添加官方 entitlement，支持系统可用的 Calendar/Reminders/Maps 建议。Flutter 在用户确认前只发送无正文的能力探测；确认后最多提供一条 4,096 字符的非阅后即焚文本和最小元数据。无历史上下文、地址簿或钱包能力。旧系统和其他宿主继续使用本地 ISO 时间规则。
4. SDK 边界：同步状态改为领域枚举，账号操作来源改为不暴露 token/client 的能力对象。UI 的直接 SDK 导入由 13 减少为 9；保留账号切换和举报迟到结果测试。剩余页面不是本次整体重写目标。
5. 旧截图失败：确认浅色 4 像素、深色 6 像素，最大通道差值 2/3，位置属于图标边缘抗锯齿。使用既定 Flutter 3.47.5 更新并严格比较，无容差放宽。

## 官方 API 核实

[Apple Suggested Actions](https://developer.apple.com/documentation/suggestedactions?changes=_2)说明设备端分析和消息旁建议；[entitlement 文档](https://developer.apple.com/documentation/bundleresources/entitlements/com.apple.developer.suggested-actions)明确键名。另直接读取本机 iPhoneOS 27.1 SDK 的公开 Swift interface，核对 Message、Participant、View 的签名和 iOS 27.0 availability。没有根据推测编写未核实 API。

## 验证边界

协议测试使用 mock Matrix 服务与密文占位夹具，不是实际端到端加密或真实服务器验收。10,000 事件用例证明分页/读边界逻辑，不证明 20 人真实群的延迟、消息无丢失或密钥恢复率。Swift 编译与模拟器构建不证明 entitlement 已获分发签名支持。完整结果、宿主 pin 与日志在收尾记录中追加。


## 本轮模块验证结果

- 最终完整 Chat 回归：7,749 passed、4 skipped、0 failed，exit 0。
- 新增历史协议/未读扫描测试：11 项；另有历史选择确认和系统行动隐私组件测试 2 项。全部包含在完整回归中，不重复累加。
- SDK 适配相关定向组合：53 项通过。最终新增/修改服务及页面定向静态分析：No issues found。全量分析无 error/warning（仅既有 info；较早日志中的新增 test Map 推断 warning 已修复）。
- SDK 边界门禁：9 个既有 presentation 直接导入、0 个新增；两个 Python 门禁测试组通过。
- Swift 原生组件使用 Xcode 27.1/iOS 27.1 SDK、iOS 16 部署目标进行 typecheck，通过。系统接口使用 iOS 27 availability 分支；不代表已取得签名和真实系统建议效果。
- 旧截图基线的数值比较与最终严格 golden 测试均记录于附件。没有放宽截图容差。

日志位于 `follow-up/`，其中 full-tests 是最终全量结果；changed-analyze 为定向分析。宿主原生编译、集成回归与最终 pin 记录在宿主 `docs/testing/chat-catch-up-follow-up-2026-10-30.md`。
