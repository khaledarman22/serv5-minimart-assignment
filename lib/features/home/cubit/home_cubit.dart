import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minimart/core/models/product_model.dart';
import 'package:minimart/features/home/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void getProducts() {
    FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((querySnapshot) async {
          querySnapshot.docs.map((doc) => doc.data()).toList();
          final products = querySnapshot.docs.map((doc) => doc.data()).toList();
          List<ProductModel> productsList = products
              .map((e) => ProductModel.fromJson(e))
              .toList();
          emit(HomeLoaded(productsList));
        })
        .catchError((error) {
          emit(HomeError(error));
        });
  }

  Future<void> addRandomProduct() async {
    try {
      final randomId = DateTime.now().millisecondsSinceEpoch.toString();
      final product = {
        'id': randomId,
        'name': 'Product #$randomId',
        'price': (10 + (100 * (randomId.hashCode % 100) / 100)).toStringAsFixed(
          2,
        ),
        'createdAt': FieldValue.serverTimestamp(),
        'description': 'This is a randomly added product.',
        'category': [
          'Electronics',
          'Clothing',
          'Books',
          'Home',
        ][randomId.hashCode % 4],
        'imageUrl': 'https://via.placeholder.com/150',
      };

      await FirebaseFirestore.instance.collection('products').add(product);
      print('Random product added: $product');
      // Optionally emit a state here
    } catch (e) {
      print('Error adding product: $e');
      // Optionally emit an error state here
    }
  }

  Future<void> createRundomProduct(int countProducts) async {
    int countProducts = 20;
    for (var i = 0; i < countProducts; i++) {
      await addRandomProduct();
    }
  }
}
