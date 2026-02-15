import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/favorites/presentation/cubits/favorites_cubit.dart';
import 'package:sweetella/feature/favorites/presentation/cubits/favories_state.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/product_item.dart';

class FavoriteScreenBody extends StatefulWidget {
  const FavoriteScreenBody({super.key});

  @override
  State<FavoriteScreenBody> createState() => _FavoriteScreenBodyState();
}

class _FavoriteScreenBodyState extends State<FavoriteScreenBody> {
  @override
  void initState() {
    context.read<FavoritesCubit>().getFavorites();
    context.read<ProductCubit>().getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites'), centerTitle: true),
      body: BlocBuilder<FavoritesCubit, FavoriesState>(
        buildWhen: (previous, current) =>
            current is FavoriesLoading ||
            current is FavoriesLoaded ||
            current is FavoriesError,

        builder: (context, favState) {
          if (favState is FavoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (favState is FavoriesError) {
            return Center(child: Text(favState.message));
          }

          if (favState is FavoriesLoaded) {
            final allProducts = context.read<ProductCubit>().allproducts;
            final favoriteIds = context.read<FavoritesCubit>().favoriteIds;

            final favoriteProducts = allProducts
                .where((product) => favoriteIds.contains(product.id))
                .toList();

            if (favoriteProducts.isEmpty) {
              return const Center(
                child: Text(
                  'No favorites yet ',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else {
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: favoriteProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: .75,
                ),
                itemBuilder: (context, index) {
                  return ProductItem(productModel: favoriteProducts[index]);
                },
              );
            }
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}
