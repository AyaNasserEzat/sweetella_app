import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/di/service_locator.dart';
import 'package:sweetella/feature/favorites/presentation/cubits/favorites_cubit.dart';
import 'package:sweetella/feature/favorites/presentation/screens/widgets/favorites_screen_body.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<FavoritesCubit>()),
        BlocProvider(create: (context) => sl<ProductCubit>()),
      ],
      child: FavoriteScreenBody(),
    );
  }
}
