import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greeno_app/features/home/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    super.discountPrice,
    required super.images,
    required super.categoryId,
    required super.stock,
    required super.isPopular,
    required super.isAvailable,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProductModel.fromEntity(ProductEntity entity){
    return ProductModel(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        price: entity.price,
        discountPrice: entity.discountPrice,
        images: entity.images,
        categoryId: entity.categoryId,
        stock: entity.stock,
        isPopular: entity.isPopular,
        isAvailable: entity.isAvailable,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
    );
  }

  factory ProductModel.fromJson(Map<String,dynamic>json, String id){
    return ProductModel(
        id: id,
        name: json['name'] as String,
        description: json['description'] as String,
        price: (json['price'] as num).toDouble(),
        discountPrice: json['discountPrice'] != null
          ? (json['discountPrice'] as num).toDouble()
          : null,
        images: List<String>.from(json['images']),
        categoryId: json['categoryId'] as String,
        stock: json['stock'] as int,
        isPopular: json['isPopular'] as bool,
        isAvailable: json['isAvailable'] as bool,
        createdAt: (json['createdAt'] as Timestamp).toDate(),
        updatedAt: (json['updatedAt'] as Timestamp).toDate(),
    );
  }
  Map<String,dynamic> toJson(){
    return{

      'name':name,
      'description':description,
      'price':price,
      'discountPrice':discountPrice,
      'images':images,
      'categoryId':categoryId,
      'stock':stock,
      'isPopular':isPopular,
      'isAvailable':isAvailable,
      'createdAt':Timestamp.fromDate(createdAt),
      'updatedAt':Timestamp.fromDate(updatedAt),
    };
  }
}