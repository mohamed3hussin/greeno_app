import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CheckoutOrderSummary extends StatelessWidget {
  const CheckoutOrderSummary({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
  });

  final double subtotal;
  final double deliveryFee;

  @override
  Widget build(BuildContext context) {
    final total = subtotal + deliveryFee;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
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
                  "${subtotal.toStringAsFixed(2)} EGP",
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
                  "${deliveryFee.toStringAsFixed(2)} EGP",
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
                  "${total.toStringAsFixed(2)} EGP",
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}