// class Product {
//   final String id;
//   final String name;
//   final String imageUrl;
//   final double price;

//   final String caregory;
//   Product({
//     required this.id,
//     required this.name,
//     required this.imageUrl,
//     required this.price,
//     this.caregory = 'General',
//   });
// }

import 'package:hive/hive.dart';

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 0; // Unique ID for this adapter

  @override
  ProductModel read(BinaryReader reader) {
    return ProductModel(
      category: reader.read(),
      description: reader.read(),
      id: reader.read(),
      imageUrl: reader.read(),
      price: reader.read(),
      name: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer.write(obj.category);
    writer.write(obj.description);
    writer.write(obj.id);
    writer.write(obj.imageUrl);
    writer.write(obj.price);
    writer.write(obj.name);
  }
}
class ProductModel {
  String? category;
  String? description;
  String? id;
  String? imageUrl;
  String? price;
  String? name;

  ProductModel({this.category, this.description, this.id, this.imageUrl, this.price, this.name});

  ProductModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    description = json['description'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    price = json['price'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['description'] = description;
    data['id'] = id;
    data['imageUrl'] = imageUrl;
    data['price'] = price;
    data['name'] = name;
    return data;
  }
}

// Mock Data
// final List<Product> mockProducts = [
//   Product(
//     id: '1',
//     name: 'Apple iPhone 15',
//     imageUrl: 'https://via.placeholder.com/150',
//     price: 999.0,
//     caregory: 'Phones',
//   ),
//   Product(
//     id: '2',
//     name: 'Samsung Galaxy S24',
//     imageUrl: 'https://via.placeholder.com/150',
//     price: 899.0,
//     caregory: 'Phones',
//   ),
//   Product(
//     id: '3',
//     name: 'Sony Headphones',
//     imageUrl: 'https://via.placeholder.com/150',
//     price: 199.0,
//     caregory: 'Accessories',
//   ),
//   Product(
//     id: '4',
//     name: 'MacBook Pro',
//     imageUrl: 'https://via.placeholder.com/150',
//     price: 1999.0,
//     caregory: 'Laptops',
//   ),
//   Product(
//     id: '5',
//     name: 'Dell XPS 13',
//     imageUrl: 'https://via.placeholder.com/150',
//     price: 1499.0,
//     caregory: 'Laptops',
//   ),
//   Product(
//     id: '6',
//     name: 'Logitech Mouse',
//     imageUrl: 'https://via.placeholder.com/150',
//     price: 49.0,
//     caregory: 'Accessories',
//   ),

//   Product(
//     id: '7',
//     name: 'Google Pixel 8',
//     imageUrl: 'https://via.placeholder.com/150',
//     price: 799.0,
//     caregory: 'Phones',
//   ),

//   Product(
//     id: '8',
//     name: 'HP Spectre x360',
//     imageUrl: 'https://via.placeholder.com/150',
//     price: 1599.0,
//     caregory: 'Laptops',
//   ),

//   Product(
//     id: '9',
//     name: 'Apple AirPods Pro',
//     imageUrl: 'https://via.placeholder.com/150',
//     price: 249.0,
//     caregory: 'Accessories',
//   ),

//   Product(
//     id: '10',
//     name: 'OnePlus 11',
//     imageUrl: 'https://via.placeholder.com/150',
//     price: 699.0,
//     caregory: 'Phones',
//   ),

//   Product(
//     id: '11',
//     name: 'Asus ROG Zephyrus',
//     imageUrl: 'https://via.placeholder.com/150',
//     price: 1799.0,
//     caregory: 'Laptops',
//   ),

//   Product(
//     id: '12',
//     name: 'Samsung Galaxy Buds',
//     imageUrl: 'https://via.placeholder.com/150',
//     price: 149.0,
//     caregory: 'Accessories',
//   ),
// ];
