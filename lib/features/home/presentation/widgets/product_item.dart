import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:greeno_app/core/assets_date/iconBroken.dart';
import 'package:greeno_app/core/routes/route_names.dart';
import 'package:greeno_app/core/theme/app_colors.dart';
import 'package:greeno_app/core/theme/app_text_styles.dart';
import 'package:greeno_app/features/home/domain/entities/product_entity.dart';
import 'package:greeno_app/features/home/presentation/widgets/home_icon_button.dart';

import '../../../cart/presentation/cubit/cart_cubit.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product
  });
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.push(RouteNames.product, extra: product);
      },
      child: Container(
        width: 200.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.09),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150.h,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(18.r),
                    ),
                    child: Image.network(
                      product.images.first,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
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
                  Positioned(
                      top: 8.h,
                      left: 8.w,
                      child: HomeIconButton(
                          icon: IconBroken.Heart,
                          onPressed: (){},
                          color: AppColors.primary,
                      ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppTextStyles.label,
                  ),
                  SizedBox(height: 4.h,),
                  Text(
                    product.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.hint,
                  ),
                  SizedBox(height: 4.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if(product.discountPrice == null)
                        Text(
                        '${product.price.toInt()} EGP',
                        style: AppTextStyles.title.copyWith(
                          color: product.discountPrice != null ? AppColors.textSecondary : AppColors.textPrimary,
                          decoration: product.discountPrice != null ? TextDecoration.lineThrough :null,
                          decorationColor: product.discountPrice != null ? AppColors.textSecondary : null,
                        ),
                      ),
                      if(product.discountPrice != null)
                        SizedBox(width: 8.w,),
                      if(product.discountPrice != null)
                        Text(
                          '${product.discountPrice!.toInt()} EGP',
                          style: AppTextStyles.title,
                        ),
                      Spacer(),
                      HomeIconButton(
                        icon: IconBroken.Plus,
                        onPressed: (){
                          context.read<CartCubit>().addProduct(product, 1);
                        },
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                  Text(
                    '${product.price.toInt()} EGP',
                    style: AppTextStyles.title.copyWith(
                      color: product.discountPrice != null ? AppColors.textSecondary : AppColors.textPrimary,
                      decoration: product.discountPrice != null ? TextDecoration.lineThrough :null,
                      decorationColor: product.discountPrice != null ? AppColors.textSecondary : null,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
