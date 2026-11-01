import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String name;
  final String categoryId;
  final String categoryName;
  final String description;
  final int salePrice;
  final String imageUrl;
  final bool hasVariants;
  final bool hasAddons;
  final List<ProductVariantModel> variants;
  final List<ProductAddonModel> addons;
  final double? price;
  final int? stock;
  ProductModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.categoryName,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.salePrice = 0,
    required this.hasVariants,
    required this.hasAddons,
    required this.variants,
    required this.addons,
    this.stock,
  });
  factory ProductModel.empty() => ProductModel(
    id: '',
    name: 'loading...',
    categoryId: '',
    description: '',
    price: 100,
    imageUrl: '',
    salePrice: 0,
    categoryName: '',
    hasVariants: false,
    hasAddons: false,
    variants: [],
    addons: [],
  );

  ///map json oriented document snapshot from firebase to user model
  factory ProductModel.fromJson(Map<String, dynamic> json, String docId) {
    return ProductModel(
      id: docId,
      name: json['name'] ?? '',
      categoryId: json['categoryId'] ?? '',
      categoryName: json['categoryName'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',

      hasVariants: json['hasVariants'] ?? false,
      hasAddons: json['hasAddons'] ?? false,
      variants:
          (json['variants'] as List<dynamic>?)
              ?.map((v) => ProductVariantModel.fromJson(v))
              .toList() ??
          [],
      addons:
          (json['addons'] as List<dynamic>?)
              ?.map((a) => ProductAddonModel.fromJson(a))
              .toList() ??
          [],
      price: (json['price'] as num?)?.toDouble(),
      stock: (json['stock'] as num?)?.toInt(),
    );
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

// class ProductVariant {
//   final String title;
//   final List<AttributeOption> options;

//   ProductVariant({required this.title, required this.options});

//   factory ProductVariant.fromJson(Map<String, dynamic> json) {
//     return ProductVariant(
//       title: json['title'] ?? '',
//       options:
//           (json['options'] as List<dynamic>?)
//               ?.map((e) => AttributeOption.fromJson(e as Map<String, dynamic>))
//               .toList() ??
//           [],
//     );
//   }
// }

// class AttributeOption {
//   final String value;
//   final double priceModifier;
//   final int stock;

//   AttributeOption({
//     required this.value,
//     required this.priceModifier,
//     required this.stock,
//   });

//   factory AttributeOption.fromJson(Map<String, dynamic> json) {
//     return AttributeOption(
//       value: json['value'] ?? '',
//       priceModifier: (json['price_modifier'] as num?)?.toDouble() ?? 0.0,
//       stock: json['stock'] ?? 0,
//     );
//   }
// }

class ProductVariantModel {
  final String id;
  final String sizeName;
  final double price;
  final int stock;
  ProductVariantModel({
    required this.id,
    required this.sizeName,
    required this.price,
    required this.stock,
  });

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) {
    return ProductVariantModel(
      id: json['id'] ?? '',
      sizeName: json['sizeName'] ?? '',
      price: (json['price'] as num).toDouble(),
      stock: json['dailyStock'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sizeName': sizeName,
      'price': price,
      'dailyStock': stock,
    };
  }
}

class ProductAddonModel {
  final String id;
  final String name;
  final double price;
  final int stock;
  ProductAddonModel({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
  });

  factory ProductAddonModel.fromJson(Map<String, dynamic> json) {
    return ProductAddonModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] as num).toDouble(),
      stock: json['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'price': price};
  }
}
// // lib/features/products/domain/entities/product_addon.dart
// class ProductAddon {
//   final String id;
//   final String name; // مثل: صوص شوكولاتة إضافي
//   final double price;

//   ProductAddon({required this.id, required this.name, required this.price});

//   Map<String, dynamic> toJson() => {'id': id, 'name': name, 'price': price};

//   factory ProductAddon.fromJson(Map<String, dynamic> json) => ProductAddon(
//     id: json['id'] ?? '',
//     name: json['name'] ?? '',
//     price: (json['price'] as num).toDouble(),
//   );
// }

// // lib/features/products/domain/entities/product_entity.dart
// class ProductModel {
//   final String id;
//   final String name;
//   final String category;
//   final String description;
//   final String imageUrl;
//   final bool isAvailable;
//   final bool hasVariants;
//   final bool hasAddons;
//   final List<ProductVariant> variants;
//   final List<ProductAddon> addons;

//   ProductModel({
//     required this.id,
//     required this.name,
//     required this.category,
//     required this.description,
//     required this.imageUrl,
//     required this.isAvailable,
//     required this.hasVariants,
//     required this.hasAddons,
//     required this.variants,
//     required this.addons,
//   });

//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'name': name,
//     'category': category,
//     'description': description,
//     'imageUrl': imageUrl,
//     'isAvailable': isAvailable,
//     'hasVariants': hasVariants,
//     'hasAddons': hasAddons,
//     'variants': variants.map((v) => v.toJson()).toList(),
//     'addons': addons.map((a) => a.toJson()).toList(),
//   };

//   factory ProductModel.fromJson(Map<String, dynamic> json, String docId) =>
//       ProductEntity(
//         id: docId,
//         name: json['name'] ?? '',
//         category: json['category'] ?? '',
//         description: json['description'] ?? '',
//         imageUrl: json['imageUrl'] ?? '',
//         isAvailable: json['isAvailable'] ?? true,
//         hasVariants: json['hasVariants'] ?? false,
//         hasAddons: json['hasAddons'] ?? false,
//         variants:
//             (json['variants'] as List<dynamic>?)
//                 ?.map((v) => ProductVariant.fromJson(v))
//                 .toList() ??
//             [],
//         addons:
//             (json['addons'] as List<dynamic>?)
//                 ?.map((a) => ProductAddon.fromJson(a))
//                 .toList() ??
//             [],
//       );
// }
