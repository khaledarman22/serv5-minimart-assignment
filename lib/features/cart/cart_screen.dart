import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/core/constant/app_sizes.dart';
import 'package:minimart/core/models/cart_model.dart';
import 'package:minimart/features/cart/cubit/cart_cubit.dart';
import 'package:minimart/features/cart/widgets/cart_app_bar.dart';
import 'package:minimart/features/cart/widgets/cart_item_card.dart';
import 'package:minimart/features/cart/widgets/cart_total_checkout.dart';
import 'package:minimart/features/cart/widgets/empty_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<CartItem> cartItems = [];

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          cartItems = state.cartItems.map((item) => CartItem(product: item.product)).toList();
        }
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              const CartAppBar(),

              // Empty Cart
              if (cartItems.isEmpty)
                const SliverFillRemaining(child: EmptyCart())
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final item = cartItems[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.s12,
                        vertical: AppSizes.s4,
                      ),
                      child: CartItemCard(item: item),
                    );
                  }, childCount: cartItems.length),
                ),

              // Total & Checkout
              if (cartItems.isNotEmpty)
                SliverToBoxAdapter(
                  child: CartTotalCheckout(
                    totalPrice: context.read<CartCubit>().totalPrice,
                    cartItems: cartItems, // مرر العناصر
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
