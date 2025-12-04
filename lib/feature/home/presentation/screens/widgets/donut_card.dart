import 'package:flutter/material.dart';
import 'package:sweetella/feature/home/presentation/screens/donuts_details_screen.dart';

class DonutCard extends StatelessWidget {
  final String title;
  final String price;
  final String image;
  final Color? backgroundColor;

  const DonutCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DonutsDetailsScreen();
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.pink.shade50,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Image.asset(image, height: 80),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 5),
            Text(
              "\$$price",
              style: TextStyle(
                color: Colors.pink.shade700,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
