import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email;
  final String name;
  final String uid;
  final DateTime? createdAt;

  UserModel({
    required this.email,
    required this.uid,
    required this.name,
    this.createdAt,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    final timestamp = json['createdAt'] as Timestamp?;
    return UserModel(
      email: json['email'],
      uid: json['id'],
      name: json['name'],
      createdAt: timestamp?.toDate(),
    );
  }
  Map<String, dynamic> toJson() => {
    'email': email,
    'id': uid,
    'name': name,
    'createdAt': createdAt,
  };
}
