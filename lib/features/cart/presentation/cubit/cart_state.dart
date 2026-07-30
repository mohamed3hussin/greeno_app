part of 'cart_cubit.dart';
class CartState extends Equatable {
  final List<CartItemEntity>items;

  const CartState({required this.items});

  double get totalPrice {
    double total = 0;
    for(final item in items){
      final price = item.product.discountPrice ?? item.product.price;
      total += price * item.quantity;
    }
    return total;
  }
  CartState copyWith({
    List<CartItemEntity>? items
}){
    return CartState(items: items ?? this.items);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [items];
}