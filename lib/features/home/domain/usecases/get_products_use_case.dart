import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/failures.dart';
import 'package:greeno_app/features/home/domain/entities/product_entity.dart';
import 'package:greeno_app/features/home/domain/repositories/home_repository.dart';

class GetProductsUseCase {
  final HomeRepository homeRepository;

  const GetProductsUseCase({required this.homeRepository});

  Future<Either<Failure,List<ProductEntity>>>call(){
    return homeRepository.getProducts();
  }
}