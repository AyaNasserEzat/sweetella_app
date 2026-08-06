import 'package:equatable/equatable.dart';
import 'package:sweetella/feature/cart/data/models/payment_model.dart';
import 'package:sweetella/feature/order/data/models/order_model.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {
  const OrderInitial();
}

class OrderLoading extends OrderState {
  const OrderLoading();
}

class OrderFailure extends OrderState {
  final String message;

  const OrderFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class OrderSuccess extends OrderState {
  final String orderId;

  const OrderSuccess({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

class PaymentMethodChanged extends OrderState {
  final PaymentMethod method;

  const PaymentMethodChanged({required this.method});

  @override
  List<Object?> get props => [method];
}

class OrderLoaded extends OrderState {
  final List<OrderModel> orders;
  final OrderStatus? selectedStatus;

  const OrderLoaded({required this.orders, this.selectedStatus});

  @override
  List<Object?> get props => [orders, selectedStatus];
}
