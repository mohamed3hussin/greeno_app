import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/core/theme/app_colors.dart';
import 'package:greeno_app/core/theme/app_text_styles.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.onTap,
    required this.user
  });
  final VoidCallback onTap;
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 150.h,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 45.r,
                  child: Icon(
                    Icons.person,
                    size: 50.sp,
                  ),
                ),
                SizedBox(width: 12.w,),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user.name,
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.surface,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(height: 8.h,),
                        Text(
                          user.email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.hint.copyWith(
                              color: AppColors.surface,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        SizedBox(height: 8.h,),
                        Text(
                          user.phone,
                          style: AppTextStyles.hint.copyWith(
                              color: AppColors.surface,
                              fontWeight: FontWeight.w400
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
