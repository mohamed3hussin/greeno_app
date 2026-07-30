import 'package:hive/hive.dart';

import '../../domain/entities/cart_item_entity.dart';
import 'product_hive_model.dart';

part 'cart_item_hive_model.g.dart';

@HiveType(typeId: 1)
class CartItemHiveModel {

  @HiveField(0)
  final ProductHiveModel product;

  @HiveField(1)
  final int quantity;

  const CartItemHiveModel({
    required this.product,
    required this.quantity,
  });

  factory CartItemHiveModel.fromEntity(CartItemEntity entity) {
    return CartItemHiveModel(
      product: ProductHiveModel(
        id: entity.product.id,
        name: entity.product.name,
        description: entity.product.description,
        price: entity.product.price,
        discountPrice: entity.product.discountPrice,
        images: entity.product.images,
        categoryId: entity.product.categoryId,
        stock: entity.product.stock,
        isPopular: entity.product.isPopular,
        isAvailable: entity.product.isAvailable,
        createdAt: entity.product.createdAt,
        updatedAt: entity.product.updatedAt,
      ),
      quantity: entity.quantity,
    );
  }

  CartItemEntity toEntity() {
    return CartItemEntity(
      product: product.toEntity(),
      quantity: quantity,
    );
  }
}