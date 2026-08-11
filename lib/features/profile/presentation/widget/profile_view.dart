import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';
import 'package:greeno_app/features/profile/presentation/widget/more_option_section.dart';
import 'package:greeno_app/features/profile/presentation/widget/my_order_section.dart';
import 'package:greeno_app/features/profile/presentation/widget/profile_header.dart';

import '../../../../core/routes/route_names.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
    required this.user
  });
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(onTap: (){}, user: user),
            SizedBox(height: 20.h,),
            MyOrderSection(onTap: (){
              context.push(
                RouteNames.myOrders,
                extra: user,
              );
            }),
            SizedBox(height: 10.h,),
            MoreOptionSection(),
          ],
        ),
      ),
    );
  }
}
