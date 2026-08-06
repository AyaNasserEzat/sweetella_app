import 'package:sweetella/feature/order/data/models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<String> createOrder({required OrderModel order});
  Future<OrderModel?> getOrderById({required String orderId});
  Future<List<OrderModel>> getOrders();
  Future<void> updateOrderStatus({
    required String orderId,
    required OrderStatus status,
  });
}
