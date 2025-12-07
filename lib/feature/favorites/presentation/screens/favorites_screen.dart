import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  final List<String> favorites = [
    'Donut 1',
    'Donut 2',
    'Donut 3',
    // Add more favorites here
  ];

   FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favorites[index]),
          );
        },
      ),
    );
  }
}
