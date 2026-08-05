import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';
import 'package:greeno_app/features/checkout/presentation/cubit/checkout_cubit.dart';

import '../../../../core/dependency_injection/injection_container.dart';
import '../widget/checkout_view.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({
    super.key,
    required this.user
  });
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<CheckoutCubit>(),
        child: CheckoutView(user:user),
    );
  }
}
