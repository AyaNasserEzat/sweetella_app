import 'package:flutter/material.dart';

class PlusOrMinus extends StatefulWidget {
  const PlusOrMinus({super.key});

  @override
  State<PlusOrMinus> createState() => _PlusOrMinusState();
}

class _PlusOrMinusState extends State<PlusOrMinus> {
  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            onPressed: decrementQuantity,
            icon: Icon(Icons.remove, color: Color(0xffe26784)),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          '$quantity',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 12),
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            onPressed: incrementQuantity,
            icon: Icon(Icons.add, color: Color(0xffe26784)),
          ),
        ),
      ],
    );
  }
}
