import 'package:flutter/material.dart';
import 'package:sweetella/feature/favorites/presentation/screens/widgets/favorite_button.dart';

class IconFavorite extends StatelessWidget {
  const IconFavorite({super.key, required this.productId});
  final String productId;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: FavoriteButton(productId: productId),
    );
  }
}
