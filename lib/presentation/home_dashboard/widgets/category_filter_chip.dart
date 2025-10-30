import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class CategoryFilterChip extends StatelessWidget {
  final String category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryFilterChip({
    Key? key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 3.w),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryOrange
              : AppTheme.lightTheme.cardColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryOrange
                : AppTheme.neutralMedium.withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primaryOrange.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          category,
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: isSelected ? AppTheme.surfaceWhite : AppTheme.neutralDark,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
