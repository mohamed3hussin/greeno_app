import 'package:equatable/equatable.dart';
import 'package:greeno_app/features/checkout/presentation/widget/checkout_payment_method.dart';

import '../../../auth/domain/entities/address_entity.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';

class OrderEntity extends Equatable {
  final String id;

  final List<CartItemEntity> items;

  final String userId;

  final AddressEntity address;

  final double subtotal;

  final double deliveryFee;

  final double total;

  final DateTime createdAt;

  final String status;

  final PaymentType paymentType;

  final PaymentStatus paymentStatus;

  const OrderEntity({
    required this.id,
    required this.items,
    required this.userId,
    required this.address,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.createdAt,
    required this.status,
    required this.paymentType,
    required this.paymentStatus,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    items,
    userId,
    address,
    subtotal,
    deliveryFee,
    total,
    createdAt,
    status,
    paymentType,
    paymentStatus,
  ];
}