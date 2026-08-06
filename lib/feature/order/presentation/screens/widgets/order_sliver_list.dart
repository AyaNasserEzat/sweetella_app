import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/order/data/models/order_model.dart';
import 'package:sweetella/feature/order/presentation/cubits/order_cubit.dart';
import 'package:sweetella/feature/order/presentation/cubits/order_state.dart';
import 'package:sweetella/feature/order/presentation/screens/widgets/order_item.dart';

class OrdersSliverList extends StatelessWidget {
  const OrdersSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<OrderCubit, OrderState, List<OrderModel>>(
      selector: (state) {
        if (state is OrderLoaded) {
          return state.orders;
        }
        return const [];
      },
      builder: (context, orders) {
        if (orders.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(child: Text("No Order found")),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: OrderItem(order: orders[index]),
            );
          }, childCount: orders.length),
        );
      },
    );
  }
}
