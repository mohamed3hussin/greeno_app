import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greeno_app/core/constants/app_images.dart';
import 'package:greeno_app/core/theme/app_text_styles.dart';

class AuthHeader extends StatelessWidget {
  final String welcomeTitle;
  final String welcomeSubtitle;
  final String? extraTitle;
  const AuthHeader({
    super.key,
    required this.welcomeTitle,
    required this.welcomeSubtitle,
    this.extraTitle
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h,),
        SvgPicture.asset(
            AppImages.logo,
            width: 120.w,

        ),
        SizedBox(height: 12.h,),
        Text(
          'Greeno',
          style: AppTextStyles.heading,
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 4.h,),

        Text(
          'Fresh groceries, better life.',
          style: AppTextStyles.hint,
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 12.h,),

        Text(
          welcomeTitle,
          style: AppTextStyles.title,
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 4.h,),
        Text(
          welcomeSubtitle,
          style: AppTextStyles.hint,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.h,),
        if(extraTitle != null)
        Text(
          extraTitle!,
          style: AppTextStyles.hint,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
