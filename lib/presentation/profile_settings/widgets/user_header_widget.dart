import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class UserHeaderWidget extends StatelessWidget {
  final Map<String, dynamic> userData;
  final VoidCallback onEditPressed;

  const UserHeaderWidget({
    Key? key,
    required this.userData,
    required this.onEditPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: AppTheme.brandGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryOrange.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.surfaceWhite,
                width: 3,
              ),
            ),
            child: ClipOval(
              child: CustomImageWidget(
                imageUrl: userData["profileImage"] as String,
                width: 20.w,
                height: 20.w,
                fit: BoxFit.cover,
                semanticLabel: userData["profileImageSemanticLabel"] as String,
              ),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData["name"] as String,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.surfaceWhite,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  userData["email"] as String,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.surfaceWhite.withValues(alpha: 0.9),
                      ),
                ),
                SizedBox(height: 1.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceWhite.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'local_fire_department',
                        color: AppTheme.surfaceWhite,
                        size: 4.w,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        "${userData["learningStreak"]} day streak",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.surfaceWhite,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onEditPressed,
            icon: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.surfaceWhite.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: 'edit',
                color: AppTheme.surfaceWhite,
                size: 5.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
