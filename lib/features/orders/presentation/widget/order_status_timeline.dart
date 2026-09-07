import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              isCompleted: true,
            ),
            _buildStatusItem(
              title: 'Confirmed',
              isCompleted: true,
            ),
            _buildStatusItem(
              title: 'Shipping',
              isCompleted: false,
            ),
            _buildStatusItem(
              title: 'Delivered',
              isCompleted: false,
            ),
          ],
        ),
      ),
    );
  }
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

