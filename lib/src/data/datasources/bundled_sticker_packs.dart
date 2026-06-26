import '../../domain/entities/sticker_pack_entity.dart';

/// 内置（随包分发）贴纸包
///
/// 这些贴纸以 SVG 资源形式打进 App 包，**收发双方都本地持有**，因此：
/// - 贴纸 `url` 使用 `asset:` scheme 指向打包资源路径（如 `asset:assets/stickers/n42_faces/smile.svg`）；
/// - 发送时不需要上传到 Matrix —— 直接发 `m.sticker` 携带该 `asset:` url + body 文本兜底；
/// - N42 客户端按 id 解析回本地资源用 `SvgPicture.asset` 渲染；非 N42 客户端回退显示 body。
///
/// `emoji` 字段用于搜索与兜底文本。新增/替换品牌素材时改这里 + 对应 SVG 文件即可。
class BundledStickerPacks {
  BundledStickerPacks._();

  /// asset url 前缀
  static const String assetScheme = 'asset:';

  /// 资源根目录
  static const String _root = 'assets/stickers';

  static Sticker _s(String pack, String id, String emoji, String name) {
    return Sticker(
      id: '${pack}_$id',
      url: '$assetScheme$_root/$pack/$id.svg',
      name: name,
      emoji: emoji,
      width: 256,
      height: 256,
      mimeType: 'image/svg+xml',
    );
  }

  /// N42 表情脸贴纸包
  static final StickerPack faces = StickerPack(
    id: 'n42_faces',
    name: 'N42 Faces',
    description: 'Expressive N42 face stickers',
    author: 'N42 Studio',
    source: StickerPackSource.builtin,
    isInstalled: true,
    isOfficial: true,
    stickers: [
      _s('n42_faces', 'smile', '😊', 'Smile'),
      _s('n42_faces', 'grin', '😁', 'Grin'),
      _s('n42_faces', 'laugh', '😂', 'Laugh'),
      _s('n42_faces', 'wink', '😉', 'Wink'),
      _s('n42_faces', 'cool', '😎', 'Cool'),
      _s('n42_faces', 'love', '😍', 'Love'),
      _s('n42_faces', 'think', '🤔', 'Think'),
      _s('n42_faces', 'cry', '😢', 'Cry'),
      _s('n42_faces', 'angry', '😠', 'Angry'),
      _s('n42_faces', 'surprise', '😮', 'Surprise'),
    ],
  );

  /// N42 反应/手势贴纸包
  static final StickerPack reactions = StickerPack(
    id: 'n42_reactions',
    name: 'N42 Reactions',
    description: 'Reactions & gestures',
    author: 'N42 Studio',
    source: StickerPackSource.builtin,
    isInstalled: true,
    isOfficial: true,
    stickers: [
      _s('n42_reactions', 'thumbsup', '👍', 'Thumbs up'),
      _s('n42_reactions', 'thumbsdown', '👎', 'Thumbs down'),
      _s('n42_reactions', 'heart', '❤️', 'Heart'),
      _s('n42_reactions', 'clap', '👏', 'Clap'),
      _s('n42_reactions', 'fire', '🔥', 'Fire'),
      _s('n42_reactions', 'party', '🎉', 'Party'),
      _s('n42_reactions', 'ok', '👌', 'OK'),
      _s('n42_reactions', 'pray', '🙏', 'Pray'),
      _s('n42_reactions', 'rocket', '🚀', 'Rocket'),
      _s('n42_reactions', 'hundred', '💯', 'Hundred'),
    ],
  );

  /// 全部内置包（展示/安装顺序）
  static List<StickerPack> get all => [faces, reactions];

  /// 是否为内置 asset 贴纸
  static bool isAssetSticker(String url) => url.startsWith(assetScheme);

  /// 取出 asset 资源路径（去掉 `asset:` 前缀）
  static String assetPath(String url) =>
      url.startsWith(assetScheme) ? url.substring(assetScheme.length) : url;
}
