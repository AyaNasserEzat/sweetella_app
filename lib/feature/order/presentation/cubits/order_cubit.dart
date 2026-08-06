import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sweetella/feature/address/data/models/address_model.dart';
import 'package:sweetella/feature/cart/data/models/cart_model.dart';
import 'package:sweetella/feature/cart/data/models/payment_model.dart';
import 'package:sweetella/feature/order/data/models/order_model.dart';
import 'package:sweetella/feature/order/data/repositories/order_repo.dart';
import 'package:sweetella/feature/order/presentation/cubits/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit({required this.orderRepo}) : super(OrderInitial());

  final OrderRepo orderRepo;
  String? orderId;
  PaymentMethod? selectedPaymentMethod;
  List<OrderModel> _allOrders = [];
  final Map<OrderStatus, List<OrderModel>> _cachedOrders = {};
  void selectPaymentMethod(PaymentMethod method) {
    selectedPaymentMethod = method;
    emit(PaymentMethodChanged(method: method));
  }

  Future<void> getOrders() async {
    emit(const OrderLoading());

    final result = await orderRepo.getOrders();

    result.fold(
      (failure) {
        emit(OrderFailure(message: failure.message));
      },
      (orders) {
        _allOrders = orders;

        _buildCache();

        emit(OrderLoaded(orders: orders));
      },
    );
  }

  void _buildCache() {
    _cachedOrders.clear();

    for (final status in OrderStatus.values) {
      _cachedOrders[status] = _allOrders
          .where((e) => e.status == status)
          .toList();
    }
  }

  void filterOrders(OrderStatus? status) {
    emit(
      OrderLoaded(
        orders: status == null ? _allOrders : _cachedOrders[status] ?? [],
        selectedStatus: status,
      ),
    );
  }

  Future<void> createOrder({
    required AddressModel? selectedAddress,
    required List<CartItemModel> cartItems,
    required double totalPrice,
  }) async {
    if (selectedAddress == null) {
      emit(OrderFailure(message: 'Please select a shipping address.'));
      return;
    }

    if (selectedPaymentMethod == null) {
      emit(OrderFailure(message: 'Please select a payment method.'));
      return;
    }

    emit(OrderLoading());

    final order = OrderModel(
      addressName: selectedAddress.name,
      addressPhone: selectedAddress.phone,
      addressLine:
          '${selectedAddress.streetName}, ${selectedAddress.buildingNumber}, ${selectedAddress.floorNumber}, ${selectedAddress.apartmentNumber}, ${selectedAddress.city}',
      paymentMethod: _paymentMethodToString(selectedPaymentMethod!),
      items: cartItems
          .map(
            (item) => {
              'productName': item.productName,
              'quantity': item.quantity,
              'price': item.price,
              'imageUrl': item.imageUrl,
            },
          )
          .toList(),
      subtotal: totalPrice,
      shipping: 5,
      tax: 2,
      discount: 1,
      total: totalPrice + 5 + 2 - 1,
    );

    final result = await orderRepo.createOrder(order: order);

    result.fold((failure) => emit(OrderFailure(message: failure.message)), (
      createdOrderId,
    ) {
      orderId = createdOrderId;
      emit(OrderSuccess(orderId: createdOrderId));
    });
  }

  String _paymentMethodToString(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.creditCard:
        return 'Credit Card';
      case PaymentMethod.paypal:
        return 'PayPal';
      case PaymentMethod.applePay:
        return 'Apple Pay';
      case PaymentMethod.cashOnDelivery:
        return 'Cash on Delivery';
    }
  }
}
