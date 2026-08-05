import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_text_styles.dart';

enum PaymentType {
  cash,
  card,
}

class CheckoutPaymentMethod extends StatelessWidget {
  const CheckoutPaymentMethod({
    super.key,
    required this.selectedMethod,
    required this.onChanged,
  });

  final PaymentType selectedMethod;
  final ValueChanged<PaymentType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment Method",
              style: AppTextStyles.title,
            ),

            SizedBox(height: 12.h),

            RadioListTile<PaymentType>(
              value: PaymentType.cash,
              groupValue: selectedMethod,
              onChanged: (value) {
                onChanged(value!);
              },
              title: const Text("Cash on Delivery"),
              secondary: const Icon(Icons.payments_outlined),
              contentPadding: EdgeInsets.zero,
            ),

            Divider(height: 8.h),

            RadioListTile<PaymentType>(
              value: PaymentType.card,
              groupValue: selectedMethod,
              onChanged: (value) {
                onChanged(value!);
              },
              title: const Text("Credit / Debit Card"),
              secondary: const Icon(Icons.credit_card),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}