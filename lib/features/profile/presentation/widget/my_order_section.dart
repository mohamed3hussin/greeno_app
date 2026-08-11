import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/core/assets_date/iconBroken.dart';
import 'package:greeno_app/core/theme/app_text_styles.dart';

import '../../../../core/theme/app_colors.dart';

class MyOrderSection extends StatelessWidget {
  const MyOrderSection({
    super.key,
    required this.onTap,
  });
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 1,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12.r)),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(.08),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(IconBroken.Bag,color: AppColors.primary,)
              ),
              SizedBox(width: 6.w,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Orders',
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h,),
                    Text(
                      'view your orders and track them',
                      style: AppTextStyles.hint,
                    ),
                  ],
                ),
              ),
              Icon(IconBroken.Arrow___Right_2),
            ],
          ),
        ),
      ),
    );
  }
}
