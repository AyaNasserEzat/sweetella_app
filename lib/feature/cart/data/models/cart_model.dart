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
