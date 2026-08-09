import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greeno_app/features/orders/domain/usecases/get_orders_use_case.dart';
import 'package:greeno_app/features/orders/presentation/cubit/orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase ordersUseCase;

  OrdersCubit({required this.ordersUseCase}):super(OrdersInitialState());

  Future<void> getOrders(String userUid)async{
    emit(OrdersLoadingState());
    final result = await ordersUseCase(userUid);
    result.fold(
        (failure){
          emit(OrdersErrorState(message: failure.message));
        },
        (orders){
          emit(OrdersSuccessState(orders: orders));
        }
    );
  }

}