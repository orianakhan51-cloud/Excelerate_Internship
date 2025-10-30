import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class StorageInfoWidget extends StatelessWidget {
  final Map<String, dynamic> storageData;
  final VoidCallback onClearCache;
  final VoidCallback onManageDownloads;

  const StorageInfoWidget({
    Key? key,
    required this.storageData,
    required this.onClearCache,
    required this.onManageDownloads,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double usedPercentage = (storageData["usedStorage"] as double) /
        (storageData["totalStorage"] as double);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                    iconName: 'storage',
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
                      "Storage Usage",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      "${storageData["usedStorage"]} GB of ${storageData["totalStorage"]} GB used",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.neutralMedium,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Container(
            height: 1.h,
            decoration: BoxDecoration(
              color: AppTheme.neutralLight,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: usedPercentage,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.progressGradient,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onClearCache,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    side: BorderSide(color: AppTheme.neutralMedium),
                  ),
                  child: Text(
                    "Clear Cache",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.neutralMedium,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: onManageDownloads,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  ),
                  child: Text("Manage Downloads"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
