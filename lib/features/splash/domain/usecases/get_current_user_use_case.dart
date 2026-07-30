import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/failures.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';
import 'package:greeno_app/features/splash/domain/repositories/splash_repository.dart';

class GetCurrentUserUseCase {
  final SplashRepository repository;

  GetCurrentUserUseCase({required this.repository});
  Future<Either<Failure,UserEntity?>> call(){
    return repository.getCurrentUser();
  }
}