import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';
import 'package:greeno_app/features/checkout/domain/entities/order_entity.dart';

import '../../../../core/theme/app_text_styles.dart';

class DeliveryInfo extends StatelessWidget {
  const DeliveryInfo({
    super.key,
    required this.user,
    required this.order,
  });
  final UserEntity user;
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
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name,
                      style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8.h,),
                    Text(order.address.fullAddress,
                      style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8.h,),
                    Text(user.phone,
                      style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
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
