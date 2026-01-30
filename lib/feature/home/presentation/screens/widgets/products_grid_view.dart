
import 'package:flutter/widgets.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/donut_card.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({
    super.key,
    required this.products,
  });
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
        childAspectRatio: .72 / 1,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return DonutCard(
          productModel: products[index],
          //  backgroundColor: backgroundColors[index],
        );
      },
    );
  }
}

