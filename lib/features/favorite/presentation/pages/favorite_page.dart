import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:greeno_app/features/favorite/presentation/widget/favorite_item_widget.dart';

import '../../../../core/constants/app_images.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: BlocBuilder<FavoriteCubit,FavoriteState>(
          builder: (context,state){
            if(state.favorites.isEmpty){
              return Center(
                child: Image.asset(AppImages.cart),
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context,index){
                        final item = state.favorites[index];
                        return FavoriteItemWidget(product: item.product);
                      },
                      separatorBuilder: (context,index) => SizedBox(height: 16.h,),
                      itemCount: state.favorites.length,
                    ),
                  ),

                ],
              ),
            );
          }
      ),
    );
  }
}
