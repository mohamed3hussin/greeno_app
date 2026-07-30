import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/failures.dart';
import 'package:greeno_app/features/home/domain/entities/banner_entity.dart';
import 'package:greeno_app/features/home/domain/repositories/home_repository.dart';

class GetBannersUseCase {
  final HomeRepository homeRepository;

  const GetBannersUseCase({required this.homeRepository});

  Future<Either<Failure,List<BannerEntity>>>call() {
    return homeRepository.getBanners();
}
}