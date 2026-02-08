import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/story/story_music_picker.dart';

/// Story creation mode
enum StoryMode {
  text,
  photo,
}

/// Create Story page for posting text or photo stories
class CreateStoryPage extends StatefulWidget {
  const CreateStoryPage({
    super.key,
    this.onPost,
  });

  /// Callback when user posts a story
  /// Parameters:
  /// - content: Text content (for text story) or caption (for photo story)
  /// - imageBytes: Image data (for photo story)
  /// - imageName: Image filename (for photo story)
  /// - backgroundColor: Background color value (for text story)
  /// - textColor: Text color value (for text story)
  /// - musicFilePath: Local path to selected music file
  /// - musicTitle: Music file display name
  final void Function(
    String? content,
    Uint8List? imageBytes,
    String? imageName,
    int? backgroundColor,
    int? textColor, {
    String? musicFilePath,
    String? musicTitle,
  })? onPost;

  @override
  State<CreateStoryPage> createState() => _CreateStoryPageState();
}

class _CreateStoryPageState extends State<CreateStoryPage> {
  StoryMode _mode = StoryMode.text;
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  // Selected image data
  Uint8List? _imageBytes;
  String? _imageName;

  // Color options for text story background
  static const List<_ColorOption> _colorOptions = [
    _ColorOption(
      background: Color(0xFF1A73E8),
      text: Colors.white,
    ),
    _ColorOption(
      background: Color(0xFF34A853),
      text: Colors.white,
    ),
    _ColorOption(
      background: Color(0xFFEA4335),
      text: Colors.white,
    ),
    _ColorOption(
      background: Color(0xFFFBBC04),
      text: Colors.black,
    ),
    _ColorOption(
      background: Color(0xFF9C27B0),
      text: Colors.white,
    ),
    _ColorOption(
      background: Color(0xFF212121),
      text: Colors.white,
    ),
  ];

  int _selectedColorIndex = 0;

  bool _isPosting = false;

  // Selected music
  StoryMusicSelection? _musicSelection;

  @override
  void dispose() {
    _textController.dispose();
    _captionController.dispose();
    super.dispose();
  }

  Color get _currentBackgroundColor =>
      _colorOptions[_selectedColorIndex].background;

  Color get _currentTextColor => _colorOptions[_selectedColorIndex].text;

  bool get _canPost {
    if (_mode == StoryMode.text) {
      return _textController.text.trim().isNotEmpty;
    } else {
      return _imageBytes != null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = S.of(context);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        backgroundColor: _mode == StoryMode.text
            ? _currentBackgroundColor
            : (isDark ? AppColors.surfaceDark : Colors.white),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: _mode == StoryMode.text
                ? _currentTextColor
                : (isDark ? Colors.white : Colors.black),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: _buildModeSelector(isDark),
        centerTitle: true,
        actions: [
          _isPosting
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : TextButton(
                  onPressed: _canPost ? _postStory : null,
                  child: Text(
                    s?.commonSend ?? 'Post',
                    style: TextStyle(
                      color: _canPost
                          ? (_mode == StoryMode.text
                              ? _currentTextColor
                              : Theme.of(context).primaryColor)
                          : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ],
      ),
      body: _mode == StoryMode.text ? _buildTextMode() : _buildPhotoMode(isDark),
    );
  }

  Widget _buildModeSelector(bool isDark) {
    final s = S.of(context);
    final textColor = _mode == StoryMode.text
        ? _currentTextColor
        : (isDark ? Colors.white : Colors.black);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildModeTab(
          label: s?.favoriteText ?? 'Text',
          isSelected: _mode == StoryMode.text,
          textColor: textColor,
          onTap: () => setState(() => _mode = StoryMode.text),
        ),
        const SizedBox(width: 24),
        _buildModeTab(
          label: s?.contactPhotos ?? 'Photo',
          isSelected: _mode == StoryMode.photo,
          textColor: textColor,
          onTap: () => setState(() => _mode = StoryMode.photo),
        ),
      ],
    );
  }

  Widget _buildModeTab({
    required String label,
    required bool isSelected,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isSelected ? textColor : textColor.withOpacity(0.5),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 2,
            width: 24,
            decoration: BoxDecoration(
              color: isSelected ? textColor : Colors.transparent,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextMode() {
    return Container(
      color: _currentBackgroundColor,
      child: Column(
        children: [
          // Text input area
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: TextField(
                  controller: _textController,
                  maxLines: null,
                  maxLength: 200,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _currentTextColor,
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: S.of(context)?.storySendMessageHint ?? 'Type something...',
                    hintStyle: TextStyle(
                      color: _currentTextColor.withOpacity(0.5),
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                    counterStyle: TextStyle(
                      color: _currentTextColor.withOpacity(0.7),
                    ),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ),
          ),

          // Music selection
          _buildMusicBar(),

          // Color picker
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _colorOptions.length,
                (index) => _buildColorOption(index),
              ),
            ),
          ),

          // Bottom safe area
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildColorOption(int index) {
    final color = _colorOptions[index];
    final isSelected = _selectedColorIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedColorIndex = index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color.background,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 3,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
      ),
    );
  }

  Widget _buildPhotoMode(bool isDark) {
    final s = S.of(context);

    return Column(
      children: [
        // Image preview or picker
        Expanded(
          child: _imageBytes != null
              ? _buildImagePreview(isDark)
              : _buildImagePicker(isDark),
        ),

        // Music selection (only show when image is selected)
        if (_imageBytes != null) _buildMusicBar(),

        // Caption input (only show when image is selected)
        if (_imageBytes != null)
          Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).padding.bottom + 16,
              top: 16,
            ),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: TextField(
              controller: _captionController,
              maxLines: 2,
              maxLength: 100,
              decoration: InputDecoration(
                hintText: s?.storySendMessageHint ?? 'Add a caption...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDark ? AppColors.dividerDark : AppColors.divider,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isDark ? AppColors.dividerDark : AppColors.divider,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: isDark
                    ? AppColors.backgroundDark
                    : AppColors.inputBackground,
                counterStyle: TextStyle(
                  color: isDark ? Colors.grey[500] : Colors.grey[600],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildImagePicker(bool isDark) {
    final s = S.of(context);

    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.dividerDark : AppColors.divider,
            width: 2,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add_photo_alternate_outlined,
                  size: 40,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                s?.contactPhotos ?? 'Add Photo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tap to select an image',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview(bool isDark) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Image
        Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.memory(
              _imageBytes!,
              fit: BoxFit.contain,
            ),
          ),
        ),

        // Remove button
        Positioned(
          top: 24,
          right: 24,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _imageBytes = null;
                _imageName = null;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),

        // Change image button
        Positioned(
          bottom: 24,
          left: 0,
          right: 0,
          child: Center(
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.swap_horiz,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Change',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    try {
      final image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          _imageBytes = bytes;
          _imageName = image.name;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick image: $e')),
        );
      }
    }
  }

  void _postStory() {
    if (!_canPost || _isPosting) return;

    setState(() => _isPosting = true);

    final musicPath = _musicSelection?.isEmpty == true ? null : _musicSelection?.filePath;
    final musicTitle = _musicSelection?.isEmpty == true ? null : _musicSelection?.fileName;

    if (_mode == StoryMode.text) {
      widget.onPost?.call(
        _textController.text.trim(),
        null,
        null,
        _currentBackgroundColor.value,
        _currentTextColor.value,
        musicFilePath: musicPath,
        musicTitle: musicTitle,
      );
    } else {
      widget.onPost?.call(
        _captionController.text.trim().isEmpty
            ? null
            : _captionController.text.trim(),
        _imageBytes,
        _imageName,
        null,
        null,
        musicFilePath: musicPath,
        musicTitle: musicTitle,
      );
    }

    // Pop after posting (caller should handle async operations)
    Navigator.of(context).pop();
  }

  Widget _buildMusicBar() {
    final hasMusic = _musicSelection != null && _musicSelection!.isEmpty != true;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: GestureDetector(
        onTap: _showMusicPicker,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _mode == StoryMode.text
                ? Colors.white.withOpacity(0.15)
                : AppColors.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.music_note,
                size: 16,
                color: _mode == StoryMode.text
                    ? _currentTextColor
                    : AppColors.primary,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  hasMusic
                      ? _musicSelection!.fileName
                      : 'Add Music',
                  style: TextStyle(
                    fontSize: 13,
                    color: _mode == StoryMode.text
                        ? _currentTextColor
                        : AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (hasMusic) ...[
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () {
                    setState(() => _musicSelection = null);
                  },
                  child: Icon(
                    Icons.close,
                    size: 14,
                    color: _mode == StoryMode.text
                        ? _currentTextColor.withOpacity(0.7)
                        : Colors.red,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showMusicPicker() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StoryMusicPicker(
        currentMusicPath: _musicSelection?.filePath,
        onMusicSelected: (selection) {
          setState(() => _musicSelection = selection);
          Navigator.of(context).pop();
        },
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }
}

/// Color option for text story background
class _ColorOption {
  const _ColorOption({
    required this.background,
    required this.text,
  });

  final Color background;
  final Color text;
}
