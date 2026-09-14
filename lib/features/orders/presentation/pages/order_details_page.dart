import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/core/theme/app_text_styles.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';
import 'package:greeno_app/features/checkout/domain/entities/order_entity.dart';
import 'package:greeno_app/features/orders/presentation/cubit/orders_state.dart';
import 'package:greeno_app/features/orders/presentation/widget/delivery_info.dart';
import 'package:greeno_app/features/orders/presentation/widget/item_section.dart';
import 'package:greeno_app/features/orders/presentation/widget/order_status_timeline.dart';
import 'package:greeno_app/features/orders/presentation/widget/order_summary.dart';
import 'package:greeno_app/features/orders/presentation/widget/payment_section.dart';

import '../../../../core/constants/order_status.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/orders_cubit.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({
    super.key,
    required this.user,
    required this.order,
  });
  final UserEntity user;
  final OrderEntity order;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit,OrdersState>(
      builder: (context,state){
        OrderEntity currentOrder = order;
        if (state is OrdersSuccessState) {
          for (final item in state.orders) {
            if (item.id == order.id) {
              currentOrder = item;
              break;
            }
          }
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('Order Details'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order #${order.id.substring(0, 8)}',
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 18.sp,
                        color: AppColors.textSecondary,
                      ),

                      SizedBox(width: 6.w),

                      Text(
                        _formatDate(order.createdAt),
                        style: AppTextStyles.hint,
                      ),
                      Spacer(),
                      if (canCancelOrder(currentOrder.status))
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.red),),
                          onPressed: (){
                            final ordersCubit = context.read<OrdersCubit>();
                            showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                    title: const Text('Cansel Order'),
                                    content: const Text(
                                      'Are you sure you want to cancel this order?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          ordersCubit.cancelOrder(
                                            user.uid!,
                                            order.id,
                                          );
                                        },
                                        child: const Text('Yes, Cancel'),
                                      ),
                                    ],
                                  );
                                }
                            );
                          },
                          child: Text('Cansel',style: TextStyle(color: Colors.red),),),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  OrderStatusTimeline(order: currentOrder),
                  SizedBox(height: 16.h,),
                  ItemSection(order: currentOrder),
                  SizedBox(height: 16.h,),
                  DeliveryInfo(user: user, order: currentOrder),
                  SizedBox(height: 16.h,),
                  OrderSummary(order: currentOrder),
                  SizedBox(height: 16.h,),
                  PaymentSection(order: currentOrder),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
String _formatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}
bool canCancelOrder(String status) {
  return status == OrderStatus.pending ||
      status == OrderStatus.confirmed;
}
