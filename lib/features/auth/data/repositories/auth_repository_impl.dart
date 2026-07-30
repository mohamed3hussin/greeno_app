import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/exceptions.dart';
import 'package:greeno_app/core/errors/failures.dart';
import 'package:greeno_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:greeno_app/features/auth/data/models/user_model.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';
import 'package:greeno_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    required UserEntity user,
  })async {
    try{
      final userModel= UserModel.fromEntity(user);
      final registeredUser = await remoteDataSource.register(
          email: email,
          password: password,
          user: userModel);
      return Right(registeredUser);
    }on AuthException catch(e){
      return Left(AuthFailure(message: e.message));
    }on ServerException catch (e){
      return Left(ServerFailure(message: e.message));
    }on CacheException catch(e){
      return Left(CacheFailure(message: e.message));
    }on NetworkException catch(e){
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  })async {
    try{

      final user = await remoteDataSource.login(email: email, password: password);

      return Right(user);

    }on AuthException catch(e){
      return Left(AuthFailure(message: e.message));
    }on ServerException catch (e){
      return Left(ServerFailure(message: e.message));
    }on CacheException catch(e){
      return Left(CacheFailure(message: e.message));
    }on NetworkException catch(e){
      return Left(NetworkFailure(message: e.message));
    }

  }

  @override
  Future<Either<Failure, void>> forgotPassword({
    required String email,
  })async {
    try{

      await remoteDataSource.forgetPassword(email: email);

      return const Right(null);

    }on AuthException catch(e){
      return Left(AuthFailure(message: e.message));
    }on ServerException catch (e){
      return Left(ServerFailure(message: e.message));
    }on CacheException catch(e){
      return Left(CacheFailure(message: e.message));
    }on NetworkException catch(e){
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> sendEmailVerification()async {
    try{

      await remoteDataSource.sendEmailVerification();

      return const Right(null);

    }on AuthException catch(e){
      return Left(AuthFailure(message: e.message));
    }on ServerException catch (e){
      return Left(ServerFailure(message: e.message));
    }on CacheException catch(e){
      return Left(CacheFailure(message: e.message));
    }on NetworkException catch(e){
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> checkEmailVerification() async {
    try {
      final isVerified =
      await remoteDataSource.checkEmailVerification();

      return Right(isVerified);
    } on AuthException catch (e) {
      return Left(
        AuthFailure(message: e.message),
      );
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message),
      );
    }
  }


  @override
  Future<Either<Failure, void>> logout()async {
    try{

      await remoteDataSource.logout();

      return const Right(null);

    }on AuthException catch(e){
      return Left(AuthFailure(message: e.message));
    }on ServerException catch (e){
      return Left(ServerFailure(message: e.message));
    }on CacheException catch(e){
      return Left(CacheFailure(message: e.message));
    }on NetworkException catch(e){
      return Left(NetworkFailure(message: e.message));
    }
  }


}