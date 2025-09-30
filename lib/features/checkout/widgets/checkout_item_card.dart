import 'package:flutter/material.dart';
import 'package:minimart/core/constant/app_colors.dart';
import 'package:minimart/core/constant/app_sizes.dart';
import 'package:minimart/core/constant/app_text_style.dart';
import 'package:minimart/core/models/cart_model.dart';

class CheckoutItemCard extends StatelessWidget {
  final CartItem item;
  const CheckoutItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.r12)),
      child: ListTile(
        leading: Icon(Icons.shopping_cart, size: 60, color: AppColors.grey),
        title: Text(
          item.product.name ?? '',
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '\$${item.product.price} x ${item.quantity}',
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondaryLight),
        ),
        trailing: Text(
          '${item.quantity}',
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
