import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:greeno_app/features/checkout/domain/entities/order_entity.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({
    super.key,
    required this.item
  });
  final CartItemEntity item;
  @override
  Widget build(BuildContext context) {
    final price = item.product.discountPrice?? item.product.price;
    return Row(
      children: [
        Container(
          height: 70.h,
          width: 70.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Colors.grey.shade100
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(item.product.images.first,fit: BoxFit.cover,),
        ),
        SizedBox(width: 12.w,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.product.name,
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Text(
                    "${price} EGP",
                    style: AppTextStyles.hint,
                  ),
                  SizedBox(width: 8.w,),
                  Text(
                    '1 Kg',
                    style: AppTextStyles.hint,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 16.w,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "x${item.quantity}",
              style: AppTextStyles.body,
            ),
            SizedBox(height: 4.h),
            Text(
              "${price * item.quantity} EGP",
              style: AppTextStyles.label.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
