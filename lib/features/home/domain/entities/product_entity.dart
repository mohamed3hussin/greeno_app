import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String description;

  final double price;
  final double? discountPrice;

  final List<String> images;

  final String categoryId;

  final int stock;

  final bool isPopular;
  final bool isAvailable;

  final DateTime createdAt;
  final DateTime updatedAt;

 const ProductEntity({
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

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    discountPrice,
    images,
    categoryId,
    stock,
    isPopular,
    isAvailable,
    createdAt,
    updatedAt,
  ];
}