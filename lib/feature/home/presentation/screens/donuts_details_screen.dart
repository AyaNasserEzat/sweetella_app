import 'package:flutter/material.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/add_to_cart_button.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/donut_title_and_price.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/icon_favorite.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/plus_or_minus.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/reviews.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/donut_description.dart';
import 'package:sweetella/feature/home/presentation/screens/widgets/donut_size_selector.dart';

class DonutsDetailsScreen extends StatelessWidget {
  const DonutsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffee3e3), 
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 90.0),
              child: Column(
                children: [
                  Image.asset('assets/images/donuts_image.png', height: 200),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(25),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 16,
                          children: [
                            DonutTitleAndPrice(),
                            Reviews(),
                            const DonutDescription(),
                            const DonutSizeSelector(),
                            Spacer(),
                            Row(
                              children: [
                                PlusOrMinus(),
                                Spacer(),
                                AddToCartButton(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconFavorite(),
          ],
        ),
      ),
    );
  }
}
