import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

import '../../../core/di/injection.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/datasources/matrix/matrix_client_manager.dart';
import 'my_qrcode_page.dart';

/// 扫一扫页面
class ScanQRPage extends StatefulWidget {
  const ScanQRPage({super.key});

  @override
  State<ScanQRPage> createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<ScanQRPage> with WidgetsBindingObserver {
  MobileScannerController? _scannerController;
  final TextEditingController _inputController = TextEditingController();
  bool _isProcessing = false;
  bool _showManualInput = false;
  bool _hasPermission = false;
  bool _isCheckingPermission = true;
  bool _torchEnabled = false;
  String? _permissionError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkCameraPermission();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // 当应用从后台恢复时，重新检查权限
    if (state == AppLifecycleState.resumed) {
      _checkCameraPermission();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scannerController?.dispose();
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _checkCameraPermission() async {
    setState(() {
      _isCheckingPermission = true;
      _permissionError = null;
    });

    try {
      final status = await Permission.camera.status;
      
      if (status.isGranted) {
        _initScanner();
        setState(() {
          _hasPermission = true;
          _isCheckingPermission = false;
        });
      } else if (status.isDenied) {
        // 请求权限
        final result = await Permission.camera.request();
        if (result.isGranted) {
          _initScanner();
          setState(() {
            _hasPermission = true;
            _isCheckingPermission = false;
          });
        } else {
          setState(() {
            _hasPermission = false;
            _isCheckingPermission = false;
            _permissionError = '需要相机权限才能扫描二维码';
          });
        }
      } else if (status.isPermanentlyDenied) {
        setState(() {
          _hasPermission = false;
          _isCheckingPermission = false;
          _permissionError = '相机权限被永久拒绝，请在系统设置中开启';
        });
      } else {
        setState(() {
          _hasPermission = false;
          _isCheckingPermission = false;
          _permissionError = '无法获取相机权限';
        });
      }
    } catch (e) {
      setState(() {
        _hasPermission = false;
        _isCheckingPermission = false;
        _permissionError = '检查权限时出错: $e';
      });
    }
  }

  void _initScanner() {
    _scannerController?.dispose();
    _scannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  void _onDetect(BarcodeCapture capture) {
    if (_isProcessing) return;
    
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      final String? rawValue = barcode.rawValue;
      if (rawValue != null && rawValue.isNotEmpty) {
        _processQRCode(rawValue);
        break;
      }
    }
  }

  Future<void> _processQRCode(String data) async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    // 暂停扫描
    _scannerController?.stop();

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
        // 恢复扫描
        _scannerController?.start();
      }
    } catch (e) {
      _showError('处理二维码失败: $e');
      // 恢复扫描
      _scannerController?.start();
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
        _scannerController?.start();
        return;
      }

      // 创建私聊
      final roomId = await client.startDirectChat(userId);
      
      if (mounted) {
        Navigator.of(context).pop({'roomId': roomId, 'userId': userId});
      }
    } catch (e) {
      _showError('无法添加好友: $e');
      _scannerController?.start();
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

  void _toggleTorch() {
    _scannerController?.toggleTorch();
    setState(() {
      _torchEnabled = !_torchEnabled;
    });
  }

  Future<void> _openSettings() async {
    await openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
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
          if (_hasPermission)
            IconButton(
              icon: Icon(
                _torchEnabled ? Icons.flash_on : Icons.flash_off,
                color: _torchEnabled ? Colors.yellow : Colors.white,
              ),
              onPressed: _toggleTorch,
            ),
        ],
      ),
      body: _buildBody(screenSize, scanSize),
    );
  }

  Widget _buildBody(Size screenSize, double scanSize) {
    // 检查权限中
    if (_isCheckingPermission) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF07C160)),
            ),
            SizedBox(height: 16),
            Text(
              '正在检查相机权限...',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      );
    }

    // 没有权限
    if (!_hasPermission) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white54,
                  size: 40,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                '需要相机权限',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _permissionError ?? '扫描二维码需要使用相机',
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _checkCameraPermission,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF07C160),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('重试'),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: _openSettings,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white54),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('打开设置'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // 手动输入选项
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
              if (_showManualInput) _buildManualInputSection(scanSize),
            ],
          ),
        ),
      );
    }

    // 有权限，显示相机扫描
    return Stack(
      children: [
        // 相机预览
        MobileScanner(
          controller: _scannerController,
          onDetect: _onDetect,
          errorBuilder: (context, error, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '相机启动失败',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.errorDetails?.message ?? '未知错误',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
        
        // 扫描框遮罩
        _buildScanOverlay(screenSize, scanSize),
        
        // 提示文字
        Positioned(
          top: (screenSize.height - scanSize) / 2 + scanSize + 24,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Text(
                '将二维码放入框内，即可自动扫描',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
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
              if (_showManualInput) _buildManualInputSection(scanSize),
            ],
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
        
        // 处理中指示器
        if (_isProcessing)
          Container(
            color: Colors.black54,
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF07C160)),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildScanOverlay(Size screenSize, double scanSize) {
    final scanRect = Rect.fromCenter(
      center: Offset(screenSize.width / 2, (screenSize.height - 150) / 2),
      width: scanSize,
      height: scanSize,
    );

    return CustomPaint(
      size: screenSize,
      painter: _ScanOverlayPainter(scanRect: scanRect),
      child: Stack(
        children: [
          // 四个角装饰
          Positioned(
            left: scanRect.left,
            top: scanRect.top,
            child: _buildCorner(isTop: true, isLeft: true),
          ),
          Positioned(
            right: screenSize.width - scanRect.right,
            top: scanRect.top,
            child: _buildCorner(isTop: true, isLeft: false),
          ),
          Positioned(
            left: scanRect.left,
            bottom: screenSize.height - scanRect.bottom,
            child: _buildCorner(isTop: false, isLeft: true),
          ),
          Positioned(
            right: screenSize.width - scanRect.right,
            bottom: screenSize.height - scanRect.bottom,
            child: _buildCorner(isTop: false, isLeft: false),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner({required bool isTop, required bool isLeft}) {
    return Container(
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
    );
  }

  Widget _buildManualInputSection(double scanSize) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _inputController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: '@username:server.com',
                hintStyle: const TextStyle(color: Colors.white38),
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

/// 扫描框遮罩绘制器
class _ScanOverlayPainter extends CustomPainter {
  final Rect scanRect;

  _ScanOverlayPainter({required this.scanRect});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    // 绘制四周遮罩
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(scanRect, const Radius.circular(12)))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);

    // 绘制扫描框边框
    final borderPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawRRect(
      RRect.fromRectAndRadius(scanRect, const Radius.circular(12)),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
