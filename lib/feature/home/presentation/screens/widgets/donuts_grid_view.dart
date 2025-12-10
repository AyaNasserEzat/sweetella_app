import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_state.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/donut_card.dart';

class DountsGridView extends StatelessWidget {
  const DountsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // final backgroundColors = [
    //   Color(0xfff8e6e1),
    //   Color(0xfffef6c9),
    // Color(0xfffef6c9),
    //   Color(0xffcbedf0),
    BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductInitial || state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductSuccess) {
          return GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 10,
              crossAxisSpacing: 14,
              childAspectRatio: .72 / 1,
            ),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              return DonutCard(
                productModel: state.products[index],
                //  backgroundColor: backgroundColors[index],
              );
            },
          );
        } else if (state is ProductError) {
          return Center(child: Text(state.message));
        }
        return Text("error");
      },
    );
  }
}

