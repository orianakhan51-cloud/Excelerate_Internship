import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EnrollmentBottomBar extends StatelessWidget {
  final Map<String, dynamic> courseData;
  final VoidCallback onEnrollPressed;
  final bool isEnrolled;

  const EnrollmentBottomBar({
    Key? key,
    required this.courseData,
    required this.onEnrollPressed,
    required this.isEnrolled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Price section
            if (!isEnrolled) ...[
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (courseData['originalPrice'] != null &&
                        courseData['originalPrice'] != courseData['price'])
                      Text(
                        '\$${courseData['originalPrice']}',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: AppTheme.neutralMedium,
                        ),
                      ),
                    Text(
                      courseData['price'] != null
                          ? '\$${courseData['price']}'
                          : 'Free',
                      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primaryOrange,
                      ),
                    ),
                    if (courseData['originalPrice'] != null &&
                        courseData['originalPrice'] != courseData['price'])
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: AppTheme.errorRed.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${_calculateDiscount()}% OFF',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.errorRed,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(width: 4.w),
            ],

            // Action button
            Expanded(
              flex: 3,
              child: ElevatedButton(
                onPressed: onEnrollPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isEnrolled
                      ? AppTheme.successGreen
                      : AppTheme.primaryOrange,
                  foregroundColor: AppTheme.surfaceWhite,
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: isEnrolled ? 'play_arrow' : 'shopping_cart',
                      color: AppTheme.surfaceWhite,
                      size: 5.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      isEnrolled ? 'Start Learning' : 'Enroll Now',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.surfaceWhite,
                        fontWeight: FontWeight.w600,
                      ),
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

  int _calculateDiscount() {
    if (courseData['originalPrice'] == null || courseData['price'] == null) {
      return 0;
    }
    final original = (courseData['originalPrice'] as num).toDouble();
    final current = (courseData['price'] as num).toDouble();
    return ((original - current) / original * 100).round();
  }
}
