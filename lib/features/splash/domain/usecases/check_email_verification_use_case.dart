import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/failures.dart';
import 'package:greeno_app/features/splash/domain/repositories/splash_repository.dart';

class CheckEmailVerificationSplashUseCase {
  final SplashRepository repository;

  CheckEmailVerificationSplashUseCase({required this.repository});

  Future<Either<Failure,bool>> call(){
    return repository.isEmailVerified();
  }
}