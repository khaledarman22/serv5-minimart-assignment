import 'package:flutter/material.dart';
import 'package:minimart/core/constant/app_sizes.dart';
import 'package:minimart/core/models/product_model.dart';
import 'package:minimart/core/widgets/product_card.dart';
import 'package:minimart/features/prodact/screens/product_details_screen.dart'
    show ProductDetailScreen;

class ProductsGrid extends StatelessWidget {
  final List<ProductModel> products;
  final Function(BuildContext, ProductModel, GlobalKey) onAddToCart;
  final GlobalKey cartKey;

  const ProductsGrid({
    super.key,
    required this.products,
    required this.onAddToCart,
    required this.cartKey,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(AppSizes.s12),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.65,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final product = products[index];
          final buttonKey = GlobalKey();
          return ProductCard(
            product: product,
            buttonKey: buttonKey,
            onAdd: () => onAddToCart(context, product, buttonKey),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailScreen(
                  product: product,
                  addToCart: (p) => onAddToCart(context, p, buttonKey),
                ),
              ),
            ),
          );
        }, childCount: products.length),
      ),
    );
  }
}
