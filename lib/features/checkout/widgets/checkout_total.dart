import 'package:flutter/material.dart';
import 'package:minimart/core/constant/app_colors.dart';
import 'package:minimart/core/constant/app_sizes.dart';
import 'package:minimart/core/constant/app_text_style.dart';

class CheckoutTotal extends StatelessWidget {
  final double totalPrice;

  const CheckoutTotal({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.s16),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(AppSizes.r12),
        color: AppColors.surfaceLight,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.s16, vertical: AppSizes.s12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: AppTextStyles.titleSmall.copyWith(
                        color: AppColors.textPrimaryLight),
                  ),
                  Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.successLight),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.s12),
              ElevatedButton(
                onPressed: () {
                  // Payment logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryLight,
                  padding: AppSizes.buttonPadding,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.r12),
                  ),
                  textStyle: AppTextStyles.button,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Pay Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
