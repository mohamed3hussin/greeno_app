import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/features/home/presentation/widgets/product_item.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class HomeProductSection extends StatelessWidget {
  const HomeProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit,HomeState>(
        builder: (context,state){
          if (state is! HomeLoaded) {
            return const SizedBox();
          }
          final products = state.products;
          if(products.isEmpty){
            return const SizedBox();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Products',
                    style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('See All'),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: SizedBox(
                  height: 295.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index) {
                      final product = products[index];
                      return ProductItem(product: product,);
                    },
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemCount: products.length,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
