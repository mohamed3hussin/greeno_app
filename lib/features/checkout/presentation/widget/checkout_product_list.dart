import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/core/theme/app_text_styles.dart';
import 'package:greeno_app/features/cart/domain/entities/cart_item_entity.dart';

import '../../../../core/theme/app_colors.dart';

class CheckoutProductList extends StatelessWidget {
  const CheckoutProductList({
    super.key,
    required this.items
  });
  final List<CartItemEntity> items;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(20.r),
      ),
      child: Padding(
          padding: EdgeInsetsGeometry.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'your order',
                style: AppTextStyles.title,
              ),
              SizedBox(height: 16.h,),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    final item = items[index];
                    final price = item.product.discountPrice?? item.product.price;
                    return Row(
                      children: [
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
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context,index)=> Divider(height: 24.h),
                  itemCount: items.length,
              ),
            ],
          ),
      ),
    );
  }
}
