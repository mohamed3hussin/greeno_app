import '../repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/failures.dart';
class CheckEmailVerificationUseCase {
  final AuthRepository repository;

  const CheckEmailVerificationUseCase({
    required this.repository,
  });

  Future<Either<Failure, bool>> call() {
    return repository.checkEmailVerification();
  }
}