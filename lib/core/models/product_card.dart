import 'package:hive/hive.dart';
import 'product_model.dart';

// Remove the part directive and HiveType annotations for manual adapter
class ProductCard {
  final ProductModel product;
  int quantity;

  ProductCard(this.product, this.quantity);
  
  double get totalPrice {
    final price = double.tryParse(product.price ?? '0') ?? 0;
    return price * quantity;
  }
  
  ProductCard copyWith({
    ProductModel? product,
    int? quantity,
  }) {
    return ProductCard(
      product ?? this.product,
      quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductCard &&
        other.product.id == product.id &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => product.id.hashCode ^ quantity.hashCode;
}
class ProductCardAdapter extends TypeAdapter<ProductCard> {
  @override
  final int typeId = 1; // Unique typeId

  @override
  ProductCard read(BinaryReader reader) {
    // Read the product first
    final product = ProductModel(
      category: reader.read(),
      description: reader.read(),
      id: reader.read(),
      imageUrl: reader.read(),
      price: reader.read(),
      name: reader.read(),
    );
    
    // Then read the quantity
    final quantity = reader.read() as int;
    
    return ProductCard(product, quantity);
  }

  @override
  void write(BinaryWriter writer, ProductCard obj) {
    // Write all product fields
    writer.write(obj.product.category);
    writer.write(obj.product.description);
    writer.write(obj.product.id);
    writer.write(obj.product.imageUrl);
    writer.write(obj.product.price);
    writer.write(obj.product.name);
    
    // Write quantity
    writer.write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}