class ProductModel {
  final String id;
  final String name;
  final String categoryId;
  final String categoryName;
  final String description;
  final String imageUrl;
  final double? price;
  final double? salePrice;
  final int? stock;
  final bool hasVariants;
  final bool hasAddons;
  final List<ProductVariantModel> variants;
  final List<ProductAddonModel> addons;

  const ProductModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.categoryName,
    required this.description,
    required this.imageUrl,
    this.price,
    this.salePrice,
    this.stock,
    this.hasVariants = false,
    this.hasAddons = false,
    this.variants = const [],
    this.addons = const [],
  });

  factory ProductModel.empty() => const ProductModel(
    id: '',
    name: 'loading...',
    categoryId: '',
    categoryName: '',
    description: '',
    imageUrl: '',
    price: 100,
    stock: 0,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json, String docId) {
    return ProductModel(
      id: docId,
      name: json['name'] ?? '',
      categoryId: json['categoryId'] ?? '',
      categoryName: json['categoryName'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      price: (json['price'] as num?)?.toDouble(),
      salePrice: (json['salePrice'] as num?)?.toDouble(),
      stock: (json['stock'] as num?)?.toInt(),
      hasVariants: json['hasVariants'] ?? false,
      hasAddons: json['hasAddons'] ?? false,
      variants:
          (json['variants'] as List<dynamic>?)
              ?.map(
                (e) =>
                    ProductVariantModel.fromJson(Map<String, dynamic>.from(e)),
              )
              .toList() ??
          [],
      addons:
          (json['addons'] as List<dynamic>?)
              ?.map(
                (e) => ProductAddonModel.fromJson(Map<String, dynamic>.from(e)),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'categoryId': categoryId,
    'categoryName': categoryName,
    'description': description,
    'imageUrl': imageUrl,
    'price': price,
    'salePrice': salePrice,
    'stock': stock,
    'hasVariants': hasVariants,
    'hasAddons': hasAddons,
    'variants': variants.map((e) => e.toJson()).toList(),
    'addons': addons.map((e) => e.toJson()).toList(),
  };

  double get effectivePrice =>
      salePrice != null &&
          salePrice! > 0 &&
          price != null &&
          salePrice! < price!
      ? salePrice!
      : price ?? 0;

  bool get hasDiscount =>
      salePrice != null &&
      salePrice! > 0 &&
      price != null &&
      salePrice! < price!;

  List<double> get effectivePrices {
    if (hasVariants && variants.isNotEmpty) {
      return variants.map((e) => e.effectivePrice).toList();
    }

    return [effectivePrice];
  }

  double get minPrice => effectivePrices.reduce((a, b) => a < b ? a : b);

  double get maxPrice => effectivePrices.reduce((a, b) => a > b ? a : b);

  bool get hasAnyDiscount => hasVariants && variants.isNotEmpty
      ? variants.any((e) => e.hasDiscount)
      : hasDiscount;

  String get formattedPrice {
    if (minPrice == maxPrice) {
      return '${_formatPrice(minPrice)} ج.م';
    }

    return '${_formatPrice(minPrice)} - '
        '${_formatPrice(maxPrice)} ج.م';
  }

  static String _formatPrice(double price) => price == price.truncateToDouble()
      ? price.toInt().toString()
      : price.toStringAsFixed(2);
}

class ProductVariantModel {
  final String id;
  final String sizeName;
  final double price;
  final double? salePrice;
  final int stock;

  const ProductVariantModel({
    required this.id,
    required this.sizeName,
    required this.price,
    this.salePrice,
    required this.stock,
  });

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) {
    return ProductVariantModel(
      id: json['id'] ?? '',
      sizeName: json['sizeName'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      salePrice: (json['salePrice'] as num?)?.toDouble(),
      stock:
          (json['stock'] as num?)?.toInt() ??
          (json['dailyStock'] as num?)?.toInt() ??
          0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'sizeName': sizeName,
    'price': price,
    'salePrice': salePrice,
    'stock': stock,
  };

  double get effectivePrice =>
      salePrice != null && salePrice! > 0 && salePrice! < price
      ? salePrice!
      : price;

  bool get hasDiscount =>
      salePrice != null && salePrice! > 0 && salePrice! < price;
}

class ProductAddonModel {
  final String id;
  final String name;
  final double price;
  final int stock;

  const ProductAddonModel({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
  });

  factory ProductAddonModel.fromJson(Map<String, dynamic> json) {
    return ProductAddonModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      stock: (json['stock'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'stock': stock,
  };
}
