import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';
import 'package:greeno_app/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:greeno_app/features/orders/presentation/widget/order_page_view.dart';

import '../../../../core/dependency_injection/injection_container.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({
    super.key,
    required this.user
  });
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<OrdersCubit>()..getOrders(user.uid!),
        child: OrderPageView(user: user,),
    );
  }
}
