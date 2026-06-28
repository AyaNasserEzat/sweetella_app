import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String name;
  final String categoryId;
  final String description;
  final int price;
  final int salePrice;
  final String imageUrl;
  final List<ProductAttribute> attributes;
  ProductModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.salePrice = 0,
    required this.attributes,
  });
  factory ProductModel.empty() => ProductModel(
    id: '',
    name: 'loading...',
    categoryId: '',
    description: '',
    price: 100,
    imageUrl: '',
    salePrice: 0,
    attributes: [],
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
        attributes:
            (data['attributes'] as List<dynamic>?)
                ?.map(
                  (e) => ProductAttribute.fromJson(e as Map<String, dynamic>),
                )
                .toList() ??
            [],
      );
    } else {
      return ProductModel.empty();
    }
  }
  int calculateFinalPrice(Map<String, String> selectedAttributes) {
    int finalPrice = price;

    for (var attribute in attributes) {
      final selectedValue = selectedAttributes[attribute.title];

      if (selectedValue == null) continue;

      final option = attribute.options.firstWhere(
        (option) => option.value == selectedValue,
      );

      finalPrice += option.priceModifier.toInt();
    }

    return finalPrice;
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

class ProductAttribute {
  final String title;
  final List<AttributeOption> options;

  ProductAttribute({required this.title, required this.options});

  factory ProductAttribute.fromJson(Map<String, dynamic> json) {
    return ProductAttribute(
      title: json['title'] ?? '',
      options:
          (json['options'] as List<dynamic>?)
              ?.map((e) => AttributeOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class AttributeOption {
  final String value;
  final double priceModifier;
  final int stock;

  AttributeOption({
    required this.value,
    required this.priceModifier,
    required this.stock,
  });

  factory AttributeOption.fromJson(Map<String, dynamic> json) {
    return AttributeOption(
      value: json['value'] ?? '',
      priceModifier: (json['price_modifier'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] ?? 0,
    );
  }
}
