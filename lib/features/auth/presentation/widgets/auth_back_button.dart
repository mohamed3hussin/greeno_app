import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:greeno_app/core/assets_date/iconBroken.dart';

import '../../../../core/theme/app_colors.dart';

class AuthBackButton extends StatelessWidget {
  const AuthBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
          onPressed: ()=>context.pop(),
          icon: const Icon(IconBroken.Arrow___Left,color: AppColors.primary,),
      ),
    );
  }
}
