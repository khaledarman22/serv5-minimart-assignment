import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:minimart/core/constant/app_colors.dart';
import 'package:minimart/core/constant/app_text_style.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "emptyCart".tr(),
        style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondaryLight),
      ),
    );
  }
}
