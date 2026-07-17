# 第三方登录支持矩阵（2026-06-27）

n42_chat 登录基于 Matrix（用户名/密码 + SSO + 自定义派生）。三类接入机制：

- **原生 SDK**：App 内拉起原生授权（需各家 client id / 原生配置），拿 token 经
  `loginWithSocialToken` 注入 Matrix。
- **Matrix SSO（OIDC/SAML）**：服务端 `identity_providers` 配好后，App 走统一
  SSO Web 流程（`getSsoProviders` → 浏览器授权 → 回调）。**无需各家原生 SDK，
  兼容性最好**；任意 OIDC 提供方都能接（picker 按 [`SsoBrandClassifier`] 显示品牌图标）。
- **钱包/DID**：钱包对固定消息签名 → 确定性派生 Matrix 用户名+密码
  （[`WalletLoginCredentials`]）登录/注册，无需服务端 SIWE 端点。

## 全球主流前十 + 适用性

| # | 提供方 | 机制 | 现状 | 备注 / 兼容性 |
|---|---|---|---|---|
| 1 | Google | 原生 SDK | ✅ 已接 | `enableGoogleLogin`，Android/iOS/Web；需 client id |
| 2 | Apple | 原生 SDK | ✅ 已接 | `enableAppleLogin`，iOS/macOS（其它平台不出现）|
| 3 | Facebook/Meta | 原生 SDK | ✅ 已接 | `enableFacebookLogin`，需 FB App 配置 |
| 4 | Twitter/X | 原生/OAuth | ✅ 已接 | `enableTwitterLogin`，需 API key/secret |
| 5 | Microsoft (Entra/Azure) | **Matrix SSO** | ✅ 经 SSO | 服务端配 OIDC 即首类显示（蓝窗图标）|
| 6 | GitHub | **Matrix SSO** | ✅ 经 SSO | 服务端配 OIDC 即可（代码图标）|
| 7 | LinkedIn | **Matrix SSO** | ✅ 经 SSO | 服务端配 OIDC 即可 |
| 8 | WeChat 微信 | 原生 SDK | ✅ 已接 | `enableWeChatLogin`，需开放平台配置 |
| 9 | Discord | **Matrix SSO** | ✅ 经 SSO | 服务端配 OIDC 即可（Discord 图标）|
| 10 | Telegram | **Matrix SSO** | ⚠️ 经 SSO（受限）| Telegram 用自有 Login Widget，需服务端桥接为 OIDC |
| + | GitLab | **Matrix SSO** | ✅ 经 SSO | 同上 |
| + | 钱包/DID | 钱包签名 | ✅ 本轮新增 | `enableWalletLogin`，需 `IWalletBridge.signMessage` 确定性签名 |

## 结论

- **能直接接上的都接了**：原生 SDK 五家（Google/Apple/Facebook/Twitter/WeChat）+
  钱包/DID（本轮）+ 通用 SSO（覆盖 Microsoft/GitHub/LinkedIn/Discord/GitLab 等任意
  OIDC 提供方，picker 已带品牌图标）。
- **受限项**：Telegram 无标准 OIDC，需服务端把 Telegram Login Widget 桥接为
  OIDC/SSO 才能纳入；纯客户端无法独立完成。
- **新增原生 SDK 提供方**（如单独 GitHub/Microsoft 原生按钮）价值低：Matrix SSO 已
  覆盖且更易维护（不引入各家 SDK 与密钥）。建议优先用 SSO 扩展，而非堆原生 SDK。

## 安全备注（钱包登录）

确定性派生密码要求钱包签名确定性（ECDSA RFC6979 / personal_sign 满足）。若某钱包
签名非确定性，会导致派生密码变化、账号无法再登录。生产环境更稳的是服务端 SIWE
（验签发 token）；本方案为纯客户端过渡，已在代码注释中标注。

## 统一身份 N42 ID Hub 钱包登录（降级兜底）

新增 `enableIdHubLogin`（默认 `false`）+ `idHubUrl` 两个 `N42ChatConfig` 开关。开启
且 `idHubUrl` 已配、且 hub 的 `POST /v1/auth/wallet/verify`（`aud=chat`）返回 Matrix
凭据时，钱包登录改经 ID Hub 供给 Matrix 账号（`_authRepository.loginWithToken`，与社交
登录同构）。**任何一步不满足**（未启用 / 未配 / hub 不可达 / hub 未返回 Matrix 凭据，
如 Synapse bridge 尚未上线）都静默回退到上面的 `WalletLoginCredentials` 派生 legacy
路径，保住既有聊天历史——这是渐进灰度与回滚的兜底开关。

- 客户端：`data/datasources/remote/id_hub_api.dart`（`IdHubApi` + `IdHubWalletResponse`）。
- 待签消息由 hub 下发（server nonce），钱包对该原文重新 `signMessage` 签名；启用此路径后
  UI 侧原有的预签名变为冗余，应移除以避免二次弹窗（后续跟进项）。
- **双落提醒（D-6）**：`n42appv2` 通过 `pubspec_overrides.yaml` vendored 了本包的一份
  副本（`packages/n42_chat`，且已与独立仓分叉）。本节改动需在独立仓与 vendored 副本
  同步落地；长期应把 vendored 副本迁回 git 依赖以消除分叉。
