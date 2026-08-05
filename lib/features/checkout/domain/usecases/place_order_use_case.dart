import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/failures.dart';
import 'package:greeno_app/features/checkout/domain/entities/order_entity.dart';
import 'package:greeno_app/features/checkout/domain/repositories/checkout_repository.dart';

class PlaceOrderUseCase {
  final CheckoutRepository repository;

  PlaceOrderUseCase({required this.repository});
  Future<Either<Failure,void>> call(OrderEntity order){
    return repository.placeOrder(order);
  }
}