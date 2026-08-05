import '../models/order_model.dart';

abstract class CheckoutRemoteDataSource {
  Future<void> placeOrder(OrderModel order);
}