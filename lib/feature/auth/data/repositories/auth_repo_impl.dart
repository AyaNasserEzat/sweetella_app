import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweetella/core/error/failure.dart';
import 'package:sweetella/core/error/firebase_exception.dart';
import '../../../../core/services/firebase_service.dart';
import 'package:dartz/dartz.dart';

class AuthRepoImpl {
  final FirebaseServices firebaseServices;

  AuthRepoImpl(this.firebaseServices);


  Future<Either<Failure, UserCredential>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await firebaseServices.signIn(
        email: email,
        password: password,
      );
      return right(result);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Either<Failure, UserCredential>> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final result = await firebaseServices.signUp(
        email: email,
        password: password,
        name: name,
      );
      return right(result);
    } on  AppException catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Either<Failure, String>> resetPassword(String email) async {
    try {
      await firebaseServices.resetPassword(email: email);
      return right('reset password successfully');
    } on AppException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, String>> signOut() async {
    try {
      await firebaseServices.signOut();
      return right('sign out successfully');
    } on AppException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
