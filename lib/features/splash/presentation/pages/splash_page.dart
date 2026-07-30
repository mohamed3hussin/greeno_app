import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:greeno_app/core/routes/route_names.dart';
import 'package:greeno_app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:greeno_app/features/splash/presentation/cubit/splash_state.dart';
import 'package:greeno_app/features/splash/presentation/widgets/splash_body.dart';

import '../../../../core/dependency_injection/injection_container.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<SplashCubit>(),
        child: const _splashView(),
    );
  }
}
class _splashView extends StatefulWidget {
  const _splashView({super.key});

  @override
  State<_splashView> createState() => _splashViewState();
}

class _splashViewState extends State<_splashView> {
  @override
  void initState(){
    super.initState();
    Future.microtask((){
      context.read<SplashCubit>().checkAuthStatus();
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit,SplashState>(
        listener: (context,state){
          if(state is SplashAuthenticated){
            context.go(RouteNames.navigation,extra: state.user);
          }
          if(state is SplashUnauthenticated){
            context.go(RouteNames.login);
          }
          if(state is SplashEmailNotVerified){
            context.go(
                RouteNames.verifyEmail,
                extra: state.user.email
            );
          }
          if(state is SplashError){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message))
            );
          }
        },
        builder: (context,state){
          return SplashBody();
        },
    );
  }
}

