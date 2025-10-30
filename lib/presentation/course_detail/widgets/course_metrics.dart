import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CourseMetrics extends StatelessWidget {
  final Map<String, dynamic> courseData;

  const CourseMetrics({
    Key? key,
    required this.courseData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Rating
          _buildMetricItem(
            icon: 'star',
            iconColor: AppTheme.warningAmber,
            value: courseData['rating']?.toString() ?? '4.5',
            label: 'Rating',
          ),

          // Students count
          _buildMetricItem(
            icon: 'people',
            iconColor: AppTheme.primaryPurple,
            value: _formatStudentCount(courseData['studentsCount'] ?? 0),
            label: 'Students',
          ),

          // Duration
          _buildMetricItem(
            icon: 'schedule',
            iconColor: AppTheme.successGreen,
            value: courseData['duration'] ?? '8h 30m',
            label: 'Duration',
          ),

          // Difficulty
          _buildMetricItem(
            icon: 'trending_up',
            iconColor: AppTheme.primaryOrange,
            value: courseData['difficulty'] ?? 'Beginner',
            label: 'Level',
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem({
    required String icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: CustomIconWidget(
            iconName: icon,
            color: iconColor,
            size: 6.w,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          value,
          style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 0.5.h),
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.neutralMedium,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  String _formatStudentCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return count.toString();
    }
  }
}
