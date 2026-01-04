import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../blocs/contact/contact_bloc.dart';
import '../../blocs/contact/contact_event.dart';
import 'contact_detail_page.dart';

/// 联系人设置页面（仿微信 - 图二）
class ContactSettingsPage extends StatefulWidget {
  final String userId;
  final String displayName;
  final bool isStarred;
  final Function(bool)? onStarChanged;
  
  const ContactSettingsPage({
    super.key,
    required this.userId,
    required this.displayName,
    this.isStarred = false,
    this.onStarChanged,
  });

  @override
  State<ContactSettingsPage> createState() => _ContactSettingsPageState();
}

class _ContactSettingsPageState extends State<ContactSettingsPage> {
  late bool _isStarred;
  bool _isBlocked = false;
  
  @override
  void initState() {
    super.initState();
    _isStarred = widget.isStarred;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;
    final cardColor = isDark ? const Color(0xFF1C1C1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.white70 : Colors.black54;
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
          '设置',
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
          children: [
            const SizedBox(height: 8),
            
            // 编辑备注
            _buildMenuSection(
              cardColor: cardColor,
              dividerColor: dividerColor,
              children: [
                _buildMenuItem(
                  title: '编辑备注',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () => _openEditRemark(),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // 设置权限
            _buildMenuSection(
              cardColor: cardColor,
              dividerColor: dividerColor,
              children: [
                _buildMenuItem(
                  title: '设置权限',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () {},
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // 把他(她)推荐给朋友
            _buildMenuSection(
              cardColor: cardColor,
              dividerColor: dividerColor,
              children: [
                _buildMenuItem(
                  title: '把他 (她) 推荐给朋友',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () {},
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // 设为星标朋友 & 加入黑名单
            _buildMenuSection(
              cardColor: cardColor,
              dividerColor: dividerColor,
              children: [
                _buildSwitchItem(
                  title: '设为星标朋友',
                  value: _isStarred,
                  textColor: textColor,
                  onChanged: (value) {
                    setState(() {
                      _isStarred = value;
                    });
                    widget.onStarChanged?.call(value);
                  },
                ),
                _buildDivider(dividerColor),
                _buildSwitchItem(
                  title: '加入黑名单',
                  value: _isBlocked,
                  textColor: textColor,
                  onChanged: (value) {
                    setState(() {
                      _isBlocked = value;
                    });
                    if (value) {
                      context.read<ContactBloc>().add(IgnoreUser(widget.userId));
                    } else {
                      context.read<ContactBloc>().add(UnignoreUser(widget.userId));
                    }
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // 投诉
            _buildMenuSection(
              cardColor: cardColor,
              dividerColor: dividerColor,
              children: [
                _buildMenuItem(
                  title: '投诉',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () {},
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // 删除联系人
            _buildMenuSection(
              cardColor: cardColor,
              dividerColor: dividerColor,
              children: [
                InkWell(
                  onTap: () => _showDeleteConfirm(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    alignment: Alignment.center,
                    child: const Text(
                      '删除联系人',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
          ],
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
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
            const Spacer(),
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
  
  Widget _buildSwitchItem({
    required String title,
    required bool value,
    required Color textColor,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
  
  Widget _buildDivider(Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Divider(height: 0.5, thickness: 0.5, color: color),
    );
  }
  
  void _openEditRemark() {
    // 获取当前的 ContactBloc
    ContactBloc? contactBloc;
    try {
      contactBloc = context.read<ContactBloc>();
    } catch (e) {
      // ContactBloc 可能不可用
    }
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          final page = FriendInfoPage(
            userId: widget.userId,
            displayName: widget.displayName,
          );
          
          if (contactBloc != null) {
            return BlocProvider.value(
              value: contactBloc,
              child: page,
            );
          }
          return page;
        },
      ),
    );
  }
  
  void _showDeleteConfirm() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除联系人'),
        content: Text('确定要删除 ${widget.displayName} 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: 实现删除联系人
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text(
              '删除',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

