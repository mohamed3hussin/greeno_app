import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets_date/iconBroken.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'home_icon_button.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          SizedBox(width: 16.w),

          Icon(
            IconBroken.Search,
            color: AppColors.textSecondary,
          ),

          SizedBox(width: 10.w),

          Expanded(
            child: TextField(
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                hintText: 'Search fruits, vegetables...',
                hintStyle: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: HomeIconButton(
              color: AppColors.primary,
              icon: IconBroken.Filter,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}