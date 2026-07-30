import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greeno_app/core/constants/custom_text_field.dart';
import 'package:greeno_app/features/auth/presentation/cubit/password_visibility_cubit.dart';

import '../assets_date/iconBroken.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText = 'Enter your password',
    this.validator,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String? labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordVisibilityCubit,bool>(
        builder:(context,isObscure){
          return CustomTextField(
              controller: controller,
              labelText: labelText,
              hintText: hintText,
              validator: validator,
              textInputAction: textInputAction,
              keyboardType: TextInputType.visiblePassword,
              obscureText: isObscure,
              prefixIcon: const Icon(IconBroken.Lock),
              suffixIcon: IconButton(
                  onPressed: (){
                    context.read<PasswordVisibilityCubit>().toggleVisibility();
                  },
                  icon: Icon(isObscure ? IconBroken.Show : IconBroken.Hide),
              ),
          );
        });
  }
}
