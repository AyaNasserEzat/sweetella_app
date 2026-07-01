import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/di/service_locator.dart';
import 'package:sweetella/core/helper/extension.dart';
import 'package:sweetella/feature/auth/presentation/screens/widgets/app_bar.dart';
import 'package:sweetella/feature/cart/presentation/cubits/cart_cubit.dart';
import 'package:sweetella/feature/favorites/presentation/cubits/favorites_cubit.dart';
import 'package:sweetella/feature/home/presentation/screens/cubit/product_attribut_selection_cubit.dart';
import 'package:sweetella/feature/search/presentation/bloc/search_bloc.dart';
import 'package:sweetella/feature/search/presentation/screens/widgets/search_screen_body.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.w * 0.05;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<SearchBloc>()),

        BlocProvider(create: (_) => ProductAttributesCubit()),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: horizontalPadding,
            top: 35,
            right: horizontalPadding,
            bottom: context.h * 0.15,
          ),
          child: Column(
            children: [
              AppBarTitle(title: "Search Product", haveArrow: true),
              SearchScreenBody(),
            ],
          ),
        ),
      ),
    );
  }
}
