import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_text_styles.dart';

class AddressHeader extends StatelessWidget {
  const AddressHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          AppImages.pin,
          width: 50.w,
        ),

        SizedBox(height: 8.h,),
        Text(
          'Where should we deliver?',
          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 6.h,),

        Text(
          'Choose your delivery location to continue',
          style: AppTextStyles.hint,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
