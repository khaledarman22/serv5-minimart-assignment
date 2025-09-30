import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/core/constant/app_colors.dart';
import 'package:minimart/core/constant/app_sizes.dart';
import 'package:minimart/core/constant/app_text_style.dart';
import 'package:minimart/core/models/cart_model.dart';
import 'package:minimart/features/cart/cubit/cart_cubit.dart';

class CartItemCard extends StatelessWidget {
  CartItem item;

  CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          final p = state.cartItems.firstWhere(
            (i) => i.product.id == item.product.id,
          );
          item = CartItem(product: p.product, quantity: p.quantity);
        }
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.r12),
          ),
          child: ListTile(
            leading: Icon(Icons.shopping_cart, size: 60, color: AppColors.grey),
            title: Text(
              item.product.name ?? '',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '\$${item.product.price} x ${item.quantity}',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondaryLight,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: AppColors.errorLight,
                  ),
                  onPressed: () {
                    context.read<CartCubit>().updateQuantity(
                      "${item.product.id}",
                      item.quantity - 1,
                    );
                  },
                ),
                Text(
                  '${item.quantity}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: AppColors.successLight,
                  ),
                  onPressed: () {
                    context.read<CartCubit>().updateQuantity(
                      "${item.product.id}",
                      item.quantity + 1,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
