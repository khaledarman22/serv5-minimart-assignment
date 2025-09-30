import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;
  final Function(ProductModel) addToCart;

  const ProductDetailScreen({super.key, required this.product, required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name ?? '')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Icon(Icons.image, size: 200)),
            const SizedBox(height: 24),
            Text(
              product.name ?? '',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('\$${product.price}', style: const TextStyle(fontSize: 20, color: Colors.green)),
            const SizedBox(height: 16),
            Text('productDescription'.tr(), style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => addToCart(product),
                icon: const Icon(Icons.add_shopping_cart),
                label: Text('addToCart'.tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
