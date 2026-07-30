import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:greeno_app/core/dependency_injection/injection_container.dart';
import 'package:greeno_app/features/auth/presentation/widgets/forgot_background.dart';

import '../../../../core/assets_date/iconBroken.dart';
import '../../../../core/constants/custom_text_field.dart';
import '../../../../core/constants/primary_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/auth_back_button.dart';
import '../widgets/auth_footer.dart';
import '../widgets/auth_header.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=> sl<AuthCubit>(),
      child: const _forgotPasswordView(),
    ) ;
  }
}
class _forgotPasswordView extends StatefulWidget{
  const _forgotPasswordView();

  @override
  State<_forgotPasswordView> createState() => _forgotPasswordViewState();
}

class _forgotPasswordViewState extends State<_forgotPasswordView> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return ColoredBox(
     color: Colors.white,
     child: Stack(
       children: [
         const ForgotBackground(),
         Scaffold(
           backgroundColor: Colors.transparent,
           resizeToAvoidBottomInset: true,
           body: SafeArea(
             child: BlocConsumer<AuthCubit,AuthState>(
               listener: (context,state){
                 if(state is ForgotPasswordSuccess){
                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                       content: Text('Password reset link has been sent to your email'),
                       backgroundColor: Colors.green,
                     ),
                   );
                 }
                 if(state is AuthError){
                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text(state.message),),
                   );
                 }
               },
               builder: (context,state){
                 return Form(
                   key:_formKey ,
                   child: SingleChildScrollView(
                     child: Padding(
                       padding: EdgeInsetsGeometry.symmetric(horizontal: 24.w),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const AuthBackButton(),
                           Center(
                             child: const AuthHeader(
                               welcomeTitle: 'Forgot Password',
                               welcomeSubtitle: 'No worries! Enter your email and',
                               extraTitle: "we'll send you reset instructions",
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
                                 return 'Please enter your email';
                               }

                               if (!EmailValidator.validate(value.trim())) {
                                 return 'Enter a valid email';
                               }

                               return null;
                             },
                           ),

                           SizedBox(height: 20.h,),

                           PrimaryButton(
                               text: 'Send Reset Link',
                               isLoading: state is AuthLoading,
                               onPressed: (){
                                 if(_formKey.currentState!.validate()){
                                   context.read<AuthCubit>().forgotPassword(
                                       email: _emailController.text.trim(),
                                   );

                                 }
                               }

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
           bottomNavigationBar: SafeArea(
               child: Padding(
                 padding: EdgeInsets.only(bottom: 20.h),
                 child: Container(
                   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                   decoration: BoxDecoration(
                     color: Colors.white.withOpacity(0.5),
                     borderRadius: BorderRadius.circular(12.r),
                   ),
                   child: AuthFooter(
                     text: "Remember Your Password? ",
                     actionText: 'Login',
                     onTap: (){
                       context.pop();
                     },
                   ),
                 ),
               )
           ),
         ),
       ],
     ),
   );
  }
}
