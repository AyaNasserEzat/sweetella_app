import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweetella/core/error/exception_handelr.dart';
import 'package:sweetella/feature/order/data/data_source/order_remote_data_source.dart';
import 'package:sweetella/feature/order/data/models/order_model.dart';

class OrderRemoteDataSourceImp implements OrderRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Future<String> createOrder({required OrderModel order}) async {
    try {
      final docRef = await firestore
          .collection('users')
          .doc(uid)
          .collection('orders')
          .add(order.toJson());
      return docRef.id;
    } catch (e) {
      ExceptionHandler.handle(e);
      rethrow;
    }
  }

  @override
  Future<OrderModel?> getOrderById({required String orderId}) async {
    try {
      final doc = await firestore
          .collection('users')
          .doc(uid)
          .collection('orders')
          .doc(orderId)
          .get();

      if (!doc.exists) return null;
      return OrderModel.fromSnapshot(doc);
    } catch (e) {
      ExceptionHandler.handle(e);
      rethrow;
    }
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      final snapshot = await firestore
          .collection('users')
          .doc(uid)
          .collection('orders')
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
    } catch (e) {
      ExceptionHandler.handle(e);
      rethrow;
    }
  }
}
