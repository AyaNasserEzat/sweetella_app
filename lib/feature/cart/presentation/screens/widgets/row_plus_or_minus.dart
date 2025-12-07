import 'package:flutter/material.dart';

class RowPlusOrMinus extends StatefulWidget {
  const RowPlusOrMinus({super.key});

  @override
  State<RowPlusOrMinus> createState() => _RowPlusOrMinusState();
}

class _RowPlusOrMinusState extends State<RowPlusOrMinus> {
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
          width: 38,
          height: 38,
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
          child: Center(
            child: IconButton(
              onPressed: decrementQuantity,
              icon: Icon(Icons.remove, color: Color(0xffe26784)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          '$quantity',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 12),
        Container(
          width: 38,
          height: 38,
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
