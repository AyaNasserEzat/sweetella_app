import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweetella/core/error/exception_handelr.dart';

class FirebaseServices {
  final _auth = FirebaseAuth.instance;

  Future signIn({required String email, required String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // getUserData();
      return result;
    } catch (e) {
      ExceptionHandler.handle(e);
    }
  }

  Future signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = _auth.currentUser;
      final uid = user!.uid;
      // await user.updateDisplayName(name);
      // await user.reload();
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'id': uid,
        'name': name,
        'email': email,
        'createdAt': Timestamp.now(),
      });
      return result;
    } catch (e) {
      ExceptionHandler.handle(e);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      ExceptionHandler.handle(e);
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      ExceptionHandler.handle(e);
    }
  }

  Future getUserData() async {
    try {
      final User? user = _auth.currentUser;
      final uid = user!.uid;
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      return userDoc;
    } catch (e) {
      ExceptionHandler.handle(e);
    }
  }

  //update shipping
  Future updateShippingAdd({required String shippingAdd}) async {
    try {
      final User? user = _auth.currentUser;
      final uid = user!.uid;
      final updatedShipping = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'shipping_add': shippingAdd});

      return updatedShipping;
    } catch (e) {
      ExceptionHandler.handle(e);
    }
  }
}
