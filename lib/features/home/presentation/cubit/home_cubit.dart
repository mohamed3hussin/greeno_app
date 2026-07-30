import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greeno_app/features/home/presentation/cubit/home_state.dart';

import '../../domain/usecases/get_banners_use_case.dart';
import '../../domain/usecases/get_categories_use_case.dart';
import '../../domain/usecases/get_products_use_case.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductsUseCase;
  final GetBannersUseCase getBannersUseCase;

  HomeCubit({
    required this.getCategoriesUseCase,
    required this.getProductsUseCase,
    required this.getBannersUseCase,
  }) : super(const HomeInitial());

  Future<void> loadHome() async {
    emit(const HomeLoading());

    final categoriesResult = await getCategoriesUseCase();
    final productsResult = await getProductsUseCase();
    final bannersResult = await getBannersUseCase();

    categoriesResult.fold(
          (failure) {
        emit(HomeError(message: failure.message));
        return;
      },
          (categories) {
        productsResult.fold(
              (failure) {
            emit(HomeError(message: failure.message));
            return;
          },
              (products) {
            bannersResult.fold(
                  (failure) {
                emit(HomeError(message: failure.message));
                return;
              },
                  (banners) {
                emit(
                  HomeLoaded(
                    categories: categories,
                    products: products,
                    banners: banners,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}