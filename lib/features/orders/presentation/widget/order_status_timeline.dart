import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/core/constants/order_status.dart';
import 'package:greeno_app/core/theme/app_colors.dart';
import 'package:greeno_app/core/theme/app_text_styles.dart';
import 'package:greeno_app/features/checkout/domain/entities/order_entity.dart';

class OrderStatusTimeline extends StatelessWidget {
  const OrderStatusTimeline({
    super.key,
    required this.order
  });
  final OrderEntity order;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
        child: Column(
          children: [
            _buildStatusItem(
              title: 'Order Placed',
              isCompleted: isStepCompleted(
                  order.status,
                  OrderStatus.pending,
              ),
            ),
            _buildStatusItem(
              title: 'Confirmed',
              isCompleted: isStepCompleted(
                order.status,
                OrderStatus.confirmed,
              ),
            ),
            _buildStatusItem(
              title: 'Shipping',
              isCompleted: isStepCompleted(
                order.status,
                OrderStatus.shipping,
              ),
            ),
            _buildStatusItem(
              title: 'Delivered',
              isCompleted: isStepCompleted(
                order.status,
                OrderStatus.delivered,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
int getStatusIndex(String status){
  switch(status){
    case OrderStatus.pending:
      return 0;
    case OrderStatus.confirmed:
      return 1;
    case OrderStatus.shipping:
      return 2;
    case OrderStatus.delivered:
      return 3;
    default:
      return -1;

  }
}
bool isStepCompleted(String currentStatus,String stepStatus){
  return getStatusIndex(currentStatus) >= getStatusIndex(stepStatus);
}
Widget _buildStatusItem({
  required String title,
  required bool isCompleted,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          CircleAvatar(
            radius: 10.r,
            backgroundColor: isCompleted ? AppColors.primary: Colors.grey,
            child: isCompleted
                ? Icon(Icons.check,size:14.r,)
                : const SizedBox(),
          ),
          SizedBox(height: 2.h,),
          Container(
            width: 2.w,
            height: 30.h,
            color: isCompleted ? AppColors.primary : Colors.grey,
          ),
          SizedBox(height: 2.h,),
        ],
      ),

      SizedBox(width: 12.w),

      Text(title,
        style:isCompleted? AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)
        :AppTextStyles.hint.copyWith(fontWeight: FontWeight.w400),
      ),
    ],
  );
}

