import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String name;
  final String? size;
  final double price;
  final double? salePrice;
  final String image;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    this.salePrice ,
    this.size = 'Small',
  });
}
class CartItemModel {
   String? id; // doc id
  final String productId;
  final String productName;
  final String size;
  final int price;
  final int quantity;
  final String imageUrl;

  CartItemModel({
     this.id,
    required this.productId,
    required this.productName,
    required this.size,
    required this.price,
    this.quantity = 1,
    required this.imageUrl,
  });

  factory CartItemModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return CartItemModel(
      id: doc.id,
      productId: data['productId'],
      productName: data['productName'],
      size: data['size'],
      price: data['price'],
      quantity: data['quantity'] ?? 1,
      imageUrl: data['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'size': size,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'addedAt': FieldValue.serverTimestamp(),
    };
  }
}
