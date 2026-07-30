import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/core/theme/app_colors.dart';
import 'package:greeno_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:greeno_app/features/home/presentation/cubit/home_state.dart';

class HomeBannerSlider extends StatelessWidget {
  const HomeBannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit,HomeState>(
        builder: (context,state){

          if (state is! HomeLoaded) {
            return const SizedBox();
          }

          final banners = state.banners;

          if (banners.isEmpty) {
            return const SizedBox();
          }
          return CarouselSlider.builder(
              itemCount: banners.length,
              itemBuilder: (context,index,realIndex){
                final banner = banners[index];
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.r),
                    color: AppColors.primary.withOpacity(0.15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18.r),
                    child: Image.network(
                        banner.image,
                        width: double.infinity,
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
                );
              },
              options: CarouselOptions(
                height: 180.h,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
              ),
          );
        });
  }
}
