
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Welcome 👋",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 2),
            Text(
              "Aya, want a donut?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
    
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.pink.shade100,
          child: const Icon(Icons.person, color: Colors.white),
        ),
      ],
    );
  }
}
