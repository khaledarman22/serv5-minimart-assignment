import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:minimart/core/constant/app_colors.dart';
import 'package:minimart/core/constant/app_sizes.dart';
import 'package:minimart/core/constant/app_text_style.dart';
import 'package:minimart/core/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final GlobalKey buttonKey;
  final VoidCallback onAdd;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.buttonKey,
    required this.onAdd,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.r16)),
        elevation: 5,
        shadowColor: AppColors.grey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.s8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.r12),
                  child: Icon(Icons.image, size: 80, color: AppColors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.s8, vertical: 4),
              child: Column(
                children: [
                  Text(
                    product.name ?? '',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price!}',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.successLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  ElevatedButton.icon(
                    key: buttonKey,
                    onPressed: onAdd,
                    icon: const Icon(Icons.add_shopping_cart),
                    label: Text('addToCart'.tr()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.r12),
                      ),
                      padding: AppSizes.buttonPadding,
                      textStyle: AppTextStyles.button,
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
