import 'package:equatable/equatable.dart';
import 'package:greeno_app/features/home/domain/entities/product_entity.dart';

class FavoriteItemEntity extends Equatable {

  final ProductEntity product;


  const FavoriteItemEntity({
    required this.product,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    product,
  ];
}