import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/core/theme/app_colors.dart';
import 'package:greeno_app/core/theme/app_text_styles.dart';
import 'package:greeno_app/features/home/domain/entities/product_entity.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({
    super.key,
    required this.product,
  });
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: AppTextStyles.title.copyWith(fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 8.h,),
        Row(
          children: [
            Icon(
                Icons.star_rounded,
                color: Colors.amber,
                size: 18.sp,
            ),
            SizedBox(width: 4.w,),
            Text(
              '4.8',
              style: AppTextStyles.body,
            ),
            SizedBox(width: 12.w,),
            Text(
              '(245 Reviews)',
              style: AppTextStyles.hint,
            ),
          ],
        ),
        SizedBox(height: 14.h,),
        Row(
          children: [
            if(product.discountPrice != null)
              Text(
                '${product.discountPrice} EGP',
                style: AppTextStyles.title.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              )
            else
              Text(
                '${product.price} EGP',
                style: AppTextStyles.title.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            SizedBox(width: 10.w,),
            if(product.discountPrice != null)
              Text(
                '${product.price} EGP',
                style: AppTextStyles.body.copyWith(
                  decoration: TextDecoration.lineThrough,
                  color: AppColors.textSecondary,
                ),
              ),
            SizedBox(width: 60.w,),
            Text(
              '1 Kilo',
              style: AppTextStyles.body.copyWith(
                fontWeight: FontWeight.w600
              ),
            ),
          ],
        ),
        SizedBox(height: 22.h,),
        Text(
          'Description',
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h,),
        Text(
          product.description,
          style: AppTextStyles.body.copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
