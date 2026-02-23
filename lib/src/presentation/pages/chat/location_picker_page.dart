import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:url_launcher/url_launcher.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';

/// 位置选择页面（微信风格）
class ChatLocationPickerPage extends StatefulWidget {
  const ChatLocationPickerPage();

  @override
  State<ChatLocationPickerPage> createState() => _ChatLocationPickerPageState();
}

class _ChatLocationPickerPageState extends State<ChatLocationPickerPage> {
  Position? _currentPosition;
  String _currentAddress = 'Getting location...';
  bool _isLoading = true;
  String? _errorMessage;
  
  // 附近地点列表
  List<NearbyPlace> _nearbyPlaces = [];
  int _selectedPlaceIndex = 0;
  
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // 检查位置服务
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _isLoading = false;
          _errorMessage = S.of(context)?.chatLocationServiceNotEnabled ?? 'Location service not enabled';
        });
        return;
      }

      // 检查权限
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _isLoading = false;
            _errorMessage = S.of(context)?.chatLocationPermissionDenied ?? 'Location permission denied';
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _isLoading = false;
          _errorMessage = S.of(context)?.chatLocationPermissionDeniedPermanent ?? 'Location permission permanently denied';
        });
        return;
      }
      
      // 获取当前位置
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );
      
      setState(() {
        _currentPosition = position;
      });
      
      // 获取地址
      await _getAddressFromPosition(position);
      
      // 生成附近地点
      _generateNearbyPlaces(position);
      
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = S.of(context)?.chatGetLocationFailed(e.toString()) ?? 'Failed to get location: $e';
      });
    }
  }

  Future<void> _getAddressFromPosition(Position position) async {
    try {
      // 使用简单的坐标显示，因为 geocoding 可能需要 API key
      setState(() {
        _currentAddress = '${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}';
      });
      
      // 尝试使用 geocoding 获取地址
      // 注意：这可能需要配置 API key
      // final placemarks = await placemarkFromCoordinates(
      //   position.latitude,
      //   position.longitude,
      // );
      // if (placemarks.isNotEmpty) {
      //   final place = placemarks.first;
      //   _currentAddress = '${place.locality ?? ''} ${place.street ?? ''}';
      // }
    } catch (e) {
      debugPrint('Get address error: $e');
    }
  }
  
  /// 搜索地点（使用 geocoding）
  Timer? _searchDebounce;

  void _searchPlaces(String query) {
    _searchDebounce?.cancel();
    if (query.trim().isEmpty) {
      // 清空搜索时恢复附近地点
      if (_currentPosition != null) {
        setState(() => _generateNearbyPlaces(_currentPosition!));
      }
      return;
    }

    _searchDebounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        final locations = await geocoding.locationFromAddress(query);
        if (!mounted) return;

        final results = <NearbyPlace>[];
        for (final loc in locations.take(5)) {
          final placemarks = await geocoding.placemarkFromCoordinates(
            loc.latitude,
            loc.longitude,
          );
          final pm = placemarks.isNotEmpty ? placemarks.first : null;
          results.add(NearbyPlace(
            name: pm?.name ?? query,
            address: [pm?.street, pm?.locality, pm?.country]
                .where((s) => s != null && s.isNotEmpty)
                .join(', '),
            latitude: loc.latitude,
            longitude: loc.longitude,
            icon: Icons.location_on,
            iconColor: AppColors.primary,
          ));
        }

        if (mounted) {
          setState(() {
            _nearbyPlaces = results;
            _selectedPlaceIndex = 0;
          });
        }
      } catch (e) {
        debugPrint('Place search error: $e');
      }
    });
  }

  void _generateNearbyPlaces(Position position) {
    // 生成模拟的附近地点
    // 实际应用中应该使用地图 API 获取真实的 POI 数据
    final l10n = S.of(context);
    final myLocation = l10n?.chatMyLocation ?? 'My Location';
    final currentLocation = l10n?.chatCurrentLocation ?? 'Current Location';

    _nearbyPlaces = [
      NearbyPlace(
        name: myLocation,
        address: _currentAddress,
        latitude: position.latitude,
        longitude: position.longitude,
        icon: Icons.my_location,
        iconColor: AppColors.primary,
      ),
      NearbyPlace(
        name: currentLocation,
        address: '${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}',
        latitude: position.latitude,
        longitude: position.longitude,
        icon: Icons.location_on,
        iconColor: Colors.red,
      ),
      // 模拟附近地点（实际应从地图 API 获取）
      NearbyPlace(
        name: l10n?.chatNearbyPlace(1) ?? 'Nearby Place 1',
        address: l10n?.chatApproximateDistance('100m') ?? 'About 100m',
        latitude: position.latitude + 0.001,
        longitude: position.longitude + 0.001,
        icon: Icons.place,
        iconColor: Colors.orange,
      ),
      NearbyPlace(
        name: l10n?.chatNearbyPlace(2) ?? 'Nearby Place 2',
        address: l10n?.chatApproximateDistance('200m') ?? 'About 200m',
        latitude: position.latitude - 0.001,
        longitude: position.longitude + 0.002,
        icon: Icons.place,
        iconColor: Colors.orange,
      ),
      NearbyPlace(
        name: l10n?.chatNearbyPlace(3) ?? 'Nearby Place 3',
        address: l10n?.chatApproximateDistance('500m') ?? 'About 500m',
        latitude: position.latitude + 0.002,
        longitude: position.longitude - 0.002,
        icon: Icons.place,
        iconColor: Colors.orange,
      ),
    ];
  }
  
  void _confirmLocation() {
    if (_currentPosition == null) return;

    final selectedPlace = _nearbyPlaces.isNotEmpty
        ? _nearbyPlaces[_selectedPlaceIndex]
        : null;

    Navigator.pop(context, {
      'latitude': selectedPlace?.latitude ?? _currentPosition!.latitude,
      'longitude': selectedPlace?.longitude ?? _currentPosition!.longitude,
      'address': _currentAddress,
      'name': selectedPlace?.name ?? (S.of(context)?.chatMyLocation ?? 'My Location'),
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1C1C1E) : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1C1C1E) : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          S.of(context)?.chatLocationTitle ?? 'Location',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _currentPosition != null ? _confirmLocation : null,
            child: Text(
              S.of(context)?.chatSendButton ?? 'Send',
              style: TextStyle(
                color: _currentPosition != null
                    ? AppColors.primary
                    : Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(S.of(context)?.chatGettingLocation ?? 'Getting location...'),
                ],
              ),
            )
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_off,
                        size: 64,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _getCurrentLocation,
                        child: Text(S.of(context)?.commonRetry ?? 'Retry'),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    // 地图预览区域
                    Container(
                      height: 200,
                      width: double.infinity,
                      color: isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F7),
                      child: Stack(
                        children: [
                          // 地图占位符
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.map,
                                  size: 48,
                                  color: isDark ? Colors.white38 : Colors.black26,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  S.of(context)?.chatMapPreview ?? 'Map Preview',
                                  style: TextStyle(
                                    color: isDark ? Colors.white38 : Colors.black26,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _currentAddress,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? Colors.white54 : Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // 中心标记
                          const Center(
                            child: Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                          // 重新定位按钮
                          Positioned(
                            right: 16,
                            bottom: 16,
                            child: FloatingActionButton.small(
                              onPressed: _getCurrentLocation,
                              backgroundColor: Colors.white,
                              child: const Icon(
                                Icons.my_location,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 搜索框
                    Container(
                      padding: const EdgeInsets.all(12),
                      color: isDark ? const Color(0xFF2C2C2E) : Colors.white,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: S.of(context)?.chatSearchLocation ?? 'Search location',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: isDark 
                              ? const Color(0xFF3A3A3C) 
                              : const Color(0xFFF2F2F7),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        onChanged: (value) {
                          _searchPlaces(value);
                        },
                      ),
                    ),
                    // 附近地点列表
                    Expanded(
                      child: ListView.builder(
                        itemCount: _nearbyPlaces.length,
                        itemBuilder: (context, index) {
                          final place = _nearbyPlaces[index];
                          final isSelected = index == _selectedPlaceIndex;
                          
                          return ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: place.iconColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                place.icon,
                                color: place.iconColor,
                                size: 22,
                              ),
                            ),
                            title: Text(
                              place.name,
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontWeight: isSelected 
                                    ? FontWeight.w600 
                                    : FontWeight.normal,
                              ),
                            ),
                            subtitle: Text(
                              place.address,
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark ? Colors.white54 : Colors.black54,
                              ),
                            ),
                            trailing: isSelected
                                ? const Icon(
                                    Icons.check_circle,
                                    color: AppColors.primary,
                                  )
                                : null,
                            onTap: () {
                              setState(() {
                                _selectedPlaceIndex = index;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}

/// 附近地点数据类
class NearbyPlace {
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final IconData icon;
  final Color iconColor;

  NearbyPlace({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.icon,
    required this.iconColor,
  });
}

/// 位置详情页面 - 微信/WhatsApp风格
class ChatLocationDetailPage extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String locationName;

  const ChatLocationDetailPage({
    required this.latitude,
    required this.longitude,
    required this.locationName,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: Stack(
        children: [
          // 地图区域（占满屏幕）
          Positioned.fill(
            child: Container(
              color: const Color(0xFFE8EEF0),
              child: CustomPaint(
                painter: _LargeMapPainter(),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 位置标记
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: AppColors.primary,
                          size: 32,
                        ),
                      ),
                      // 标记阴影
                      Container(
                        width: 16,
                        height: 6,
                        margin: const EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // 顶部导航栏
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 底部位置信息卡片
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 拖动指示条
                      Container(
                        width: 36,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white24 : Colors.black12,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      // 位置信息
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.location_on,
                              color: AppColors.primary,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  locationName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${latitude.toStringAsFixed(6)}, ${longitude.toStringAsFixed(6)}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // 操作按钮
                      Row(
                        children: [
                          // 复制坐标
                          Expanded(
                            child: _LocationActionButton(
                              icon: Icons.copy_rounded,
                              label: S.of(context)?.chatCopy ?? 'Copy',
                              isDark: isDark,
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: '$latitude, $longitude'));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(S.of(context)?.commonAddressCopied ?? 'Coordinates copied'),
                                    duration: const Duration(seconds: 1),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          // 在地图中打开
                          Expanded(
                            flex: 2,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                final url = 'https://maps.google.com/?q=$latitude,$longitude';
                                final uri = Uri.parse(url);
                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                                }
                              },
                              icon: const Icon(Icons.navigation_rounded, size: 20),
                              label: Text(S.of(context)?.chatMapPreview ?? 'Open in Maps'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 位置详情页面的操作按钮
class _LocationActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;
  final VoidCallback onTap;

  const _LocationActionButton({
    required this.icon,
    required this.label,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDark ? AppColors.backgroundDark : const Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 22,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 大地图网格绘制器
class _LargeMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD4DDE0)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // 绘制网格线
    const spacing = 40.0;
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // 绘制主干道
    final mainPaint = Paint()
      ..color = const Color(0xFFC0CDD2)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    // 水平主干道
    canvas.drawLine(
      Offset(0, size.height * 0.4),
      Offset(size.width, size.height * 0.4),
      mainPaint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.7),
      Offset(size.width, size.height * 0.7),
      mainPaint,
    );

    // 垂直主干道
    canvas.drawLine(
      Offset(size.width * 0.3, 0),
      Offset(size.width * 0.3, size.height),
      mainPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.6, 0),
      Offset(size.width * 0.6, size.height),
      mainPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// 联系人名片选择底部弹窗
