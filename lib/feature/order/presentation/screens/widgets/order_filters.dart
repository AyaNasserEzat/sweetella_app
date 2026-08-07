import 'package:flutter/material.dart';
import 'package:sweetella/feature/order/data/models/order_model.dart';
import 'package:sweetella/feature/order/presentation/screens/widgets/order_filter_item.dart';

class OrdersFilter extends StatelessWidget {
  const OrdersFilter({super.key});

  static final filters = <OrderStatus?>[null, ...OrderStatus.values];

  @override
  Widget build(BuildContext context) {
    debugPrint("OrdersFilter Rebuild");

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return OrderFilterItem(status: filters[index]);
        },
      ),
    );
  }
}
