import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:greeno_app/core/assets_date/iconBroken.dart';
import 'package:greeno_app/core/constants/app_images.dart';
import 'package:greeno_app/core/constants/custom_text_field.dart';
import 'package:greeno_app/core/constants/password_text_field.dart';
import 'package:greeno_app/core/constants/primary_button.dart';
import 'package:greeno_app/core/routes/route_names.dart';
import 'package:greeno_app/core/theme/app_colors.dart';
import 'package:greeno_app/core/theme/app_text_styles.dart';
import 'package:greeno_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:greeno_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:greeno_app/features/auth/presentation/cubit/password_visibility_cubit.dart';
import 'package:greeno_app/features/auth/presentation/widgets/auth_background.dart';
import 'package:greeno_app/features/auth/presentation/widgets/auth_footer.dart';
import 'package:greeno_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:greeno_app/features/auth/presentation/widgets/or_divider.dart';
import 'package:greeno_app/features/auth/presentation/widgets/social_button.dart';

import '../../../../core/dependency_injection/injection_container.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers:[
          BlocProvider(
              create: (_)=> sl<AuthCubit>(),
          ),
          BlocProvider(
            create: (_)=> sl<PasswordVisibilityCubit>(),
          ),
        ],
        child: const _loginView(),
    );
  }
}
class _loginView extends StatefulWidget{
  const _loginView();

  @override
  State<_loginView> createState() => _loginViewState();
}

class _loginViewState extends State<_loginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: BlocConsumer<AuthCubit,AuthState>(
                listener: (context,state){
                  if(state is AuthAuthenticated){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Login Success'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    context.go(RouteNames.navigation,extra: state.user);
                  }
                  if(state is AuthError){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message),),
                    );
                  }
                },
                builder: (context,state){
                  return Form(
                    key: _formKey,
                    child:SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Center(
                              child: const AuthHeader(
                                welcomeTitle: 'Welcome Back',
                                welcomeSubtitle: 'Sign in to continue in to your account',
                              ),
                            ),
                            SizedBox(height: 20.h,),
                            CustomTextField(
                              controller: _emailController,
                              labelText: 'Email',
                              hintText: 'Enter your email',
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              prefixIcon: const Icon(IconBroken.Message,),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email is required';
                                }

                                if (!EmailValidator.validate(value.trim())) {
                                  return 'Enter a valid email';
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: 14.h,),
                            PasswordTextField(
                              controller: _passwordController,
                              labelText: 'Password',
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                }

                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: 2.h,),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: (){
                                  context.push(RouteNames.forgotPassword);
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: AppTextStyles.hint.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),),
                            ),
                            SizedBox(height: 12.h,),

                            PrimaryButton(
                                text: 'Login',
                                isLoading: state is AuthLoading,
                                onPressed: (){
                                  if(_formKey.currentState!.validate()){
                                    context.read<AuthCubit>().login(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text,
                                    );
                                  }
                                }
                            ),

                            SizedBox(height: 16.h,),

                            const OrDivider(text: 'or continue with',),

                            SizedBox(height: 16.h,),

                            SocialButton(
                              color: AppColors.primary,
                              text: 'Continue with Google',
                              icon: SvgPicture.asset(
                                AppImages.google,
                                width: 22.w,
                                height: 22.h,
                              ),
                              onPressed: (){},
                            ),

                            SizedBox(height: 50.h,),

                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: AuthFooter(
                                text: "Don't have an account? ",
                                actionText: 'Sign Up',
                                onTap: (){
                                  context.push(RouteNames.register);
                                },
                              ),
                            ),


                          ],
                        ),
                      ),
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
