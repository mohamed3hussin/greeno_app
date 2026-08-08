import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greeno_app/features/cart/data/models/cart_item_hive_model.dart';
import 'package:greeno_app/features/cart/data/models/cart_item_model.dart';
import 'package:greeno_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:greeno_app/features/checkout/presentation/widget/checkout_payment_method.dart';

import '../../../auth/data/models/address_model.dart';
import '../../domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.items,
    required super.userId,
    required super.address,
    required super.subtotal,
    required super.deliveryFee,
    required super.total,
    required super.createdAt,
    required super.status,
    required super.paymentType,
    required super.paymentStatus,
  });

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      id: entity.id,
      items: entity.items,
      userId: entity.userId,
      address: entity.address,
      subtotal: entity.subtotal,
      deliveryFee: entity.deliveryFee,
      total: entity.total,
      createdAt: entity.createdAt,
      status: entity.status,
      paymentType: entity.paymentType,
      paymentStatus: entity.paymentStatus,
    );
  }
  factory OrderModel.fromJson(
      Map<String, dynamic> json,
      String id,
      ) {
    return OrderModel(
      id: id,

      items: (json['items'] as List)
          .map(
            (item) => CartItemModel.fromJson(
          item as Map<String, dynamic>,
        ),
      )
          .toList(),

      userId: json['userId'] as String,

      address: AddressModel.fromJson(
        json['address'] as Map<String, dynamic>,
      ),

      subtotal: (json['subtotal'] as num).toDouble(),

      deliveryFee: (json['deliveryFee'] as num).toDouble(),

      total: (json['total'] as num).toDouble(),

      createdAt: (json['createdAt'] as Timestamp).toDate(),

      status: json['status'] as String,
      paymentType: PaymentType.values.byName(json['paymentType']),
      paymentStatus: PaymentStatus.values.byName(json['paymentStatus']),
    );
  }
  Map<String, dynamic> toJson(){
    return {

      'items':items.map((item) => CartItemModel.fromEntity(item).toJson()).toList(),
      'userId':userId,
      'address':AddressModel.fromEntity(address).toJson(),
      'subtotal':subtotal,
      'deliveryFee':deliveryFee,
      'total':total,
      'createdAt':Timestamp.fromDate(createdAt),
      'status':status,
      'paymentType':paymentType.name,
      'paymentStatus':paymentStatus.name,
    };
  }
}