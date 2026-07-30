import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/failures.dart';
import 'package:greeno_app/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository repository;

  const ForgotPasswordUseCase({required this.repository});
  Future<Either<Failure,void>> call({
    required String email,
}){
    return repository.forgotPassword(email: email);
  }
}