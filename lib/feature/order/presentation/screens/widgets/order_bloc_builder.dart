import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/order/presentation/cubits/order_cubit.dart';
import 'package:sweetella/feature/order/presentation/cubits/order_state.dart';
import 'package:sweetella/feature/order/presentation/screens/widgets/order_sliver_list.dart';

class OrderBlocBuilder extends StatelessWidget {
  const OrderBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      buildWhen: (previous, current) {
        return current is OrderLoading ||
            current is OrderFailure ||
            current is OrderLoaded;
      },
      builder: (context, state) {
        if (state is OrderLoading) {
          return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is OrderFailure) {
          return SliverFillRemaining(child: Center(child: Text(state.message)));
        }

        return const OrdersSliverList();
      },
    );
  }
}
