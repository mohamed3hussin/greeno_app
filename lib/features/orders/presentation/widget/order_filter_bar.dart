import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/core/theme/app_colors.dart';
import 'package:greeno_app/features/orders/presentation/enums/order_filter.dart';

class OrderFilterBar extends StatelessWidget {
  const OrderFilterBar({
    super.key,
    required this.selectedFilter,
    required this.onChanged,
  });
  final OrderFilter selectedFilter;
  final ValueChanged<OrderFilter> onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index){
            final filter = OrderFilter.values[index];
            return ChoiceChip(
                label: Text(_getFilterName(filter)),
                selectedColor: AppColors.primary,
                selected: selectedFilter == filter,
                onSelected: (_){
                  print('CHIP CLICKED: $filter');
                  onChanged(filter);
                },
            );
          },
          separatorBuilder: (context,index) => SizedBox(width: 8.w,),
          itemCount: OrderFilter.values.length,
      ),
    );
  }
  String _getFilterName(OrderFilter filter){
    switch(filter){
      case OrderFilter.all:
        return 'All';
      case OrderFilter.pending:
        return 'Pending';
      case OrderFilter.confirmed:
        return 'Confirmed';
      case OrderFilter.shipping:
        return 'Shipping';
      case OrderFilter.delivered:
        return 'Delivered';
      case OrderFilter.cancelled:
        return 'Cancelled';
    }
  }
}

