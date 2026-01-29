// Copyright 2021-2026 N42 Inc. All rights reserved.
// Use of this source code is governed by a dual license:
// Apache License 2.0 and MIT License.
// See LICENSE file in the project root for full license information.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../../core/di/injection.dart';
import '../../../../data/datasources/matrix/matrix_client_manager.dart';

/// 视频播放器页面
class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;
  final String? thumbnailUrl;

  const VideoPlayerPage({
    super.key,
    required this.videoUrl,
    this.thumbnailUrl,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      debugPrint('Initializing video player with URL: ${widget.videoUrl}');

      // 获取 access token
      String? accessToken;
      try {
        final matrixManager = getIt<MatrixClientManager>();
        accessToken = matrixManager.client?.accessToken;
      } catch (e) {
        debugPrint('Failed to get access token: $e');
      }

      // 创建视频控制器
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
        httpHeaders: accessToken != null
            ? {'Authorization': 'Bearer $accessToken'}
            : {},
      );

      await _controller.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _controller,
        autoPlay: true,
        looping: false,
        aspectRatio: _controller.value.aspectRatio,
        placeholder: widget.thumbnailUrl != null
            ? CachedNetworkImage(
                imageUrl: widget.thumbnailUrl!,
                fit: BoxFit.cover,
              )
            : Container(color: Colors.black),
        errorBuilder: (ctx, errorMessage) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text(
                '${S.of(ctx)?.videoPlaybackFailed ?? 'Video playback failed'}\n$errorMessage',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Video player error: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = e.toString();
        });
      }
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(S.of(context)?.videoTitle ?? 'Video', style: const TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: Center(
        child: _isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: Colors.white),
                  const SizedBox(height: 16),
                  Text(S.of(context)?.loadingText ?? 'Loading...', style: const TextStyle(color: Colors.white)),
                ],
              )
            : _error != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 48),
                      const SizedBox(height: 16),
                      Text(
                        '${S.of(context)?.videoLoadFailed ?? 'Video load failed'}\n$_error',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                            _error = null;
                          });
                          _initializePlayer();
                        },
                        child: Text(S.of(context)?.retryButton ?? 'Retry'),
                      ),
                    ],
                  )
                : _chewieController != null
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio > 0
                            ? _controller.value.aspectRatio
                            : 16 / 9,
                        child: Chewie(controller: _chewieController!),
                      )
                    : Text(S.of(context)?.playerInitFailed ?? 'Player initialization failed', style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
