import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CourseCardWidget extends StatelessWidget {
  final Map<String, dynamic> course;
  final VoidCallback? onTap;
  final VoidCallback? onBookmark;
  final VoidCallback? onShare;

  const CourseCardWidget({
    Key? key,
    required this.course,
    this.onTap,
    this.onBookmark,
    this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: () => _showQuickActions(context),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildThumbnail(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(),
                    SizedBox(height: 1.h),
                    _buildInstructor(),
                    SizedBox(height: 1.h),
                    _buildRatingAndPrice(),
                    const Spacer(),
                    _buildDuration(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: CustomImageWidget(
            imageUrl: course['thumbnail'] as String,
            width: double.infinity,
            height: 20.h,
            fit: BoxFit.cover,
            semanticLabel: course['semanticLabel'] as String,
          ),
        ),
        Positioned(
          top: 2.w,
          right: 2.w,
          child: GestureDetector(
            onTap: onBookmark,
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface
                    .withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
              child: CustomIconWidget(
                iconName: (course['isBookmarked'] as bool? ?? false)
                    ? 'bookmark'
                    : 'bookmark_border',
                color: (course['isBookmarked'] as bool? ?? false)
                    ? AppTheme.primaryOrange
                    : AppTheme.neutralMedium,
                size: 5.w,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      course['title'] as String,
      style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildInstructor() {
    return Text(
      course['instructor'] as String,
      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
        color: AppTheme.neutralMedium,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildRatingAndPrice() {
    return Row(
      children: [
        CustomIconWidget(
          iconName: 'star',
          color: AppTheme.warningAmber,
          size: 4.w,
        ),
        SizedBox(width: 1.w),
        Text(
          course['rating'].toString(),
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          course['price'] as String,
          style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
            color: AppTheme.primaryOrange,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildDuration() {
    return Row(
      children: [
        CustomIconWidget(
          iconName: 'access_time',
          color: AppTheme.neutralMedium,
          size: 4.w,
        ),
        SizedBox(width: 1.w),
        Text(
          course['duration'] as String,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.neutralMedium,
          ),
        ),
      ],
    );
  }

  void _showQuickActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(6.w),
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
            SizedBox(height: 4.h),
            _buildQuickActionItem(
              context,
              'preview',
              'Preview Course',
              () => Navigator.pop(context),
            ),
            _buildQuickActionItem(
              context,
              'bookmark_add',
              'Add to Wishlist',
              () {
                Navigator.pop(context);
                onBookmark?.call();
              },
            ),
            _buildQuickActionItem(
              context,
              'compare_arrows',
              'Compare',
              () => Navigator.pop(context),
            ),
            _buildQuickActionItem(
              context,
              'share',
              'Share Course',
              () {
                Navigator.pop(context);
                onShare?.call();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionItem(
    BuildContext context,
    String iconName,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: CustomIconWidget(
        iconName: iconName,
        color: AppTheme.neutralDark,
        size: 6.w,
      ),
      title: Text(
        title,
        style: AppTheme.lightTheme.textTheme.bodyLarge,
      ),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
    );
  }
}
