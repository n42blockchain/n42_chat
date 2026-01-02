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

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // 监听状态变化
        if (state.status == AuthStatus.authenticated && _isUploading) {
          setState(() => _isUploading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('头像更新成功')),
          );
        } else if (state.status == AuthStatus.error && state.errorMessage != null) {
          setState(() => _isUploading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
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
            // 左侧标题 - 固定宽度
            SizedBox(
              width: 80,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
            ),
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
      
      // 上传头像 - BlocConsumer 会监听状态变化并显示结果
      context.read<AuthBloc>().add(UpdateAvatar(
        avatarBytes: bytes,
        filename: image.name,
      ));
    } catch (e) {
      if (mounted) {
        setState(() => _isUploading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('选择图片失败: $e')),
        );
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
    // 省份列表
    final provinces = [
      '北京', '上海', '天津', '重庆', '广东', '江苏', '浙江', '山东', 
      '河南', '四川', '湖北', '湖南', '河北', '福建', '安徽', '陕西',
      '辽宁', '江西', '云南', '广西', '山西', '贵州', '黑龙江', '吉林',
      '甘肃', '内蒙古', '新疆', '海南', '宁夏', '青海', '西藏', '香港', '澳门', '台湾',
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
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.divider),
                ),
              ),
              child: Row(
                children: [
                  const Text(
                    '选择地区',
                    style: TextStyle(
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
                itemCount: provinces.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(provinces[index]),
                  onTap: () => Navigator.pop(context, provinces[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (province != null) {
      // 选择城市（简化版，实际应该有更完整的城市数据）
      final cities = _getCitiesForProvince(province);
      
      if (cities.isNotEmpty) {
        final city = await showModalBottomSheet<String>(
          context: context,
          builder: (context) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    '选择城市',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...cities.map((c) => ListTile(
                  title: Text(c),
                  onTap: () => Navigator.pop(context, c),
                )),
              ],
            ),
          ),
        );

        if (city != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('地区已设置为: $province $city'),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      }
    }
  }

  List<String> _getCitiesForProvince(String province) {
    // 简化版城市数据
    final Map<String, List<String>> cityData = {
      '北京': ['北京'],
      '上海': ['上海'],
      '天津': ['天津'],
      '重庆': ['重庆'],
      '广东': ['广州', '深圳', '东莞', '佛山', '珠海', '惠州', '中山'],
      '江苏': ['南京', '苏州', '无锡', '常州', '南通', '徐州'],
      '浙江': ['杭州', '宁波', '温州', '嘉兴', '绍兴', '金华'],
      '山东': ['济南', '青岛', '烟台', '潍坊', '威海', '淄博'],
      '四川': ['成都', '绵阳', '德阳', '宜宾', '泸州'],
      '湖北': ['武汉', '宜昌', '襄阳', '荆州', '黄石'],
      '湖南': ['长沙', '株洲', '湘潭', '衡阳', '岳阳'],
    };
    return cityData[province] ?? [province];
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
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const _AddressManagePage(),
      ),
    );
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

/// 地址管理页面
class _AddressManagePage extends StatefulWidget {
  const _AddressManagePage();

  @override
  State<_AddressManagePage> createState() => _AddressManagePageState();
}

class _AddressManagePageState extends State<_AddressManagePage> {
  final List<_AddressItem> _addresses = [];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        title: const Text('我的地址'),
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        actions: [
          TextButton(
            onPressed: _addAddress,
            child: const Text('新增'),
          ),
        ],
      ),
      body: _addresses.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_off_outlined,
                    size: 64,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '暂无收货地址',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _addAddress,
                    icon: const Icon(Icons.add),
                    label: const Text('添加地址'),
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
                              style: TextStyle(
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
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '默认',
                                  style: TextStyle(
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
                          style: TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => _editAddress(index),
                              child: const Text('编辑'),
                            ),
                            TextButton(
                              onPressed: () => _deleteAddress(index),
                              child: Text(
                                '删除',
                                style: TextStyle(color: AppColors.error),
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
      setState(() {
        _addresses.add(result);
      });
    }
  }

  Future<void> _editAddress(int index) async {
    final result = await _showAddressEditor(address: _addresses[index]);
    if (result != null) {
      setState(() {
        _addresses[index] = result;
      });
    }
  }

  void _deleteAddress(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除地址'),
        content: const Text('确定要删除这个地址吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _addresses.removeAt(index);
              });
            },
            child: Text(
              '删除',
              style: TextStyle(color: AppColors.error),
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

    return await showDialog<_AddressItem>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(address == null ? '新增地址' : '编辑地址'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: '收货人',
                    hintText: '请输入收货人姓名',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: '手机号码',
                    hintText: '请输入手机号码',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: regionController,
                  decoration: const InputDecoration(
                    labelText: '所在地区',
                    hintText: '省/市/区',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: detailController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: '详细地址',
                    hintText: '街道、门牌号等',
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
                  title: const Text('设为默认地址'),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isEmpty ||
                    phoneController.text.isEmpty ||
                    regionController.text.isEmpty ||
                    detailController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('请填写完整信息')),
                  );
                  return;
                }
                Navigator.pop(
                  context,
                  _AddressItem(
                    name: nameController.text,
                    phone: phoneController.text,
                    region: regionController.text,
                    detail: detailController.text,
                    isDefault: isDefault,
                  ),
                );
              },
              child: const Text('保存'),
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

