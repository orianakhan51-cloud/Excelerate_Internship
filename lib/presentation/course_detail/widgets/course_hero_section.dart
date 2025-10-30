import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../../core/app_export.dart';

class CourseHeroSection extends StatefulWidget {
  final Map<String, dynamic> courseData;

  const CourseHeroSection({
    Key? key,
    required this.courseData,
  }) : super(key: key);

  @override
  State<CourseHeroSection> createState() => _CourseHeroSectionState();
}

class _CourseHeroSectionState extends State<CourseHeroSection> {
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _videoController = VideoPlayerController.networkUrl(
        Uri.parse(widget.courseData['previewVideo'] ?? ''),
      );
      await _videoController!.initialize();
      setState(() {
        _isVideoInitialized = true;
      });
    } catch (e) {
      // Video initialization failed, will show image instead
      setState(() {
        _isVideoInitialized = false;
      });
    }
  }

  void _togglePlayPause() {
    if (_videoController != null && _isVideoInitialized) {
      setState(() {
        if (_isPlaying) {
          _videoController!.pause();
          _isPlaying = false;
        } else {
          _videoController!.play();
          _isPlaying = true;
        }
      });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30.h,
      child: Stack(
        children: [
          // Video or Image Background
          _isVideoInitialized && _videoController != null
              ? VideoPlayer(_videoController!)
              : CustomImageWidget(
                  imageUrl: widget.courseData['thumbnail'] ?? '',
                  width: double.infinity,
                  height: 30.h,
                  fit: BoxFit.cover,
                  semanticLabel: widget.courseData['thumbnailSemanticLabel'] ??
                      'Course preview image',
                ),

          // Dark overlay for better text visibility
          Container(
            width: double.infinity,
            height: 30.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.3),
                  Colors.black.withValues(alpha: 0.6),
                ],
              ),
            ),
          ),

          // Play button overlay for video
          if (_isVideoInitialized)
            Center(
              child: GestureDetector(
                onTap: _togglePlayPause,
                child: Container(
                  width: 15.w,
                  height: 15.w,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryOrange.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                  child: CustomIconWidget(
                    iconName: _isPlaying ? 'pause' : 'play_arrow',
                    color: AppTheme.surfaceWhite,
                    size: 8.w,
                  ),
                ),
              ),
            ),

          // Course duration badge
          Positioned(
            bottom: 2.h,
            right: 4.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                widget.courseData['duration'] ?? '0h 0m',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.surfaceWhite,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
