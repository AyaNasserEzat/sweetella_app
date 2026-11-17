import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sweetella/core/error/failure.dart';
import 'package:sweetella/feature/address/data/models/address_model.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';
import 'package:sweetella/feature/cart/data/models/payment_model.dart';
import 'package:sweetella/feature/home/data/models/product_model.dart';
import 'package:sweetella/feature/order/data/models/order_model.dart';
import 'package:sweetella/feature/order/data/repositories/order_repo.dart';
import 'package:sweetella/feature/order/presentation/cubits/order_cubit.dart';
import 'package:sweetella/feature/order/presentation/cubits/order_state.dart';

class FakeOrderRepo implements OrderRepo {
  OrderModel? submittedOrder;
  int createOrderCalls = 0;

  @override
  Future<Either<Failure, String>> createOrder({
    required OrderModel order,
  }) async {
    submittedOrder = order;
    createOrderCalls++;
    return right('order-1');
  }

  @override
  Future<Either<Failure, OrderModel?>> getOrderById({
    required String orderId,
  }) async {
    return right(null);
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getOrders() async {
    return right([]);
  }
}

void main() {
  group('OrderCubit.createOrder', () {
    test('creates a COD order with cart product options and totals', () async {
      final repo = FakeOrderRepo();
      final cubit = OrderCubit(orderRepo: repo)
        ..selectPaymentMethod(PaymentMethod.cashOnDelivery);

      final item = CartItemModel(
        productId: 'product-1',
        productName: 'Chocolate Cake',
        price: 150.5,
        quantity: 2,
        imageUrl: 'cake.png',
        selectedVariant: const ProductVariantModel(
          id: 'large',
          sizeName: 'Large',
          price: 120,
          stock: 5,
        ),
        selectedAddons: const [
          ProductAddonModel(
            id: 'berries',
            name: 'Berries',
            price: 30,
            stock: 5,
          ),
        ],
      );

      await cubit.createOrder(
        selectedAddress: const AddressModel(
          name: 'Jane',
          phone: '01000000000',
          country: 'Egypt',
          city: 'Cairo',
          streetName: 'Main Street',
          floorNumber: '2',
          buildingNumber: '12',
          apartmentNumber: '3',
        ),
        cartItems: [item],
      );

      final order = repo.submittedOrder!;
      final orderItem = order.items.single;
      expect(cubit.state, isA<OrderSuccess>());
      expect(order.paymentMethod, 'Cash on Delivery');
      expect(orderItem['productId'], 'product-1');
      expect(orderItem['price'], 150.5);
      expect(orderItem['quantity'], 2);
      expect(orderItem['selectedVariant']['sizeName'], 'Large');
      expect(orderItem['selectedAddons'].single['name'], 'Berries');
      expect(order.subtotal, 301);
      expect(order.total, 307);

      await cubit.close();
    });

    test('does not create orders for unsupported payment methods', () async {
      final repo = FakeOrderRepo();
      final cubit = OrderCubit(orderRepo: repo)
        ..selectPaymentMethod(PaymentMethod.creditCard);

      await cubit.createOrder(
        selectedAddress: const AddressModel(
          name: 'Jane',
          phone: '01000000000',
          country: 'Egypt',
          city: 'Cairo',
          streetName: 'Main Street',
          floorNumber: '2',
          buildingNumber: '12',
          apartmentNumber: '3',
        ),
        cartItems: [
          CartItemModel(
            productId: 'product-1',
            productName: 'Cake',
            price: 100,
            imageUrl: 'cake.png',
            selectedVariant: null,
            selectedAddons: const [],
          ),
        ],
      );

      expect(cubit.state, isA<OrderFailure>());
      expect(repo.createOrderCalls, 0);

      await cubit.close();
    });
  });
}
