import '../repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/failures.dart';
class SendEmailVerificationUseCase {
  final AuthRepository repository;

  const SendEmailVerificationUseCase({required this.repository});

  Future<Either<Failure,void>> call(){
    return repository.sendEmailVerification();
  }
}