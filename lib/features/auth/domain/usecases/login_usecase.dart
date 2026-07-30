import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/failures.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';
import 'package:greeno_app/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

 const LoginUseCase({required this.repository});
 Future<Either<Failure,UserEntity>> call({
    required String email,
    required String password,
}){
   return repository.login(
       email: email,
       password: password,
   );
 }
}