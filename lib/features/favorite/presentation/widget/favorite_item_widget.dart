import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/core/theme/app_colors.dart';
import 'package:greeno_app/features/favorite/domain/entities/favorite_item_entity.dart';
import 'package:greeno_app/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:greeno_app/features/home/domain/entities/product_entity.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../home/presentation/widgets/home_icon_button.dart';

class FavoriteItemWidget extends StatelessWidget {
  const FavoriteItemWidget({
    super.key,
    required this.product
  });
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    final isFavorite = context.watch<FavoriteCubit>().isFavorite(product);
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.network(
                product.images.first,
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
                    product.name,
                    style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.h,),
                  Text(
                    product.description,
                    style: AppTextStyles.hint.copyWith(color: Colors.grey[500]),
                  ),
                ],
              ),
            ),

            HomeIconButton(
              icon:isFavorite ? Icons.favorite : Icons.favorite_border,
              onPressed: (){
                context.read<FavoriteCubit>().toggleFavorite(product);
              },
              color:isFavorite ? AppColors.primary : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );;
  }
}
