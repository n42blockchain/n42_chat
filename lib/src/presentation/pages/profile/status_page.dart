import 'package:flutter/material.dart';

/// 状态设置页面（仿微信）
class StatusPage extends StatefulWidget {
  final String? currentStatus;
  
  const StatusPage({super.key, this.currentStatus});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  final TextEditingController _customController = TextEditingController();
  
  // 状态分类数据
  final List<StatusCategory> _categories = [
    StatusCategory(
      title: '心情想法',
      items: [
        StatusItem(icon: Icons.sentiment_very_satisfied, text: '美滋滋'),
        StatusItem(icon: Icons.sentiment_dissatisfied, text: '裂开'),
        StatusItem(icon: Icons.auto_awesome, text: '求锦鲤'),
        StatusItem(icon: Icons.wb_sunny_outlined, text: '等天晴'),
        StatusItem(icon: Icons.airline_seat_recline_normal, text: '疲惫'),
        StatusItem(icon: Icons.psychology_outlined, text: '发呆'),
        StatusItem(icon: Icons.flash_on, text: '冲'),
        StatusItem(icon: Icons.mood_bad, text: 'emo'),
        StatusItem(icon: Icons.cloud_outlined, text: '胡思乱想'),
        StatusItem(icon: Icons.celebration, text: '元气满满'),
        StatusItem(icon: Icons.smart_toy_outlined, text: 'bot'),
      ],
    ),
    StatusCategory(
      title: '工作学习',
      items: [
        StatusItem(icon: Icons.construction, text: '搬砖'),
        StatusItem(icon: Icons.menu_book, text: '沉迷学习'),
        StatusItem(icon: Icons.work_outline, text: '忙'),
        StatusItem(icon: Icons.catching_pokemon, text: '摸鱼'),
        StatusItem(icon: Icons.flight_takeoff, text: '出差'),
        StatusItem(icon: Icons.directions_run, text: '飞奔回家'),
        StatusItem(icon: Icons.do_not_disturb_on_outlined, text: '勿扰模式'),
      ],
    ),
    StatusCategory(
      title: '活动',
      items: [
        StatusItem(icon: Icons.surfing, text: '浪'),
        StatusItem(icon: Icons.check_circle_outline, text: '打卡'),
        StatusItem(icon: Icons.fitness_center, text: '运动'),
        StatusItem(icon: Icons.coffee_outlined, text: '喝咖啡'),
        StatusItem(icon: Icons.local_cafe_outlined, text: '喝奶茶'),
        StatusItem(icon: Icons.rice_bowl, text: '干饭'),
        StatusItem(icon: Icons.child_friendly, text: '带娃'),
        StatusItem(icon: Icons.public, text: '拯救世界'),
        StatusItem(icon: Icons.camera_alt_outlined, text: '自拍'),
      ],
    ),
    StatusCategory(
      title: '休息',
      items: [
        StatusItem(icon: Icons.self_improvement, text: '闭关'),
        StatusItem(icon: Icons.home_outlined, text: '宅'),
        StatusItem(icon: Icons.bedtime_outlined, text: '睡觉'),
        StatusItem(icon: Icons.pets, text: '吸猫'),
        StatusItem(icon: Icons.pets_outlined, text: '遛狗'),
        StatusItem(icon: Icons.sports_esports, text: '玩游戏'),
        StatusItem(icon: Icons.headphones, text: '听歌'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8B9A6B), // 黄绿色
              Color(0xFFB5A87A), // 浅棕色
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 顶部导航栏
              _buildHeader(),
              
              // 内容区域
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 填写状态输入框
                      _buildCustomInput(),
                      
                      // 状态分类列表
                      ..._categories.map((category) => _buildCategory(category)),
                      
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
          // 关闭按钮
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 28,
            ),
          ),
          
          // 标题
          Expanded(
            child: Column(
              children: [
                const Text(
                  '设个状态',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '朋友 24 小时内可见',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          
          // 占位，保持标题居中
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
              '填写状态',
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
          // 分类标题
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
          
          // 状态网格
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
        width: (MediaQuery.of(context).size.width - 32 - 16) / 5, // 5列
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
        title: const Text('填写状态'),
        content: TextField(
          controller: _customController,
          autofocus: true,
          maxLength: 20,
          decoration: const InputDecoration(
            hintText: '输入你的状态...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              if (_customController.text.trim().isNotEmpty) {
                Navigator.pop(ctx);
                Navigator.pop(context, _customController.text.trim());
              }
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}

/// 状态分类
class StatusCategory {
  final String title;
  final List<StatusItem> items;
  
  StatusCategory({required this.title, required this.items});
}

/// 状态项
class StatusItem {
  final IconData icon;
  final String text;
  
  StatusItem({required this.icon, required this.text});
}

