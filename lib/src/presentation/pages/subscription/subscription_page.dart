import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/di/injection.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/services/subscription_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/chat_contrast.dart';
import '../../../domain/entities/subscription_entity.dart';
import '../../../core/theme/app_dimensions.dart';

/// 订阅页：我的订阅 + 可用计划 + 创建计划
class SubscriptionPage extends StatefulWidget {
  /// 限定某创作者（房间/用户）；为空显示全部计划
  final String? creatorId;
  final String? creatorName;

  const SubscriptionPage({super.key, this.creatorId, this.creatorName});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  final SubscriptionService _service = getIt<SubscriptionService>();
  List<UserSubscription> _mySubs = const [];
  List<SubscriptionPlan> _plans = const [];
  bool _loading = true;

  /// Plan or subscription id whose request is in flight; blocks repeat taps.
  String? _busyId;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final subs = await _service.getMySubscriptions();
    final plans = await _service.getPlans(creatorId: widget.creatorId);
    if (!mounted) return;
    setState(() {
      _mySubs = subs;
      _plans = plans;
      _loading = false;
    });
  }

  Future<void> _subscribe(SubscriptionPlan plan) async {
    if (_busyId != null) return;
    setState(() => _busyId = plan.id);
    try {
      await _service.subscribe(plan);
      await _load();
    } finally {
      if (mounted) setState(() => _busyId = null);
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          S.of(context)?.ui3SubscribedTo(plan.name) ??
              'Subscribed to ${plan.name}',
        ),
        backgroundColor: AppColors.primaryFillOf(context),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _cancel(UserSubscription sub) async {
    if (_busyId != null) return;
    final l10n = S.of(context);
    final confirmed = await context.showConfirmDialog(
      title: l10n?.ui3CancelSubscriptionTitle ?? 'Cancel subscription?',
      content:
          l10n?.ui3CancelSubscriptionConfirm(sub.plan.name) ??
          'Your subscription to ${sub.plan.name} stays active until it '
              'expires and will not renew.',
      isDanger: true,
    );
    if (!confirmed || !mounted) return;
    setState(() => _busyId = sub.id);
    try {
      await _service.cancel(sub.id);
      await _load();
    } finally {
      if (mounted) setState(() => _busyId = null);
    }
  }

  Future<void> _toggleAutoRenew(UserSubscription sub) async {
    if (_busyId != null) return;
    setState(() => _busyId = sub.id);
    try {
      await _service.toggleAutoRenew(sub.id);
      await _load();
    } finally {
      if (mounted) setState(() => _busyId = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: AppBar(
        title: Text(
          widget.creatorName == null
              ? (l10n?.ui3ProfileSubscriptions ?? 'Subscriptions')
              : (l10n?.ui3CreatorPlans(widget.creatorName!) ??
                    '${widget.creatorName} · Plans'),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createPlan,
        backgroundColor: AppColors.primaryFillOf(context),
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          l10n?.ui3NewPlan ?? 'New plan',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
                children: [
                  if (_mySubs.isNotEmpty) ...[
                    _sectionTitle(
                      l10n?.ui3MySubscriptions ?? 'My subscriptions',
                    ),
                    ..._mySubs.map(_buildMySubCard),
                    const SizedBox(height: AppDimensions.spacingL),
                  ],
                  _sectionTitle(l10n?.ui3AvailablePlans ?? 'Available plans'),
                  if (_plans.isEmpty)
                    _emptyPlans()
                  else
                    ..._plans.map(_buildPlanCard),
                ],
              ),
            ),
    );
  }

  Widget _sectionTitle(String t) => Padding(
    padding: const EdgeInsets.only(
      bottom: AppDimensions.spacingS,
      top: AppDimensions.spacingXS,
    ),
    child: Text(
      t,
      style: TextStyle(
        color: context.textSecondary,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  Widget _emptyPlans() => Container(
    padding: const EdgeInsets.symmetric(vertical: 28),
    alignment: Alignment.center,
    child: Text(
      S.of(context)?.ui3NoPlansYet ??
          'No plans yet · tap “New plan” to create one',
      // textTertiary is decorative only (1.7:1 on light surfaces).
      style: TextStyle(color: context.textSecondary),
    ),
  );

  Widget _buildMySubCard(UserSubscription sub) {
    final l10n = S.of(context);
    final active = sub.isActive;
    final busy = _busyId != null;
    final statusColor = active
        ? AppColors.success
        : (sub.status == SubscriptionStatus.cancelled
              ? AppColors.warning
              : context.textTertiary);
    return Card(
      color: context.surfaceColor,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    sub.plan.name,
                    style: TextStyle(
                      color: context.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spacingS,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    active
                        ? (l10n?.ui3DaysLeft(sub.daysLeft) ??
                              '${sub.daysLeft}d left')
                        : sub.status == SubscriptionStatus.cancelled
                        ? (l10n?.ui3SubscriptionCancelled ?? 'Cancelled')
                        : (l10n?.commonExpired ?? 'Expired'),
                    style: TextStyle(
                      // Text-safe shade on the 12% tint (raw green/orange/
                      // grey measured 1.7-2.2:1).
                      color: ChatContrast.onTint(
                        statusColor,
                        [context.surfaceColor],
                        dark: context.isDarkMode,
                        alpha: 0.12,
                      ),
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spacingXS),
            Text(
              '${sub.plan.creatorName} · ${sub.plan.priceLabel}',
              style: TextStyle(color: context.textSecondary, fontSize: 12),
            ),
            if (active) ...[
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: busy ? null : () => _toggleAutoRenew(sub),
                    child: Text(
                      sub.autoRenew
                          ? (l10n?.ui3AutoRenewOn ?? 'Auto-renew: on')
                          : (l10n?.ui3AutoRenewOff ?? 'Auto-renew: off'),
                    ),
                  ),
                  TextButton(
                    onPressed: busy ? null : () => _cancel(sub),
                    style: TextButton.styleFrom(
                      // errorFill keeps 4.5:1 on light surfaces.
                      foregroundColor: context.isDarkMode
                          ? AppColors.error
                          : AppColors.errorFill,
                    ),
                    child: Text(l10n?.commonCancel ?? 'Cancel'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPlanCard(SubscriptionPlan plan) {
    return Card(
      color: context.surfaceColor,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plan.name,
              style: TextStyle(
                color: context.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            if (plan.description != null && plan.description!.isNotEmpty) ...[
              const SizedBox(height: AppDimensions.spacingXS),
              Text(
                plan.description!,
                style: TextStyle(color: context.textSecondary, fontSize: 13),
              ),
            ],
            const SizedBox(height: AppDimensions.spacingS),
            ...plan.benefits.map(
              (b) => Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      size: 15,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        b,
                        style: TextStyle(
                          color: context.textSecondary,
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  plan.priceLabel,
                  style: TextStyle(
                    color: AppColors.primaryOf(context),
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  // Disabled while any request is in flight (no double pay).
                  onPressed: _busyId != null ? null : () => _subscribe(plan),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryFillOf(context),
                    foregroundColor: Colors.white,
                  ),
                  child: _busyId == plan.id
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(S.of(context)?.ui3Subscribe ?? 'Subscribe'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================
  // 创建计划
  // ============================================

  Future<void> _createPlan() async {
    final nameC = TextEditingController();
    final priceC = TextEditingController();
    final descC = TextEditingController();
    final benefitsC = TextEditingController();
    var period = SubscriptionPeriod.monthly;
    final l10n = S.of(context);

    final created = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => AlertDialog(
          backgroundColor: context.surfaceColor,
          title: Text(l10n?.ui3NewPlan ?? 'New plan'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameC,
                  decoration: InputDecoration(
                    labelText: l10n?.profileName ?? 'Name',
                  ),
                ),
                TextField(
                  controller: priceC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText:
                        l10n?.ui3PlanPriceLabel ?? 'Price (e.g. 9.9 USDT)',
                  ),
                ),
                TextField(
                  controller: descC,
                  decoration: InputDecoration(
                    labelText:
                        l10n?.ui3PlanDescriptionLabel ??
                        'Description (optional)',
                  ),
                ),
                TextField(
                  controller: benefitsC,
                  decoration: InputDecoration(
                    labelText:
                        l10n?.ui3PlanBenefitsLabel ??
                        'Benefits (comma separated)',
                  ),
                ),
                const SizedBox(height: AppDimensions.spacingS),
                // Wrap (not Row): the chips no longer overflow at 320pt
                // width or 130% text size.
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: AppDimensions.spacingS,
                  children: [
                    Text(l10n?.ui3PlanPeriod ?? 'Period:'),
                    ChoiceChip(
                      label: Text(l10n?.ui3Monthly ?? 'Monthly'),
                      selected: period == SubscriptionPeriod.monthly,
                      onSelected: (_) =>
                          setLocal(() => period = SubscriptionPeriod.monthly),
                    ),
                    ChoiceChip(
                      label: Text(l10n?.ui3Yearly ?? 'Yearly'),
                      selected: period == SubscriptionPeriod.yearly,
                      onSelected: (_) =>
                          setLocal(() => period = SubscriptionPeriod.yearly),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l10n?.commonCancel ?? 'Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l10n?.ui3Create ?? 'Create'),
            ),
          ],
        ),
      ),
    );

    if (created == true &&
        mounted &&
        nameC.text.trim().isNotEmpty &&
        priceC.text.trim().isNotEmpty) {
      final plan = SubscriptionPlan(
        id: 'plan_${DateTime.now().microsecondsSinceEpoch}',
        name: nameC.text.trim(),
        description: descC.text.trim().isEmpty ? null : descC.text.trim(),
        price: priceC.text.trim(),
        period: period,
        creatorId: widget.creatorId ?? 'me',
        creatorName: widget.creatorName ?? 'Me',
        benefits: benefitsC.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
      );
      await _service.upsertPlan(plan);
      await _load();
    }
    nameC.dispose();
    priceC.dispose();
    descC.dispose();
    benefitsC.dispose();
  }
}
