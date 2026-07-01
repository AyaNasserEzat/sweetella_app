import 'package:flutter/material.dart';

class IconFavorite extends StatelessWidget {
  const IconFavorite({super.key});

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
      child: IconButton(
        icon: Icon(Icons.favorite_border, color: Color(0xffe26784)),
        onPressed: () {},
      ),
    );
  }
}
