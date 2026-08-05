import 'package:greeno_app/features/cart/domain/entities/cart_item_entity.dart';

import '../../../home/data/models/product_model.dart';

class CartItemModel extends CartItemEntity {
  const CartItemModel({
    required super.product,
    required super.quantity,
  });

  factory CartItemModel.fromEntity(CartItemEntity entity) {
    return CartItemModel(
      product: entity.product,
      quantity: entity.quantity,
    );
  }
  factory CartItemModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return CartItemModel(
      product: ProductModel.fromJson(
        json['product'] as Map<String, dynamic>,
        json['product']['id'] as String,
      ),
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': ProductModel.fromEntity(product).toJson(),
      'quantity': quantity,
    };
  }
}