import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:greeno_app/core/constants/primary_button.dart';
import 'package:greeno_app/core/routes/route_names.dart';
import 'package:greeno_app/features/auth/domain/entities/address_entity.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';
import 'package:greeno_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:greeno_app/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:greeno_app/features/checkout/presentation/widget/checkout_address_card.dart';
import 'package:greeno_app/features/checkout/presentation/widget/checkout_product_list.dart';

import '../cubit/checkout_cubit.dart';
import 'checkout_order_summary.dart';
import 'checkout_payment_method.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({
    super.key,
    required this.user
  });
  final UserEntity user;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  PaymentType paymentType = PaymentType.cash;
  late AddressEntity selectedAddress;
  @override
  void initState(){
    super.initState();
    selectedAddress = widget.user.address;
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutCubit,CheckoutState>(
        listener: (context,state){
          if(state is CheckoutSuccess){
            context.read<CartCubit>().clearCart();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order placed successfully')
              )
            );
            context.pop();
          }
          if(state is CheckoutError){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)
                )
            );
          }
        },
        builder: (context,state){
          final cartItems = context.watch<CartCubit>().state.items;
          final subtotal = cartItems.fold<double>(
            0,
                (sum, item) {
              final price = item.product.discountPrice ?? item.product.price;
              return sum + (price * item.quantity);
            },
          );
          return Scaffold(
            appBar: AppBar(
              title: const Text('Checkout'),
            ),
            body: SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 20.w,
                  ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CheckoutAddressCard(
                          address: selectedAddress,
                          onChange: ()async{
                            final result = await context.push<AddressEntity>(
                                RouteNames.selectDeliveryAddress,
                                extra: selectedAddress,
                            );
                            if(result != null){
                              setState(() {
                                selectedAddress = result;
                              });
                            }

                          },
                      ),
                      SizedBox(height: 16.h,),
                      CheckoutProductList(items: cartItems),
                      SizedBox(height: 16.h,),
                      CheckoutPaymentMethod(
                        selectedMethod: paymentType,
                        onChanged: (value) {
                          setState(() {
                            paymentType = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.h,),
                      CheckoutOrderSummary(
                        subtotal: subtotal,
                        deliveryFee: 30,
                      ),
                      SizedBox(height: 16.h,),
                      PrimaryButton(
                          text: 'Place Order',
                          isLoading: state is CheckoutLoading,
                          onPressed: (){
                            context.read<CheckoutCubit>().placeOrder(
                              user: widget.user,
                              items: cartItems,
                              address: selectedAddress,
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
    );
  }
}
