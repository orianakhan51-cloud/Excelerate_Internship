import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ContinueLearningCard extends StatelessWidget {
  final Map<String, dynamic> courseData;
  final VoidCallback onResume;

  const ContinueLearningCard({
    Key? key,
    required this.courseData,
    required this.onResume,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = (courseData['progress'] as num?)?.toDouble() ?? 0.0;
    final progressPercentage = (progress * 100).toInt();

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        gradient: AppTheme.brandGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryOrange.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Continue Learning',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.surfaceWhite,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        courseData['title'] as String? ?? 'Course Title',
                        style: AppTheme.lightTheme.textTheme.headlineSmall
                            ?.copyWith(
                          color: AppTheme.surfaceWhite,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        'by ${courseData['instructor'] as String? ?? 'Instructor'}',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.surfaceWhite.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 3.w),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CustomImageWidget(
                    imageUrl: courseData['thumbnail'] as String? ?? '',
                    width: 20.w,
                    height: 15.w,
                    fit: BoxFit.cover,
                    semanticLabel: courseData['semanticLabel'] as String? ??
                        'Course thumbnail image',
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Progress',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color:
                                  AppTheme.surfaceWhite.withValues(alpha: 0.8),
                            ),
                          ),
                          Text(
                            '$progressPercentage%',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.surfaceWhite,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Container(
                        height: 0.8.h,
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceWhite.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: progress,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceWhite,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 4.w),
                ElevatedButton(
                  onPressed: onResume,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.surfaceWhite,
                    foregroundColor: AppTheme.primaryOrange,
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Resume',
                    style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                      color: AppTheme.primaryOrange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
