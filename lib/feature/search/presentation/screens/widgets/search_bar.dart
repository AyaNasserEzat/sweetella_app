import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/core/utils/app_colors.dart';
import 'package:sweetella/feature/search/presentation/bloc/search_bloc.dart';
import 'package:sweetella/feature/search/presentation/bloc/search_event.dart';

class SearchTextFormField extends StatelessWidget {
  const SearchTextFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        context.read<SearchBloc>().add(SearchProductsEvent(value));
      },
      decoration: InputDecoration(
        hintText: 'Search here...',
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: AppColors.grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
