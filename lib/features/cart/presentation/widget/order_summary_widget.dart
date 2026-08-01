import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({
    super.key,
    required this.subtotal,
  });

  final double subtotal;

  @override
  Widget build(BuildContext context) {
    const delivery = 30.0;

    final total = subtotal + delivery;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(18.w),
        child: Column(
          children: [

            _buildRow(
              title: 'Subtotal',
              value: '${subtotal.toStringAsFixed(2)} EGP',
            ),

            SizedBox(height: 12.h),

            _buildRow(
              title: 'Delivery',
              value: '${delivery.toStringAsFixed(2)} EGP',
            ),

            Divider(height: 30.h),

            _buildRow(
              title: 'Total',
              value: '${total.toStringAsFixed(2)} EGP',
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow({
    required String title,
    required String value,
    bool isBold = false,
  }) {
    return Row(
      children: [

        Text(
          title,
          style: isBold
              ? AppTextStyles.button
              : AppTextStyles.body,
        ),

        const Spacer(),

        Text(
          value,
          style: isBold
              ? AppTextStyles.button.copyWith(
            color: AppColors.primary,
          )
              : AppTextStyles.body,
        ),
      ],
    );
  }
}