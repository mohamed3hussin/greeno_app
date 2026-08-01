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
      elevation: 1.5,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(22.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.network(
                    item.product.images.first,
                    width: 110.w,
                    height: 100.h,
                    fit: BoxFit.cover,
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
                SizedBox(width: 16.w,),
                Text(
                  item.product.name,
                  style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: Colors.red.withValues(alpha: 0.1),
                  child: IconButton(
                    onPressed: () {
                      context.read<CartCubit>()
                          .removeProduct(item.product);
                    },
                    icon: Icon(Icons.delete_outline,color: Colors.red,),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h,),
            Text(
              item.product.description,
              style: AppTextStyles.hint.copyWith(color: Colors.grey[500]),
            ),
            SizedBox(height: 12.h,),
            Text(
              "${item.product.discountPrice ?? item.product.price} EGP",
              style: AppTextStyles.label.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 18.h,),
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: BoxBorder.all(color: AppColors.primary),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<CartCubit>()
                            .decreaseQuantity(item.product);
                      },
                      icon: const Icon(Icons.remove,color: Colors.red,),
                    ),
                    SizedBox(width: 14.w,),
                    Text(
                      item.quantity.toString(),
                      style: AppTextStyles.title,
                    ),
                    SizedBox(width: 14.w,),
                    IconButton(
                      onPressed: () {
                        context.read<CartCubit>()
                            .increaseQuantity(item.product);
                      },
                      icon: const Icon(
                        Icons.add,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
