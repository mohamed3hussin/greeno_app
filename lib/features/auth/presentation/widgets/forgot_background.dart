import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_images.dart';

class ForgotBackground extends StatelessWidget {
  const ForgotBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: 80.h,
            left: 0,
            child:Image.asset(
              AppImages.topLeftLeaf,
              width: 95.w,
            ),
          ),
          Positioned(
            top: 80.h,
            right: 0,
            child:Image.asset(
              AppImages.topRightLeaf,
              width: 120.w,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child:Image.asset(
              AppImages.forgot,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),

        ],
      ),
    );
  }
}
