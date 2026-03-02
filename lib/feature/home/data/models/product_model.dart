import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String name;
  final String categoryId;
  final String description;
  final int price;
  final int salePrice;
  final String imageUrl;
  final List<SizeInfoModel>? sizes;

  ProductModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.salePrice = 0,
    this.sizes,
  });
  factory ProductModel.empty() => ProductModel(
    id: '',
    name: 'loading...',
    categoryId: '',
    description: '',
    price: 100,
    imageUrl: '',
    salePrice: 0,
  );

  ///map json oriented document snapshot from firebase to user model
  factory ProductModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;

      //Map JSON record to the model
      return ProductModel(
        id: document.id,
        categoryId: document['categoryId'],
        price: document['price'] ?? 0,
        name: data['name'] ?? '',
        description: data['description'] ?? '',
        imageUrl: data['imageUrl'] ?? '',
        salePrice: data['salePrice'] ?? 0,
        sizes: data['sizes'] != null
            ? (data['sizes'] as List)
                  .map(
                    (e) => SizeInfoModel.fromJson(e as Map<String, dynamic>),
                  )
                  .toList()
            : null,
      );
    } else {
      return ProductModel.empty();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'salePrice': salePrice,
    };
  }
}

class SizeInfoModel {
  final String size;
  final int price;
  final int? salePrice;
  final int stock;
  SizeInfoModel({
    required this.size,
    required this.price,
    this.salePrice,
    required this.stock,
  });
  factory SizeInfoModel.fromJson(Map<String, dynamic> json) {
    return SizeInfoModel(
      size: json['size'],
      price: json['price'] ?? 0,
      stock: json['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': size, 'price': price, 'stock': stock};
  }
}
