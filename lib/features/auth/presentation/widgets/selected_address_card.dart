import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/features/auth/domain/entities/address_entity.dart';

import '../../../../core/assets_date/iconBroken.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SelectedAddressCard extends StatelessWidget {
  const SelectedAddressCard({
    super.key,
    this.address,
  });
  final AddressEntity? address;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: address == null
              ? AppColors.border
              : AppColors.primary,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Selected Address",
            style: AppTextStyles.label,
          ),

          const SizedBox(height: 12),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

               Icon(
                IconBroken.Location,
                color: address == null
                    ? AppColors.textSecondary
                    : AppColors.primary,
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  children: [
                    Text(
                      address?.fullAddress ?? "No address selected yet",
                      style: AppTextStyles.body.copyWith(
                        color: address == null
                            ? AppColors.textSecondary
                            : AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.h,),
                    Text(
                      address == null
                          ? "Choose your location first"
                          :"${address!.city}, ${address!.governorate}, ${address!.country}",
                      style: AppTextStyles.body.copyWith(
                        color: address == null
                            ? AppColors.textSecondary
                            : AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
