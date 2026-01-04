import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/contact_entity.dart';
import '../../blocs/contact/contact_bloc.dart';
import '../../blocs/contact/contact_state.dart';
import '../../widgets/common/n42_avatar.dart';
import 'contact_settings_page.dart';

/// 联系人详情页面（仿微信）
class ContactDetailPage extends StatefulWidget {
  /// 联系人用户ID
  final String userId;
  
  /// 联系人显示名称
  final String displayName;
  
  /// 联系人头像URL
  final String? avatarUrl;
  
  /// 发消息回调
  final VoidCallback? onSendMessage;
  
  /// 音视频通话回调
  final VoidCallback? onVideoCall;

  const ContactDetailPage({
    super.key,
    required this.userId,
    required this.displayName,
    this.avatarUrl,
    this.onSendMessage,
    this.onVideoCall,
  });

  @override
  State<ContactDetailPage> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  ContactEntity? _contact;
  bool _isStarred = false;
  
  @override
  void initState() {
    super.initState();
    _loadContact();
  }
  
  void _loadContact() {
    final contactState = context.read<ContactBloc>().state;
    if (contactState is ContactLoaded) {
      final contact = contactState.contacts.where(
        (c) => c.userId == widget.userId
      ).firstOrNull;
      if (contact != null) {
        setState(() {
          _contact = contact;
        });
      }
    }
  }
  
  String get _effectiveDisplayName {
    if (_contact?.remark != null && _contact!.remark!.isNotEmpty) {
      return _contact!.remark!;
    }
    return widget.displayName;
  }
  
  String get _n42Id {
    // 从 userId 提取 N42 ID
    if (widget.userId.startsWith('@')) {
      final colonIndex = widget.userId.indexOf(':');
      if (colonIndex > 1) {
        return widget.userId.substring(1, colonIndex);
      }
      return widget.userId.substring(1);
    }
    return widget.userId;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;
    final cardColor = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.white70 : Colors.black54;
    final dividerColor = isDark ? Colors.white10 : Colors.black12;
    
    return BlocListener<ContactBloc, ContactState>(
      listener: (context, state) {
        if (state is ContactRemarkUpdated && state.userId == widget.userId) {
          _loadContact();
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: textColor, size: 20),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_horiz, color: textColor),
              onPressed: () => _openSettings(),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              
              // 用户信息卡片
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 头像
                    N42Avatar(
                      imageUrl: widget.avatarUrl,
                      name: _effectiveDisplayName,
                      size: 64,
                      borderRadius: 8,
                    ),
                    const SizedBox(width: 16),
                    
                    // 名称和ID
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _effectiveDisplayName,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'N42号：$_n42Id',
                            style: TextStyle(
                              fontSize: 14,
                              color: secondaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // 星标
                    if (_isStarred)
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFFD700),
                        size: 24,
                      ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // 朋友资料
              _buildMenuSection(
                cardColor: cardColor,
                dividerColor: dividerColor,
                children: [
                  _buildMenuItem(
                    title: '朋友资料',
                    subtitle: '添加朋友的备注名、电话、标签、备忘、照片等，并设置朋友权限。',
                    textColor: textColor,
                    secondaryTextColor: secondaryTextColor,
                    onTap: () => _openFriendInfo(),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // 朋友圈
              _buildMenuSection(
                cardColor: cardColor,
                dividerColor: dividerColor,
                children: [
                  _buildMenuItem(
                    title: '朋友圈',
                    textColor: textColor,
                    secondaryTextColor: secondaryTextColor,
                    onTap: () {},
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // 视频号
              _buildMenuSection(
                cardColor: cardColor,
                dividerColor: dividerColor,
                children: [
                  _buildVideoSection(textColor, secondaryTextColor),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // 发消息按钮
              _buildActionButton(
                icon: Icons.chat_bubble_outline,
                label: '发消息',
                onTap: widget.onSendMessage ?? () => Navigator.of(context).pop(),
              ),
              
              const SizedBox(height: 12),
              
              // 音视频通话按钮
              _buildActionButton(
                icon: Icons.phone_outlined,
                label: '音视频通话',
                onTap: widget.onVideoCall ?? () {},
              ),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildMenuSection({
    required Color cardColor,
    required Color dividerColor,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border(
          top: BorderSide(color: dividerColor, width: 0.5),
          bottom: BorderSide(color: dividerColor, width: 0.5),
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }
  
  Widget _buildMenuItem({
    required String title,
    String? subtitle,
    required Color textColor,
    required Color secondaryTextColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: secondaryTextColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildVideoSection(Color textColor, Color secondaryTextColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '视频号',
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Text(
                  _effectiveDisplayName,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 视频缩略图列表
          SizedBox(
            height: 80,
            child: Row(
              children: [
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      return Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Icon(
                                Icons.play_arrow,
                                color: Colors.white54,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.chevron_right,
                  color: secondaryTextColor,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.white10, width: 0.5),
              bottom: BorderSide(color: Colors.white10, width: 0.5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white70, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _openSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactSettingsPage(
          userId: widget.userId,
          displayName: _effectiveDisplayName,
          isStarred: _isStarred,
          onStarChanged: (starred) {
            setState(() {
              _isStarred = starred;
            });
          },
        ),
      ),
    );
  }
  
  void _openFriendInfo() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FriendInfoPage(
          userId: widget.userId,
          displayName: widget.displayName,
          avatarUrl: widget.avatarUrl,
          remark: _contact?.remark,
        ),
      ),
    ).then((_) => _loadContact());
  }
}

/// 朋友资料页面（图三）
class FriendInfoPage extends StatelessWidget {
  final String userId;
  final String displayName;
  final String? avatarUrl;
  final String? remark;
  
  const FriendInfoPage({
    super.key,
    required this.userId,
    required this.displayName,
    this.avatarUrl,
    this.remark,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;
    final cardColor = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.white70 : Colors.black54;
    final labelColor = isDark ? Colors.white38 : Colors.black38;
    final dividerColor = isDark ? Colors.white10 : Colors.black12;
    
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColor, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '朋友资料',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 备注分组
            _buildSectionLabel('备注', labelColor),
            _buildMenuSection(
              cardColor: cardColor,
              dividerColor: dividerColor,
              children: [
                _buildMenuItem(
                  title: '备注名',
                  value: remark ?? displayName,
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () => _openEditRemark(context),
                ),
                _buildDivider(dividerColor),
                _buildMenuItem(
                  title: '电话',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () {},
                ),
                _buildDivider(dividerColor),
                _buildMenuItem(
                  title: '标签',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () {},
                ),
                _buildDivider(dividerColor),
                _buildMenuItem(
                  title: '备忘',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () {},
                ),
                _buildDivider(dividerColor),
                _buildMenuItem(
                  title: '照片',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () {},
                ),
              ],
            ),
            
            // 权限分组
            _buildSectionLabel('权限', labelColor),
            _buildMenuSection(
              cardColor: cardColor,
              dividerColor: dividerColor,
              children: [
                _buildMenuItem(
                  title: '权限',
                  value: '聊天、朋友圈、运动等',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () {},
                ),
              ],
            ),
            
            // 更多信息分组
            _buildSectionLabel('更多信息', labelColor),
            _buildMenuSection(
              cardColor: cardColor,
              dividerColor: dividerColor,
              children: [
                _buildMenuItem(
                  title: '我和他 (她) 的共同群聊',
                  value: '0个',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () {},
                  showArrow: false,
                ),
                _buildDivider(dividerColor),
                _buildMenuItem(
                  title: '来源',
                  value: '通过搜索添加',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () {},
                  showArrow: false,
                ),
                _buildDivider(dividerColor),
                _buildMenuItem(
                  title: '添加时间',
                  value: '未知',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () {},
                  showArrow: false,
                ),
              ],
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSectionLabel(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          color: color,
        ),
      ),
    );
  }
  
  Widget _buildMenuSection({
    required Color cardColor,
    required Color dividerColor,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        border: Border(
          top: BorderSide(color: dividerColor, width: 0.5),
          bottom: BorderSide(color: dividerColor, width: 0.5),
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }
  
  Widget _buildMenuItem({
    required String title,
    String? value,
    required Color textColor,
    required Color secondaryTextColor,
    required VoidCallback onTap,
    bool showArrow = true,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
            const Spacer(),
            if (value != null)
              Flexible(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    color: secondaryTextColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            if (showArrow) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.chevron_right,
                color: secondaryTextColor,
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _buildDivider(Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Divider(height: 0.5, thickness: 0.5, color: color),
    );
  }
  
  void _openEditRemark(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditRemarkPage(
          userId: userId,
          currentRemark: remark,
          displayName: displayName,
        ),
      ),
    );
  }
}

/// 编辑备注页面（图四）
class EditRemarkPage extends StatefulWidget {
  final String userId;
  final String? currentRemark;
  final String displayName;
  
  const EditRemarkPage({
    super.key,
    required this.userId,
    this.currentRemark,
    required this.displayName,
  });

  @override
  State<EditRemarkPage> createState() => _EditRemarkPageState();
}

class _EditRemarkPageState extends State<EditRemarkPage> {
  late TextEditingController _remarkController;
  late TextEditingController _phoneController;
  late TextEditingController _memoController;
  
  @override
  void initState() {
    super.initState();
    _remarkController = TextEditingController(
      text: widget.currentRemark ?? widget.displayName,
    );
    _phoneController = TextEditingController();
    _memoController = TextEditingController();
  }
  
  @override
  void dispose() {
    _remarkController.dispose();
    _phoneController.dispose();
    _memoController.dispose();
    super.dispose();
  }
  
  void _save() {
    final remark = _remarkController.text.trim();
    
    // 保存备注名
    context.read<ContactBloc>().add(
      SetContactRemark(widget.userId, remark.isEmpty ? null : remark),
    );
    
    // 返回到上一页
    Navigator.of(context).pop();
    Navigator.of(context).pop(); // 返回到联系人详情页
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;
    final cardColor = isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7);
    final textColor = isDark ? Colors.white : Colors.black;
    final hintColor = isDark ? Colors.white38 : Colors.black38;
    final labelColor = isDark ? Colors.white54 : Colors.black54;
    
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            '取消',
            style: TextStyle(
              fontSize: 16,
              color: textColor,
            ),
          ),
        ),
        title: Text(
          '编辑备注',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
              onPressed: _save,
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              ),
              child: const Text(
                '完成',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            
            // 备注名
            Text(
              '备注名',
              style: TextStyle(
                fontSize: 13,
                color: labelColor,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _remarkController,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
                decoration: InputDecoration(
                  hintText: widget.displayName,
                  hintStyle: TextStyle(color: hintColor),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 电话
            Text(
              '电话',
              style: TextStyle(
                fontSize: 13,
                color: labelColor,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: hintColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '添加电话',
                        style: TextStyle(
                          fontSize: 16,
                          color: hintColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 标签
            Text(
              '标签',
              style: TextStyle(
                fontSize: 13,
                color: labelColor,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      Text(
                        '添加标签',
                        style: TextStyle(
                          fontSize: 16,
                          color: hintColor,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: hintColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 备忘
            Text(
              '备忘',
              style: TextStyle(
                fontSize: 13,
                color: labelColor,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _memoController,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                ),
                decoration: InputDecoration(
                  hintText: '添加文字',
                  hintStyle: TextStyle(color: hintColor),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // 照片
            Text(
              '照片',
              style: TextStyle(
                fontSize: 13,
                color: labelColor,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: hintColor,
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '添加照片',
                      style: TextStyle(
                        fontSize: 12,
                        color: hintColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

