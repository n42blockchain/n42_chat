import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';
import '../../widgets/common/common_widgets.dart';

/// 个人资料编辑页面
/// 
/// 微信风格的个人资料设置页面
class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final ImagePicker _imagePicker = ImagePicker();
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = state.user;
        
        return Scaffold(
          backgroundColor: isDark ? AppColors.backgroundDark : const Color(0xFFF5F5F5),
          appBar: N42AppBar(
            title: '个人资料',
            backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
          ),
          body: ListView(
            children: [
              const SizedBox(height: 10),
              
              // 基本信息区块
              _buildSection(
                isDark: isDark,
                children: [
                  // 头像
                  _buildListTile(
                    isDark: isDark,
                    title: '头像',
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_isUploading)
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        else
                          N42Avatar(
                            name: user?.displayName ?? '',
                            imageUrl: user?.avatarUrl,
                            size: 60,
                          ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.chevron_right,
                          color: AppColors.textTertiary,
                        ),
                      ],
                    ),
                    onTap: _pickAvatar,
                  ),
                  _buildDivider(isDark),
                  
                  // 名字
                  _buildListTile(
                    isDark: isDark,
                    title: '名字',
                    value: user?.displayName ?? '未设置',
                    onTap: () => _editDisplayName(user?.displayName),
                  ),
                  _buildDivider(isDark),
                  
                  // 性别
                  _buildListTile(
                    isDark: isDark,
                    title: '性别',
                    value: _getGenderText(user?.gender),
                    onTap: _selectGender,
                  ),
                  _buildDivider(isDark),
                  
                  // 地区
                  _buildListTile(
                    isDark: isDark,
                    title: '地区',
                    value: user?.region ?? '未设置',
                    onTap: _selectRegion,
                  ),
                ],
              ),
              
              const SizedBox(height: 10),
              
              // 账号信息区块
              _buildSection(
                isDark: isDark,
                children: [
                  // N42号
                  _buildListTile(
                    isDark: isDark,
                    title: 'N42号',
                    value: user?.userId ?? '',
                    showArrow: false,
                  ),
                  _buildDivider(isDark),
                  
                  // 我的二维码
                  _buildListTile(
                    isDark: isDark,
                    title: '我的二维码',
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.qr_code,
                          size: 20,
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.chevron_right,
                          color: AppColors.textTertiary,
                        ),
                      ],
                    ),
                    onTap: () => _showMyQRCode(user?.userId ?? ''),
                  ),
                ],
              ),
              
              const SizedBox(height: 10),
              
              // 其他信息区块
              _buildSection(
                isDark: isDark,
                children: [
                  // 拍一拍
                  _buildListTile(
                    isDark: isDark,
                    title: '拍一拍',
                    value: user?.pokeText ?? '你',
                    onTap: _editPokeText,
                  ),
                  _buildDivider(isDark),
                  
                  // 签名
                  _buildListTile(
                    isDark: isDark,
                    title: '签名',
                    value: user?.signature ?? '未设置',
                    onTap: () => _editSignature(user?.signature),
                  ),
                ],
              ),
              
              const SizedBox(height: 10),
              
              // 更多设置区块
              _buildSection(
                isDark: isDark,
                children: [
                  // 来电铃声
                  _buildListTile(
                    isDark: isDark,
                    title: '来电铃声',
                    value: '默认',
                    onTap: _selectRingtone,
                  ),
                ],
              ),
              
              const SizedBox(height: 10),
              
              // 地址与发票区块
              _buildSection(
                isDark: isDark,
                children: [
                  // 我的地址
                  _buildListTile(
                    isDark: isDark,
                    title: '我的地址',
                    onTap: _manageAddresses,
                  ),
                  _buildDivider(isDark),
                  
                  // 我的发票抬头
                  _buildListTile(
                    isDark: isDark,
                    title: '我的发票抬头',
                    onTap: _manageInvoices,
                  ),
                ],
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection({
    required bool isDark,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildListTile({
    required bool isDark,
    required String title,
    String? value,
    Widget? trailing,
    VoidCallback? onTap,
    bool showArrow = true,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            if (trailing != null)
              trailing
            else ...[
              if (value != null)
                Flexible(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                  ),
                ),
              if (showArrow) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.textTertiary,
                  size: 20,
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Divider(
        height: 1,
        color: isDark ? AppColors.dividerDark : AppColors.divider,
      ),
    );
  }

  String _getGenderText(String? gender) {
    switch (gender) {
      case 'male':
        return '男';
      case 'female':
        return '女';
      default:
        return '未设置';
    }
  }

  Future<void> _pickAvatar() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('拍照'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('从相册选择'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.close),
              title: const Text('取消'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );

      if (image == null) return;

      setState(() => _isUploading = true);

      final bytes = await image.readAsBytes();
      
      // 上传头像
      context.read<AuthBloc>().add(UpdateAvatar(
        avatarBytes: bytes,
        filename: image.name,
      ));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('头像上传成功')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('头像上传失败: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  Future<void> _editDisplayName(String? currentName) async {
    final controller = TextEditingController(text: currentName);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('修改名字'),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLength: 20,
          decoration: const InputDecoration(
            hintText: '请输入昵称',
            counterText: '',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('确定'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty && result != currentName) {
      context.read<AuthBloc>().add(UpdateDisplayName(result));
    }
  }

  Future<void> _selectGender() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('男', textAlign: TextAlign.center),
              onTap: () => Navigator.pop(context, 'male'),
            ),
            const Divider(height: 1),
            ListTile(
              title: const Text('女', textAlign: TextAlign.center),
              onTap: () => Navigator.pop(context, 'female'),
            ),
            const Divider(height: 1),
            ListTile(
              title: const Text('取消', textAlign: TextAlign.center),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );

    if (result != null) {
      // TODO: 更新性别
      _showFeatureToast('性别设置');
    }
  }

  Future<void> _selectRegion() async {
    // TODO: 实现地区选择器
    _showFeatureToast('地区选择');
  }

  Future<void> _editPokeText() async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('设置拍一拍'),
        content: Row(
          children: [
            const Text('朋友拍了拍我'),
            Expanded(
              child: TextField(
                controller: controller,
                autofocus: true,
                maxLength: 10,
                decoration: const InputDecoration(
                  hintText: '的肩膀',
                  counterText: '',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('确定'),
          ),
        ],
      ),
    );

    if (result != null) {
      // TODO: 更新拍一拍文字
      _showFeatureToast('拍一拍设置');
    }
  }

  Future<void> _editSignature(String? currentSignature) async {
    final controller = TextEditingController(text: currentSignature);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('修改签名'),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLength: 50,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: '一句话介绍自己',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('确定'),
          ),
        ],
      ),
    );

    if (result != null && result != currentSignature) {
      // TODO: 更新签名
      _showFeatureToast('签名设置');
    }
  }

  Future<void> _showMyQRCode(String userId) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '我的二维码',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: QrImageView(
                  data: 'n42chat:user:$userId',
                  version: QrVersions.auto,
                  size: 200,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                userId,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '扫一扫上面的二维码，加我为好友',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectRingtone() async {
    _showFeatureToast('来电铃声');
  }

  Future<void> _manageAddresses() async {
    _showFeatureToast('地址管理');
  }

  Future<void> _manageInvoices() async {
    _showFeatureToast('发票抬头');
  }

  void _showFeatureToast(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature功能开发中...'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

