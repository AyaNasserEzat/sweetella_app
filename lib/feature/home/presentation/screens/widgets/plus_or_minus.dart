import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/quantity_cubit.dart';

class PlusOrMinus extends StatelessWidget {
  const PlusOrMinus({super.key});

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
            onPressed: () {
              context.read<QuantityCubit>().decrement();
            },
            icon: Icon(Icons.remove, color: Color(0xffe26784)),
          ),
        ),
        const SizedBox(width: 12),
        BlocBuilder<QuantityCubit, int>(
          builder: (context, quantity) {
            return Text(quantity.toString());
          },
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
            onPressed: () {
              context.read<QuantityCubit>().increment();
            },
            icon: Icon(Icons.add, color: Color(0xffe26784)),
          ),
        ),
      ],
    );
  }
}
