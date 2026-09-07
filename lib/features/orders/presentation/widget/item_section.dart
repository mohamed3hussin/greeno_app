import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/core/theme/app_text_styles.dart';
import 'package:greeno_app/features/checkout/domain/entities/order_entity.dart';
import 'package:greeno_app/features/orders/presentation/widget/items_widget.dart';

class ItemSection extends StatelessWidget {
  const ItemSection({
    super.key,
    required this.order,
  });
  final OrderEntity order;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Items',
              style: AppTextStyles.title.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(width: 16.w,),
            Text('(${order.items.length})',
              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Card(
          elevation: 1,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
            child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  final item = order.items[index];
                  return ItemsWidget(item: item);
                },
                separatorBuilder: (context,index)=> Divider(height: 24.h),
                itemCount: order.items.length,
            ),
          ),
        ),
      ],
    );
  }
}
