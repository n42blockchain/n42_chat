import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/user_profile_entity.dart';
import '../../widgets/common/common_widgets.dart';

/// 编辑资料页面
class EditProfilePage extends StatefulWidget {
  final UserProfileEntity profile;
  final Function(String displayName, File? avatar)? onSave;

  const EditProfilePage({
    super.key,
    required this.profile,
    this.onSave,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _displayNameController;
  late TextEditingController _statusController;
  File? _selectedAvatar;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _displayNameController = TextEditingController(
      text: widget.profile.displayName,
    );
    _statusController = TextEditingController(
      text: widget.profile.statusMessage,
    );
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final result = await showModalBottomSheet<XFile?>(
      context: context,
      builder: (context) => _AvatarPickerSheet(
        onCamera: () async {
          final image = await picker.pickImage(source: ImageSource.camera);
          Navigator.pop(context, image);
        },
        onGallery: () async {
          final image = await picker.pickImage(source: ImageSource.gallery);
          Navigator.pop(context, image);
        },
      ),
    );

    if (result != null) {
      setState(() {
        _selectedAvatar = File(result.path);
      });
    }
  }

  Future<void> _save() async {
    if (_displayNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入昵称')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await widget.onSave?.call(
        _displayNameController.text.trim(),
        _selectedAvatar,
      );
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('保存失败: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: N42AppBar(
        title: '编辑资料',
        onBackPressed: () => Navigator.pop(context),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _save,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    '保存',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 24),

          // 头像
          Center(
            child: GestureDetector(
              onTap: _pickAvatar,
              child: Stack(
                children: [
                  if (_selectedAvatar != null)
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(_selectedAvatar!),
                    )
                  else
                    N42Avatar(
                      imageUrl: widget.profile.avatarUrl,
                      name: widget.profile.effectiveDisplayName,
                      size: 100,
                    ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark ? AppColors.surfaceDark : AppColors.surface,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),

          // 表单
          Container(
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // 昵称
                _FormField(
                  label: '昵称',
                  controller: _displayNameController,
                  placeholder: '请输入昵称',
                  isDark: isDark,
                ),

                Divider(
                  color: isDark ? AppColors.dividerDark : AppColors.divider,
                ),

                // 签名
                _FormField(
                  label: '签名',
                  controller: _statusController,
                  placeholder: '添加个性签名',
                  isDark: isDark,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 用户ID（只读）
          Container(
            color: isDark ? AppColors.surfaceDark : AppColors.surface,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  'Matrix ID',
                  style: TextStyle(
                    fontSize: 15,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.profile.userId,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 表单字段
class _FormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? placeholder;
  final bool isDark;

  const _FormField({
    required this.label,
    required this.controller,
    this.placeholder,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15,
                color: isDark ? Colors.white : AppColors.textPrimary,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 15,
                color: isDark ? Colors.white : AppColors.textPrimary,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

/// 头像选择器
class _AvatarPickerSheet extends StatelessWidget {
  final VoidCallback? onCamera;
  final VoidCallback? onGallery;

  const _AvatarPickerSheet({
    this.onCamera,
    this.onGallery,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('拍照'),
              onTap: onCamera,
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('从相册选择'),
              onTap: onGallery,
            ),
            const SizedBox(height: 8),
            N42Button.text(
              text: '取消',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

