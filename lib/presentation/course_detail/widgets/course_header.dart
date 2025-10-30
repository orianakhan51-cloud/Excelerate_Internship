import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CourseHeader extends StatelessWidget {
  final Map<String, dynamic> courseData;
  final VoidCallback onBackPressed;
  final VoidCallback onSharePressed;
  final VoidCallback onBookmarkPressed;
  final bool isBookmarked;

  const CourseHeader({
    Key? key,
    required this.courseData,
    required this.onBackPressed,
    required this.onSharePressed,
    required this.onBookmarkPressed,
    required this.isBookmarked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Back button
            GestureDetector(
              onTap: onBackPressed,
              child: Container(
                width: 10.w,
                height: 10.w,
                decoration: BoxDecoration(
                  color: AppTheme.surfaceWhite,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.shadowLight,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CustomIconWidget(
                  iconName: 'arrow_back',
                  color: AppTheme.neutralDark,
                  size: 5.w,
                ),
              ),
            ),

            SizedBox(width: 4.w),

            // Course title and instructor
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseData['title'] ?? 'Course Title',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    'by ${courseData['instructor'] ?? 'Instructor Name'}',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.neutralMedium,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            SizedBox(width: 4.w),

            // Share button
            GestureDetector(
              onTap: onSharePressed,
              child: Container(
                width: 10.w,
                height: 10.w,
                decoration: BoxDecoration(
                  color: AppTheme.surfaceWhite,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.shadowLight,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CustomIconWidget(
                  iconName: 'share',
                  color: AppTheme.neutralDark,
                  size: 5.w,
                ),
              ),
            ),

            SizedBox(width: 3.w),

            // Bookmark button
            GestureDetector(
              onTap: onBookmarkPressed,
              child: Container(
                width: 10.w,
                height: 10.w,
                decoration: BoxDecoration(
                  color: AppTheme.surfaceWhite,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.shadowLight,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CustomIconWidget(
                  iconName: isBookmarked ? 'bookmark' : 'bookmark_border',
                  color: isBookmarked
                      ? AppTheme.primaryOrange
                      : AppTheme.neutralDark,
                  size: 5.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
