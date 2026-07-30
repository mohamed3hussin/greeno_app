import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/features/auth/presentation/widgets/auth_back_button.dart';
import 'package:greeno_app/features/home/domain/entities/product_entity.dart';
import 'package:greeno_app/features/home/presentation/cubit/product_quantity_cubit.dart';
import 'package:greeno_app/features/home/presentation/widgets/product_add_to_cart_section.dart';
import 'package:greeno_app/features/home/presentation/widgets/product_images_slider.dart';
import 'package:greeno_app/features/home/presentation/widgets/product_info_section.dart';
import 'package:greeno_app/features/home/presentation/widgets/product_quantity_section.dart';

import '../../../../core/dependency_injection/injection_container.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({
    super.key,
    required this.product,
  });
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductQuantityCubit>(),
      child: Scaffold(
        body: SafeArea(
            child:Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProductImagesSlider(product: product),
                    SizedBox(height: 20.h,),
                    ProductInfoSection(product: product),
                    SizedBox(height: 24.h,),
                    ProductQuantitySection(),
                    SizedBox(height: 20.h,),
                    ProductAddToCartSection(product: product),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}
