import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesModel {
  final String id;
  final String productId;
  final DateTime createdAt;
  FavoritesModel({
    required this.id,
    required this.productId,
    required this.createdAt,
  });

  factory FavoritesModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    return FavoritesModel(
      id: document.id,
      productId: document['productId'],
      createdAt: (document['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'createdAt': createdAt,
    };
  }
}
