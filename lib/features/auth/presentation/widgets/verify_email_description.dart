import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class VerifyEmailDescription extends StatelessWidget {
  const VerifyEmailDescription({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Text(
          email,
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),

        SizedBox(height: 10.h),

        Text(
          'Please verify your email before continuing.',
          textAlign: TextAlign.center,
          style: AppTextStyles.hint,
        ),
      ],
    );
  }
}