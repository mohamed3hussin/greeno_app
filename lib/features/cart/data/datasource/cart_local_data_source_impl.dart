import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/cart_item_entity.dart';
import '../models/cart_item_hive_model.dart';
import 'cart_local_data_source.dart';

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final Box<CartItemHiveModel> box;

  CartLocalDataSourceImpl(this.box);

  @override
  Future<void> clearCart() async {
    await box.clear();
  }

  @override
  List<CartItemEntity> getCart() {
    return box.values.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> saveCart(List<CartItemEntity> items) async {
    final hiveItems =
    items.map((e) => CartItemHiveModel.fromEntity(e)).toList();

    await box.clear();

    await box.addAll(hiveItems);
  }
}