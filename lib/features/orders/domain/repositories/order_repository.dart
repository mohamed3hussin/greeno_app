import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/failures.dart';
import 'package:greeno_app/features/checkout/domain/entities/order_entity.dart';

abstract class OrderRepository {
  Future<Either<Failure,List<OrderEntity>>> getOrders(String userUid);
}