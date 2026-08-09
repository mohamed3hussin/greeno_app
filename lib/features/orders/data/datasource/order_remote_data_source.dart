import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/failures.dart';
import 'package:greeno_app/features/checkout/data/models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders(String userUid);
}