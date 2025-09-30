import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimart/core/constant/app_colors.dart';
import 'package:minimart/core/models/product_model.dart';
import 'package:minimart/features/cart/cubit/cart_cubit.dart';
import 'package:minimart/features/home/cubit/home_cubit.dart';
import 'package:minimart/features/home/cubit/home_state.dart';
import 'package:minimart/features/home/widgets/animated_product_overlay.dart';
import 'package:minimart/features/home/widgets/app_bar.dart';
import 'package:minimart/features/home/widgets/categories_list.dart';
import 'package:minimart/features/home/widgets/product_grid.dart';
import 'package:minimart/features/home/widgets/search_bar.dart';
import 'package:minimart/service_locator.dart';

// ========== Main Screen ==========
class HomeScreen extends StatefulWidget {
  final Function(ProductModel) addToCart;
  final GlobalKey cartKey;

  const HomeScreen({super.key, required this.addToCart, required this.cartKey});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  String selectedCategory = 'All';
  List<String> categories = ['All', 'Home', 'Clothing', 'Electronics', 'Books'];

  final ScrollController _scrollController = ScrollController();
  bool showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 100 && !showBackToTop) {
      setState(() => showBackToTop = true);
    } else if (_scrollController.offset <= 100 && showBackToTop) {
      setState(() => showBackToTop = false);
    }
  }

  /// TODO
  void _addToCartWithAnimation(
    BuildContext context,
    ProductModel product,
    GlobalKey buttonKey,
  ) {
    log("add to cart with animation");
    final overlay = Overlay.of(context);
    final renderBox =
        buttonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final start = renderBox.localToGlobal(renderBox.size.center(Offset.zero));
    final cartBox =
        widget.cartKey.currentContext!.findRenderObject() as RenderBox;
    final end = cartBox.localToGlobal(cartBox.size.center(Offset.zero));

    final overlayEntry = OverlayEntry(
      builder: (context) => AnimatedProductOverlay(
        start: start,
        end: end,
        child: Icon(
          Icons.shopping_cart,
          color: AppColors.primaryLight,
          size: 40,
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(milliseconds: 600), () {
      overlayEntry.remove();
      widget.addToCart(product);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..getProducts(),
      child: Scaffold(
        floatingActionButton: showBackToTop
            ? FloatingActionButton(
                onPressed: () => _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                ),
                backgroundColor: AppColors.primaryLight,
                child: const Icon(Icons.arrow_upward),
              )
            : null,
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            HomeAppBar(
              showBackToTop: showBackToTop,
              selectedCategory: selectedCategory,
            ),
            HomeSearchBar(
              showBackToTop: showBackToTop,
              searchQuery: searchQuery,
              onChanged: (value) => setState(() => searchQuery = value),
            ),
            CategoriesList(
              categories: categories,
              selectedCategory: selectedCategory,
              showBackToTop: showBackToTop,
              onSelected: (category) =>
                  setState(() => selectedCategory = category),
            ),

            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is HomeLoaded) {
                  var list = state.products;

                  if (selectedCategory != 'All') {
                    list = list
                        .where((p) => p.category == selectedCategory)
                        .toList();
                  }
                  if (searchQuery.isNotEmpty) {
                    print(searchQuery);
                    list = list
                        .where(
                          (p) => "${p.name}".toLowerCase().contains(
                            searchQuery.toLowerCase(),
                          ),
                        )
                        .toList();
                  }

                  return BlocProvider(
                    create: (context) => sl<CartCubit>(),
                    child: BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        return ProductsGrid(
                          products: list,
                          onAddToCart: (context, product, onAddToCart) {
                            context.read<CartCubit>().addToCart(product,quantity: 1);
                            _addToCartWithAnimation(context, product, onAddToCart);
                          },
                          cartKey: widget.cartKey,
                        );
                      },
                    ),
                  );
                } else if (state is HomeError) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text(state.message)),
                  );
                } else {
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
