import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/features/cart/cart_screen.dart';
import 'package:minimart/features/cart/cubit/cart_cubit.dart';
import 'package:minimart/features/home/home_screen.dart';

import '../../core/models/cart_model.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final GlobalKey _cartKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        List<CartItem> cartItems = [];
        if (state is CartLoaded) {
          cartItems = state.cartItems.map((item) => CartItem(product: item.product)).toList();
        }

        return Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: [
              HomeScreen(
                addToCart: (p) {
                  context.read<CartCubit>().addToCart(p);
                },
                cartKey: _cartKey,
              ),
              CartScreen(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'.tr()),
              BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    Icon(Icons.shopping_cart, key: _cartKey),
                    if (cartItems.isNotEmpty)
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${cartItems.length}',
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                  ],
                ),
                label: 'cart'.tr(),
              ),
            ],
          ),
        );
      },
    );
  }
}
