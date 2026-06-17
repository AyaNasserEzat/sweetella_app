import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/helper/extension.dart';
import 'package:sweetella/core/widgets/empty_gridview.dart';
import 'package:sweetella/core/widgets/empty_widget.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/app_bar.dart';
import 'package:sweetella/feature/favorites/presentation/cubits/favorites_cubit.dart';
import 'package:sweetella/feature/favorites/presentation/cubits/favories_state.dart';
import 'package:sweetella/feature/favorites/presentation/screens/widgets/grid_view_favorties.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_state.dart';

class FavoriteScreenBody extends StatefulWidget {
  const FavoriteScreenBody({super.key});

  @override
  State<FavoriteScreenBody> createState() => _FavoriteScreenBodyState();
}

class _FavoriteScreenBodyState extends State<FavoriteScreenBody> {
  @override
  void initState() {
    super.initState();

    final productCubit = context.read<ProductCubit>();
    final favoritesCubit = context.read<FavoritesCubit>();

    productCubit.getAllProducts().then((_) {
      favoritesCubit.getFavoritesIds();
    });
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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              AppBarTitle(title: "Favorites"),
              BlocBuilder<ProductCubit, ProductState>(
                builder: (context, productState) {
                  print(productState);
                  if (productState is ProductLoading) {
                    return EmptyGridView();
                  }

                  if (productState is ProductSuccess) {
                    return BlocBuilder<FavoritesCubit, FavoriesState>(
                      buildWhen: (previous, current) =>
                          current is FavoriesLoading ||
                          current is FavoriesLoaded ||
                          current is FavoriesError,
                      builder: (context, favState) {
                        print(favState);

                        if (favState is FavoriesLoading) {
                          return EmptyGridView();
                        }

                        if (favState is FavoriesLoaded) {
                          final favoriteProducts = context
                              .read<FavoritesCubit>()
                              .getFavorites(productState.products);

                          if (favoriteProducts.isEmpty) {
                            return const EmptyWidget(
                              imageUrl: 'assets/images/empty_wishlist.png',
                            );
                          }

                          return GridViewFavorties(products: favoriteProducts);
                        }

                        return const SizedBox();
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
