import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets_date/iconBroken.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class MoreOptionSection extends StatelessWidget {
  const MoreOptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MoreOptionItem(
              icon: IconBroken.Location,
              title: 'Addresses',
              onTap: (){},
              iconColor: AppColors.primary,
              titleColor: AppColors.textPrimary,
              logout: false,
          ),
          Padding(
            padding: EdgeInsets.only(left: 65.w,right: 20.w),
            child: Divider(
              color: AppColors.border.withOpacity(.15),
              thickness: 1,
            ),
          ),
          MoreOptionItem(
            icon: Icons.credit_card,
            title: 'Payment Method',
            onTap: (){},
            iconColor: AppColors.primary,
            titleColor: AppColors.textPrimary,
            logout: false,
          ),
          Padding(
            padding: EdgeInsets.only(left: 65.w,right: 20.w),
            child: Divider(
              color: AppColors.border.withOpacity(.15),
              thickness: 1,
            ),
          ),
          MoreOptionItem(
            icon: IconBroken.Heart,
            title: 'Favorites',
            onTap: (){},
            iconColor: AppColors.primary,
            titleColor: AppColors.textPrimary,
            logout: false,
          ),
          Padding(
            padding: EdgeInsets.only(left: 65.w,right: 20.w),
            child: Divider(
              color: AppColors.border.withOpacity(.15),
              thickness: 1,
            ),
          ),
          MoreOptionItem(
            icon: IconBroken.Discount,
            title: 'Coupons',
            onTap: (){},
            iconColor: AppColors.primary,
            titleColor: AppColors.textPrimary,
            logout: false,
          ),
          Padding(
            padding: EdgeInsets.only(left: 65.w,right: 20.w),
            child: Divider(
              color: AppColors.border.withOpacity(.15),
              thickness: 1,
            ),
          ),
          MoreOptionItem(
            icon: IconBroken.Notification,
            title: 'Notification',
            onTap: (){},
            iconColor: AppColors.primary,
            titleColor: AppColors.textPrimary,
            logout: false,
          ),
          Padding(
            padding: EdgeInsets.only(left: 65.w,right: 20.w),
            child: Divider(
              color: AppColors.border.withOpacity(.15),
              thickness: 1,
            ),
          ),
          MoreOptionItem(
            icon: Icons.headset_mic_outlined,
            title: 'Help & Support',
            onTap: (){},
            iconColor: AppColors.primary,
            titleColor: AppColors.textPrimary,
            logout: false,
          ),
          Padding(
            padding: EdgeInsets.only(left: 65.w,right: 20.w),
            child: Divider(
              color: AppColors.border.withOpacity(.15),
              thickness: 1,
            ),
          ),
          MoreOptionItem(
            icon: IconBroken.Setting,
            title: 'Setting',
            onTap: (){},
            iconColor: AppColors.primary,
            titleColor: AppColors.textPrimary,
            logout: false,
          ),
          Padding(
            padding: EdgeInsets.only(left: 65.w,right: 20.w),
            child: Divider(
              color: AppColors.border.withOpacity(.15),
              thickness: 1,
            ),
          ),
          MoreOptionItem(
            icon: IconBroken.Logout,
            title: 'Sign Out',
            onTap: (){},
            iconColor: Colors.red,
            titleColor: Colors.red,
            logout: true,
          ),
        ],
      ),
    );
  }
}
class MoreOptionItem extends StatelessWidget {
  const MoreOptionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.iconColor,
    required this.titleColor,
    required this.logout
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? titleColor;
  final bool logout;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 8.w),
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
                child: Icon(icon,color: iconColor,),
            ),
            SizedBox(width: 6.w,),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w600,
                  color: titleColor,
                ),
              ),
            ),
            if(!logout)
              Icon(IconBroken.Arrow___Right_2),
          ],
        ),
      ),
    );
  }
}

