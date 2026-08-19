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
      color: AppColors.primary.withOpacity(.08),
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.product.name,
                        style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 6.h,),
                      Text(
                        item.product.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.hint.copyWith(color: Colors.grey[500]),
                      ),
                      SizedBox(height: 12.h,),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${item.product.discountPrice ?? item.product.price} EGP",
                              style: AppTextStyles.label.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  context.read<CartCubit>()
                                      .decreaseQuantity(item.product);
                                },
                                icon: const Icon(Icons.remove,color: Colors.red,),
                              ),

                              Text(
                                item.quantity.toString(),
                                style: AppTextStyles.title,
                              ),

                              IconButton(
                                padding: EdgeInsets.zero,
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
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
