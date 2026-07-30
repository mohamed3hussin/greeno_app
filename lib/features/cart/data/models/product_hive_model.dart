import 'package:hive/hive.dart';

import '../../../home/data/models/product_model.dart';
import '../../../home/domain/entities/product_entity.dart';

part 'product_hive_model.g.dart';

@HiveType(typeId: 0)
class ProductHiveModel {

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final double? discountPrice;

  @HiveField(5)
  final List<String> images;

  @HiveField(6)
  final String categoryId;

  @HiveField(7)
  final int stock;

  @HiveField(8)
  final bool isPopular;

  @HiveField(9)
  final bool isAvailable;

  @HiveField(10)
  final DateTime createdAt;

  @HiveField(11)
  final DateTime updatedAt;

  const ProductHiveModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.discountPrice,
    required this.images,
    required this.categoryId,
    required this.stock,
    required this.isPopular,
    required this.isAvailable,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductHiveModel.fromProductModel(ProductModel model) {
    return ProductHiveModel(
      id: model.id,
      name: model.name,
      description: model.description,
      price: model.price,
      discountPrice: model.discountPrice,
      images: model.images,
      categoryId: model.categoryId,
      stock: model.stock,
      isPopular: model.isPopular,
      isAvailable: model.isAvailable,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      description: description,
      price: price,
      discountPrice: discountPrice,
      images: images,
      categoryId: categoryId,
      stock: stock,
      isPopular: isPopular,
      isAvailable: isAvailable,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}