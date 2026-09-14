import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/failures.dart';
import 'package:greeno_app/features/checkout/domain/entities/order_entity.dart';
import 'package:greeno_app/features/orders/data/datasource/order_remote_data_source.dart';
import 'package:greeno_app/features/orders/domain/repositories/order_repository.dart';

import '../../../../core/errors/exceptions.dart';

class OrderRepositoryImpl extends OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders(String userUid)async {
    try {
      final orders = await remoteDataSource.getOrders(userUid);
      return Right(orders);
    }on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          message: e.toString(),
        ),
      );
    }
  }
  @override
  Future<Either<Failure, void>> cancelOrder(
      String userUid,
      String orderId,
      ) async {
    try {
      await remoteDataSource.cancelOrder(userUid, orderId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          message: e.toString(),
        ),
      );
    }
  }
}