import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greeno_app/features/orders/domain/usecases/get_orders_use_case.dart';
import 'package:greeno_app/features/orders/presentation/cubit/orders_state.dart';

import '../enums/order_filter.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase ordersUseCase;

  OrdersCubit({required this.ordersUseCase}):super(OrdersInitialState());

  Future<void> getOrders(String userUid)async{
    print('🔥 GET ORDERS CALLED');
    emit(OrdersLoadingState());
    final result = await ordersUseCase(userUid);
    result.fold(
        (failure){
          emit(OrdersErrorState(message: failure.message));
        },
        (orders){
          emit(OrdersSuccessState(orders: orders, selectedFilter: OrderFilter.all,));
        }
    );
  }
  void changeFilter(OrderFilter filter) {
    print('FILTER CLICKED: $filter');

    final currentState = state;

    if (currentState is OrdersSuccessState) {
      print('OLD FILTER: ${currentState.selectedFilter}');
      print('NEW FILTER: $filter');

      emit(
        OrdersSuccessState(
          orders: currentState.orders,
          selectedFilter: filter,
        ),
      );
    }
  }

}