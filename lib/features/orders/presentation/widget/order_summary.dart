import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/features/checkout/domain/entities/order_entity.dart';

import '../../../../core/theme/app_text_styles.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    super.key,
    required this.order
  });
  final OrderEntity order;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Delivery info',
          style: AppTextStyles.title.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10.h,),
        Card(
          elevation: 1,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Subtotal",
                      style: AppTextStyles.body,
                    ),
                    Text(
                      "${order.subtotal.toStringAsFixed(2)} EGP",
                      style: AppTextStyles.body,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delivery Fee",
                      style: AppTextStyles.body,
                    ),
                    Text(
                      "${order.deliveryFee.toStringAsFixed(2)} EGP",
                      style: AppTextStyles.body,
                    ),
                  ],
                ),
                Divider(height: 28.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: AppTextStyles.title.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${order.total.toStringAsFixed(2)} EGP",
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
