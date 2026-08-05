import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/core/constants/primary_button.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';
import 'package:greeno_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:greeno_app/features/checkout/presentation/cubit/checkout_state.dart';

import '../cubit/checkout_cubit.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({
    super.key,
    required this.user
  });
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutCubit,CheckoutState>(
        listener: (context,state){
          if(state is CheckoutSuccess){
            context.read<CartCubit>().loadCart();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Order placed successfully')
              )
            );
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
          return Scaffold(
            appBar: AppBar(
              title: const Text('Checkout'),
            ),
            body: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 20.h,
                    horizontal: 20.w,
                ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];

                        return ListTile(
                          title: Text(item.product.name),
                          subtitle: Text(
                            'x${item.quantity}',
                          ),
                          trailing: Text(
                            '${(item.product.discountPrice ?? item.product.price) * item.quantity}',
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.h,),
                  PrimaryButton(
                      text: 'Place Order',
                      isLoading: state is CheckoutLoading,
                      onPressed: (){
                        context.read<CheckoutCubit>().placeOrder(
                          user: user,
                          items: cartItems,
                        );
                      },
                  ),
                ],
              ),
            ),
          );
        },
    );
  }
}
