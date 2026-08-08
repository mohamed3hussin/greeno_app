import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greeno_app/features/auth/domain/entities/address_entity.dart';
import 'package:greeno_app/features/cart/data/datasource/cart_local_data_source.dart';
import 'package:greeno_app/features/checkout/domain/entities/order_entity.dart';
import 'package:greeno_app/features/checkout/domain/usecases/place_order_use_case.dart';
import 'package:greeno_app/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:greeno_app/features/checkout/presentation/widget/checkout_payment_method.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/order_status.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final PlaceOrderUseCase placeOrderUseCase;
  CheckoutCubit({
    required this.placeOrderUseCase,
      }): super(CheckoutInitial());

  Future<void> placeOrder({
    required UserEntity user,
    required List<CartItemEntity> items,
    required AddressEntity address,
  })async{
    final subtotal = items.fold<double>(
      0,
          (sum, item) {
        final price = item.product.discountPrice ?? item.product.price;
        return sum + (price * item.quantity);
      },
    );
    const deliveryFee = 30.0;

    final total = subtotal + deliveryFee;
    final order = OrderEntity(
      id: const Uuid().v4(),

      items: items,

      userId: user.uid!,

      address: address,

      subtotal: subtotal,

      deliveryFee: deliveryFee,

      total: total,

      createdAt: DateTime.now(),

      status: OrderStatus.pending,
      paymentType: PaymentType.cash,
      paymentStatus: PaymentStatus.pending
    );
    emit(CheckoutLoading());
    final result = await placeOrderUseCase(order);
    result.fold(
            (failure){
              emit(CheckoutError(message: failure.message));
            }, (_) async{
              emit(CheckoutSuccess());
    });
  }
}