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

  String get formattedPrice {
    // التأكد من أن المنتج لديه متغيرات (أحجام) وأن قائمة الـ variants ليست فارغة
    if (hasVariants && variants.isNotEmpty) {
      // استخراج كل الأسعار الخاصة بالأحجام
      List<double> prices = variants.map((v) => v.price).toList();

      // إيجاد أقل سعر وأكبر سعر
      double minPrice = prices.reduce((a, b) => a < b ? a : b);
      double maxPrice = prices.reduce((a, b) => a > b ? a : b);

      // إذا كان أصغر سعر يساوي أكبر سعر، اعرض سعراً واحداً فقط
      if (minPrice == maxPrice) {
        return '$minPrice ج.م'; // أو العملفته الخاصة بك
      }

      // لو الأحجام أسعارها مختلفة، اعرض من الصغير للكبير
      return '$minPrice - $maxPrice ج.م';
    } else {
      // لو مفيش أحجام، اعرض السعر العادي (مع مراعاة لو الـ price بيقبى null)
      return '${price ?? 0.0} ج.م';
    }
  }
}

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
