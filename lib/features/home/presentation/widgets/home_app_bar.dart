import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:greeno_app/core/assets_date/iconBroken.dart';
import 'package:greeno_app/core/theme/app_colors.dart';
import 'package:greeno_app/core/theme/app_text_styles.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';
import 'package:greeno_app/features/home/presentation/widgets/home_icon_button.dart';

import '../../../../core/routes/route_names.dart';
import '../../../navigation/presentation/cubit/navigation_cubit.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.user,
  });
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
                IconBroken.Location,
                color: AppColors.primary,
            ),
            SizedBox(width: 6.w,),
            Expanded(
              child: Text(
                'Deliver to',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
            HomeIconButton(
                color: AppColors.primary,
                icon: IconBroken.Notification,
                onPressed: (){},
            ),
            SizedBox(width: 8.w,),
            HomeIconButton(
                color: AppColors.primary,
                icon: IconBroken.Bag,
                onPressed: (){
                  context.read<NavigationCubit>().changeTab(2);
                },
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          children: [
            Text(
              user.address.fullAddress,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 4.w,),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.primary,
                size: 18.sp,
              ),
            )
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          children: [
            Text(
              'Good Morning',
              style: AppTextStyles.body,
            ),
            SizedBox(width: 2.w,),
            Icon(
                Icons.waving_hand,
                color: Colors.amber,
                size: 18.sp,
            ),
          ],
        ),
        SizedBox(height: 2.h,),
        Text(
          user.name,
          style: AppTextStyles.title,
        ),
      ],
    );
  }
}
