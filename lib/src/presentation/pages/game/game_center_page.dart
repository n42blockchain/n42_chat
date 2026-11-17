import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/di/injection.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/chat_contrast.dart';
import 'services/game_score_service.dart';
import 'game_2048/game_2048_page.dart';
import 'minesweeper/minesweeper_page.dart';
import 'block_drop/block_drop_page.dart';
import 'match3/match3_page.dart';
import '../../../core/theme/app_dimensions.dart';

class GameCenterPage extends StatefulWidget {
  const GameCenterPage({super.key});

  @override
  State<GameCenterPage> createState() => _GameCenterPageState();
}

class _GameCenterPageState extends State<GameCenterPage> {
  final _scoreService = getIt<GameScoreService>();
  final Map<String, int?> _highScores = {};

  @override
  void initState() {
    super.initState();
    _loadHighScores();
  }

  Future<void> _loadHighScores() async {
    final ids = ['game_2048', 'minesweeper', 'block_drop', 'match3'];
    final results = await Future.wait(
      ids.map((id) => _scoreService.getHighScore(id)),
    );
    for (int i = 0; i < ids.length; i++) {
      _highScores[ids[i]] = results[i];
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    final games = [
      _GameInfo(
        id: 'game_2048',
        name: l10n?.game2048 ?? '2048',
        desc: l10n?.game2048Desc ?? 'Merge tiles to reach 2048',
        icon: Icons.grid_4x4,
        color: const Color(0xFFEDC22E),
        page: const Game2048Page(),
      ),
      _GameInfo(
        id: 'minesweeper',
        name: l10n?.gameMinesweeper ?? 'Minesweeper',
        desc: l10n?.gameMinesweeperDesc ?? 'Find all safe cells',
        icon: Icons.flag,
        color: const Color(0xFF4CAF50),
        page: const MinesweeperPage(),
      ),
      _GameInfo(
        id: 'block_drop',
        name: l10n?.gameBlockDrop ?? 'Block Drop',
        desc: l10n?.gameBlockDropDesc ?? 'Drop and clear lines',
        icon: Icons.view_comfy,
        color: const Color(0xFF2196F3),
        page: const BlockDropPage(),
      ),
      _GameInfo(
        id: 'match3',
        name: l10n?.gameMatch3 ?? 'Match 3',
        desc: l10n?.gameMatch3Desc ?? 'Match 3 or more gems',
        icon: Icons.auto_awesome,
        color: const Color(0xFFE91E63),
        page: const Match3Page(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n?.gameCenter ?? 'Games')),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacing),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: _cardAspectRatio(context),
          ),
          itemCount: games.length,
          itemBuilder: (context, index) {
            final game = games[index];
            final high = _highScores[game.id];

            return _buildGameCard(context, game, high, l10n);
          },
        ),
      ),
    );
  }

  /// 0.85 by default; taller cards when narrow screens or large text would
  /// clip the icon + name + two-line description + best score column.
  double _cardAspectRatio(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final cardWidth = (width - AppDimensions.spacing * 2 - 12) / 2;
    // 56 icon + 22 gaps + 32 padding + 8 slack; ~61pt of text at 100%.
    final needed = 118 + MediaQuery.textScalerOf(context).scale(61);
    final ratio = cardWidth / needed;
    return ratio < 0.85 ? ratio : 0.85;
  }

  Widget _buildGameCard(
    BuildContext context,
    _GameInfo game,
    int? highScore,
    S? l10n,
  ) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (_) => game.page),
          );
          await _loadHighScores();
        },
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spacing),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: game.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
                ),
                child: Icon(game.icon, size: 32, color: game.color),
              ),
              const SizedBox(height: AppDimensions.spacingM),
              Text(
                game.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppDimensions.spacingXS),
              Text(
                game.desc,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: context.textSecondary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (highScore != null) ...[
                const SizedBox(height: 6),
                Text(
                  '${l10n?.gameHighScore ?? 'Best'}: $highScore',
                  style: TextStyle(
                    fontSize: 12,
                    // Game accent shaded to 4.5:1 on the card.
                    color: ChatContrast.onTint(
                      game.color,
                      [Theme.of(context).cardColor],
                      dark: context.isDarkMode,
                      alpha: 0,
                    ),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _GameInfo {
  final String id;
  final String name;
  final String desc;
  final IconData icon;
  final Color color;
  final Widget page;

  const _GameInfo({
    required this.id,
    required this.name,
    required this.desc,
    required this.icon,
    required this.color,
    required this.page,
  });
}
