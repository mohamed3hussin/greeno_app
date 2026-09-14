import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/order_repository.dart';

class CancelOrderUseCase {
  final OrderRepository repository;

  CancelOrderUseCase({required this.repository});

  Future<Either<Failure, void>> call(
      String userUid,
      String orderId,
      ) async {
    return await repository.cancelOrder(userUid, orderId);
  }
}