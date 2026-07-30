import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_text_styles.dart';

class VerifyEmailHeader extends StatelessWidget {
  const VerifyEmailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        SvgPicture.asset(
          AppImages.email,
          width: 90.w,
        ),

        SizedBox(height: 12.h),

        Text(
          'Verify Your Email',
          style: AppTextStyles.title,
        ),

        SizedBox(height: 6.h),

        Text(
          'We sent a verification link to your email address.',
          textAlign: TextAlign.center,
          style: AppTextStyles.hint,
        ),
      ],
    );
  }
}