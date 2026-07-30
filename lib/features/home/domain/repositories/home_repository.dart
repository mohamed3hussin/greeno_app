import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/failures.dart';
import 'package:greeno_app/features/home/domain/entities/banner_entity.dart';
import 'package:greeno_app/features/home/domain/entities/category_entity.dart';
import 'package:greeno_app/features/home/domain/entities/product_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure,List<CategoryEntity>>> getCategories();
  Future<Either<Failure,List<ProductEntity>>> getProducts();
  Future<Either<Failure,List<BannerEntity>>> getBanners();
}