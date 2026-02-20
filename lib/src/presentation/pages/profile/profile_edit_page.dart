import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/di/injection.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../../services/ringtone/system_ringtone_service.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';
import '../../widgets/common/common_widgets.dart';
import 'n42_bean_page.dart';

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
  void initState() {
    super.initState();
    // 加载用户资料数据
    context.read<AuthBloc>().add(const LoadUserProfileData());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        debugPrint('ProfileEditPage: AuthState changed - status: ${state.status}, isUploading: $_isUploading');
        
        // 监听状态变化
        if (_isUploading) {
          if (state.status == AuthStatus.authenticated) {
            debugPrint('ProfileEditPage: Avatar upload succeeded');
            setState(() => _isUploading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context)?.profileAvatarUpdated ?? 'Avatar updated'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state.status == AuthStatus.error) {
            debugPrint('ProfileEditPage: Avatar upload failed - ${state.errorMessage}');
            setState(() => _isUploading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? (S.of(context)?.profileAvatarUploadFailed ?? 'Avatar upload failed')),
                backgroundColor: AppColors.error,
              ),
            );
          }
        }
      },
      builder: (context, state) {
        final user = state.user;
        
        return Scaffold(
          backgroundColor: isDark ? AppColors.backgroundDark : const Color(0xFFF5F5F5),
          appBar: N42AppBar(
            title: S.of(context)?.profilePersonalProfile ?? 'Personal Profile',
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
                    title: S.of(context)?.profileAvatar ?? 'Avatar',
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
                        const Icon(
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
                    title: S.of(context)?.profileName ?? 'Name',
                    value: user?.displayName ?? (S.of(context)?.commonNotSet ?? 'Not Set'),
                    onTap: () => _editDisplayName(user?.displayName),
                  ),
                  _buildDivider(isDark),
                  
                  // 性别
                  _buildListTile(
                    isDark: isDark,
                    title: S.of(context)?.profileGender ?? 'Gender',
                    value: _getGenderText(context, user?.gender),
                    onTap: _selectGender,
                  ),
                  _buildDivider(isDark),
                  
                  // 地区
                  _buildListTile(
                    isDark: isDark,
                    title: S.of(context)?.profileRegion ?? 'Region',
                    value: user?.region ?? (S.of(context)?.commonNotSet ?? 'Not Set'),
                    onTap: _selectRegion,
                  ),
                ],
              ),
              
              const SizedBox(height: 10),
              
              // 账号信息区块
              _buildSection(
                isDark: isDark,
                children: [
                  // N42 ID
                  _buildListTile(
                    isDark: isDark,
                    title: S.of(context)?.profileN42IdTitle ?? 'N42 ID',
                    value: user?.userId ?? '',
                    showArrow: false,
                  ),
                  _buildDivider(isDark),
                  
                  // 我的二维码
                  _buildListTile(
                    isDark: isDark,
                    title: S.of(context)?.commonMyQrCode ?? 'My QR Code',
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.qr_code,
                          size: 20,
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 8),
                        const Icon(
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
                    title: S.of(context)?.profilePoke ?? 'Poke',
                    value: user?.pokeText?.isNotEmpty == true ? user!.pokeText! : (S.of(context)?.commonNotSet ?? 'Not Set'),
                    onTap: () => _editPokeText(user?.pokeText),
                  ),
                  _buildDivider(isDark),
                  
                  // 签名
                  _buildListTile(
                    isDark: isDark,
                    title: S.of(context)?.profileSignature ?? 'Signature',
                    value: user?.signature ?? (S.of(context)?.commonNotSet ?? 'Not Set'),
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
                    title: S.of(context)?.profileRingtone ?? 'Ringtone',
                    value: user?.ringtone ?? (S.of(context)?.profileDefaultRingtone ?? 'Default Ringtone'),
                    onTap: () => _selectRingtone(user?.ringtone),
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
                    title: S.of(context)?.profileMyAddresses ?? 'My Addresses',
                    onTap: _manageAddresses,
                  ),
                  _buildDivider(isDark),
                  
                  // 我的发票抬头
                  _buildListTile(
                    isDark: isDark,
                    title: S.of(context)?.profileMyInvoices ?? 'My Invoices',
                    onTap: _manageInvoices,
                  ),
                ],
              ),
              
              const SizedBox(height: 10),
              
              // N42 Bean区块
              _buildSection(
                isDark: isDark,
                children: [
                  _buildListTile(
                    isDark: isDark,
                    title: S.of(context)?.profileN42Bean ?? 'N42 Bean',
                    onTap: _openN42Bean,
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
            // 左侧标题 - 不换行
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 16),
            // 右侧内容
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (trailing != null)
                    trailing
                  else ...[
                    if (value != null)
                      Expanded(
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
                      const Icon(
                        Icons.chevron_right,
                        color: AppColors.textTertiary,
                        size: 20,
                      ),
                    ],
                  ],
                ],
              ),
            ),
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

  String _getGenderText(BuildContext context, String? gender) {
    switch (gender) {
      case 'male':
        return S.of(context)?.profileMale ?? 'Male';
      case 'female':
        return S.of(context)?.profileFemale ?? 'Female';
      default:
        return S.of(context)?.commonNotSet ?? 'Not Set';
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
              title: Text(S.of(context)?.commonTakePhoto ?? 'Take Photo'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(S.of(context)?.profileChooseFromGallery ?? 'Choose from Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.close),
              title: Text(S.of(context)?.commonCancel ?? 'Cancel'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    try {
      debugPrint('ProfileEditPage: Picking image from $source');
      
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );

      if (image == null) {
        debugPrint('ProfileEditPage: No image selected');
        return;
      }

      debugPrint('ProfileEditPage: Image selected: ${image.path}, name: ${image.name}');
      
      setState(() => _isUploading = true);

      final bytes = await image.readAsBytes();
      debugPrint('ProfileEditPage: Image bytes: ${bytes.length}');

      if (!mounted) return;
      if (bytes.isEmpty) {
        throw Exception(S.of(context)?.commonImageDataEmpty ?? 'Image data is empty');
      }

      // 确保文件名有正确的扩展名
      String filename = image.name;
      if (!filename.contains('.')) {
        // iOS 相机可能不带扩展名，添加 .jpg
        filename = '$filename.jpg';
      }

      debugPrint('ProfileEditPage: Uploading avatar with filename: $filename');

      // 上传头像 - BlocConsumer 会监听状态变化并显示结果
      context.read<AuthBloc>().add(UpdateAvatar(
        avatarBytes: bytes,
        filename: filename,
      ));
    } catch (e, stackTrace) {
      debugPrint('ProfileEditPage: Pick image error: $e');
      debugPrint('ProfileEditPage: Stack trace: $stackTrace');
      if (mounted) {
        setState(() => _isUploading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${S.of(context)?.commonSelectImageFailed ?? 'Failed to select image'}: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _editDisplayName(String? currentName) async {
    final controller = TextEditingController(text: currentName);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context)?.profileChangeName ?? 'Change Name'),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLength: 20,
          decoration: InputDecoration(
            hintText: S.of(context)?.profileEnterNickname ?? 'Enter nickname',
            counterText: '',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: Text(S.of(context)?.commonConfirm ?? 'Confirm'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty && result != currentName) {
      if (!mounted) return;
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
              title: Text(S.of(context)?.profileMale ?? 'Male', textAlign: TextAlign.center),
              onTap: () => Navigator.pop(context, 'male'),
            ),
            const Divider(height: 1),
            ListTile(
              title: Text(S.of(context)?.profileFemale ?? 'Female', textAlign: TextAlign.center),
              onTap: () => Navigator.pop(context, 'female'),
            ),
            const Divider(height: 1),
            ListTile(
              title: Text(S.of(context)?.commonCancel ?? 'Cancel', textAlign: TextAlign.center),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );

    if (result != null && mounted) {
      context.read<AuthBloc>().add(UpdateUserProfile(gender: result));
      final genderText = result == 'male' ? (S.of(context)?.profileMale ?? 'Male') : (S.of(context)?.profileFemale ?? 'Female');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.profileGenderSetTo(genderText) ?? 'Gender set to: $genderText'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> _selectRegion() async {
    // 世界著名城市 - 按地区分类
    final regions = [
      'North America', 'Europe', 'Asia', 'Oceania',
      'South America', 'Middle East', 'Africa',
    ];

    final province = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.divider),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    S.of(context)?.profileSelectRegion ?? 'Select Region',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: regions.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(regions[index]),
                  onTap: () => Navigator.pop(context, regions[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (province != null && mounted) {
      // 选择城市
      final cities = _getCitiesForRegion(province);

      if (cities.isNotEmpty) {
        final city = await showModalBottomSheet<String>(
          context: context,
          isScrollControlled: true,
          builder: (context) => SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      S.of(context)?.profileSelectCity ?? 'Select City',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cities.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(cities[index]),
                        onTap: () => Navigator.pop(context, cities[index]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

        if (city != null && mounted) {
          context.read<AuthBloc>().add(UpdateUserProfile(region: city));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context)?.profileRegionSetTo(city) ?? 'Region set to: $city'),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      }
    }
  }

  List<String> _getCitiesForRegion(String region) {
    // 世界著名城市数据
    final Map<String, List<String>> cityData = {
      'North America': ['New York', 'Los Angeles', 'Chicago', 'San Francisco', 'Miami', 'Toronto', 'Vancouver', 'Mexico City'],
      'Europe': ['London', 'Paris', 'Berlin', 'Rome', 'Madrid', 'Amsterdam', 'Barcelona', 'Vienna', 'Prague', 'Zurich'],
      'Asia': ['Tokyo', 'Singapore', 'Hong Kong', 'Seoul', 'Shanghai', 'Beijing', 'Bangkok', 'Mumbai', 'Taipei', 'Osaka'],
      'Oceania': ['Sydney', 'Melbourne', 'Auckland', 'Brisbane', 'Perth'],
      'South America': ['São Paulo', 'Rio de Janeiro', 'Buenos Aires', 'Lima', 'Bogotá', 'Santiago'],
      'Middle East': ['Dubai', 'Abu Dhabi', 'Tel Aviv', 'Istanbul', 'Doha', 'Riyadh'],
      'Africa': ['Cape Town', 'Cairo', 'Johannesburg', 'Nairobi', 'Casablanca', 'Lagos'],
    };
    return cityData[region] ?? [];
  }

  Future<void> _editPokeText(String? currentPokeText) async {
    final controller = TextEditingController(text: currentPokeText);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context)?.profileSetPoke ?? 'Set Poke'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context)?.profileFriendPokedMe ?? 'Friend poked me',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              autofocus: true,
              maxLength: 50,
              decoration: InputDecoration(
                hintText: S.of(context)?.profileEnterPokeSuffixHint ?? 'Enter poke suffix, e.g.: on the shoulder',
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${S.of(context)?.profileExample ?? 'Example'}: ${S.of(context)?.profileFriendPokedMe ?? 'Friend poked me'}${controller.text.isNotEmpty ? controller.text : (S.of(context)?.profileOnTheShoulder ?? " on the shoulder")}',
              style: const TextStyle(
                color: AppColors.textTertiary,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: Text(S.of(context)?.commonConfirm ?? 'Confirm'),
          ),
        ],
      ),
    );

    if (result != null && mounted) {
      context.read<AuthBloc>().add(UpdateUserProfile(pokeText: result));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.isEmpty ? (S.of(context)?.profilePokeCleared ?? 'Poke cleared') : (S.of(context)?.profilePokeSetTo(result) ?? 'Poke set to: poked me$result')),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> _editSignature(String? currentSignature) async {
    final controller = TextEditingController(text: currentSignature);
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context)?.profileEditSignature ?? 'Edit Signature'),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLength: 50,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: S.of(context)?.profileIntroduceYourself ?? 'A sentence to introduce yourself',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: Text(S.of(context)?.commonConfirm ?? 'Confirm'),
          ),
        ],
      ),
    );

    if (result != null && result != currentSignature && mounted) {
      context.read<AuthBloc>().add(UpdateUserProfile(signature: result));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.isEmpty ? (S.of(context)?.profileSignatureCleared ?? 'Signature cleared') : (S.of(context)?.profileSignatureUpdated ?? 'Signature updated')),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> _showMyQRCode(String userId) async {
    await showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context)?.commonMyQrCode ?? 'My QR Code',
                style: const TextStyle(
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
                  data: 'n42chat://user/$userId',
                  version: QrVersions.auto,
                  size: 200,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                userId,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                S.of(context)?.profileScanToAddFriend ?? 'Scan the QR code above to add me as a friend',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectRingtone(String? currentRingtone) async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute<String>(
        builder: (context) => _RingtoneSelectPage(
          currentRingtone: currentRingtone ?? (S.of(context)?.profileDefaultRingtone ?? 'Default Ringtone'),
        ),
      ),
    );

    if (result != null && result != currentRingtone && mounted) {
      context.read<AuthBloc>().add(UpdateUserProfile(ringtone: result));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context)?.profileRingtoneSetTo(result) ?? 'Ringtone set to: $result'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> _manageAddresses() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const _AddressManagePage(),
      ),
    );
  }

  Future<void> _manageInvoices() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const _InvoiceManagePage(),
      ),
    );
  }

  Future<void> _openN42Bean() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const N42BeanPage(),
      ),
    );
  }

}

/// 地址管理页面
class _AddressManagePage extends StatefulWidget {
  const _AddressManagePage();

  @override
  State<_AddressManagePage> createState() => _AddressManagePageState();
}

class _AddressManagePageState extends State<_AddressManagePage> {
  List<_AddressItem> _addresses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    try {
      final clientManager = getIt<MatrixClientManager>();
      final client = clientManager.client;
      
      if (client != null && client.isLogged()) {
        try {
          final data = await client.getAccountData(
            client.userID!,
            'n42.user.addresses',
          );
          
          if (data['addresses'] != null) {
            final addressList = data['addresses'] as List;
            setState(() {
              _addresses = addressList.map((item) {
                final map = item as Map<String, dynamic>;
                return _AddressItem(
                  name: (map['name'] as String?) ?? '',
                  phone: (map['phone'] as String?) ?? '',
                  region: (map['region'] as String?) ?? '',
                  detail: (map['detail'] as String?) ?? '',
                  isDefault: (map['isDefault'] as bool?) ?? false,
                );
              }).toList();
              _isLoading = false;
            });
            return;
          }
        } catch (e) {
          debugPrint('No saved addresses: $e');
        }
      }
      
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Load addresses error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveAddresses() async {
    try {
      final clientManager = getIt<MatrixClientManager>();
      final client = clientManager.client;
      
      if (client != null && client.isLogged()) {
        final addressList = _addresses.map((item) => {
          'name': item.name,
          'phone': item.phone,
          'region': item.region,
          'detail': item.detail,
          'isDefault': item.isDefault,
        }).toList();
        
        await client.setAccountData(
          client.userID!,
          'n42.user.addresses',
          {'addresses': addressList},
        );
        debugPrint('Addresses saved successfully');
      }
    } catch (e) {
      debugPrint('Save addresses error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${S.of(context)?.profileSaveAddressFailed ?? 'Save address failed'}: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        title: Text(S.of(context)?.profileMyAddresses ?? 'My Addresses'),
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        actions: [
          TextButton(
            onPressed: _addAddress,
            child: Text(S.of(context)?.profileAddNew ?? 'Add New'),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _addresses.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_off_outlined,
                    size: 64,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    S.of(context)?.profileNoShippingAddress ?? 'No shipping address',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _addAddress,
                    icon: const Icon(Icons.add),
                    label: Text(S.of(context)?.profileAddAddress ?? 'Add Address'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _addresses.length,
              itemBuilder: (context, index) {
                final address = _addresses[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              address.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              address.phone,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const Spacer(),
                            if (address.isDefault)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  S.of(context)?.profileDefaultLabel ?? 'Default',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          address.fullAddress,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => _editAddress(index),
                              child: Text(S.of(context)?.commonEdit ?? 'Edit'),
                            ),
                            TextButton(
                              onPressed: () => _deleteAddress(index),
                              child: Text(
                                S.of(context)?.commonDelete ?? 'Delete',
                                style: const TextStyle(color: AppColors.error),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future<void> _addAddress() async {
    final result = await _showAddressEditor();
    if (result != null) {
      // 如果新地址设为默认，清除其他默认地址
      if (result.isDefault) {
        for (int i = 0; i < _addresses.length; i++) {
          if (_addresses[i].isDefault) {
            _addresses[i] = _AddressItem(
              name: _addresses[i].name,
              phone: _addresses[i].phone,
              region: _addresses[i].region,
              detail: _addresses[i].detail,
              isDefault: false,
            );
          }
        }
      }
      setState(() {
        _addresses.add(result);
      });
      await _saveAddresses();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context)?.profileAddressAdded ?? 'Address added'), duration: const Duration(seconds: 1)),
        );
      }
    }
  }

  Future<void> _editAddress(int index) async {
    final result = await _showAddressEditor(address: _addresses[index]);
    if (result != null) {
      // 如果修改后的地址设为默认，清除其他默认地址
      if (result.isDefault) {
        for (int i = 0; i < _addresses.length; i++) {
          if (i != index && _addresses[i].isDefault) {
            _addresses[i] = _AddressItem(
              name: _addresses[i].name,
              phone: _addresses[i].phone,
              region: _addresses[i].region,
              detail: _addresses[i].detail,
              isDefault: false,
            );
          }
        }
      }
      setState(() {
        _addresses[index] = result;
      });
      await _saveAddresses();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context)?.profileAddressUpdated ?? 'Address updated'), duration: const Duration(seconds: 1)),
        );
      }
    }
  }

  void _deleteAddress(int index) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(context)?.profileDeleteAddress ?? 'Delete Address'),
        content: Text(S.of(context)?.profileConfirmDeleteAddress ?? 'Are you sure you want to delete this address?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              setState(() {
                _addresses.removeAt(index);
              });
              await _saveAddresses();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(S.of(context)?.profileAddressDeleted ?? 'Address deleted'), duration: const Duration(seconds: 1)),
                );
              }
            },
            child: Text(
              S.of(context)?.commonDelete ?? 'Delete',
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  Future<_AddressItem?> _showAddressEditor({_AddressItem? address}) async {
    final nameController = TextEditingController(text: address?.name);
    final phoneController = TextEditingController(text: address?.phone);
    final regionController = TextEditingController(text: address?.region);
    final detailController = TextEditingController(text: address?.detail);
    bool isDefault = address?.isDefault ?? false;

    final s = S.of(context);
    return await showDialog<_AddressItem>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
          title: Text(address == null ? (s?.profileAddAddress ?? 'Add Address') : (s?.profileEditAddress ?? 'Edit Address')),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: s?.profileRecipient ?? 'Recipient',
                    hintText: s?.profileEnterRecipientName ?? 'Enter recipient name',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: s?.profilePhoneNumber ?? 'Phone Number',
                    hintText: s?.profileEnterPhoneNumber ?? 'Enter phone number',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: regionController,
                  decoration: InputDecoration(
                    labelText: s?.profileRegion ?? 'Region',
                    hintText: s?.profileRegionHint ?? 'Province/City/District',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: detailController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    labelText: s?.profileDetailedAddress ?? 'Detailed Address',
                    hintText: s?.profileDetailedAddressHint ?? 'Street, building number, etc.',
                  ),
                ),
                const SizedBox(height: 12),
                CheckboxListTile(
                  value: isDefault,
                  onChanged: (value) {
                    setDialogState(() {
                      isDefault = value ?? false;
                    });
                  },
                  title: Text(s?.profileSetAsDefaultAddress ?? 'Set as default address'),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(s?.commonCancel ?? 'Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isEmpty ||
                    phoneController.text.isEmpty ||
                    regionController.text.isEmpty ||
                    detailController.text.isEmpty) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    SnackBar(content: Text(s?.profilePleaseCompleteInfo ?? 'Please complete all fields')),
                  );
                  return;
                }
                Navigator.pop(
                  dialogContext,
                  _AddressItem(
                    name: nameController.text,
                    phone: phoneController.text,
                    region: regionController.text,
                    detail: detailController.text,
                    isDefault: isDefault,
                  ),
                );
              },
              child: Text(s?.commonSave ?? 'Save'),
            ),
          ],
        ),
      ),
    );
  }
}

/// 地址数据模型
class _AddressItem {
  final String name;
  final String phone;
  final String region;
  final String detail;
  final bool isDefault;

  _AddressItem({
    required this.name,
    required this.phone,
    required this.region,
    required this.detail,
    this.isDefault = false,
  });

  String get fullAddress => '$region $detail';
}

/// 发票抬头管理页面
class _InvoiceManagePage extends StatefulWidget {
  const _InvoiceManagePage();

  @override
  State<_InvoiceManagePage> createState() => _InvoiceManagePageState();
}

class _InvoiceManagePageState extends State<_InvoiceManagePage> {
  List<_InvoiceItem> _invoices = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInvoices();
  }

  Future<void> _loadInvoices() async {
    try {
      final clientManager = getIt<MatrixClientManager>();
      final client = clientManager.client;
      
      if (client != null && client.isLogged()) {
        try {
          final data = await client.getAccountData(
            client.userID!,
            'n42.user.invoices',
          );
          
          if (data['invoices'] != null) {
            final invoiceList = data['invoices'] as List;
            setState(() {
              _invoices = invoiceList.map((item) {
                final map = item as Map<String, dynamic>;
                return _InvoiceItem(
                  type: (map['type'] as String?) ?? 'personal',
                  title: (map['title'] as String?) ?? '',
                  taxNumber: map['taxNumber'] as String?,
                  bankName: map['bankName'] as String?,
                  bankAccount: map['bankAccount'] as String?,
                  companyAddress: map['companyAddress'] as String?,
                  companyPhone: map['companyPhone'] as String?,
                  isDefault: (map['isDefault'] as bool?) ?? false,
                );
              }).toList();
              _isLoading = false;
            });
            return;
          }
        } catch (e) {
          debugPrint('No saved invoices: $e');
        }
      }
      
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Load invoices error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveInvoices() async {
    try {
      final clientManager = getIt<MatrixClientManager>();
      final client = clientManager.client;
      
      if (client != null && client.isLogged()) {
        final invoiceList = _invoices.map((item) => {
          'type': item.type,
          'title': item.title,
          'taxNumber': item.taxNumber,
          'bankName': item.bankName,
          'bankAccount': item.bankAccount,
          'companyAddress': item.companyAddress,
          'companyPhone': item.companyPhone,
          'isDefault': item.isDefault,
        }).toList();
        
        await client.setAccountData(
          client.userID!,
          'n42.user.invoices',
          {'invoices': invoiceList},
        );
        debugPrint('Invoices saved successfully');
      }
    } catch (e) {
      debugPrint('Save invoices error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${S.of(context)?.profileSaveInvoiceFailed ?? 'Save invoice failed'}: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        title: Text(S.of(context)?.profileMyInvoices ?? 'My Invoices'),
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        actions: [
          TextButton(
            onPressed: _addInvoice,
            child: Text(S.of(context)?.profileAddNew ?? 'Add New'),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _invoices.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.receipt_long_outlined,
                    size: 64,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    S.of(context)?.profileNoInvoice ?? 'No invoice',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _addInvoice,
                    icon: const Icon(Icons.add),
                    label: Text(S.of(context)?.profileAddInvoice ?? 'Add Invoice'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _invoices.length,
              itemBuilder: (context, index) {
                final invoice = _invoices[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: invoice.type == 'company' 
                                    ? AppColors.primary.withValues(alpha: 0.1)
                                    : Colors.orange.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                invoice.type == 'company' ? (S.of(context)?.profileCompany ?? 'Company') : (S.of(context)?.profilePersonal ?? 'Personal'),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: invoice.type == 'company'
                                      ? AppColors.primary
                                      : Colors.orange,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                invoice.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (invoice.isDefault)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  S.of(context)?.profileDefaultLabel ?? 'Default',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        if (invoice.taxNumber != null && invoice.taxNumber!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            '${S.of(context)?.profileTaxNumber ?? 'Tax Number'}: ${invoice.taxNumber}',
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => _editInvoice(index),
                              child: Text(S.of(context)?.commonEdit ?? 'Edit'),
                            ),
                            TextButton(
                              onPressed: () => _deleteInvoice(index),
                              child: Text(
                                S.of(context)?.commonDelete ?? 'Delete',
                                style: const TextStyle(color: AppColors.error),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future<void> _addInvoice() async {
    final result = await _showInvoiceEditor();
    if (result != null) {
      if (result.isDefault) {
        for (int i = 0; i < _invoices.length; i++) {
          if (_invoices[i].isDefault) {
            _invoices[i] = _InvoiceItem(
              type: _invoices[i].type,
              title: _invoices[i].title,
              taxNumber: _invoices[i].taxNumber,
              bankName: _invoices[i].bankName,
              bankAccount: _invoices[i].bankAccount,
              companyAddress: _invoices[i].companyAddress,
              companyPhone: _invoices[i].companyPhone,
              isDefault: false,
            );
          }
        }
      }
      setState(() {
        _invoices.add(result);
      });
      await _saveInvoices();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context)?.profileInvoiceAdded ?? 'Invoice added'), duration: const Duration(seconds: 1)),
        );
      }
    }
  }

  Future<void> _editInvoice(int index) async {
    final result = await _showInvoiceEditor(invoice: _invoices[index]);
    if (result != null) {
      if (result.isDefault) {
        for (int i = 0; i < _invoices.length; i++) {
          if (i != index && _invoices[i].isDefault) {
            _invoices[i] = _InvoiceItem(
              type: _invoices[i].type,
              title: _invoices[i].title,
              taxNumber: _invoices[i].taxNumber,
              bankName: _invoices[i].bankName,
              bankAccount: _invoices[i].bankAccount,
              companyAddress: _invoices[i].companyAddress,
              companyPhone: _invoices[i].companyPhone,
              isDefault: false,
            );
          }
        }
      }
      setState(() {
        _invoices[index] = result;
      });
      await _saveInvoices();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context)?.profileInvoiceUpdated ?? 'Invoice updated'), duration: const Duration(seconds: 1)),
        );
      }
    }
  }

  void _deleteInvoice(int index) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(context)?.profileDeleteInvoice ?? 'Delete Invoice'),
        content: Text(S.of(context)?.profileConfirmDeleteInvoice ?? 'Are you sure you want to delete this invoice?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              setState(() {
                _invoices.removeAt(index);
              });
              await _saveInvoices();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(S.of(context)?.profileInvoiceDeleted ?? 'Invoice deleted'), duration: const Duration(seconds: 1)),
                );
              }
            },
            child: Text(
              S.of(context)?.commonDelete ?? 'Delete',
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  Future<_InvoiceItem?> _showInvoiceEditor({_InvoiceItem? invoice}) async {
    String type = invoice?.type ?? 'personal';
    final titleController = TextEditingController(text: invoice?.title);
    final taxNumberController = TextEditingController(text: invoice?.taxNumber);
    final bankNameController = TextEditingController(text: invoice?.bankName);
    final bankAccountController = TextEditingController(text: invoice?.bankAccount);
    final companyAddressController = TextEditingController(text: invoice?.companyAddress);
    final companyPhoneController = TextEditingController(text: invoice?.companyPhone);
    bool isDefault = invoice?.isDefault ?? false;

    final s = S.of(context);
    return await showDialog<_InvoiceItem>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
          title: Text(invoice == null ? (s?.profileAddInvoice ?? 'Add Invoice') : (s?.profileEditInvoice ?? 'Edit Invoice')),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 抬头类型
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Text('${s?.profileInvoiceType ?? 'Invoice Type'}: '),
                    ChoiceChip(
                      label: Text(s?.profilePersonal ?? 'Personal'),
                      selected: type == 'personal',
                      onSelected: (selected) {
                        if (selected) {
                          setDialogState(() => type = 'personal');
                        }
                      },
                    ),
                    ChoiceChip(
                      label: Text(s?.profileCompany ?? 'Company'),
                      selected: type == 'company',
                      onSelected: (selected) {
                        if (selected) {
                          setDialogState(() => type = 'company');
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: type == 'company' ? (s?.profileCompanyName ?? 'Company Name') : (s?.profilePersonalName ?? 'Personal Name'),
                    hintText: type == 'company' ? (s?.profileEnterCompanyName ?? 'Enter company name') : (s?.profileEnterName ?? 'Enter name'),
                  ),
                ),
                if (type == 'company') ...[
                  const SizedBox(height: 12),
                  TextField(
                    controller: taxNumberController,
                    decoration: InputDecoration(
                      labelText: s?.profileTaxIdNumber ?? 'Tax ID Number',
                      hintText: s?.profileEnterTaxIdNumber ?? 'Enter tax ID number',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: bankNameController,
                    decoration: InputDecoration(
                      labelText: s?.profileBankNameOptional ?? 'Bank Name (Optional)',
                      hintText: s?.profileEnterBankName ?? 'Enter bank name',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: bankAccountController,
                    decoration: InputDecoration(
                      labelText: s?.profileBankAccountOptional ?? 'Bank Account (Optional)',
                      hintText: s?.profileEnterBankAccount ?? 'Enter bank account',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: companyAddressController,
                    decoration: InputDecoration(
                      labelText: s?.profileCompanyAddressOptional ?? 'Company Address (Optional)',
                      hintText: s?.profileEnterCompanyAddress ?? 'Enter company address',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: companyPhoneController,
                    decoration: InputDecoration(
                      labelText: s?.profileCompanyPhoneOptional ?? 'Company Phone (Optional)',
                      hintText: s?.profileEnterCompanyPhone ?? 'Enter company phone',
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                CheckboxListTile(
                  value: isDefault,
                  onChanged: (value) {
                    setDialogState(() {
                      isDefault = value ?? false;
                    });
                  },
                  title: Text(s?.profileSetAsDefaultInvoice ?? 'Set as default invoice'),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(s?.commonCancel ?? 'Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isEmpty) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    SnackBar(content: Text(type == 'company' ? (s?.profileEnterCompanyName ?? 'Enter company name') : (s?.profileEnterName ?? 'Enter name'))),
                  );
                  return;
                }
                if (type == 'company' && taxNumberController.text.isEmpty) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    SnackBar(content: Text(s?.profileEnterTaxIdNumber ?? 'Enter tax ID number')),
                  );
                  return;
                }
                Navigator.pop(
                  dialogContext,
                  _InvoiceItem(
                    type: type,
                    title: titleController.text,
                    taxNumber: type == 'company' ? taxNumberController.text : null,
                    bankName: type == 'company' ? bankNameController.text : null,
                    bankAccount: type == 'company' ? bankAccountController.text : null,
                    companyAddress: type == 'company' ? companyAddressController.text : null,
                    companyPhone: type == 'company' ? companyPhoneController.text : null,
                    isDefault: isDefault,
                  ),
                );
              },
              child: Text(s?.commonSave ?? 'Save'),
            ),
          ],
        ),
      ),
    );
  }
}

/// 发票抬头数据模型
class _InvoiceItem {
  final String type; // 'personal' or 'company'
  final String title;
  final String? taxNumber;
  final String? bankName;
  final String? bankAccount;
  final String? companyAddress;
  final String? companyPhone;
  final bool isDefault;

  _InvoiceItem({
    required this.type,
    required this.title,
    this.taxNumber,
    this.bankName,
    this.bankAccount,
    this.companyAddress,
    this.companyPhone,
    this.isDefault = false,
  });
}

/// 铃声选择页面
///
/// 使用设备系统铃声列表，确保所有铃声都可以正常播放
class _RingtoneSelectPage extends StatefulWidget {
  final String currentRingtone;

  const _RingtoneSelectPage({required this.currentRingtone});

  @override
  State<_RingtoneSelectPage> createState() => _RingtoneSelectPageState();
}

class _RingtoneSelectPageState extends State<_RingtoneSelectPage> {
  late String _selectedRingtone;
  String? _playingRingtone;
  bool _isLoading = true;
  bool _hasLoadedRingtones = false;
  List<_RingtoneItem> _ringtones = [];

  final _ringtoneService = SystemRingtoneService.instance;

  @override
  void initState() {
    super.initState();
    _selectedRingtone = widget.currentRingtone;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 只加载一次，避免重复调用
    if (!_hasLoadedRingtones) {
      _hasLoadedRingtones = true;
      _loadRingtones();
    }
  }

  /// 加载系统铃声
  Future<void> _loadRingtones() async {
    try {
      // RingtoneManager 获取系统铃声不需要 READ_MEDIA_AUDIO 权限
      // 该权限仅用于访问用户设备上的音乐文件，而非系统铃声
      final s = S.of(context);
      final systemRingtones = await _ringtoneService.getAvailableRingtones();

      final ringtoneItems = <_RingtoneItem>[];

      // 添加系统铃声
      for (final ringtone in systemRingtones) {
        ringtoneItems.add(_RingtoneItem(
          key: ringtone.id,
          name: ringtone.title,
          icon: ringtone.isDefault ? Icons.music_note : Icons.audiotrack,
          uri: ringtone.uri,
          isSystemRingtone: true,
        ));
      }

      // 添加振动和静音选项
      ringtoneItems.add(_RingtoneItem(
        key: 'vibrate',
        name: s?.profileRingtoneVibrate ?? 'Vibrate',
        icon: Icons.vibration,
        uri: null,
        isSystemRingtone: false,
      ));

      ringtoneItems.add(_RingtoneItem(
        key: 'silent',
        name: s?.profileRingtoneSilent ?? 'Silent',
        icon: Icons.volume_off,
        uri: null,
        isSystemRingtone: false,
      ));

      if (mounted) {
        setState(() {
          _ringtones = ringtoneItems;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('加载铃声失败: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _stopRingtone();
    super.dispose();
  }

  /// 播放铃声
  Future<void> _playRingtone(_RingtoneItem ringtone) async {
    // 先停止当前播放
    await _stopRingtone();

    if (!mounted) return;
    final s = S.of(context);

    // 如果是振动，触发振动
    if (ringtone.key == 'vibrate') {
      unawaited(HapticFeedback.heavyImpact());
      await Future<void>.delayed(const Duration(milliseconds: 100));
      unawaited(HapticFeedback.heavyImpact());
      await Future<void>.delayed(const Duration(milliseconds: 100));
      unawaited(HapticFeedback.heavyImpact());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(s?.profileVibrateMode ?? 'Vibrate mode'),
            duration: const Duration(milliseconds: 800),
          ),
        );
      }
      return;
    }

    // 如果是静音，不播放
    if (ringtone.key == 'silent') {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(s?.profileSilentMode ?? 'Silent mode'),
            duration: const Duration(milliseconds: 800),
          ),
        );
      }
      return;
    }

    // 如果没有 URI，不播放
    if (ringtone.uri == null) {
      return;
    }

    setState(() {
      _playingRingtone = ringtone.name;
    });

    try {
      // 使用系统铃声服务播放
      final success = await _ringtoneService.playRingtone(ringtone.uri!);

      if (!success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(s?.profilePlayFailed(ringtone.name) ?? 'Failed to play: ${ringtone.name}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 1),
          ),
        );
        setState(() {
          _playingRingtone = null;
        });
        return;
      }

      // 显示播放提示
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.play_arrow, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    s?.profilePlaying(ringtone.name) ?? 'Playing: ${ringtone.name}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: s?.profileStop ?? 'Stop',
              textColor: Colors.white,
              onPressed: _stopRingtone,
            ),
          ),
        );
      }

      // 5秒后自动停止
      await Future<void>.delayed(const Duration(seconds: 5));
      if (mounted && _playingRingtone == ringtone.name) {
        await _stopRingtone();
      }
    } catch (e) {
      debugPrint('播放铃声失败: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(s?.profilePlayFailed(ringtone.name) ?? 'Failed to play: ${ringtone.name}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 1),
          ),
        );
        setState(() {
          _playingRingtone = null;
        });
      }
    }
  }

  /// 停止铃声
  Future<void> _stopRingtone() async {
    try {
      await _ringtoneService.stopRingtone();
    } catch (e) {
      debugPrint('停止铃声失败: $e');
    }
    if (mounted && _playingRingtone != null) {
      setState(() {
        _playingRingtone = null;
      });
    }
  }

  /// 确认保存
  void _confirmSave() {
    Navigator.pop(context, _selectedRingtone);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final s = S.of(context);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context), // 取消不保存
        ),
        title: Text(
          s?.profileSelectRingtone ?? 'Select Ringtone',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _confirmSave,
            child: Text(
              s?.commonConfirm ?? 'Confirm',
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    s?.profileLoadingRingtones ?? 'Loading ringtones...',
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            )
          : _ringtones.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.music_off,
                        size: 64,
                        color: isDark ? Colors.white38 : Colors.black26,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        s?.profileNoRingtonesFound ?? 'No ringtones found',
                        style: TextStyle(
                          color: isDark ? Colors.white54 : Colors.black45,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: _ringtones.length,
                  itemBuilder: (context, index) {
                    final ringtone = _ringtones[index];
                    final isSelected = ringtone.name == _selectedRingtone;
                    final isPlaying = ringtone.name == _playingRingtone;

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceDark : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: isSelected
                            ? Border.all(color: AppColors.primary, width: 2)
                            : null,
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: isPlaying
                                ? AppColors.primary.withValues(alpha: 0.2)
                                : (isDark ? const Color(0xFF3A3A3C) : const Color(0xFFF2F2F7)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            isPlaying ? Icons.pause : ringtone.icon,
                            color: isPlaying ? AppColors.primary : (isDark ? Colors.white70 : Colors.black54),
                          ),
                        ),
                        title: Text(
                          ringtone.name,
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // 试听按钮
                            if (ringtone.uri != null || ringtone.key == 'vibrate')
                              IconButton(
                                icon: Icon(
                                  isPlaying ? Icons.stop : Icons.play_circle_outline,
                                  color: AppColors.primary,
                                ),
                                onPressed: () {
                                  if (isPlaying) {
                                    _stopRingtone();
                                  } else {
                                    _playRingtone(ringtone);
                                  }
                                },
                              ),
                            // 选中标记
                            if (isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: AppColors.primary,
                              ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            _selectedRingtone = ringtone.name;
                          });
                          // 选中后自动试听
                          _playRingtone(ringtone);
                        },
                      ),
                    );
                  },
                ),
    );
  }
}

/// 铃声项数据模型
class _RingtoneItem {
  final String key;
  final String name;
  final IconData icon;
  final String? uri;
  final bool isSystemRingtone;

  const _RingtoneItem({
    required this.key,
    required this.name,
    required this.icon,
    this.uri,
    this.isSystemRingtone = false,
  });
}

