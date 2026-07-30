import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';
import '../../../../core/dependency_injection/injection_container.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../cubit/navigation_cubit.dart';
import '../widgets/navigation_view.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({
    super.key,
    required this.user
  });
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<NavigationCubit>(),
        ),

        BlocProvider(
          create: (_) => sl<CartCubit>(),
        ),
      ],
      child: NavigationView(
        user: user,
      ),
    );
  }
}
