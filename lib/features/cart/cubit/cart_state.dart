part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<ProductCard> cartItems;
  final int totalItems;
  final double totalPrice;

   CartLoaded(this.cartItems)
      : totalItems = cartItems.fold(0, (sum, item) => sum + item.quantity),
        totalPrice = cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  @override
  List<Object> get props => [cartItems, totalItems, totalPrice];
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object> get props => [message];
}