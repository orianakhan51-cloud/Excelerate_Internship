import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class SocialRegistrationWidget extends StatelessWidget {
  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;
  final VoidCallback onFacebookTap;

  const SocialRegistrationWidget({
    Key? key,
    required this.onGoogleTap,
    required this.onAppleTap,
    required this.onFacebookTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: AppTheme.neutralMedium.withValues(alpha: 0.3),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                'Or register with',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.neutralMedium,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: AppTheme.neutralMedium.withValues(alpha: 0.3),
              ),
            ),
          ],
        ),
        SizedBox(height: 3.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSocialButton(
              onTap: onGoogleTap,
              icon:
                  'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/google/google-original.svg',
              label: 'Google',
              semanticLabel: 'Google logo with colorful G letter',
            ),
            _buildSocialButton(
              onTap: onAppleTap,
              icon:
                  'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/apple/apple-original.svg',
              label: 'Apple',
              semanticLabel: 'Apple logo with black apple silhouette',
            ),
            _buildSocialButton(
              onTap: onFacebookTap,
              icon:
                  'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/facebook/facebook-original.svg',
              label: 'Facebook',
              semanticLabel: 'Facebook logo with blue f letter',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required VoidCallback onTap,
    required String icon,
    required String label,
    required String semanticLabel,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20.w,
        height: 20.w,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.neutralMedium.withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowLight,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: CustomImageWidget(
            imageUrl: icon,
            width: 8.w,
            height: 8.w,
            fit: BoxFit.contain,
            semanticLabel: semanticLabel,
          ),
        ),
      ),
    );
  }
}
