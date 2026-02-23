/// BLoC 层使用的消息 key 常量
///
/// BLoC 无 BuildContext，不能直接使用 l10n。
/// 此类定义静态常量 key，UI 层在 BlocListener 中通过
/// [BlocMessageHelper.resolve] 将 key 映射为本地化文本。
class BlocMessageKeys {
  BlocMessageKeys._();

  // Group
  static const groupNotFound = 'group_not_found';
  static const groupNameUpdated = 'group_name_updated';
  static const groupDescriptionUpdated = 'group_description_updated';
  static const groupAvatarUpdated = 'group_avatar_updated';
  static const groupMembersInvited = 'group_members_invited';
  static const groupMemberRemoved = 'group_member_removed';
  static const groupSetAsAdmin = 'group_set_as_admin';
  static const groupAdminRemoved = 'group_admin_removed';
  static const groupLeft = 'group_left';
  static const groupDisbanded = 'group_disbanded';
  static const groupJoined = 'group_joined';
  static const groupInviteDeclined = 'group_invite_declined';
  static const groupTokenGateUpdated = 'group_token_gate_updated';
  static const groupMaxMembersUpdated = 'group_max_members_updated';
  static const groupFull = 'group_full';
  static const groupContentFilterUpdated = 'group_content_filter_updated';
  static const groupBotConfigUpdated = 'group_bot_config_updated';
  static const chatReportSuccess = 'chat_report_success';

  // Transfer
  static const transferProcessing = 'transfer_processing';
  static const transferCancelled = 'transfer_cancelled';
  static const transferFailed = 'transfer_failed';
  static const paymentProcessing = 'payment_processing';
  static const paymentFailed = 'payment_failed';
}
