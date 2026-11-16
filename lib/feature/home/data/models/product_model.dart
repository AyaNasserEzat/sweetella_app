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
    required this.price,
    this.salePrice,
    this.stock,
    required this.hasVariants,
    required this.hasAddons,
    this.variants = const [],
    this.addons = const [],
  });

  factory ProductModel.empty() {
    return const ProductModel(
      id: '',
      name: 'loading...',
      categoryId: '',
      categoryName: '',
      description: '',
      imageUrl: '',
      price: 100,
      hasVariants: false,
      hasAddons: false,
      stock: 0,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json, String docId) {
    return ProductModel(
      id: docId,
      name: json['name'] as String? ?? '',
      categoryId: json['categoryId'] as String? ?? '',
      categoryName: json['categoryName'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble(),
      salePrice: (json['salePrice'] as num?)?.toDouble(),
      stock: (json['stock'] as num?)?.toInt(),
      hasVariants: json['hasVariants'] as bool? ?? false,
      hasAddons: json['hasAddons'] as bool? ?? false,
      variants: _parseList(json['variants'], ProductVariantModel.fromJson),
      addons: _parseList(json['addons'], ProductAddonModel.fromJson),
    );
  }

  static List<T> _parseList<T>(
    dynamic value,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (value is! List) return [];

    return value
        .whereType<Map>()
        .map((item) => fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
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
      'variants': variants.map((v) => v.toJson()).toList(),
      'addons': addons.map((a) => a.toJson()).toList(),
    };
  }

  // Effective price for simple products.
  double get effectivePrice {
    if (_isValidSalePrice(salePrice, price)) {
      return salePrice!;
    }

    return price ?? 0;
  }

  bool get hasDiscount => _isValidSalePrice(salePrice, price);

  // Returns the lowest and highest effective variant prices.
  double get minPrice {
    if (hasVariants && variants.isNotEmpty) {
      return variants
          .map((v) => v.effectivePrice)
          .reduce((a, b) => a < b ? a : b);
    }

    return effectivePrice;
  }

  double get maxPrice {
    if (hasVariants && variants.isNotEmpty) {
      return variants
          .map((v) => v.effectivePrice)
          .reduce((a, b) => a > b ? a : b);
    }

    return effectivePrice;
  }

  bool get hasAnyDiscount {
    if (hasVariants && variants.isNotEmpty) {
      return variants.any((v) => v.hasDiscount);
    }

    return hasDiscount;
  }

  String get formattedPrice {
    if (hasVariants && variants.isNotEmpty) {
      if (minPrice == maxPrice) {
        return '${_formatNumber(minPrice)} ج.م';
      }

      return '${_formatNumber(minPrice)} - '
          '${_formatNumber(maxPrice)} ج.م';
    }

    return '${_formatNumber(effectivePrice)} ج.م';
  }

  static bool _isValidSalePrice(double? salePrice, double? originalPrice) {
    return salePrice != null &&
        originalPrice != null &&
        salePrice > 0 &&
        salePrice < originalPrice;
  }

  static String _formatNumber(double value) {
    return value == value.truncateToDouble()
        ? value.toInt().toString()
        : value.toStringAsFixed(2);
  }
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
      id: json['id'] as String? ?? '',
      sizeName: json['sizeName'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      salePrice: (json['salePrice'] as num?)?.toDouble(),
      stock:
          (json['stock'] as num?)?.toInt() ??
          (json['dailyStock'] as num?)?.toInt() ??
          0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sizeName': sizeName,
      'price': price,
      'salePrice': salePrice,
      'stock': stock,
    };
  }

  double get effectivePrice {
    if (salePrice != null && salePrice! > 0 && salePrice! < price) {
      return salePrice!;
    }

    return price;
  }

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
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      stock: (json['stock'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'price': price, 'stock': stock};
  }
}
