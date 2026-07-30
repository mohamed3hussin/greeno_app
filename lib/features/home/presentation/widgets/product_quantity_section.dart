import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/core/assets_date/iconBroken.dart';
import 'package:greeno_app/core/theme/app_colors.dart';
import 'package:greeno_app/core/theme/app_text_styles.dart';
import 'package:greeno_app/features/home/presentation/cubit/product_quantity_cubit.dart';
import 'package:greeno_app/features/home/presentation/widgets/home_icon_button.dart';

class ProductQuantitySection extends StatelessWidget {
  const ProductQuantitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductQuantityCubit,ProductQuantityState>(
        builder: (context,state){
          return Row(
            children: [
              Text(
                'Quantity',
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              HomeIconButton(
                  icon: Icons.remove,
                  onPressed: (){
                    context.read<ProductQuantityCubit>().decrement();
                  },
                  color: Colors.red,
              ),
              SizedBox(width: 14.w,),
              Text(
                state.quantity.toString(),
                style: AppTextStyles.title,
              ),
              SizedBox(width: 14.w,),
              HomeIconButton(
                icon: Icons.add,
                onPressed: (){
                  context.read<ProductQuantityCubit>().increment();
                },
                color: AppColors.primary,
              ),
            ],
          );
        }
    );
  }
}
