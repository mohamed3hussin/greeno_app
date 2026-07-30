import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/exceptions.dart';
import 'package:greeno_app/core/errors/failures.dart';
import 'package:greeno_app/features/home/data/datasource/home_remote_data_source.dart';
import 'package:greeno_app/features/home/data/models/banner_model.dart';
import 'package:greeno_app/features/home/data/models/category_model.dart';
import 'package:greeno_app/features/home/data/models/product_model.dart';
import 'package:greeno_app/features/home/domain/entities/banner_entity.dart';
import 'package:greeno_app/features/home/domain/entities/category_entity.dart';
import 'package:greeno_app/features/home/domain/entities/product_entity.dart';
import 'package:greeno_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImpl({required this.homeRemoteDataSource});

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try{
      final List<CategoryModel> categories = await homeRemoteDataSource.getCategories();
      return Right(categories);
    }on ServerException catch(e){
      return Left(ServerFailure(message: e.message));
    }catch(e){
      return Left(ServerFailure(message: 'Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts()async {
    try{
      final List<ProductModel> products = await homeRemoteDataSource.getProducts();
      return Right(products);
    }on ServerException catch(e){
      return Left(ServerFailure(message: e.message));
    }catch(e){
      return Left(ServerFailure(message: 'Failed to load products'));
    }
  }

  @override
  Future<Either<Failure, List<BannerEntity>>> getBanners()async {
    try{
      final List<BannerModel> banners = await homeRemoteDataSource.getBanners();
      return Right(banners);
    }on ServerException catch(e){
      return Left(ServerFailure(message: e.message));
    }catch(e){
      return Left(ServerFailure(message: 'Failed to load banners'));
    }
  }
}