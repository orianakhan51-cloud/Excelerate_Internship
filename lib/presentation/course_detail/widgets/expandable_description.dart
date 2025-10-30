import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ExpandableDescription extends StatefulWidget {
  final String description;
  final int maxLines;

  const ExpandableDescription({
    Key? key,
    required this.description,
    this.maxLines = 3,
  }) : super(key: key);

  @override
  State<ExpandableDescription> createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<ExpandableDescription> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About this course',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          AnimatedCrossFade(
            firstChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.description,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                  ),
                  maxLines: widget.maxLines,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 1.h),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = true;
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        'Read More',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.primaryOrange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 1.w),
                      CustomIconWidget(
                        iconName: 'keyboard_arrow_down',
                        color: AppTheme.primaryOrange,
                        size: 4.w,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.description,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 1.h),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = false;
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        'Read Less',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.primaryOrange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 1.w),
                      CustomIconWidget(
                        iconName: 'keyboard_arrow_up',
                        color: AppTheme.primaryOrange,
                        size: 4.w,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
