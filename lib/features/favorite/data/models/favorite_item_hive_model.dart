import 'package:greeno_app/features/favorite/domain/entities/favorite_item_entity.dart';
import 'package:hive/hive.dart';

import '../../../cart/data/models/product_hive_model.dart';

part 'favorite_item_hive_model.g.dart';

@HiveType(typeId: 2)
class FavoriteItemHiveModel {

  @HiveField(0)
  final ProductHiveModel product;

  const FavoriteItemHiveModel({
    required this.product,
  });

  factory FavoriteItemHiveModel.fromEntity(FavoriteItemEntity entity) {
    return FavoriteItemHiveModel(
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

    );
  }

  FavoriteItemEntity toEntity() {
    return FavoriteItemEntity(
      product: product.toEntity(),

    );
  }
}