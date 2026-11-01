import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';

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
  final ProductVariantModel? selectedVariant;
  final List<ProductAddonModel>? selectedAddons;

  CartItemModel({
    this.id,
    required this.productId,
    required this.productName,
    required this.price,
    this.salePrice,
    this.quantity = 1,
    required this.imageUrl,
    required this.selectedVariant,
    required this.selectedAddons,
  });

  factory CartItemModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    if (data == null) {
      throw StateError('Cart item ${doc.id} has no data.');
    }

    final variantData = data['selectedVariant'];
    final addonsData = data['selectedAddons'];
    return CartItemModel(
      id: doc.id,
      productId: data['productId'],
      productName: data['productName'],
      price: data['price'],
      salePrice: data['salePrice'],
      quantity: data['quantity'] ?? 1,
      imageUrl: data['imageUrl'],
      selectedVariant: variantData is Map
          ? ProductVariantModel.fromJson(Map<String, dynamic>.from(variantData))
          : null,
      selectedAddons:
          (addonsData as List<dynamic>?)
              ?.whereType<Map>()
              .map(
                (addon) => ProductAddonModel.fromJson(
                  Map<String, dynamic>.from(addon),
                ),
              )
              .toList() ??
          [],
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
      'selectedVariant': selectedVariant?.toJson(),
      'selectedAddons': selectedAddons?.map((addon) => addon.toJson()).toList(),
      'addedAt': FieldValue.serverTimestamp(),
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

      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      selectedVariant: selectedVariant,
      selectedAddons: selectedAddons,
    );
  }

  String generateCartItemId(CartItemModel item) {
    final variantId = item.selectedVariant?.id;
    final addonIds =
        item.selectedAddons?.map((addon) => addon.id).toList() ?? <String>[];
    addonIds.sort();
    if (variantId == null && addonIds.isEmpty) return item.productId;

    final uniqueId = variantId == null
        ? '${item.productId}_no_variant_${addonIds.join("_")}'
        : '${item.productId}_${variantId}_${addonIds.join("_")}';
    return '${item.productId}_$uniqueId';
  }
}
