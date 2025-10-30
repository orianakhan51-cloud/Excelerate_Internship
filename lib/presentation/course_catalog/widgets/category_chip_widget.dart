import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CategoryChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final int? count;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const CategoryChipWidget({
    Key? key,
    required this.label,
    this.isSelected = false,
    this.count,
    this.onTap,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 2.w),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryOrange.withValues(alpha: 0.1)
              : AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryOrange
                : AppTheme.neutralMedium.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color:
                    isSelected ? AppTheme.primaryOrange : AppTheme.neutralDark,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            if (count != null && count! > 0) ...[
              SizedBox(width: 1.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.w),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primaryOrange
                      : AppTheme.neutralMedium,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  count.toString(),
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.surface,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
            if (isSelected && onRemove != null) ...[
              SizedBox(width: 2.w),
              GestureDetector(
                onTap: onRemove,
                child: CustomIconWidget(
                  iconName: 'close',
                  color: AppTheme.primaryOrange,
                  size: 4.w,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
