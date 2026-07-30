import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:greeno_app/core/theme/app_text_styles.dart';

import '../../../../core/theme/app_colors.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    super.key,
    required this.text
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
            child: Divider(
              color: AppColors.border,
              thickness: 1,
            ),
        ),
        Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 12.w),
            child: Text(
              text,
              style: AppTextStyles.hint,
            ),
        ),
        const Expanded(
          child: Divider(
            color: AppColors.border,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
