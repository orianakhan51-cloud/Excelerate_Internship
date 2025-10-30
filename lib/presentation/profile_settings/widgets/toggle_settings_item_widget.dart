import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ToggleSettingsItemWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String iconName;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool showDivider;

  const ToggleSettingsItemWidget({
    Key? key,
    required this.title,
    this.subtitle,
    required this.iconName,
    required this.value,
    required this.onChanged,
    this.showDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Row(
            children: [
              Container(
                width: 10.w,
                height: 10.w,
                decoration: BoxDecoration(
                  color: AppTheme.primaryOrange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: iconName,
                    color: AppTheme.primaryOrange,
                    size: 5.w,
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    subtitle != null
                        ? SizedBox(height: 0.5.h)
                        : const SizedBox.shrink(),
                    subtitle != null
                        ? Text(
                            subtitle!,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppTheme.neutralMedium,
                                    ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              Switch(
                value: value,
                onChanged: onChanged,
                activeColor: AppTheme.primaryOrange,
                activeTrackColor: AppTheme.primaryOrange.withValues(alpha: 0.3),
                inactiveThumbColor: AppTheme.neutralMedium,
                inactiveTrackColor:
                    AppTheme.neutralMedium.withValues(alpha: 0.3),
              ),
            ],
          ),
        ),
        showDivider
            ? Divider(
                height: 1,
                thickness: 0.5,
                color: AppTheme.neutralMedium.withValues(alpha: 0.2),
                indent: 4.w,
                endIndent: 4.w,
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
