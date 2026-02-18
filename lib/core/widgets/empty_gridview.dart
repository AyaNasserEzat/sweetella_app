
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/products_grid_view.dart';

class EmptyGridView extends StatelessWidget {
  const EmptyGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled:true,
      child: ProductsGridView(products: List.generate(10, (index) => ProductModel.empty()),));
  }
}
