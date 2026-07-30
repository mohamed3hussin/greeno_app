import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/core/theme/app_text_styles.dart';
import 'package:greeno_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:greeno_app/features/home/presentation/cubit/home_state.dart';
import 'package:greeno_app/features/home/presentation/widgets/category_item.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit,HomeState>(
        builder: (context,state){
          if (state is! HomeLoaded) {
            return const SizedBox();
          }
          final categories = state.categories;
          if(categories.isEmpty){
            return const SizedBox();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('See All'),
                  ),
                ],
              ),

              SizedBox(
                height: 100.h,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index) {
                      final category = categories[index];
                      return CategoryItem(category: category,);
                    },
                  separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemCount: categories.length,
                ),
              ),
            ],
          );
        });
  }
}
