import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:greeno_app/features/auth/presentation/widgets/auth_back_button.dart';

import '../../../../core/assets_date/iconBroken.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/custom_text_field.dart';
import '../../../../core/constants/password_text_field.dart';
import '../../../../core/constants/primary_button.dart';
import '../../../../core/dependency_injection/injection_container.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/register_data_entity.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../cubit/password_visibility_cubit.dart';
import '../widgets/auth_background.dart';
import '../widgets/auth_footer.dart';
import '../widgets/auth_header.dart';
import '../widgets/or_divider.dart';
import '../widgets/social_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
      child: const _registerView(),
    );
  }
}

class _registerView extends StatefulWidget{
  const _registerView();

  @override
  State<_registerView> createState() => _registerViewState();
}

class _registerViewState extends State<_registerView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _confirmPasswordController.dispose();
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
                            const AuthBackButton(),
                            SizedBox(height: 10.h,),
                            Center(
                              child: const AuthHeader(
                                welcomeTitle: 'Create Account',
                                welcomeSubtitle: 'Sign up to get started',
                              ),
                            ),

                            SizedBox(height: 20.h,),

                            CustomTextField(
                              controller: _nameController,
                              labelText: 'Name',
                              hintText: 'Enter your full Name',
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              prefixIcon: const Icon(IconBroken.User,),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Name is required';
                                }
                                if (value.trim().length < 3) {
                                  return 'Name must be at least 3 characters';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 14.h,),

                            CustomTextField(
                              controller: _emailController,
                              labelText: 'Email',
                              hintText: 'example@gmail.com',
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

                            CustomTextField(
                              controller: _phoneController,
                              labelText: 'Phone',
                              hintText: '01xxxxxxxxx',
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              prefixIcon: const Icon(IconBroken.Call,),
                              validator: (value){
                                if (value == null || value.isEmpty) {
                                  return 'Phone is required';
                                }

                                if (!RegExp(r'^01[0125][0-9]{8}$').hasMatch(value)) {
                                  return 'Enter a valid phone number';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 14.h,),

                            PasswordTextField(
                              controller: _passwordController,
                              labelText: 'Password',
                              textInputAction: TextInputAction.next,
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

                            SizedBox(height: 14.h,),

                            PasswordTextField(
                              controller: _confirmPasswordController,
                              labelText: 'Confirm password',
                              textInputAction: TextInputAction.none,
                              validator: (value){
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 12.h,),

                            PrimaryButton(
                                text: 'Continue',
                                onPressed: (){
                                  if(_formKey.currentState!.validate()){
                                    context.push(
                                      RouteNames.address,
                                      extra: RegisterDataEntity(
                                        name: _nameController.text.trim(),
                                        email: _emailController.text.trim(),
                                        phone: _phoneController.text.trim(),
                                        password: _passwordController.text,
                                      ),
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

                            SizedBox(height: 14.h,),

                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: AuthFooter(
                                text: "Already have an account? ",
                                actionText: 'Login',
                                onTap: (){
                                  context.pop();
                                },
                              ),
                            ),
                            SizedBox(height: 20.h,),


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
