import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class FormValidationWidget extends StatelessWidget {
  final String? errorMessage;
  final bool isValid;
  final bool showValidation;

  const FormValidationWidget({
    Key? key,
    this.errorMessage,
    required this.isValid,
    required this.showValidation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!showValidation) return SizedBox.shrink();

    return Container(
      margin: EdgeInsets.only(top: 1.h),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: isValid ? 'check_circle' : 'error',
            color: isValid ? AppTheme.successGreen : AppTheme.errorRed,
            size: 16,
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              errorMessage ?? (isValid ? 'Valid' : 'Invalid'),
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: isValid ? AppTheme.successGreen : AppTheme.errorRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
