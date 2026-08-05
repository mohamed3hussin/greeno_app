import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greeno_app/features/home/domain/entities/product_entity.dart';
import '../../data/datasource/cart_local_data_source.dart';
import '../../domain/entities/cart_item_entity.dart';
part 'cart_state.dart';
class CartCubit extends Cubit<CartState> {
  final CartLocalDataSource localDataSource;
  CartCubit(this.localDataSource):super(CartState(items: localDataSource.getCart()));

  Future<void> addProduct(ProductEntity product , int quantity) async{
    final items = List<CartItemEntity>.from(state.items);
    final index = items.indexWhere(
        (item) => item.product.id == product.id
    );
    if (index == -1) {
      items.add(
        CartItemEntity(
          product: product,
          quantity: quantity,
        ),
      );
    } else {
      final oldItem = items[index];

      items[index] = CartItemEntity(
        product: oldItem.product,
        quantity: oldItem.quantity + quantity,
      );
    }
    await localDataSource.saveCart(items);
    emit(state.copyWith(items: items));
  }
  Future<void> removeProduct(ProductEntity product)async{
    final items = List<CartItemEntity>.from(state.items);
    items.removeWhere(
        (item) => item.product.id == product.id,
    );
    await localDataSource.saveCart(items);
    emit(state.copyWith(
      items: items,
    ));
  }
  Future<void> increaseQuantity(ProductEntity product) async{
    final items = List<CartItemEntity>.from(state.items);

    final index = items.indexWhere(
          (item) => item.product.id == product.id,
    );

    if (index == -1) return;

    final oldItem = items[index];

    items[index] = CartItemEntity(
      product: oldItem.product,
      quantity: oldItem.quantity + 1,
    );
    await localDataSource.saveCart(items);
    emit(
      state.copyWith(
        items: items,
      ),
    );
  }

  Future<void> decreaseQuantity(ProductEntity product)async {
    final items = List<CartItemEntity>.from(state.items);

    final index = items.indexWhere(
          (item) => item.product.id == product.id,
    );

    if (index == -1) return;

    final oldItem = items[index];

    if (oldItem.quantity == 1) {
      items.removeAt(index);
    } else {
      items[index] = CartItemEntity(
        product: oldItem.product,
        quantity: oldItem.quantity - 1,
      );
    }
    await localDataSource.saveCart(items);
    emit(
      state.copyWith(
        items: items,
      ),
    );
  }
  Future<void> loadCart()async{
    final items = localDataSource.getCart();
    emit(state.copyWith(items: items));
  }
  Future<void> restoreProduct(CartItemEntity item) async {
    final items = List<CartItemEntity>.from(state.items);

    items.add(item);

    await localDataSource.saveCart(items);

    emit(state.copyWith(items: items));
  }
}