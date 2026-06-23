import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweetella/core/error/exception_handelr.dart';
import 'package:sweetella/feature/auth/data/models/user_model.dart';
import 'package:sweetella/feature/profile/data/data_source/profile_remote_data_source.dart';

class ProfileRemoteDataSourceImp extends ProfileRemoteDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  @override
  Future<UserModel> getProfile() async {
    try {
      final userId = auth.currentUser?.uid;
      final userDoc = await firestore.collection('users').doc(userId).get();
      return UserModel.fromJson(userDoc.data()!);
    } catch (e) {
      ExceptionHandler.handle(e);
      rethrow;
    }
  }
}
