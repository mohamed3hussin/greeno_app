import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/failures.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {

  Future<Either<Failure,UserEntity>> register({
    required String email,
    required String password,
    required UserEntity user,
  });
  Future<Either<Failure,UserEntity>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure,void>> forgotPassword({
    required String email,
  });
  Future<Either<Failure,void>> sendEmailVerification();
  Future<Either<Failure, bool>> checkEmailVerification();
  Future<Either<Failure,void>> logout();
}