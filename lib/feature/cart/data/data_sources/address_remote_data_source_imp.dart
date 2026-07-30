import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweetella/core/error/exception_handelr.dart';
import 'package:sweetella/feature/cart/data/data_sources/address_remote_data_source.dart';
import 'package:sweetella/feature/cart/data/models/address_model.dart';

class AddressRemoteDataSourceImp implements AddressRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String _uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Future<void> addAddress({required AddressModel address}) async {
    try {
      final docRef = firestore
          .collection('users')
          .doc(_uid)
          .collection('addresses')
          .doc();

      final addressToSave = address.copyWith(id: docRef.id);
      await docRef.set(addressToSave.toJson());
    } catch (e) {
      ExceptionHandler.handle(e);
      rethrow;
    }
  }

  @override
  Future<List<AddressModel>> getAddresses() async {
    try {
      final snapshot = await firestore
          .collection('users')
          .doc(_uid)
          .collection('addresses')
          .get();

      return snapshot.docs
          .map((doc) => AddressModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      ExceptionHandler.handle(e);
      rethrow;
    }
  }

  @override
  Future<void> editAddress({required AddressModel address}) async {
    try {
      await firestore
          .collection('users')
          .doc(_uid)
          .collection('addresses')
          .doc(address.id)
          .update(address.toJson());
    } catch (e) {
      ExceptionHandler.handle(e);
      rethrow;
    }
  }

  @override
  Future<void> deleteAddress({required String addressId}) async {
    try {
      await firestore
          .collection('users')
          .doc(_uid)
          .collection('addresses')
          .doc(addressId)
          .delete();
    } catch (e) {
      ExceptionHandler.handle(e);
      rethrow;
    }
  }
}
