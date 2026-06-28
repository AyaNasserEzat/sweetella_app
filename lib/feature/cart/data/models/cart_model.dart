import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String name;

  final double price;
  final double? salePrice;
  final String image;
  int quantity;
  final Map<String, String> selectedAttributes;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    this.salePrice,
    required this.selectedAttributes,
  });
}

class CartItemModel {
  String? id; // doc id
  final String productId;
  final String productName;
  final int price;
  final double? salePrice;
  final int quantity;
  final String imageUrl;
  final Map<String, String> selectedAttributes;

  CartItemModel({
    this.id,
    required this.productId,
    required this.productName,
    required this.price,
    this.salePrice,
    this.quantity = 1,
    required this.imageUrl,
    required this.selectedAttributes,
  });

  factory CartItemModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;
    return CartItemModel(
      id: doc.id,
      productId: data['productId'],
      productName: data['productName'],
      price: data['price'],
      salePrice: data['salePrice'],
      quantity: data['quantity'] ?? 1,
      imageUrl: data['imageUrl'],
      selectedAttributes: Map<String, String>.from(
        data['selectedAttributes'] ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'salePrice': salePrice,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'addedAt': FieldValue.serverTimestamp(),
      'selectedAttributes': selectedAttributes,
    };
  }

  CartItemModel copyWith({
    String? id,
    String? productId,
    String? productName,
    Map<String, String>? selectedAttributes,
    int? price,
    int? quantity,
    String? imageUrl,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      selectedAttributes: selectedAttributes ?? this.selectedAttributes,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  String generateCartItemId(CartItemModel item) {
    if (item.selectedAttributes.isEmpty) return item.productId;

    // Sort keys so {'size': 'L', 'flavor': 'Vanilla'} always yields the same string as {'flavor': 'Vanilla', 'size': 'L'}
    final sortedKeys = item.selectedAttributes.keys.toList()..sort();
    final attributesString = sortedKeys
        .map((key) => '$key:${item.selectedAttributes[key]}')
        .join('_');

    return '${item.productId}_$attributesString';
  }
}
