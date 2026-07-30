import '../../domain/entities/cart_item_entity.dart';

abstract class CartLocalDataSource {
  Future<void> saveCart(List<CartItemEntity> items);

  List<CartItemEntity> getCart();

  Future<void> clearCart();
}