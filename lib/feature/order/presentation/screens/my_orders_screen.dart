import 'package:flutter/material.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/app_bar.dart';
import 'package:sweetella/feature/order/presentation/screens/widgets/order_bloc_builder.dart';
import 'package:sweetella/feature/order/presentation/screens/widgets/order_filters.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 35, left: 12, right: 12),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                AppBarTitle(title: "My Orders"),
                const SizedBox(height: 15),
                const OrdersFilter(),
                const SizedBox(height: 12),
              ]),
            ),
          ),

          const OrderBlocBuilder(),
        ],
      ),
    );
  }
}
