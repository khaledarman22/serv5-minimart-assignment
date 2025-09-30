import 'package:flutter/material.dart';
import 'package:minimart/core/constant/app_sizes.dart';
import 'package:minimart/core/models/cart_model.dart';
import 'package:minimart/features/checkout/widgets/checkout_app_bar.dart';
import 'package:minimart/features/checkout/widgets/checkout_item_card.dart';
import 'package:minimart/features/checkout/widgets/checkout_total.dart';
import 'package:minimart/features/checkout/widgets/empty_checkout.dart';

class CheckoutScreen extends StatelessWidget {
  final List<CartItem> cartItems;

  const CheckoutScreen({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartItems.fold(
      0,
      (sum, item) => sum + double.tryParse(item.product.price!)! * item.quantity,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CheckoutAppBar(),

          if (cartItems.isEmpty)
            const SliverFillRemaining(child: EmptyCheckout())
          else
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = cartItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.s12,
                    vertical: AppSizes.s4,
                  ),
                  child: CheckoutItemCard(item: item),
                );
              }, childCount: cartItems.length),
            ),

          if (cartItems.isNotEmpty)
            SliverToBoxAdapter(child: CheckoutTotal(totalPrice: totalPrice)),
        ],
      ),
    );
  }
}
