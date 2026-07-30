import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/core/theme/app_colors.dart';
import 'package:greeno_app/core/theme/app_text_styles.dart';
import 'package:greeno_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:greeno_app/features/cart/presentation/cubit/cart_cubit.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.item
  });
  final CartItemEntity item;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
          ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                item.product.images.first,
                width: 90.w,
                height: 90.h,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image_rounded,
                      size: 40,
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 12.w,),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product.name,
                      style: AppTextStyles.label,
                    ),
                    SizedBox(height: 8.h,),
                    Text(
                      "${item.product.discountPrice ?? item.product.price} EGP",
                      style: AppTextStyles.hint.copyWith(
                        color: AppColors.primary
                      ),
                    ),
                    SizedBox(height: 12.h,),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<CartCubit>()
                                .decreaseQuantity(item.product);
                          },
                          icon: const Icon(Icons.remove,color: Colors.red,),
                        ),
                        SizedBox(width: 8.w,),
                        Text(
                          item.quantity.toString(),
                          style: AppTextStyles.title,
                        ),
                        SizedBox(width: 8.w,),
                        IconButton(
                          onPressed: () {
                            context.read<CartCubit>()
                                .addProduct(item.product,item.quantity);
                          },
                          icon: const Icon(
                            Icons.add,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
            ),
            IconButton(
              onPressed: () {
                context.read<CartCubit>()
                    .removeProduct(item.product);
              },
              icon: Icon(Icons.delete,color: Colors.red,),
            )
          ],
        ),
      ),
    );
  }
}
