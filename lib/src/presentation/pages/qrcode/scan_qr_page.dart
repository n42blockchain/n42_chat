import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import '../../widgets/common/common_widgets.dart';
import 'my_qrcode_page.dart';

/// 扫一扫页面
class ScanQRPage extends StatefulWidget {
  const ScanQRPage({super.key});

  @override
  State<ScanQRPage> createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final TextEditingController _inputController = TextEditingController();
  bool _isProcessing = false;
  bool _showManualInput = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _processQRCode(String data) async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    try {
      // 解析二维码数据
      // 格式: n42chat://user/@username:server.com
      if (data.startsWith('n42chat://user/')) {
        final userId = data.replaceFirst('n42chat://user/', '');
        await _startChatWithUser(userId);
      } else if (data.startsWith('@') && data.contains(':')) {
        // 直接是 Matrix ID
        await _startChatWithUser(data);
      } else {
        _showError('无效的二维码');
      }
    } catch (e) {
      _showError('处理二维码失败: $e');
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  Future<void> _startChatWithUser(String userId) async {
    try {
      final clientManager = getIt<MatrixClientManager>();
      final client = clientManager.client;

      if (client == null) {
        _showError('聊天服务未连接');
        return;
      }

      // 创建私聊
      final roomId = await client.startDirectChat(userId);
      
      if (mounted) {
        Navigator.of(context).pop({'roomId': roomId, 'userId': userId});
      }
    } catch (e) {
      _showError('无法添加好友: $e');
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _showMyQRCode() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const MyQRCodePage()),
    );
  }

  void _toggleManualInput() {
    setState(() {
      _showManualInput = !_showManualInput;
    });
  }

  void _submitManualInput() {
    final input = _inputController.text.trim();
    if (input.isNotEmpty) {
      _processQRCode(input);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;
    final scanSize = screenSize.width * 0.7;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '扫一扫',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library_outlined, color: Colors.white),
            onPressed: () {
              // TODO: 从相册选择图片识别二维码
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('相册功能即将推出')),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // 扫描区域背景（模拟相机）
          Container(
            color: Colors.black87,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 扫描框
                  Container(
                    width: scanSize,
                    height: scanSize,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white30, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        // 四个角装饰
                        _buildCorner(Alignment.topLeft),
                        _buildCorner(Alignment.topRight),
                        _buildCorner(Alignment.bottomLeft),
                        _buildCorner(Alignment.bottomRight),
                        
                        // 扫描线动画
                        AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Positioned(
                              top: _animation.value * (scanSize - 4),
                              left: 8,
                              right: 8,
                              child: Container(
                                height: 2,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      const Color(0xFF07C160),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        
                        // 中心图标
                        Center(
                          child: Icon(
                            Icons.qr_code_scanner,
                            size: 60,
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  Text(
                    '将二维码放入框内，即可自动扫描',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // 由于没有实际相机，显示手动输入选项
                  TextButton(
                    onPressed: _toggleManualInput,
                    child: Text(
                      _showManualInput ? '关闭手动输入' : '手动输入用户 ID',
                      style: const TextStyle(
                        color: Color(0xFF07C160),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  
                  // 手动输入框
                  if (_showManualInput) ...[
                    const SizedBox(height: 16),
                    Container(
                      width: scanSize,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _inputController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: '@username:server.com',
                                hintStyle: TextStyle(color: Colors.white38),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.1),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: _isProcessing ? null : _submitManualInput,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF07C160),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: _isProcessing
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text('添加'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          
          // 底部功能按钮
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBottomButton(
                  icon: Icons.qr_code,
                  label: '我的二维码',
                  onTap: _showMyQRCode,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner(Alignment alignment) {
    final isTop = alignment == Alignment.topLeft || alignment == Alignment.topRight;
    final isLeft = alignment == Alignment.topLeft || alignment == Alignment.bottomLeft;

    return Positioned(
      top: isTop ? 0 : null,
      bottom: isTop ? null : 0,
      left: isLeft ? 0 : null,
      right: isLeft ? null : 0,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          border: Border(
            top: isTop ? const BorderSide(color: Color(0xFF07C160), width: 3) : BorderSide.none,
            bottom: isTop ? BorderSide.none : const BorderSide(color: Color(0xFF07C160), width: 3),
            left: isLeft ? const BorderSide(color: Color(0xFF07C160), width: 3) : BorderSide.none,
            right: isLeft ? BorderSide.none : const BorderSide(color: Color(0xFF07C160), width: 3),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

