import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/di/service_locator.dart';
import 'package:sweetella/feature/favorites/presentation/cubits/favorites_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/home_screen_body.dart';

class DonutsHomeScreen extends StatelessWidget {
  const DonutsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ProductCubit>()..getAllCategories(),
        ),
        BlocProvider(create: (context) => sl<FavoritesCubit>()..getFavoritesIds()),
      ],
      child: HomeScreenBody(),
    );
  }
}
