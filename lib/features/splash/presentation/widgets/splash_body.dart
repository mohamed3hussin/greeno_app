import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:greeno_app/core/constants/app_images.dart';
import 'package:greeno_app/core/theme/app_text_styles.dart';
import 'package:greeno_app/features/splash/presentation/widgets/loading_dots.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoFade;
  late Animation<double> _logoScale;
  late Animation<double> _nameFade;
  late Animation<Offset> _nameSlide;
  late Animation<double> _subtitleFade;
  late Animation<Offset> _subtitleSlide;

  @override
  void initState(){
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 3000),
    );
    _logoFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
          0.0,
          0.35,
        curve: Curves.easeIn,
      ),
    );
    _logoScale = Tween<double>(
      begin: 0.6,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
            0.0,
            0.35,
            curve: Curves.easeOutBack,
        ),
      ),
    );
    _nameFade = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.6,curve: Curves.easeIn),
    );
    _nameSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.40,
          0.60,
          curve: Curves.easeOut,
        ),
      ),
    );
    _subtitleFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.65, 0.85,curve: Curves.easeIn),
    );
    _subtitleSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.65,
          0.85,
          curve: Curves.easeOut,
        ),
      ),
    );
    _controller.forward();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffFFFFFF),
              Color(0xffc1f8c7),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Spacer(),
              FadeTransition(
                opacity: _logoFade,
                child: ScaleTransition(
                  scale: _logoScale,
                  child: SvgPicture.asset(
                    AppImages.logo,
                    width: 120.r,
                    height: 120.r,
                  ),
                ),
              ),
              SizedBox(height: 24.h,),
              FadeTransition(
                opacity: _nameFade,
                child: SlideTransition(
                  position: _nameSlide,
                  child: Text(
                    'Greeno',
                    style: AppTextStyles.heading,
                  ),
                ),
              ),
              SizedBox(height: 8.h,),
              FadeTransition(
                opacity: _subtitleFade,
                child: SlideTransition(
                  position: _subtitleSlide,
                  child: Text(
                    'Fresh groceries delivered to your door',
                    style: AppTextStyles.hint,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Spacer(),

              SizedBox(
                height: 20.h,
                child: const LoadingDots(),
              ),
              SizedBox(height: 60.h,),
            ],
          ),
        ),
      ),
    );
  }
}
