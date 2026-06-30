import 'package:flutter/widgets.dart';
import 'package:sweetella/feature/favorites/presentation/screens/widgets/favorite_item.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/product_item.dart';

class GridViewFavorties extends StatelessWidget {
  const GridViewFavorties({super.key, required this.products});
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 10,
        crossAxisSpacing: 14,
        childAspectRatio: .49,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return FavoriteItem(
          productModel: products[index],
          //  backgroundColor: backgroundColors[index],
        );
      },
    );
  }
}
