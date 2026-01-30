import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_state.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/products_grid_view.dart';
import 'package:skeletonizer/skeletonizer.dart';
class ProductsBlocBuilder extends StatelessWidget {
  const ProductsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // final backgroundColors = [
    //   Color(0xfff8e6e1),
    //   Color(0xfffef6c9),
    // Color(0xfffef6c9),
    //   Color(0xffcbedf0),
    BlocBuilder<ProductCubit, ProductState>(
      buildWhen: (previous, current) => current is ProductLoading || current is ProductSuccess || current is ProductError,
      builder: (context, state) {
        if ( state is ProductLoading) {
          return  Skeletonizer(
            enabled:true,
            child: ProductsGridView(products: List.generate(10, (index) => ProductModel.empty()),));
        } else if (state is ProductSuccess) {
          return ProductsGridView(products: state.products,);
        } else if (state is ProductError) {
          return Center(child: Text(state.message));
        }
        return SizedBox();
      },
    );
  }
}
