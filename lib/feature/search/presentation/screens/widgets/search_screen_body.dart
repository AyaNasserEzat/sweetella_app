import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/widgets/empty_gridview.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/products_grid_view.dart';
import 'package:sweetella/feature/search/presentation/bloc/search_bloc.dart';
import 'package:sweetella/feature/search/presentation/bloc/search_state.dart';
import 'package:sweetella/feature/search/presentation/screens/widgets/search_bar.dart';

class SearchScreenBody extends StatelessWidget {
  const SearchScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: SearchTextFormField(),
        ),
        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchLoading) {
              return EmptyGridView();
            }

            if (state is SearchError) {
              return Center(child: Text(state.message));
            }

            if (state is SearchSuccess) {
              if (state.products.isEmpty) {
                return Center(child: Text("No results found"));
              } else {
                return ProductsGridView(products: state.products);
              }
            }

            return SizedBox();
          },
        ),
      ],
    );
  }
}
