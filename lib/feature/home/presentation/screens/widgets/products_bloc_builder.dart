import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/widgets/empty_gridview.dart';
import 'package:sweetella/feature/cart/presentation/cubits/cart_cubit.dart';
import 'package:sweetella/feature/favorites/presentation/cubits/favories_state.dart';
import 'package:sweetella/feature/favorites/presentation/cubits/favorites_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_state.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/products_grid_view.dart';

class ProductsBlocBuilder extends StatelessWidget {
  const ProductsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red, // لون أحمر للتنبيه بالخطأ
                ),
              );
            }
          },
        ),
        BlocListener<FavoritesCubit, FavoriesState>(
          listenWhen: (previous, current) => current is FavoriesError,
          listener: (context, state) {
            if (state is FavoriesError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red, // لون أحمر للتنبيه بالخطأ
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<ProductCubit, ProductState>(
        buildWhen: (previous, current) =>
            current is ProductLoading ||
            current is ProductSuccess ||
            current is ProductError,
        builder: (context, state) {
          print(state);
          if (state is ProductLoading) {
            return EmptyGridView();
          } else if (state is ProductSuccess) {
            return ProductsGridView(products: state.products);
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          return SizedBox();
        },
      ),
    );
  }
}
