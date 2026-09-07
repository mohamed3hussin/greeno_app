import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/features/checkout/domain/entities/order_entity.dart';

import '../../../../core/theme/app_text_styles.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({
    super.key,
    required this.order
  });
  final OrderEntity order;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment',
          style: AppTextStyles.title.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10.h,),
        Text(order.paymentType.name,
          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 6.h,),
        Text(order.paymentStatus.name,
          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
