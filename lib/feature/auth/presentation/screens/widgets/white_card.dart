import 'package:flutter/material.dart';

class WhiteCard extends StatelessWidget {
  const WhiteCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      top: keyboardHeight > 0 ? screenHeight * 0.12 : screenHeight * 0.29,
      left: screenWidth * 0.05,
      right: screenWidth * 0.05,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: keyboardHeight > 0
              ? screenHeight * 0.75
              : screenHeight * 0.6,
        ),
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
        child: SingleChildScrollView(child: child),
      ),
    );
  }
}
