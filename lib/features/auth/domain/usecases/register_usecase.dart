import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/failures.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';
import 'package:greeno_app/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

 const RegisterUseCase({required this.repository});

  Future<Either<Failure,UserEntity>> call({
    required String email,
    required String password,
    required UserEntity user,
}){
    return repository.register(
        email: email,
        password: password,
        user: user,
    );
  }
}