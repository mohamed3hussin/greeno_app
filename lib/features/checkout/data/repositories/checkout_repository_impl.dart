import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/failures.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/checkout_repository.dart';
import '../datasource/checkout_remote_data_source.dart';
import '../models/order_model.dart';

class CheckoutRepositoryImpl extends CheckoutRepository {
  final CheckoutRemoteDataSource remoteDataSource;

  CheckoutRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure,void>> placeOrder(OrderEntity order)async {
    try {
      await remoteDataSource.placeOrder(OrderModel.fromEntity(order));
      return const Right(null);
    }on ServerException catch(e){
      return Left(ServerFailure(message: e.message));
    }catch(_){
      return Left(ServerFailure(message: 'Something went wrong'));
    }
  }
}