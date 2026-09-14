import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:greeno_app/core/routes/route_names.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';

import '../cubit/orders_cubit.dart';
import '../cubit/orders_state.dart';
import '../enums/order_filter.dart';
import 'order_card.dart';
import 'order_filter_bar.dart';

class OrderPageView extends StatelessWidget {
  const OrderPageView({
    super.key,
    required this.user,
  });
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          print('CURRENT STATE: $state');
          if (state is OrdersLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is OrdersErrorState) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is OrdersSuccessState) {
            print('STATE FILTER: ${state.selectedFilter}');

            final filteredOrders = state.selectedFilter == OrderFilter.all
                ? state.orders
                : state.orders
                .where(
                  (order) => order.status == state.selectedFilter.name,
            )
                .toList();

            return Column(
              children: [
                SizedBox(height: 12.h),

                OrderFilterBar(
                  selectedFilter: state.selectedFilter,
                  onChanged: (filter) {
                    context.read<OrdersCubit>().changeFilter(filter);
                  },
                ),
                SizedBox(height: 16.h,),
                Expanded(
                  child: filteredOrders.isEmpty
                      ? const Center(
                    child: Text('No orders found'),
                  )
                      : ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    itemCount: filteredOrders.length,
                    separatorBuilder: (_, __) => SizedBox(
                      height: 12.h,
                    ),
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];

                      return OrderCard(
                        order: order,
                        onTap: () {
                          context.push(
                            RouteNames.orderDetails,
                            extra: {
                              'order':order,
                              'user': user,
                              'orderCubit':context.read<OrdersCubit>(),
                            }
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
