import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/failures.dart';
import 'package:greeno_app/features/checkout/domain/entities/order_entity.dart';
import 'package:greeno_app/features/orders/domain/repositories/order_repository.dart';

class GetOrdersUseCase {
  final OrderRepository repository;

  GetOrdersUseCase({required this.repository});

  Future<Either<Failure,List<OrderEntity>>> call(String userUid){
    return repository.getOrders(userUid);
  }

}