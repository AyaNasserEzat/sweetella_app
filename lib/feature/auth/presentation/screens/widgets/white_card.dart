import 'package:flutter/material.dart';

class WhiteCard extends StatelessWidget {
  const WhiteCard({super.key, required this.child,this.height = 350});
  final Widget child;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 200,
      left: 20,
      right: 20,
      child: Container(
        height: height,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
