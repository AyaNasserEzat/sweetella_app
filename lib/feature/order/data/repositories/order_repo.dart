import 'package:dartz/dartz.dart';
import 'package:sweetella/core/error/failure.dart';
import 'package:sweetella/feature/order/data/models/order_model.dart';

abstract class OrderRepo {
  Future<Either<Failure, String>> createOrder({required OrderModel order});
  Future<Either<Failure, OrderModel?>> getOrderById({required String orderId});
  Future<Either<Failure, List<OrderModel>>> getOrders();
}
