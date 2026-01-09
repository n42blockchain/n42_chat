import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

/// Status setting page (WeChat-style)
class StatusPage extends StatefulWidget {
  final String? currentStatus;

  const StatusPage({super.key, this.currentStatus});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  final TextEditingController _customController = TextEditingController();

  List<StatusCategory> _getCategories(BuildContext context) {
    final s = S.of(context);
    return [
      StatusCategory(
        title: s?.moodAndThoughts ?? 'Mood & Thoughts',
        items: [
          StatusItem(icon: Icons.sentiment_very_satisfied, text: s?.statusHappy ?? 'Happy'),
          StatusItem(icon: Icons.sentiment_dissatisfied, text: s?.statusCracked ?? 'Shattered'),
          StatusItem(icon: Icons.auto_awesome, text: s?.statusLucky ?? 'Lucky'),
          StatusItem(icon: Icons.wb_sunny_outlined, text: s?.statusSunny ?? 'Sunny'),
          StatusItem(icon: Icons.airline_seat_recline_normal, text: s?.statusTired ?? 'Tired'),
          StatusItem(icon: Icons.psychology_outlined, text: s?.statusDaydream ?? 'Daydream'),
          StatusItem(icon: Icons.flash_on, text: s?.statusRushing ?? 'Rushing'),
          StatusItem(icon: Icons.mood_bad, text: 'emo'),
          StatusItem(icon: Icons.cloud_outlined, text: s?.statusOverthinking ?? 'Overthinking'),
          StatusItem(icon: Icons.celebration, text: s?.statusEnergized ?? 'Energized'),
          StatusItem(icon: Icons.smart_toy_outlined, text: 'bot'),
        ],
      ),
      StatusCategory(
        title: s?.workAndStudy ?? 'Work & Study',
        items: [
          StatusItem(icon: Icons.construction, text: s?.statusWorking ?? 'Working'),
          StatusItem(icon: Icons.menu_book, text: s?.statusStudying ?? 'Studying'),
          StatusItem(icon: Icons.work_outline, text: s?.statusBusy ?? 'Busy'),
          StatusItem(icon: Icons.catching_pokemon, text: s?.statusSlacking ?? 'Slacking'),
          StatusItem(icon: Icons.flight_takeoff, text: s?.statusTraveling ?? 'Traveling'),
          StatusItem(icon: Icons.directions_run, text: s?.statusGoingHome ?? 'Going Home'),
          StatusItem(icon: Icons.do_not_disturb_on_outlined, text: s?.statusDnd ?? 'Do Not Disturb'),
        ],
      ),
      StatusCategory(
        title: s?.activities ?? 'Activities',
        items: [
          StatusItem(icon: Icons.surfing, text: s?.statusHanging ?? 'Hanging Out'),
          StatusItem(icon: Icons.check_circle_outline, text: s?.statusCheckIn ?? 'Check In'),
          StatusItem(icon: Icons.fitness_center, text: s?.statusExercising ?? 'Exercising'),
          StatusItem(icon: Icons.coffee_outlined, text: s?.statusCoffee ?? 'Coffee'),
          StatusItem(icon: Icons.local_cafe_outlined, text: s?.statusBubbleTea ?? 'Bubble Tea'),
          StatusItem(icon: Icons.rice_bowl, text: s?.statusEating ?? 'Eating'),
          StatusItem(icon: Icons.child_friendly, text: s?.statusParenting ?? 'Parenting'),
          StatusItem(icon: Icons.public, text: s?.statusSavingWorld ?? 'Saving World'),
          StatusItem(icon: Icons.camera_alt_outlined, text: s?.statusSelfie ?? 'Selfie'),
        ],
      ),
      StatusCategory(
        title: s?.rest ?? 'Rest',
        items: [
          StatusItem(icon: Icons.self_improvement, text: s?.statusRetreat ?? 'Retreat'),
          StatusItem(icon: Icons.home_outlined, text: s?.statusHome ?? 'Home'),
          StatusItem(icon: Icons.bedtime_outlined, text: s?.statusSleeping ?? 'Sleeping'),
          StatusItem(icon: Icons.pets, text: s?.statusCatLover ?? 'Cat Lover'),
          StatusItem(icon: Icons.pets_outlined, text: s?.statusDogWalking ?? 'Walking Dog'),
          StatusItem(icon: Icons.sports_esports, text: s?.statusGaming ?? 'Gaming'),
          StatusItem(icon: Icons.headphones, text: s?.statusListening ?? 'Listening'),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final categories = _getCategories(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8B9A6B),
              Color(0xFFB5A87A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCustomInput(),
                      ...categories.map((category) => _buildCategory(category)),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 28,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  S.of(context)?.setStatus ?? 'Set Status',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  S.of(context)?.visibleToFriends24h ?? 'Visible to friends for 24 hours',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 28),
        ],
      ),
    );
  }

  Widget _buildCustomInput() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
        onTap: () => _showCustomStatusDialog(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.6), width: 2),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              S.of(context)?.writeStatus ?? 'Write Status',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(StatusCategory category) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Text(
              category.title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
            child: Wrap(
              spacing: 0,
              runSpacing: 8,
              children: category.items.map((item) => _buildStatusItem(item)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(StatusItem item) {
    final isSelected = widget.currentStatus == item.text;

    return GestureDetector(
      onTap: () {
        Navigator.pop(context, item.text);
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 32 - 16) / 5,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: isSelected ? BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ) : null,
              child: Icon(
                item.icon,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              item.text,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomStatusDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(S.of(context)?.writeStatus ?? 'Write Status'),
        content: TextField(
          controller: _customController,
          autofocus: true,
          maxLength: 20,
          decoration: InputDecoration(
            hintText: S.of(context)?.enterYourStatus ?? 'Enter your status...',
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(S.of(context)?.cancel ?? 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_customController.text.trim().isNotEmpty) {
                Navigator.pop(ctx);
                Navigator.pop(context, _customController.text.trim());
              }
            },
            child: Text(S.of(context)?.ok ?? 'OK'),
          ),
        ],
      ),
    );
  }
}

/// Status category
class StatusCategory {
  final String title;
  final List<StatusItem> items;

  StatusCategory({required this.title, required this.items});
}

/// Status item
class StatusItem {
  final IconData icon;
  final String text;

  StatusItem({required this.icon, required this.text});
}
