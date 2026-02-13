import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../blocs/contact/contact_bloc.dart';
import '../../blocs/contact/contact_event.dart';
import '../../blocs/contact/contact_state.dart';
import 'contact_detail_page.dart';
import 'contact_permissions_page.dart';

/// 联系人设置页面（仿微信 - 图二）
class ContactSettingsPage extends StatefulWidget {
  final String userId;
  final String displayName;
  final bool isStarred;
  final void Function(bool)? onStarChanged;
  
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
    final isDark = context.isDarkMode;
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
          S.of(context)?.commonSettings ?? 'Settings',
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
                  title: S.of(context)?.contactEditRemark ?? 'Edit Remark',
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
                  title: S.of(context)?.contactSetPermissions ?? 'Set Permissions',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () => _openPermissions(),
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
                  title: S.of(context)?.contactRecommendToFriend ?? 'Share contact',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () => _shareContact(),
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
                  title: S.of(context)?.contactSetAsStarred ?? 'Set as Starred',
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
                  title: S.of(context)?.contactAddToBlocklist ?? 'Add to Blocklist',
                  value: _isBlocked,
                  textColor: textColor,
                  onChanged: (value) {
                    setState(() {
                      _isBlocked = value;
                    });
                    try {
                      if (value) {
                        context.read<ContactBloc>().add(IgnoreUser(widget.userId));
                      } else {
                        context.read<ContactBloc>().add(UnignoreUser(widget.userId));
                      }
                    } catch (_) {
                      debugPrint('ContactBloc not available for blocklist toggle');
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
                  title: S.of(context)?.commonReport ?? 'Report',
                  textColor: textColor,
                  secondaryTextColor: secondaryTextColor,
                  onTap: () => _showReportDialog(),
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
                    child: Text(
                      S.of(context)?.contactDeleteContact ?? 'Delete Contact',
                      style: const TextStyle(
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
            activeTrackColor: AppColors.primary,
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
  
  void _openPermissions() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ContactPermissionsPage(
          userId: widget.userId,
          displayName: widget.displayName,
        ),
      ),
    );
  }

  void _shareContact() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.of(context)?.commonFeatureComingSoon(S.of(context)?.contactRecommendToFriend ?? 'Share contact') ?? 'Share contact coming soon'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showReportDialog() {
    final isDark = context.isDarkMode;
    final descController = TextEditingController();
    String? selectedReason;

    showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: isDark ? const Color(0xFF1C1C1E) : Colors.white,
          title: Text(
            S.of(context)?.reportTitle ?? 'Report',
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...[
                S.of(context)?.reportReasonSpam ?? 'Spam',
                S.of(context)?.reportReasonHarassment ?? 'Harassment',
                S.of(context)?.reportReasonFraud ?? 'Fraud',
                S.of(context)?.reportReasonOther ?? 'Other',
              ].map((reason) => RadioListTile<String>(
                title: Text(reason, style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                value: reason,
                groupValue: selectedReason,
                onChanged: (val) => setDialogState(() => selectedReason = val),
                activeColor: AppColors.primary,
                contentPadding: EdgeInsets.zero,
                dense: true,
              )),
              const SizedBox(height: 8),
              TextField(
                controller: descController,
                maxLines: 2,
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  hintText: S.of(context)?.reportDescription ?? 'Additional description (optional)',
                  hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                descController.dispose();
                Navigator.pop(ctx);
              },
              child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (selectedReason == null) {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    SnackBar(
                      content: Text(S.of(context)?.reportSelectReason ?? 'Please select a reason'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                  return;
                }
                descController.dispose();
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(S.of(context)?.reportSubmitted ?? 'Report submitted'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: Text(S.of(context)?.commonConfirm ?? 'Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _openEditRemark() {
    // 获取当前的 ContactBloc
    ContactBloc? contactBloc;
    try {
      contactBloc = context.read<ContactBloc>();
    } catch (e) {
      // ContactBloc 可能不可用
      debugPrint('Error: $e');
    }
    
    Navigator.of(context).push(
      MaterialPageRoute<void>(
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
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(context)?.contactDeleteContact ?? 'Delete Contact'),
        content: Text(S.of(context)?.contactDeleteContactConfirm(widget.displayName) ?? 'Are you sure you want to delete ${widget.displayName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(S.of(context)?.commonCancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _deleteContact();
            },
            child: Text(
              S.of(context)?.commonDelete ?? 'Delete',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteContact() async {
    // 显示加载指示器
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      // 发送删除事件
      final bloc = context.read<ContactBloc>();
      bloc.add(DeleteContact(widget.userId));

      // 等待状态变化
      await for (final state in bloc.stream) {
        if (state is ContactDeleted && state.userId == widget.userId) {
          // 删除成功
          if (mounted) {
            Navigator.of(context).pop(); // 关闭加载指示器

            // 返回到联系人列表（连续关闭设置页和详情页）
            Navigator.of(context).pop(); // 关闭设置页面
            Navigator.of(context).pop(); // 关闭联系人详情页面
          }
          break;
        } else if (state is ContactError) {
          // 删除失败
          if (mounted) {
            Navigator.of(context).pop(); // 关闭加载指示器
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
          break;
        } else if (state is ContactLoaded) {
          // 联系人列表已刷新，说明删除成功
          if (mounted) {
            Navigator.of(context).pop(); // 关闭加载指示器
            Navigator.of(context).pop(); // 关闭设置页面
            Navigator.of(context).pop(); // 关闭联系人详情页面
          }
          break;
        }
      }
    } catch (e) {
      // 发生异常
      if (mounted) {
        Navigator.of(context).pop(); // 关闭加载指示器
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${S.of(context)?.contactDeleteContact ?? "Delete failed"}: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }
}

