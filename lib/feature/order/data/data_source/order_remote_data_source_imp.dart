import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweetella/core/error/exception_handelr.dart';
import 'package:sweetella/feature/order/data/data_source/order_remote_data_source.dart';
import 'package:sweetella/feature/order/data/models/order_model.dart';

class OrderRemoteDataSourceImp implements OrderRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference<Map<String, dynamic>> get ordersCollection {
    return firestore.collection('users').doc(uid).collection('orders');
  }

  @override
  Future<String> createOrder({required OrderModel order}) async {
    try {
      // Global counter shared by all users.
      final counterRef = firestore.collection('counters').doc('orders');

      // User-specific orders collection.
      final orders = firestore
          .collection('users')
          .doc(uid)
          .collection('orders');

      return await firestore.runTransaction((transaction) async {
        // 1. Read the global counter.
        final counterSnapshot = await transaction.get(counterRef);

        // 2. Generate the next number.
        final lastNumber =
            (counterSnapshot.data()?['lastOrderNumber'] as num?)?.toInt() ?? 0;

        final nextNumber = lastNumber + 1;

        // 3. Generate order ID.
        final orderId = 'ORD-$nextNumber';

        // 4. Create order document.
        final orderRef = orders.doc(orderId);

        // 5. Update global counter.
        transaction.set(counterRef, {'lastOrderNumber': nextNumber});

        // 6. Save order.
        transaction.set(orderRef, {
          ...order.toJson(),
          'id': orderId,
          'userId': uid,
          'createdAt': FieldValue.serverTimestamp(),
        });

        return orderId;
      });
    } catch (e) {
      ExceptionHandler.handle(e);
      rethrow;
    }
  }

  @override
  Future<OrderModel?> getOrderById({required String orderId}) async {
    try {
      final doc = await ordersCollection.doc(orderId).get();

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
      final snapshot = await ordersCollection
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList();
    } catch (e) {
      ExceptionHandler.handle(e);
      rethrow;
    }
  }
}
