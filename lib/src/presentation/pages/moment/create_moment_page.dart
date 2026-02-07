import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/moment_entity.dart';
import '../../blocs/moment/moment_bloc.dart';
import '../../blocs/moment/moment_event.dart';
import '../../blocs/moment/moment_state.dart';

/// 发布动态页面
class CreateMomentPage extends StatefulWidget {
  const CreateMomentPage({super.key});

  @override
  State<CreateMomentPage> createState() => _CreateMomentPageState();
}

class _CreateMomentPageState extends State<CreateMomentPage> {
  final TextEditingController _contentController = TextEditingController();
  final List<_MediaItem> _selectedMedia = [];
  MomentLocation? _location;
  MomentVisibility _visibility = MomentVisibility.public;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = S.of(context);

    return BlocListener<MomentBloc, MomentState>(
      listenWhen: (previous, current) =>
          previous.isPosting && !current.isPosting,
      listener: (context, state) {
        if (!state.hasError) {
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Error')),
          );
        }
      },
      child: Scaffold(
        backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
        appBar: AppBar(
          title: const Text('Create Moment'),
          backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
          actions: [
            BlocBuilder<MomentBloc, MomentState>(
              builder: (context, state) {
                if (state.isPosting) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                return TextButton(
                  onPressed: _canPost() ? _postMoment : null,
                  child: Text(
                    s?.commonSend ?? 'Post',
                    style: TextStyle(
                      color: _canPost()
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 文字输入
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _contentController,
                  maxLines: 5,
                  maxLength: 500,
                  decoration: InputDecoration(
                    hintText: "What's on your mind?",
                    border: InputBorder.none,
                    counterStyle: TextStyle(
                      color: isDark ? Colors.grey[500] : Colors.grey[600],
                    ),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),

              const SizedBox(height: 16),

              // 已选择的媒体
              if (_selectedMedia.isNotEmpty) ...[
                _buildMediaPreview(isDark),
                const SizedBox(height: 16),
              ],

              // 操作按钮
              Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    _buildOptionTile(
                      icon: Icons.photo_library,
                      title: 'Add Photos',
                      onTap: _pickImages,
                      isDark: isDark,
                    ),
                    Divider(
                      height: 1,
                      color: isDark ? AppColors.dividerDark : AppColors.divider,
                    ),
                    _buildOptionTile(
                      icon: Icons.videocam,
                      title: 'Add Video',
                      onTap: _pickVideo,
                      isDark: isDark,
                    ),
                    Divider(
                      height: 1,
                      color: isDark ? AppColors.dividerDark : AppColors.divider,
                    ),
                    _buildOptionTile(
                      icon: Icons.location_on,
                      title: _location?.displayText ?? 'Add Location',
                      onTap: _selectLocation,
                      isDark: isDark,
                      trailing: _location != null
                          ? IconButton(
                              icon: const Icon(Icons.close, size: 20),
                              onPressed: () => setState(() => _location = null),
                            )
                          : null,
                    ),
                    Divider(
                      height: 1,
                      color: isDark ? AppColors.dividerDark : AppColors.divider,
                    ),
                    _buildOptionTile(
                      icon: Icons.visibility,
                      title: _getVisibilityText(s),
                      onTap: _selectVisibility,
                      isDark: isDark,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaPreview(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Selected Media (${_selectedMedia.length})',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => setState(() => _selectedMedia.clear()),
                child: const Text('Clear All'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: _selectedMedia.length,
            itemBuilder: (context, index) {
              final media = _selectedMedia[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                      media.bytes,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (media.isVideo)
                    const Center(
                      child: Icon(
                        Icons.play_circle_filled,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedMedia.removeAt(index)),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isDark,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: isDark ? Colors.grey[400] : Colors.grey[600]),
      title: Text(
        title,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      trailing: trailing ?? Icon(
        Icons.chevron_right,
        color: isDark ? Colors.grey[600] : Colors.grey[400],
      ),
      onTap: onTap,
    );
  }

  String _getVisibilityText(S? s) {
    switch (_visibility) {
      case MomentVisibility.public:
        return 'Public';
      case MomentVisibility.private:
        return 'Private';
      case MomentVisibility.partial:
        return 'Selected Friends';
      case MomentVisibility.excluded:
        return 'Exclude Some Friends';
    }
  }

  bool _canPost() {
    return _contentController.text.trim().isNotEmpty || _selectedMedia.isNotEmpty;
  }

  Future<void> _pickImages() async {
    final images = await _picker.pickMultiImage(
      maxWidth: 1920,
      maxHeight: 1920,
      imageQuality: 85,
    );

    if (images.isNotEmpty) {
      for (final image in images) {
        if (_selectedMedia.length >= 9) break;

        final bytes = await image.readAsBytes();
        setState(() {
          _selectedMedia.add(_MediaItem(
            bytes: bytes,
            filename: image.name,
            mimeType: image.mimeType,
            isVideo: false,
          ));
        });
      }
    }
  }

  Future<void> _pickVideo() async {
    final video = await _picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(minutes: 5),
    );

    if (video != null) {
      final bytes = await video.readAsBytes();
      setState(() {
        _selectedMedia.clear();
        _selectedMedia.add(_MediaItem(
          bytes: bytes,
          filename: video.name,
          mimeType: video.mimeType,
          isVideo: true,
        ));
      });
    }
  }

  Future<void> _selectLocation() async {
    // TODO: 实现位置选择
    // 暂时使用模拟数据
    setState(() {
      _location = const MomentLocation(
        latitude: 39.9042,
        longitude: 116.4074,
        name: 'Beijing',
      );
    });
  }

  void _selectVisibility() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.public),
              title: const Text('Public'),
              subtitle: const Text('All friends can see'),
              trailing: _visibility == MomentVisibility.public
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: () {
                setState(() => _visibility = MomentVisibility.public);
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Private'),
              subtitle: const Text('Only you can see'),
              trailing: _visibility == MomentVisibility.private
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: () {
                setState(() => _visibility = MomentVisibility.private);
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('Selected Friends'),
              subtitle: const Text('Choose who can see'),
              trailing: _visibility == MomentVisibility.partial
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: () {
                setState(() => _visibility = MomentVisibility.partial);
                Navigator.pop(ctx);
                // TODO: 选择好友
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_off),
              title: const Text('Exclude Some Friends'),
              subtitle: const Text('Hide from specific friends'),
              trailing: _visibility == MomentVisibility.excluded
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: () {
                setState(() => _visibility = MomentVisibility.excluded);
                Navigator.pop(ctx);
                // TODO: 选择排除的好友
              },
            ),
          ],
        ),
      ),
    );
  }

  void _postMoment() {
    final bloc = context.read<MomentBloc>();

    if (_selectedMedia.isEmpty) {
      // 纯文字动态
      bloc.add(PostTextMoment(
        content: _contentController.text.trim(),
        location: _location,
        visibility: _visibility,
      ));
    } else if (_selectedMedia.first.isVideo) {
      // 视频动态
      final video = _selectedMedia.first;
      bloc.add(PostVideoMoment(
        content: _contentController.text.trim().isEmpty
            ? null
            : _contentController.text.trim(),
        videoBytes: video.bytes,
        filename: video.filename,
        mimeType: video.mimeType,
        location: _location,
        visibility: _visibility,
      ));
    } else {
      // 图片动态
      final images = _selectedMedia
          .map((m) => MomentImageInput(
                bytes: m.bytes,
                filename: m.filename,
                mimeType: m.mimeType,
              ))
          .toList();

      bloc.add(PostImageMoment(
        content: _contentController.text.trim().isEmpty
            ? null
            : _contentController.text.trim(),
        images: images,
        location: _location,
        visibility: _visibility,
      ));
    }
  }
}

/// 媒体项
class _MediaItem {
  final Uint8List bytes;
  final String filename;
  final String? mimeType;
  final bool isVideo;

  const _MediaItem({
    required this.bytes,
    required this.filename,
    this.mimeType,
    required this.isVideo,
  });
}
