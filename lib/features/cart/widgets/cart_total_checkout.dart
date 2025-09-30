import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:minimart/core/constant/app_colors.dart';
import 'package:minimart/core/constant/app_sizes.dart';
import 'package:minimart/core/constant/app_text_style.dart';
import 'package:minimart/core/models/cart_model.dart';
import 'package:minimart/features/checkout/checkout_screen.dart';

class CartTotalCheckout extends StatelessWidget {
  final double totalPrice;
  final List<CartItem> cartItems;

  const CartTotalCheckout({super.key, required this.totalPrice, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.s16),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(AppSizes.r12),
        color: AppColors.surfaceLight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.s16, vertical: AppSizes.s12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: \$${totalPrice.toStringAsFixed(2)}',
                style: AppTextStyles.titleSmall.copyWith(color: AppColors.textPrimaryLight),
              ),
              // TODO DDDDDDDDDD
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    // الانتقال لصفحة Checkout وتمرير العناصر والدالة
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckoutScreen(cartItems: cartItems)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryLight,
                    padding: AppSizes.buttonPadding,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.r12),
                    ),
                    textStyle: AppTextStyles.button,
                  ),
                  child: Text('Checkout'.tr()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
