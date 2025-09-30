import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:minimart/core/models/product_model.dart';
import 'package:minimart/core/models/product_card.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial()) {
    _initializeCart();
  }

  static const String _cartBoxName = 'cart';
  late Box<ProductCard> _cartBox;

  Future<void> _initializeCart() async {
    try {
      _cartBox = await Hive.openBox<ProductCard>(_cartBoxName);
      emit(CartLoaded(_getAllCartItems()));
    } catch (e) {
      emit(CartError('Failed to initialize cart: $e'));
    }
  }

  // Add product to cart or increment quantity if exists
  Future<void> addToCart(ProductModel product, {int quantity = 1}) async {
    try {
      final String key = product.id!;
      final existingItem = _cartBox.get(key);

      if (existingItem != null) {
        // Update quantity if product already exists
        final updatedItem = existingItem.copyWith(
          quantity: existingItem.quantity,
        );
        await _cartBox.put(key, updatedItem);
      } else {
        // Add new product to cart
        final newItem = ProductCard(product, quantity);
        await _cartBox.put(key, newItem);
      }

      emit(CartLoaded(_getAllCartItems()));
    } catch (e) {
      emit(CartError('Failed to add to cart: $e'));
    }
  }

  // Remove product from cart
  Future<void> removeFromCart(String productId) async {
    try {
      await _cartBox.delete(productId);
      emit(CartLoaded(_getAllCartItems()));
    } catch (e) {
      emit(CartError('Failed to remove from cart: $e'));
    }
  }

  // Update product quantity
  Future<void> updateQuantity(String productId, int newQuantity) async {
    try {
      if (newQuantity <= 0) {
        // Remove item if quantity is 0 or negative
        await removeFromCart(productId);
        return;
      }

      final existingItem = _cartBox.get(productId);
      if (existingItem != null) {
        final updatedItem = existingItem.copyWith(quantity: newQuantity);
        await _cartBox.put(productId, updatedItem);
        emit(CartLoaded(_getAllCartItems()));
      }
    } catch (e) {
      emit(CartError('Failed to update quantity: $e'));
    }
  }

  // Increment quantity by 1
  Future<void> incrementQuantity(String productId) async {
    try {
      final existingItem = _cartBox.get(productId);
      if (existingItem != null) {
        await updateQuantity(productId, existingItem.quantity + 1);
      }
    } catch (e) {
      emit(CartError('Failed to increment quantity: $e'));
    }
  }

  // Decrement quantity by 1
  Future<void> decrementQuantity(String productId) async {
    try {
      final existingItem = _cartBox.get(productId);
      if (existingItem != null) {
        await updateQuantity(productId, existingItem.quantity - 1);
      }
    } catch (e) {
      emit(CartError('Failed to decrement quantity: $e'));
    }
  }

  // Clear entire cart
  Future<void> clearCart() async {
    try {
      await _cartBox.clear();
      emit(CartLoaded(_getAllCartItems()));
    } catch (e) {
      emit(CartError('Failed to clear cart: $e'));
    }
  }

  // Get cart item by product ID
  ProductCard? getCartItem(String productId) {
    return _cartBox.get(productId);
  }

  // Check if product is in cart
  bool isInCart(String productId) {
    return _cartBox.containsKey(productId);
  }

  // Get total number of items in cart
  int get totalItems {
    return _getAllCartItems().fold(0, (sum, item) => sum + item.quantity);
  }

  // Get total price of all items in cart
  double get totalPrice {
    return _getAllCartItems().fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  // Get all cart items
  List<ProductCard> _getAllCartItems() {
    return _cartBox.values.toList();
  }

  // Listen to cart changes
  void listenToCartChanges() {
    _cartBox.watch().listen((event) {
      emit(CartLoaded(_getAllCartItems()));
    });
  }

  @override
  Future<void> close() {
    _cartBox.close();
    return super.close();
  }
}
