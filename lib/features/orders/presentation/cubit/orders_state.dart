import 'package:equatable/equatable.dart';
import 'package:greeno_app/features/checkout/domain/entities/order_entity.dart';

import '../enums/order_filter.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class OrdersInitialState extends OrdersState{}
class OrdersLoadingState extends OrdersState{}
class OrdersSuccessState extends OrdersState {
  final List<OrderEntity> orders;
  final OrderFilter selectedFilter;

  const OrdersSuccessState({
    required this.orders,
    required this.selectedFilter,
  });

  @override
  List<Object?> get props => [
    orders,
    selectedFilter,
  ];
}
class OrdersErrorState extends OrdersState{
  final String message;

  const OrdersErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}