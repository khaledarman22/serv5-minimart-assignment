import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:minimart/core/constant/app_colors.dart';
import 'package:minimart/core/constant/app_text_style.dart';

class EmptyCheckout extends StatelessWidget {
  const EmptyCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No items to checkout'.tr(),
        style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondaryLight),
      ),
    );
  }
}
