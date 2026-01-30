import 'package:flutter/material.dart';
import 'package:sweetella/feature/home/data/models/category_model.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/category_chip.dart';

class GategoryListView extends StatefulWidget {
  const GategoryListView({super.key, required this.categories});
  final List<CategoryModel> categories;

  @override
  State<GategoryListView> createState() => _GategoryListViewState();
}

class _GategoryListViewState extends State<GategoryListView> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selected = index;
              });
            },
            child: CategoryItem(
              categoryModel: widget.categories[index],
              selected: selected == index,
            ),
          );
        },
      ),
    );
  }
}
