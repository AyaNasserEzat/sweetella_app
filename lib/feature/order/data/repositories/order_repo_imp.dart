import 'package:dartz/dartz.dart';
import 'package:sweetella/core/error/failure.dart';
import 'package:sweetella/core/error/firebase_exception.dart';
import 'package:sweetella/feature/order/data/data_source/order_remote_data_source.dart';
import 'package:sweetella/feature/order/data/models/order_model.dart';
import 'package:sweetella/feature/order/data/repositories/order_repo.dart';

class OrderRepoImp implements OrderRepo {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepoImp(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> createOrder({
    required OrderModel order,
  }) async {
    try {
      final orderId = await remoteDataSource.createOrder(order: order);
      return right(orderId);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, OrderModel?>> getOrderById({
    required String orderId,
  }) async {
    try {
      final order = await remoteDataSource.getOrderById(orderId: orderId);
      return right(order);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getOrders() async {
    try {
      final orders = await remoteDataSource.getOrders();
      return right(orders);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateOrderStatus({
    required String orderId,
    required OrderStatus status,
  }) async {
    try {
      await remoteDataSource.updateOrderStatus(
        orderId: orderId,
        status: status,
      );
      return right(null);
    } on AppException catch (e) {
      return left(Failure(e.message));
    }
  }
}
