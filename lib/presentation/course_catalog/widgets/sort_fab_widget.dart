import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SortFabWidget extends StatelessWidget {
  final String currentSort;
  final Function(String) onSortChanged;

  const SortFabWidget({
    Key? key,
    required this.currentSort,
    required this.onSortChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showSortOptions(context),
      backgroundColor: AppTheme.primaryOrange,
      child: CustomIconWidget(
        iconName: 'sort',
        color: AppTheme.surfaceWhite,
        size: 6.w,
      ),
    );
  }

  void _showSortOptions(BuildContext context) {
    final sortOptions = [
      {'key': 'popularity', 'label': 'Popularity', 'icon': 'trending_up'},
      {'key': 'rating', 'label': 'Rating', 'icon': 'star'},
      {
        'key': 'price_low',
        'label': 'Price: Low to High',
        'icon': 'arrow_upward'
      },
      {
        'key': 'price_high',
        'label': 'Price: High to Low',
        'icon': 'arrow_downward'
      },
      {'key': 'newest', 'label': 'Newest', 'icon': 'new_releases'},
      {'key': 'duration', 'label': 'Duration', 'icon': 'access_time'},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.neutralMedium.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'Sort by',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h),
            ...sortOptions.map((option) {
              final isSelected = currentSort == option['key'];
              return ListTile(
                leading: CustomIconWidget(
                  iconName: option['icon'] as String,
                  color: isSelected
                      ? AppTheme.primaryOrange
                      : AppTheme.neutralMedium,
                  size: 6.w,
                ),
                title: Text(
                  option['label'] as String,
                  style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                    color: isSelected
                        ? AppTheme.primaryOrange
                        : AppTheme.neutralDark,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                trailing: isSelected
                    ? CustomIconWidget(
                        iconName: 'check',
                        color: AppTheme.primaryOrange,
                        size: 6.w,
                      )
                    : null,
                onTap: () {
                  onSortChanged(option['key'] as String);
                  Navigator.pop(context);
                },
              );
            }).toList(),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
