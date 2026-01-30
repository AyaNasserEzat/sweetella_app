import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String name;

  final String imageUrl;

  CategoryModel({required this.id, required this.name, required this.imageUrl});
  factory CategoryModel.empty() => CategoryModel(id: '', name: '', imageUrl: '');

  factory CategoryModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;

      return CategoryModel(
        id: document.id,
        name: data['category_name'] ?? '',
        imageUrl: data['image'] ?? '',
      );
    } else {
      return CategoryModel.empty();
    }
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'category_name': name, 'image': imageUrl};
  }
}
