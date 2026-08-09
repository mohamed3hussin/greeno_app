import 'package:equatable/equatable.dart';
import 'package:greeno_app/features/checkout/domain/entities/order_entity.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class OrdersInitialState extends OrdersState{}
class OrdersLoadingState extends OrdersState{}
class OrdersSuccessState extends OrdersState{
  final List<OrderEntity>orders;

  const OrdersSuccessState({required this.orders});
  @override
  List<Object?> get props => [orders];
}
class OrdersErrorState extends OrdersState{
  final String message;

  const OrdersErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}