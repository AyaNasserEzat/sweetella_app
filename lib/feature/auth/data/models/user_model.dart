class UserModel {
  final String email;
  final String name;
  final String uid;

  UserModel({required this.email, required this.uid, required this.name});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      uid: json['uid'],
      name: json['name'],
    );
  }
  Map<String, dynamic> toJson() => {'email': email, 'uid': uid, 'name': name};
}
