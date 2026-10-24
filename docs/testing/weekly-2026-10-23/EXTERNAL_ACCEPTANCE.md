# 设备、媒体与线下试点验收步骤

## 媒体基线

文件路径/流现用磁盘流式加密，能力上限1GiB，实际取客户端配置与服务器限额较小值；未知服务器限额回退50MiB。内存/定时附件仍限50MiB。文本预览最多2MiB。Markdown以16,384 UTF-16字符分页，复杂表格/代码块可能跨页；可切换源文、确认打开HTTPS链接、点击加载单图，默认不请求远程资源，HTML不进入WebView。预览计时为内容到达后首个Flutter frame，不能当成下载总时间。

大文件真机验收：在隔离加密房间选择64MiB、服务器限额内及超限文件；核对收件端文件SHA-256，检查媒体服务器只收到密文，记录临时磁盘空间、内存及取消/退出后的文件清理。增加配额需要服务端独立配置，不把客户端1GiB上限当作服务器已开放。

复现本地图片基线（使用仓库要求的 Flutter/Dart 版本）：

```sh
dart run tool/weekly_benchmark/generate_image_corpus.dart /tmp/n42-media-corpus
N42_MEDIA_CORPUS=/tmp/n42-media-corpus flutter test --no-pub test/benchmarks/media_decode_baseline_test.dart
python3 -m unittest discover -s tool/weekly_benchmark -p 'test_*.py'
```

生成 200 个 PNG RGB/RGBA、JPEG、GIF、BMP 样本，包含尺寸、字节数和 SHA-256 manifest。结果写入 corpus 的 `decode-results.json`。这些是合成静态图，不能代替视频、实际相机、HDR/P3、动画、畸形媒体或移动设备。

下一阶段实际样本：JPEG/PNG/WebP/HEIC、透明/动画图，H.264/HEVC/VP9/AV1 视频，sRGB/Display-P3/BT.2020，横竖屏、4K、0字节、截断/损坏、超限文件；至少200个有许可、去身份化的文件。分别记录编码/容器/色彩空间/尺寸/方向/时长/字节数与哈希。使用 iOS、Android 的 release/profile 构建与真实 Matrix 测试房间，分别测 Wi-Fi、弱网、断网恢复、前后台和加密房间。

记录上传成功率、转码失败率、首帧时间、进程峰值RSS、网络字节、参考图色差。服务端转码必须来自服务端日志；若该链路不转码，填写“不适用”，不能把客户端 send 时间伪装成转码时间。生产失败率 <0.1% 要有足够样本和置信区间；200个零失败时单侧95%上限约1.49%，不能验收0.1%。

宿主显式订阅 `MediaTelemetry.onEvent` 才接收新遥测。事件只有随机 operationId/eventId、stage、outcome、耗时和字节，不包含URL、文件名、房间、用户或正文。SDK内部加密上传只有外层 `send`，不能假设它有独立的 `upload` 或 `decrypt` 事件；手工上传、SDK直接图片上传、普通下载、文档下载/解密/预览有对应事件。重试拥有独立eventId；同一操作的阶段共享operationId。传输的字节字段是客户端已知负载大小，不是包含TLS/重试的网络流量。

```sh
python3 tool/weekly_benchmark/summarize.py media media-events.jsonl --expected expected-stages.json
```

独立测试驱动提供 `expected-stages.json`：`[{"operationId":"随机ID","stage":"download"}]`。缺少此清单时漏报率输出 null。汇总脚本按eventId去重，并拒绝冲突重复；输出阶段成功P50/P95、失败/取消、重复率、漏报率及零失败置信上限。

## NFC / QR / 普通链接试点（P2）

客户端已实现扫描页NFC按钮。宿主需要Android NFC权限及可选硬件声明；iOS需要NFCReaderUsageDescription和TAG entitlement，并在Apple开发者配置中启用NFC、重新生成签名描述文件。先用NDEF URI标签写入已登记Mini App的HTTPS基础入口，在扫描页点击NFC后触碰标签，核对服务方确认；再验证取消、后台切换、禁用NFC、双URI标签和无效签名。实体标签与签名构建必须实测，模拟器和单测不能替代。

1. 招募3–5个已在使用聊天服务的真实商户/活动，每家选择一个流程：签到、会员加入或服务入口。取得试点与有限分析同意。每家先完成普通链接/QR基线，再随机分配或交叉平衡NFC/QR/link入口，保持任务、奖励、地点、设备范围一致。
2. NFC与QR都使用同一签名入口协议。无短链服务时不要把未经验证的302重定向当成签名入口。发行/替换目标由强认证后台操作，记录操作人、旧/新服务目标、时间、审批与签名版本；不把个人到店行为上链。
3. 展示可信注册服务方和真实域名，由参与者明确选择打开。后台维护标签资产登记；每日检查实体覆盖/替换。客户端能拒绝伪造签名和非允许域名，但不能单凭合法URL识别实体标签被换成另一个合法商户标签。
4. 故意执行覆盖标签、过期链接、错误域名、复制合法标签和后台目标变更；分别记录哪些被客户端拒绝、哪些需要实体巡检/后台告警。检测率分母仅限预先记录的攻击事件。
5. 每次记录匿名trialId、入口方式、完成与否、进入耗时；七天后才填写复用结果。关联映射仅在受控试点后端短期保留，按同意和最短保留期清理，不记录Matrix ID、钱包地址或聊天正文到分析导出。
6. 访谈每家是否愿意持续使用及原因；至少两家明确愿意继续，并观察NFC完成率相对QR改善。小样本仅作试点描述，不宣称因果提升或全面商业化。

导出JSONL字段：`trialId`、`method` (`nfc`/`qr`/`link`)、`completed` (bool)、`entryMs` (可空)、`reused7d` (bool/未到期null)、`tamperExpected`、`tamperDetected`（可选bool）。商户决策单独以JSON数组提供`pilotId`、`willContinue`。

```sh
python3 tool/weekly_benchmark/summarize.py pilot pilot-events.jsonl --pilots pilot-decisions.json
```

没有真实商户、实体标签及七天观察数据时不生成示范“成功”报表。当前交付为安全复用能力、试点方案和计算工具，试点效果待验收。
