import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/core/assets_date/iconBroken.dart';
import 'package:greeno_app/core/theme/app_colors.dart';
import 'package:greeno_app/features/auth/presentation/widgets/auth_back_button.dart';
import 'package:greeno_app/features/home/domain/entities/product_entity.dart';
import 'package:greeno_app/features/home/presentation/widgets/home_icon_button.dart';

class ProductImagesSlider extends StatefulWidget {
  const ProductImagesSlider({
    super.key,
    required this.product,
  });
  final ProductEntity product;

  @override
  State<ProductImagesSlider> createState() => _ProductImagesSliderState();
}

class _ProductImagesSliderState extends State<ProductImagesSlider> {
  final PageController _pageController = PageController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340.h,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.09),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            PageView.builder(
                controller: _pageController,
                itemCount: widget.product.images.length,
                onPageChanged: (index){
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder:(context,index){
                  return Padding(
                    padding: EdgeInsets.all(20.r),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(24.r),
                      child: Image.network(
                        widget.product.images[index],
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                } ,
            ),
            Positioned(
                top: 12.h,
                left: 12.w,
                child: AuthBackButton(),
            ),
            Positioned(
              top: 12.h,
              right: 12.w,
              child: HomeIconButton(
                  icon: IconBroken.Heart,
                  onPressed: (){},
                  color: AppColors.primary,
              ),
            ),
            Positioned(
              bottom: 20.h,
              right: 0,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    widget.product.images.length,
                    (index){
                      return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          height: 8.h,
                          width: currentIndex == index ? 22.w : 8.w,
                          decoration: BoxDecoration(
                            color: currentIndex == index ?
                                AppColors.primary :
                                Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20.r),

                          ),
                      );
                    },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
