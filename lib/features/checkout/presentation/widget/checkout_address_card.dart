import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/core/assets_date/iconBroken.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../auth/domain/entities/address_entity.dart';

class CheckoutAddressCard extends StatelessWidget {
  const CheckoutAddressCard({
    super.key,
    required this.address,
    required this.onChange,
  });

  final AddressEntity address;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              IconBroken.Location,
              color: AppColors.primary,
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery Address",
                    style: AppTextStyles.label.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 6.h),

                  Text(
                    "${address.city}, ${address.governorate}",
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  Text(
                    address.fullAddress,
                    style: AppTextStyles.hint,
                  ),

                  SizedBox(height: 2.h),

                  Text(
                    address.country,
                    style: AppTextStyles.hint,
                  ),
                ],
              ),
            ),

            TextButton(
              onPressed: onChange,
              child: const Text("Change"),
            ),
          ],
        ),
      ),
    );
  }
}