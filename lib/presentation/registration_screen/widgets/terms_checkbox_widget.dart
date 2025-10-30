import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class TermsCheckboxWidget extends StatelessWidget {
  final bool isAccepted;
  final Function(bool?) onChanged;
  final VoidCallback onTermsTap;
  final VoidCallback onPrivacyTap;

  const TermsCheckboxWidget({
    Key? key,
    required this.isAccepted,
    required this.onChanged,
    required this.onTermsTap,
    required this.onPrivacyTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: isAccepted,
          onChanged: onChanged,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.neutralMedium,
                height: 1.4,
              ),
              children: [
                TextSpan(text: 'I agree to the '),
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(
                    color: AppTheme.primaryOrange,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onTermsTap,
                ),
                TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: AppTheme.primaryOrange,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onPrivacyTap,
                ),
                TextSpan(text: ' of MADG28 Learning.'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
