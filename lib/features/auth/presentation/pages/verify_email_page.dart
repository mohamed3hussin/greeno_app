import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:greeno_app/core/assets_date/iconBroken.dart';
import 'package:greeno_app/core/constants/primary_button.dart';
import 'package:greeno_app/core/theme/app_colors.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';
import 'package:greeno_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:greeno_app/features/auth/presentation/widgets/auth_background.dart';
import 'package:greeno_app/features/auth/presentation/widgets/social_button.dart';
import 'package:greeno_app/features/auth/presentation/widgets/verify_email_description.dart';
import 'package:greeno_app/features/auth/presentation/widgets/verify_email_header.dart';

import '../../../../core/dependency_injection/injection_container.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/utils/email_launcher.dart';
import '../cubit/auth_cubit.dart';
import 'dart:async';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({
    super.key,
    required this.user
  });
  final UserEntity user;

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  Timer? _timer;
  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      const Duration(seconds: 2),
          (_) {
        context.read<AuthCubit>().checkEmailVerification();
      },
    );
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Stack(
        children: [
          const AuthBackground(),
          Scaffold(
            backgroundColor: Colors.transparent ,
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: BlocConsumer<AuthCubit,AuthState>(
                  listener: (context,state){
                    if (state is EmailVerifiedSuccess) {
                      _timer?.cancel();
                      context.go(RouteNames.navigation,extra: widget.user);
                    }
                    if (state is SendEmailVerificationSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Verification email sent successfully.',
                          ),
                        ),
                      );
                    }
                    if (state is EmailNotVerified) {}
                  },
                  builder: (context , state){
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const VerifyEmailHeader(),
                          SizedBox(height: 20.h,),
                          VerifyEmailDescription(email: widget.user.email),
                          SizedBox(height: 30.h,),
                          PrimaryButton(
                              text: 'Open Email App',
                              onPressed: ()async {
                                await EmailLauncher.openEmailApp();
                              },
                          ),
                          SizedBox(height: 30.h,),

                          SocialButton(
                            text: 'Resend Email',
                            icon: Icon(IconBroken.Send),
                            onPressed: (){
                              context.read<AuthCubit>().sendEmailVerification();
                            },
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    );
                  },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

