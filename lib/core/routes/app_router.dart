import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:greeno_app/core/routes/route_names.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';
import 'package:greeno_app/features/auth/presentation/pages/address_page.dart';
import 'package:greeno_app/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:greeno_app/features/auth/presentation/pages/login_page.dart';
import 'package:greeno_app/features/auth/presentation/pages/register_page.dart';
import 'package:greeno_app/features/auth/presentation/pages/verify_email_page.dart';
import 'package:greeno_app/features/cart/presentation/pages/cart_page.dart';
import 'package:greeno_app/features/home/domain/entities/product_entity.dart';
import 'package:greeno_app/features/home/presentation/pages/home_page.dart';
import 'package:greeno_app/features/home/presentation/pages/product_details_page.dart';
import 'package:greeno_app/features/navigation/presentation/pages/navigation_page.dart';

import '../../features/auth/domain/entities/register_data_entity.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/cart/presentation/cubit/cart_cubit.dart';
import '../../features/checkout/presentation/pages/checkout_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../dependency_injection/injection_container.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
      initialLocation: RouteNames.splash,
      routes:[
        GoRoute(
          path: RouteNames.splash,
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: RouteNames.login,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const LoginPage(),
              transitionDuration: const Duration(milliseconds: 400),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
          path: RouteNames.register,
          builder: (context,state) => const RegisterPage(),
        ),
        GoRoute(
          path: RouteNames.address,
          builder: (context, state) {
            final registerData = state.extra as RegisterDataEntity;

            return AddressPage(
              registerData: registerData,
            );
          },
        ),
        GoRoute(
          path: RouteNames.verifyEmail,
          builder: (context, state) {
            return BlocProvider(
              create: (_) => sl<AuthCubit>(),
              child: VerifyEmailPage(
                user: state.extra as UserEntity,
              ),
            );
          },
        ),
        GoRoute(
          path: RouteNames.forgotPassword,
          builder: (context,state) => const ForgotPasswordPage(),
        ),
        GoRoute(
          path: RouteNames.home,
          pageBuilder: (context, state) {
            final user = state.extra as UserEntity;
            return CustomTransitionPage(
              key: state.pageKey,
              child: HomePage(user: user,),
              transitionDuration: const Duration(milliseconds: 400),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
            path: RouteNames.product,
            builder: (context, state){
              final product = state.extra as ProductEntity;
              return ProductDetailsPage(product: product);
            }
        ),
        GoRoute(
            path: RouteNames.navigation,
            builder: (context, state){
              final user = state.extra as UserEntity;
              return NavigationPage(user: user);
            }
        ),
        GoRoute(
          path: RouteNames.checkout,
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>;

            return BlocProvider.value(
              value: data['cartCubit'] as CartCubit,
              child: CheckoutPage(
                user: data['user'] as UserEntity,
              ),
            );
          },
        ),

      ],
  );
}