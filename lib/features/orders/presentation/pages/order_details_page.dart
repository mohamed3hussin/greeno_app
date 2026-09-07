import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/core/theme/app_text_styles.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';
import 'package:greeno_app/features/checkout/domain/entities/order_entity.dart';
import 'package:greeno_app/features/orders/presentation/widget/delivery_info.dart';
import 'package:greeno_app/features/orders/presentation/widget/item_section.dart';
import 'package:greeno_app/features/orders/presentation/widget/order_status_timeline.dart';
import 'package:greeno_app/features/orders/presentation/widget/order_summary.dart';
import 'package:greeno_app/features/orders/presentation/widget/payment_section.dart';

import '../../../../core/theme/app_colors.dart';

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
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.red),),
                      onPressed: (){},
                      child: Text('Cansel',style: TextStyle(color: Colors.red),),),
                ],
              ),
              SizedBox(height: 10.h,),
              OrderStatusTimeline(order: order),
              SizedBox(height: 16.h,),
              ItemSection(order: order),
              SizedBox(height: 16.h,),
              DeliveryInfo(user: user, order: order),
              SizedBox(height: 16.h,),
              OrderSummary(order: order),
              SizedBox(height: 16.h,),
              PaymentSection(order: order),
            ],
          ),
        ),
      ),
    );
  }
}
String _formatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}
