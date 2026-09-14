import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:greeno_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:greeno_app/features/auth/data/data_sources/firebase_auth_remote_data_source_impl.dart';
import 'package:greeno_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:greeno_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:greeno_app/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:greeno_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:greeno_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:greeno_app/features/auth/domain/usecases/send_email_verification_usecase.dart';
import 'package:greeno_app/features/auth/presentation/cubit/address_cubit.dart';
import 'package:greeno_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:greeno_app/features/auth/presentation/cubit/password_visibility_cubit.dart';
import 'package:greeno_app/features/favorite/data/datasource/favorite_local_data_source.dart';
import 'package:greeno_app/features/favorite/data/datasource/favorite_local_data_source_impl.dart';
import 'package:greeno_app/features/favorite/data/models/favorite_item_hive_model.dart';
import 'package:greeno_app/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:greeno_app/features/navigation/presentation/cubit/navigation_cubit.dart';
import 'package:greeno_app/features/orders/data/datasource/order_remote_data_source.dart';
import 'package:greeno_app/features/orders/data/datasource/order_remote_data_source_impl.dart';
import 'package:greeno_app/features/orders/data/repository_impl/order_repository_impl.dart';
import 'package:greeno_app/features/orders/domain/repositories/order_repository.dart';
import 'package:greeno_app/features/orders/domain/usecases/cancel_order_usecase.dart';
import 'package:greeno_app/features/orders/domain/usecases/get_orders_use_case.dart';
import 'package:greeno_app/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:greeno_app/features/splash/data/data_sources/splash_remote_data_source.dart';
import 'package:greeno_app/features/splash/data/data_sources/splash_remote_data_source_impl.dart';
import 'package:greeno_app/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:greeno_app/features/splash/domain/repositories/splash_repository.dart';
import 'package:greeno_app/features/splash/domain/usecases/check_email_verification_use_case.dart';
import 'package:greeno_app/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/auth/domain/usecases/check_email_verification_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/cart/data/datasource/cart_local_data_source.dart';
import '../../features/cart/data/datasource/cart_local_data_source_impl.dart';
import '../../features/cart/data/models/cart_item_hive_model.dart';
import '../../features/cart/presentation/cubit/cart_cubit.dart';
import '../../features/checkout/data/datasource/checkout_remote_data_source.dart';
import '../../features/checkout/data/datasource/firebase_checkout_remote_data_source.dart';
import '../../features/checkout/data/repositories/checkout_repository_impl.dart';
import '../../features/checkout/domain/repositories/checkout_repository.dart';
import '../../features/checkout/domain/usecases/place_order_use_case.dart';
import '../../features/checkout/presentation/cubit/checkout_cubit.dart';
import '../../features/home/data/datasource/firebase_home_remote_data_source_impl.dart';
import '../../features/home/data/datasource/home_remote_data_source.dart';
import '../../features/home/data/repository_impl/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_banners_use_case.dart';
import '../../features/home/domain/usecases/get_categories_use_case.dart';
import '../../features/home/domain/usecases/get_products_use_case.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/home/presentation/cubit/product_quantity_cubit.dart';
import '../../features/splash/domain/usecases/get_current_user_use_case.dart';
final sl = GetIt.instance;

Future<void> setupDependencies()async{

  sl.registerLazySingleton<FirebaseAuth>(
      () => FirebaseAuth.instance,
  );

  sl.registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance,
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => FirebaseAuthRemoteDataSourceImpl(
          firebaseAuth: sl(),
          firestore: sl(),
      ),
  );
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl())
  );
  sl.registerLazySingleton(
      () => RegisterUseCase(repository: sl())
  );
  sl.registerLazySingleton(
      () => LoginUseCase(repository: sl())
  );
  sl.registerLazySingleton(
      () => ForgotPasswordUseCase(repository: sl())
  );
  sl.registerLazySingleton(
          () => SendEmailVerificationUseCase(repository: sl())
  );
  sl.registerLazySingleton(
        () => CheckEmailVerificationUseCase(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
      () => LogoutUseCase(repository: sl())
  );
  sl.registerFactory(
      () => AuthCubit(
          registerUseCase: sl(),
          loginUseCase: sl(),
          forgotPasswordUseCase: sl(),
          sendEmailVerificationUseCase: sl(),
          checkEmailVerificationUseCase: sl(),
          logoutUseCase: sl()),
  );
  sl.registerFactory<PasswordVisibilityCubit>(
      () => PasswordVisibilityCubit(),
  );
  sl.registerFactory<AddressCubit>(
        () => AddressCubit(),
  );

  sl.registerLazySingleton<SplashRemoteDataSource>(
      () => SplashRemoteDataSourceImpl(
          firebaseAuth: sl(),
          firestore: sl(),
      ),
  );

  sl.registerLazySingleton<SplashRepository>(
      () => SplashRepositoryImpl(remoteDataSource: sl())
  );
  sl.registerLazySingleton(
        () => GetCurrentUserUseCase(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
        () => CheckEmailVerificationSplashUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
      () => SplashCubit(
          getCurrentUserUseCase: sl(),
          checkVerificationSplashUseCase: sl(),
      ),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
        () => FirebaseHomeRemoteDataSourceImpl(
      firestore: sl(),
    ),
  );
  sl.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(
      homeRemoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(
        () => GetCategoriesUseCase(
      homeRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
        () => GetProductsUseCase(
      homeRepository: sl(),
    ),
  );

  sl.registerLazySingleton(
        () => GetBannersUseCase(
      homeRepository: sl(),
    ),
  );
  sl.registerFactory(
        () => HomeCubit(
      getCategoriesUseCase: sl(),
      getProductsUseCase: sl(),
      getBannersUseCase: sl(),
    ),
  );
  sl.registerFactory(
        () => ProductQuantityCubit(),
  );
  sl.registerFactory(
        () => NavigationCubit(),
  );
  sl.registerFactory<CartCubit>(
        () => CartCubit(sl()),
  );
  sl.registerLazySingleton<Box<CartItemHiveModel>>(
        () => Hive.box<CartItemHiveModel>('cartBox'),
  );
  sl.registerLazySingleton<CartLocalDataSource>(
        () => CartLocalDataSourceImpl(sl()),
  );

  sl.registerFactory<FavoriteCubit>(
        () => FavoriteCubit(sl()),
  );
  sl.registerLazySingleton<Box<FavoriteItemHiveModel>>(
        () => Hive.box<FavoriteItemHiveModel>('favoriteBox'),
  );
  sl.registerLazySingleton<FavoriteLocalDataSource>(
        () => FavoriteLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<CheckoutRemoteDataSource>(
        () => FirebaseCheckoutRemoteDataSource(
      sl<FirebaseFirestore>(),
    ),
  );
  sl.registerLazySingleton<CheckoutRepository>(
        () => CheckoutRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(
        () => PlaceOrderUseCase(
      repository: sl(),
    ),
  );
  sl.registerFactory(
        () => CheckoutCubit(
            placeOrderUseCase: sl(),
        ),
  );
  sl.registerLazySingleton<OrderRemoteDataSource>(
      () => OrderRemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton(
      () => GetOrdersUseCase(repository: sl()),
  );
  sl.registerLazySingleton(
      () => CancelOrderUseCase(repository: sl())
  );
  sl.registerFactory(
      () => OrdersCubit(ordersUseCase: sl(),cancelOrderUseCase: sl())
  );
}