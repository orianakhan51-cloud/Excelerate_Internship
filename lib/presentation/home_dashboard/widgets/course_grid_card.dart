import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CourseGridCard extends StatelessWidget {
  final Map<String, dynamic> courseData;
  final VoidCallback? onTap;
  final VoidCallback? onBookmark;
  final VoidCallback? onLongPress;

  const CourseGridCard({
    Key? key,
    required this.courseData,
    this.onTap,
    this.onBookmark,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rating = (courseData['rating'] as num?)?.toDouble() ?? 0.0;
    final isBookmarked = courseData['isBookmarked'] as bool? ?? false;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowLight,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: CustomImageWidget(
                    imageUrl: courseData['thumbnail'] as String? ?? '',
                    width: double.infinity,
                    height: 15.h,
                    fit: BoxFit.cover,
                    semanticLabel: courseData['semanticLabel'] as String? ??
                        'Course thumbnail image',
                  ),
                ),
                Positioned(
                  top: 2.w,
                  right: 2.w,
                  child: GestureDetector(
                    onTap: onBookmark,
                    child: Container(
                      padding: EdgeInsets.all(1.5.w),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceWhite.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: CustomIconWidget(
                        iconName: isBookmarked ? 'bookmark' : 'bookmark_border',
                        color: isBookmarked
                            ? AppTheme.primaryOrange
                            : AppTheme.neutralMedium,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                if (courseData['level'] != null)
                  Positioned(
                    bottom: 2.w,
                    left: 2.w,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryOrange,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        courseData['level'] as String,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.surfaceWhite,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courseData['title'] as String? ?? 'Course Title',
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      courseData['instructor'] as String? ?? 'Instructor',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.neutralMedium,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'star',
                          color: AppTheme.warningAmber,
                          size: 14,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          rating.toStringAsFixed(1),
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 10.sp,
                          ),
                        ),
                        const Spacer(),
                        if (courseData['price'] != null)
                          Text(
                            courseData['price'] as String,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.primaryOrange,
                              fontWeight: FontWeight.w700,
                              fontSize: 11.sp,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
