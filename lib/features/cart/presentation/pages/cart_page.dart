import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:greeno_app/core/constants/app_images.dart';
import 'package:greeno_app/core/constants/primary_button.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';
import 'package:greeno_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:greeno_app/features/cart/presentation/widget/cart_item_widget.dart';
import 'package:greeno_app/features/cart/presentation/widget/order_summary_widget.dart';

import '../../../../core/routes/route_names.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    super.key,
    required this.user
  });
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: BlocBuilder<CartCubit,CartState>(
          builder: (context,state){
            if(state.items.isEmpty){
              return Center(
                child: Image.asset(AppImages.cart),
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemBuilder: (context,index){
                          final item = state.items[index];
                          return SizedBox(
                            height: 180.h,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: Dismissible(
                                key: ValueKey(item.product.id),

                                direction: DismissDirection.endToStart,

                                background: Container(
                                  margin: EdgeInsets.only(bottom: 16.h),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                                  child: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),

                                confirmDismiss: (_) async {
                                  return await showDialog<bool>(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text("Remove Product"),
                                      content: Text(
                                        "Remove ${item.product.name} from cart?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                          },
                                          child: const Text("Delete"),
                                        ),
                                      ],
                                    ),
                                  ) ??
                                      false;
                                },

                                onDismissed: (_) {
                                  final removedItem = item;

                                  final cartCubit = context.read<CartCubit>();

                                  cartCubit.removeProduct(removedItem.product);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("${removedItem.product.name} removed"),
                                      action: SnackBarAction(
                                        label: "UNDO",
                                        onPressed: () {
                                          cartCubit.restoreProduct(removedItem);
                                        },
                                      ),
                                    ),
                                  );
                                },

                                child: CartItemWidget(
                                  item: item,
                                ),
                              ),
                            ),
                          );
                        },

                        itemCount: state.items.length,
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OrderSummaryWidget(subtotal: state.subtotal,),
                      SizedBox(height: 16.h,),
                      PrimaryButton(text: 'Proceed to Checkout', onPressed: (){
                        context.push(
                          RouteNames.checkout,
                          extra: {
                            'user': user,
                            'cartCubit': context.read<CartCubit>(),
                          },
                        );
                      }),
                    ],
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}
