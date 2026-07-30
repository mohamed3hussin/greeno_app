import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/failures.dart';

import 'package:greeno_app/features/home/domain/entities/category_entity.dart';
import 'package:greeno_app/features/home/domain/repositories/home_repository.dart';

class GetCategoriesUseCase {
  final HomeRepository homeRepository;

  const GetCategoriesUseCase({required this.homeRepository});
  Future<Either<Failure,List<CategoryEntity>>>call(){
    return homeRepository.getCategories();
  }
}