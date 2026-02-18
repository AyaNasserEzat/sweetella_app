import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/helper/extension.dart';
import 'package:sweetella/core/widgets/empty_gridview.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/app_bar.dart';
import 'package:sweetella/feature/favorites/presentation/cubits/favorites_cubit.dart';
import 'package:sweetella/feature/favorites/presentation/cubits/favories_state.dart';
import 'package:sweetella/feature/favorites/presentation/screens/widgets/grid_view_favorties.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_cubit.dart';

class FavoriteScreenBody extends StatefulWidget {
  const FavoriteScreenBody({super.key});

  @override
  State<FavoriteScreenBody> createState() => _FavoriteScreenBodyState();
}

class _FavoriteScreenBodyState extends State<FavoriteScreenBody> {
  @override
  void initState() {
    context.read<ProductCubit>().getAllProducts();
    context.read<FavoritesCubit>().getFavoritesIds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: context.w * 0.05,
          top: 35,
          right: context.w * 0.05,
          bottom: context.h * 0.15,
        ),
        child: Column(
          spacing: 10,
          children: [
            AppBarTitle(title: "Favorites"),
            BlocBuilder<FavoritesCubit, FavoriesState>(
              buildWhen: (previous, current) =>
                  current is FavoriesLoading ||
                  current is FavoriesLoaded ||
                  current is FavoriesError,

              builder: (context, favState) {
                if (favState is FavoriesLoading) {
                  return EmptyGridView();
                }

                if (favState is FavoriesError) {
                  return Center(child: Text(favState.message));
                }

                if (favState is FavoriesLoaded) {
                  final allProducts = context.read<ProductCubit>().allproducts;
                  final favoriteProducts = context
                      .read<FavoritesCubit>()
                      .getFavorites(allProducts);

                  if (favoriteProducts.isEmpty) {
                    return const Center(
                      child: Text(
                        'No favorites yet ',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  } else {
                    return GridViewFavorties(products: favoriteProducts);
                  }
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
