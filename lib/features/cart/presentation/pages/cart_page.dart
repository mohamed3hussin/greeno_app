import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/core/constants/app_images.dart';
import 'package:greeno_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:greeno_app/features/cart/presentation/widget/cart_item_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: BlocBuilder<CartCubit,CartState>(
          builder: (context,state){
            if(state.items.isEmpty){
              return Center(
                child: Image.asset(AppImages.cart),
              );
            }
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
              child: ListView.separated(
                  itemBuilder: (context,index){
                    final item = state.items[index];
                    return CartItemWidget(item: item);
                  },
                  separatorBuilder: (context,index) => SizedBox(height: 8.h,),
                  itemCount: state.items.length,
              ),
            );
          }
      ),
    );
  }
}
