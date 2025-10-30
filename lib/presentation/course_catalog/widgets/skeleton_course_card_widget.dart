import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class SkeletonCourseCardWidget extends StatefulWidget {
  const SkeletonCourseCardWidget({Key? key}) : super(key: key);

  @override
  State<SkeletonCourseCardWidget> createState() =>
      _SkeletonCourseCardWidgetState();
}

class _SkeletonCourseCardWidgetState extends State<SkeletonCourseCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppTheme.shadowLight,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSkeletonThumbnail(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSkeletonTitle(),
                      SizedBox(height: 1.h),
                      _buildSkeletonInstructor(),
                      SizedBox(height: 1.h),
                      _buildSkeletonRatingAndPrice(),
                      const Spacer(),
                      _buildSkeletonDuration(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSkeletonThumbnail() {
    return Container(
      width: double.infinity,
      height: 20.h,
      decoration: BoxDecoration(
        color: AppTheme.neutralLight.withValues(alpha: _animation.value),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
    );
  }

  Widget _buildSkeletonTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 2.h,
          decoration: BoxDecoration(
            color: AppTheme.neutralLight.withValues(alpha: _animation.value),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          width: 70.w,
          height: 2.h,
          decoration: BoxDecoration(
            color: AppTheme.neutralLight.withValues(alpha: _animation.value),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }

  Widget _buildSkeletonInstructor() {
    return Container(
      width: 50.w,
      height: 1.5.h,
      decoration: BoxDecoration(
        color: AppTheme.neutralLight.withValues(alpha: _animation.value),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildSkeletonRatingAndPrice() {
    return Row(
      children: [
        Container(
          width: 20.w,
          height: 1.5.h,
          decoration: BoxDecoration(
            color: AppTheme.neutralLight.withValues(alpha: _animation.value),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const Spacer(),
        Container(
          width: 15.w,
          height: 1.5.h,
          decoration: BoxDecoration(
            color: AppTheme.neutralLight.withValues(alpha: _animation.value),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }

  Widget _buildSkeletonDuration() {
    return Container(
      width: 25.w,
      height: 1.5.h,
      decoration: BoxDecoration(
        color: AppTheme.neutralLight.withValues(alpha: _animation.value),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
