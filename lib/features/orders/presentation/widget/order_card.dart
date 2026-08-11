import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets_date/iconBroken.dart';
import '../../../../core/constants/order_status.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../checkout/domain/entities/order_entity.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
    required this.onTap,
  });

  final OrderEntity order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 1,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Order #${order.id.substring(0, 8)}',
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  _OrderStatusBadge(
                    status: order.status,
                  ),
                ],
              ),

              SizedBox(height: 12.h),

              Row(
                children: [
                  Icon(
                    IconBroken.Bag,
                    size: 20.sp,
                    color: AppColors.primary,
                  ),

                  SizedBox(width: 6.w),

                  Text(
                    '${order.items.length} Items',
                    style: AppTextStyles.hint,
                  ),

                  const Spacer(),

                  Text(
                    '${order.total.toStringAsFixed(2)} EGP',
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.h),

              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 18.sp,
                    color: AppColors.textSecondary,
                  ),

                  SizedBox(width: 6.w),

                  Text(
                    _formatDate(order.createdAt),
                    style: AppTextStyles.hint,
                  ),

                  const Spacer(),

                  Icon(
                    IconBroken.Arrow___Right_2,
                    size: 20.sp,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
class _OrderStatusBadge extends StatelessWidget {
  const _OrderStatusBadge({
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor(status);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        _getStatusText(status),
        style: AppTextStyles.hint.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;

      case OrderStatus.confirmed:
        return Colors.blue;

      case OrderStatus.shipping:
        return Colors.purple;

      case OrderStatus.delivered:
        return Colors.green;

      case OrderStatus.cancelled:
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';

      case OrderStatus.confirmed:
        return 'Confirmed';

      case OrderStatus.shipping:
        return 'Shipping';

      case OrderStatus.delivered:
        return 'Delivered';

      case OrderStatus.cancelled:
        return 'Cancelled';

      default:
        return 'Unknown';
    }
  }
}