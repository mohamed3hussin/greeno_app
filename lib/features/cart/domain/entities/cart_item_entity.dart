import 'package:equatable/equatable.dart';
import 'package:greeno_app/features/home/domain/entities/product_entity.dart';

class CartItemEntity extends Equatable {
  final ProductEntity product;
  final int quantity;

  const CartItemEntity({
    required this.product,
    required this.quantity,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    product,
    quantity
  ];

}