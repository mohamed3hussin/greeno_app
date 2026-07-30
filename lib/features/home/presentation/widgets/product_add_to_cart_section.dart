import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/product_entity.dart';
import '../cubit/product_quantity_cubit.dart';

class ProductAddToCartSection extends StatelessWidget {
  const ProductAddToCartSection({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductQuantityCubit, ProductQuantityState>(
      builder: (context, state) {
        final quantity = state.quantity;

        final price =
            product.discountPrice ?? product.price;

        final total = price * quantity;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Price',
                      style: AppTextStyles.hint,
                    ),

                    SizedBox(height: 4.h),

                    Text(
                      '${total.toInt()} EGP',
                      style: AppTextStyles.title.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              /// Add To Cart
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: () {

                    },
                    child: const Text(
                      'Add To Cart',
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}