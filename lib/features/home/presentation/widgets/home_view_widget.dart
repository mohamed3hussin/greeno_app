import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/features/auth/domain/entities/user_entity.dart';
import 'package:greeno_app/features/home/presentation/widgets/home_categories_section.dart';
import 'package:greeno_app/features/home/presentation/widgets/home_product_section.dart';

import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'home_app_bar.dart';
import 'home_banner_slider.dart';
import 'home_searsh_bar.dart';

class HomeViewWidget extends StatelessWidget {
  const HomeViewWidget({
    super.key,
    required this.user,
  });
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {

          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is HomeError) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is HomeLoaded) {
            return SafeArea(
                child: Padding(
                  padding:EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: HomeAppBar(user: user,),
                      ),

                      SliverToBoxAdapter(
                        child: SizedBox(height: 20.h),
                      ),

                      SliverToBoxAdapter(
                        child: HomeSearchBar(),
                      ),

                      SliverToBoxAdapter(
                        child: SizedBox(height: 20.h),
                      ),

                      SliverToBoxAdapter(
                        child: HomeBannerSlider(),
                      ),

                      SliverToBoxAdapter(
                        child: SizedBox(height: 12.h),
                      ),

                      SliverToBoxAdapter(
                        child: HomeCategoriesSection(),
                      ),

                      SliverToBoxAdapter(
                        child: SizedBox(height: 12.h),
                      ),

                      SliverToBoxAdapter(
                        child: HomeProductSection(),
                      ),
                    ],
                  ),
                ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
