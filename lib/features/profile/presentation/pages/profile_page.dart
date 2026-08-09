import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/core/theme/app_colors.dart';
import 'package:greeno_app/core/theme/app_text_styles.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';
import 'package:greeno_app/features/home/presentation/widgets/home_icon_button.dart';
import 'package:greeno_app/features/profile/presentation/widget/profile_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required this.user
  });
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Text('Profile'),
        ),
        centerTitle: false,
        actions: [
          HomeIconButton(icon: Icons.edit, onPressed: (){}, color: AppColors.primary)
        ],
        actionsPadding: EdgeInsets.only(right: 10.w),
      ),
      body: ProfileView(user: user,),
    );
  }
}
