import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/exceptions.dart';
import 'package:greeno_app/core/errors/failures.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';
import 'package:greeno_app/features/splash/data/data_sources/splash_remote_data_source.dart';
import 'package:greeno_app/features/splash/domain/repositories/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashRemoteDataSource remoteDataSource;

  SplashRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure,UserEntity?>> getCurrentUser() async {
    try{
      final user = await remoteDataSource.getCurrentUser();

      return Right(user);
    }on ServerException catch(e){
      return Left(ServerFailure(message: e.message));
    }on AuthException catch(e){
      return Left(AuthFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure,bool>> isEmailVerified()async {
    try{
      final isVerified = await remoteDataSource.isEmailVerified();
      return Right(isVerified);
    }on ServerException catch(e){
      return Left(ServerFailure(message: e.message));
    }on AuthException catch(e){
      return Left(AuthFailure(message: e.message));
    }
  }
}