import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/failures.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';

abstract class SplashRepository {

  Future<Either<Failure,bool>> isEmailVerified();
  Future<Either<Failure,UserEntity?>> getCurrentUser();
}